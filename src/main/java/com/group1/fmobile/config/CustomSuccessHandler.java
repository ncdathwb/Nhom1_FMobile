package com.group1.fmobile.config;

import com.group1.fmobile.domain.User;
import com.group1.fmobile.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.Configuration;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;


import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


/**
 * Xử lý tùy chỉnh sau khi xác thực thành công.
 *
 * @author [Ha Van Dat]
 */
@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    /**
     * Xác định URL đích chuyển hướng dựa trên vai trò của người dùng.
     *
     * @param authentication Đối tượng Authentication chứa thông tin về người dùng đã xác thực.
     * @return URL đích chuyển hướng.
     * @throws IllegalStateException Nếu không tìm thấy URL đích phù hợp với vai trò.
     */
    protected String determineTargetUrl(final Authentication authentication) {
        // Ánh xạ giữa vai trò và URL đích

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/client/homepage");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin/home");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        throw new IllegalStateException();
    }


    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    /**
     * Xử lý sau khi xác thực thành công.
     *
     * @param request        Yêu cầu HTTP.
     * @param response       Phản hồi HTTP.
     * @param authentication Đối tượng Authentication chứa thông tin về người dùng đã xác thực.
     * @throws IOException      Nếu có lỗi xảy ra trong quá trình nhập/xuất.
     * @throws ServletException Nếu có lỗi xảy ra trong servlet.
     */

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String email = authentication.getName();
        User user = userService.findByEmail(email);

        if (!user.isEnabled()) {

            redirectStrategy.sendRedirect(request, response, "/verify");
            return;
        }

        String targetUrl = determineTargetUrl(authentication);

        if (response.isCommitted()) {

            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
        clearAuthenticationAttributes(request, authentication);

    }


    /**
     * Xóa các thuộc tính xác thực khỏi request và lưu thông tin người dùng vào session.
     *
     * @param request        Yêu cầu HTTP.
     * @param authentication Đối tượng Authentication chứa thông tin về người dùng đã xác thực.
     */

    private void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }

        String email = authentication.getName();

        User user = this.userService.findByEmail(email);
        if (user != null) {
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("phone", user.getPhone());
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());

        }
        // Xóa thuộc tính AUTHENTICATION_EXCEPTION khỏi session

        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
}
