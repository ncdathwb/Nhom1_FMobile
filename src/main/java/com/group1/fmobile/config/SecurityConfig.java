package com.group1.fmobile.config;

import com.group1.fmobile.service.CustomUserDetailsService;
import com.group1.fmobile.service.UserService;
import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;


/**
 * Cấu hình bảo mật cho ứng dụng.
 *
 * @author [Ha Van Dat]
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    /**
     * Tạo bean xử lý đăng nhập thành công.
     *
     * @return Đối tượng CustomSuccessHandler để xử lý khi đăng nhập thành công
     */

//Lỗi khi chạy chương trình báo "The bean 'customSuccessHandler',
// defined in class path resource [com/group1/fmobile/config/SecurityConfig.class],could not be registered.
// A bean with that name has already been defined in file
// [D:\Local Reponsive\Nhom1_FMobile\target\classes\com\group1\fmobile\config\CustomSuccessHandler.class] and overriding is disabled."
// nên Hieu comment lại để chạy tạm. Của ai thì khi merge mở ra.
    @Bean (name = "customSuccessHandlerBean")
    public AuthenticationSuccessHandler customSuccessHandler() {
        return new CustomSuccessHandler();
    }


    /**
     * Tạo bean dịch vụ "nhớ tôi" (remember-me) sử dụng Spring Session.
     *
     * @return Đối tượng SpringSessionRememberMeServices đã được cấu hình
     */

    @Bean
    public SpringSessionRememberMeServices rememberMeServices() {


        return new SpringSessionRememberMeServices();
    }


    /**
     * Cấu hình chuỗi bộ lọc bảo mật (SecurityFilterChain).
     *
     * @param httpSecurity Đối tượng HttpSecurity để cấu hình
     * @return SecurityFilterChain đã được cấu hình
     * @throws Exception Nếu có lỗi  
     *                   xảy ra trong quá trình cấu hình
     */

    @Bean
    SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity

                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                        .requestMatchers("/", "/login", "/register",  "/css/**", "/js/**", "/images/**", "/verify", "/reset-password", "/forgotpassword","/home","/guest/**","/checkout/**","/checkout-not-login","/client/homepage").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                .sessionManagement((sessionManagement) -> sessionManagement
                        .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                        .invalidSessionUrl("/logout?expired")

                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false))
                .logout(logout -> logout.deleteCookies("JSESSIONID").invalidateHttpSession(true))


                .rememberMe(r -> r
                        .rememberMeServices(rememberMeServices())
                        .tokenValiditySeconds(1209600)
                        .key("uniqueAndSecret")
                        .rememberMeParameter("remember-me")
                )

                .formLogin(formLogin -> formLogin
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .successHandler(customSuccessHandler())
                        .permitAll()
                )



                .exceptionHandling(ex->ex.accessDeniedPage("/access-deny"));


        return httpSecurity.build();
    }


    /**
     * Tạo bean bộ mã hóa mật khẩu BCrypt.
     *
     * @return Đối tượng BCryptPasswordEncoder
     */

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    /**
     * Tạo bean dịch vụ chi tiết người dùng (UserDetailsService).
     *
     * @param userService Dịch vụ người dùng
     * @return Đối tượng CustomUserDetailsService
     */

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }


    /**
     * Tạo bean nhà cung cấp xác thực DAO (DaoAuthenticationProvider).
     *
     * @param passwordEncoder    Bộ mã hóa mật khẩu
     * @param userDetailsService Dịch vụ chi tiết người dùng
     * @return Đối tượng DaoAuthenticationProvider đã được cấu hình
     */

    @Bean
    public DaoAuthenticationProvider authenticationProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        return authProvider;
    }


    /**
     * Tạo bean trình quản lý xác thực (AuthenticationManager).
     *
     * @param http                   Đối tượng HttpSecurity
     * @param authenticationProvider Nhà cung cấp xác thực
     * @return Đối tượng AuthenticationManager
     * @throws Exception Nếu có lỗi xảy ra trong quá trình cấu hình
     */

    @Bean
    public AuthenticationManager authenticationManager(
            HttpSecurity http,
            DaoAuthenticationProvider authenticationProvider) throws Exception {
        return http.getSharedObject(AuthenticationManager.class);
    }

}
