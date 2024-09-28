package com.group1.fmobile.controller.client;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.UpdateProfileRequest;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.service.OrderService;
import com.group1.fmobile.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("client/homepage")
public class UserController {
    private final UserService userService;
    private final OrderService orderService;
    @Autowired
    public UserController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    public String getHome() {
        return "client/homepage/index";
    }

    // Display user profile page with current information
    @GetMapping("/userpage")
    public String getUserPage(Model model) {
        // Get the current authenticated user's email
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userEmail = auth.getName();  // Assume email is used as the username

        // Retrieve user details from the database using email
        User user = userService.getUserByEmail(userEmail);

        if (user != null) {
            // Add user information to the model
            model.addAttribute("user", user);
            return "client/homepage/userpage";  // Return the user profile JSP page
        } else {
            // If user not found, redirect to login page
            return "redirect:/client/auth/login";
        }
    }

    // Xử lý yêu cầu hiển thị lịch sử mua hàng
    @GetMapping("/orders/{fullName}")
        public String getOrderHistory(@PathVariable String fullName, Model model) {
            Optional<User> user = userService.findByFullName(fullName);
            if (user.isPresent()) {
                List<Orders> orders = orderService.findOrdersByUser(user.get());
                model.addAttribute("orders", orders);
                return "client/homepage/userpage";  // tên của file JSP hiển thị lịch sử đơn hàng
            } else {
                return "error"; // hoặc trả về trang lỗi nếu không tìm thấy user
            }
        }

    @GetMapping("/profile")
    public String getUserProfile(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        String email = userDetails.getUsername(); // Assuming email is used as username
        User user = userService.getUserByEmail(email);
        if (user != null) {
            model.addAttribute("user", user);
            return "client/homepage/profile";
        } else {
            return "error";
        }
    }

    @PostMapping("/update-profile")
    public String updateUserProfile(@ModelAttribute("user") User user,
                                    Authentication authentication,
                                    RedirectAttributes redirectAttributes) {
        String userEmail = authentication.getName();
        // Updating the user profile with the new values
        User updatedUser = userService.updateUserProfile(userEmail, user.getFullName(), user.getPhone(), user.getAddress());

        // Checking if the update was successful
        if (updatedUser != null) {
            redirectAttributes.addFlashAttribute("message", "Profile updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile");
        }
        // Redirect to the user profile page after the update
        return "redirect:/client/homepage/userpage";
    }



}
