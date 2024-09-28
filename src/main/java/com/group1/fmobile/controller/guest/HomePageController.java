package com.group1.fmobile.controller.guest;

import com.group1.fmobile.domain.dto.*;
import com.group1.fmobile.service.account.AccountService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

/**
 * Bộ điều khiển (controller) cho các trang chính của ứng dụng, xử lý các yêu cầu liên quan đến
 * đăng ký, đăng nhập, quên mật khẩu, và xác thực.
 * @author [Ha Van Dat]
 */
@Controller

public class HomePageController {
    private final AccountService accountService;

    @Autowired
    public HomePageController(AccountService accountService) {
        this.accountService = accountService;
    }

    /**
     * Hiển thị trang chủ.
     *
     * @return Tên view của trang chủ.
     */
//    @GetMapping("/")
//    public String getHome() {
//        return "client/homepage/index";
//    }

    /**
     * Hiển thị trang đăng ký.
     *
     * @param model Đối tượng Model để truyền dữ liệu đến view.
     * @return Tên view của trang đăng ký.
     */
    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("register", new RegisterDTO());
        return "client/auth/register";
    }

    /**
     * Xử lý yêu cầu đăng ký người dùng.
     *
     * @param registerDTO      DTO chứa thông tin đăng ký.
     * @param bindingResult    Đối tượng BindingResult để kiểm tra lỗi ràng buộc dữ liệu.
     * @param session          Đối tượng HttpSession để lưu trữ thông tin phiên làm việc.
     * @param model            Đối tượng Model để truyền dữ liệu đến view.
     * @return Chuyển hướng đến trang xác thực nếu đăng ký thành công, ngược lại quay về trang đăng ký với thông báo lỗi.
     */
    @PostMapping("/register")
    public String registerPage(@ModelAttribute("register") @Valid RegisterDTO registerDTO,
                               BindingResult bindingResult,
                               HttpSession session,
                               Model model) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        try {
            accountService.registerUser(registerDTO);
            session.setAttribute("registeredEmail", registerDTO.getEmail());
            return "redirect:/verify";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "client/auth/register";
        }
    }

    /**
     * Hiển thị trang đăng nhập.
     *
     * @param model Đối tượng Model để truyền dữ liệu đến view.
     * @return Tên view của trang đăng nhập.
     */
    @GetMapping("/login")
    public String loginPage(Model model) {
        return "client/auth/login";
    }

    /**
     * Hiển thị trang chính sau khi đăng nhập thành công.
     *
     * @param session Đối tượng HttpSession để lấy thông tin phiên làm việc.
     * @param model   Đối tượng Model để truyền dữ liệu đến view.
     * @return Tên view của trang chính hoặc trang quản trị (nếu người dùng có quyền ADMIN).
     */
//    @GetMapping("/home")
//    public String homePage(HttpSession session, Model model) {
//        return "client/homepage/index";
//    }

    /**
     * Hiển thị trang quên mật khẩu.
     *
     * @param model Đối tượng Model để truyền dữ liệu đến view.
     * @return Tên view của trang quên mật khẩu.
     */
    @GetMapping("/forgotpassword")
    public String forgotPasswordPage(Model model) {
        model.addAttribute("forgotpassword", new ForgotPasswordDTO());
        return "client/auth/forgotpassword";
    }

    /**
     * Xử lý yêu cầu quên mật khẩu.
     *
     * @param forgotPasswordDTO DTO chứa địa chỉ email để đặt lại mật khẩu.
     * @param bindingResult     Đối tượng BindingResult để kiểm tra lỗi ràng buộc dữ liệu.
     * @param httpSession       Đối tượng HttpSession để lưu trữ thông tin phiên làm việc.
     * @param model             Đối tượng Model để truyền dữ liệu đến view.
     * @return Chuyển hướng đến trang đặt lại mật khẩu nếu email hợp lệ, ngược lại quay về trang quên mật khẩu với thông báo lỗi.
     */
    @PostMapping("/forgotpassword")
    public String forgotPasswordPage(@ModelAttribute("forgotpassword") @Valid ForgotPasswordDTO forgotPasswordDTO,
                                     BindingResult bindingResult,
                                     HttpSession httpSession,
                                     Model model) {
        if (bindingResult.hasErrors()) {
            return "client/auth/forgotpassword";
        }

        try {
            accountService.initiatePasswordReset(forgotPasswordDTO.getEmail());
            httpSession.setAttribute("resetEmail", forgotPasswordDTO.getEmail());
            return "redirect:/reset-password";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while processing your request. Please try again.");
            return "client/auth/forgotpassword";
        }
    }

    /**
     * Hiển thị trang xác thực tài khoản.
     *
     * @param model Đối tượng Model để truyền dữ liệu đến view.
     * @return Tên view của trang xác thực.
     */
    @GetMapping("/verify")
    public String verifyPage(Model model) {
        model.addAttribute("verify", new VerifyDTO());
        return "client/auth/verify";
    }

    /**
     * Xử lý yêu cầu xác thực tài khoản bằng OTP.
     *
     * @param verifyDTO    DTO chứa mã OTP.
     * @param bindingResult Đối tượng BindingResult để kiểm tra lỗi ràng buộc dữ liệu.
     * @param httpSession   Đối tượng HttpSession để lấy thông tin phiên làm việc.
     * @return Chuyển hướng đến trang đăng nhập nếu xác thực thành công, ngược lại quay về trang xác thực với thông báo lỗi.
     */
    @PostMapping("/verify")
    public String verifyPage(@Valid @ModelAttribute("verify") VerifyDTO verifyDTO,
                             BindingResult bindingResult,
                             HttpSession httpSession) {
        if (bindingResult.hasErrors()) {
            return "client/auth/verify";
        }

        String email = (String) httpSession.getAttribute("registeredEmail");
        if (email != null && accountService.verifyAccount(email, verifyDTO.getOtp())) {
            httpSession.removeAttribute("registeredEmail");
            return "redirect:/login";
        }
        return "redirect:/verify?error";
    }

    /**
     * Gửi lại mã OTP xác thực.
     *
     * @param httpSession Đối tượng HttpSession để lấy thông tin phiên làm việc.
     * @return Thông báo cho biết OTP đã được gửi lại hoặc không tìm thấy email đã đăng ký.
     */
    @PostMapping("/resend-otp")
    @ResponseBody
    public String resendOTP(HttpSession httpSession) {
        String email = (String) httpSession.getAttribute("registeredEmail");
        if (email != null) {
            accountService.resendOTP(email);
            return "OTP has been resent. Please check your email.";
        }
        return "Registered email address not found.";
    }

    /**
     * Hiển thị trang đặt lại mật khẩu.
     *
     * @param model Đối tượng Model để truyền dữ liệu đến view.
     * @return Tên view của trang đặt lại mật khẩu.
     */
    @GetMapping("/reset-password")
    public String resetPassword(Model model) {
        model.addAttribute("resetpassword", new ResetPasswordDTO());
        return "client/auth/resetpassword";
    }

    /**
     * Xử lý yêu cầu đặt lại mật khẩu.
     *
     * @param resetPasswordDTO DTO chứa thông tin đặt lại mật khẩu (OTP, mật khẩu mới, xác nhận mật khẩu mới).
     * @param bindingResult     Đối tượng BindingResult để kiểm tra lỗi ràng buộc dữ liệu.
     * @param httpSession       Đối tượng HttpSession để lấy thông tin phiên làm việc.
     * @param model             Đối tượng Model để truyền dữ liệu đến view.
     * @return Chuyển hướng đến trang đăng nhập nếu đặt lại mật khẩu thành công, ngược lại quay về trang đặt lại mật khẩu với thông báo lỗi.
     */
    @PostMapping("/reset-password")
    public String resetPassword(@ModelAttribute("resetpassword") @Valid ResetPasswordDTO resetPasswordDTO,
                                BindingResult bindingResult,
                                HttpSession httpSession,
                                Model model) {
        if (bindingResult.hasErrors()) {
            return "client/auth/resetpassword";
        }

        String email = (String) httpSession.getAttribute("resetEmail");

        try {
            if (accountService.resetPassword(email, resetPasswordDTO.getOtp(), resetPasswordDTO.getNewPassword())) {
                httpSession.removeAttribute("resetEmail");
                return "redirect:/login?resetSuccess";
            } else {
                model.addAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn.");
                return "client/auth/resetpassword";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
            return "client/auth/resetpassword";
        }
    }

    /**
     * Hiển thị trang bị từ chối truy cập (access denied).
     *
     * @param model Đối tượng Model để truyền dữ liệu đến view (nếu cần).
     * @return Tên view của trang bị từ chối truy cập.
     */
    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {
        return "client/auth/deny";
    }
}
