package com.group1.fmobile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

/**
 * Lớp Service này triển khai {@link UserDetailsService} để cung cấp
 * chi tiết người dùng tùy chỉnh dựa trên email (username) cho Spring Security.
 */
@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final UserService userService;

    /**
     * Hàm khởi tạo cho CustomUserDetailsService.
     *
     * @param userService đối tượng UserService cung cấp dữ liệu người dùng
     */
    @Autowired
    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    /**
     * Tải thông tin người dùng từ cơ sở dữ liệu dựa trên email (username).
     *
     * @param username email của người dùng cần lấy thông tin
     * @return UserDetails đối tượng chứa thông tin người dùng cho Spring Security
     * @throws UsernameNotFoundException nếu không tìm thấy người dùng
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        com.group1.fmobile.domain.User user = this.userService.findByEmail(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        // Lấy danh sách các quyền (authorities) từ vai trò (roles) của người dùng
        Set<SimpleGrantedAuthority> authorities = user.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getName().name()))
                .collect(Collectors.toSet());

        // Trả về đối tượng User chứa email, mật khẩu và quyền
        return new User(user.getEmail(), user.getPassword(), authorities);
    }
}
