package com.group1.fmobile.controller.admin;

import com.group1.fmobile.domain.User;
import com.group1.fmobile.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminUserController {
    private final UserService userService;

    @Autowired
    public AdminUserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping(value = "/user")
    public String getAdminUserPage(Model model,
                                   @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                   @RequestParam(name = "search", required = false) String search) {
        // Lấy danh sách user cùng tổng tiền từ database
        List<Object[]> results = (search != null && !search.isEmpty())
                ? userService.findTotalPaymentsByUserWithSearch(search)
                : userService.findTotalPaymentsByUser();

        // Lấy dữ liệu phân trang
        Page<User> userPage = userService.getAllPage(search, pageNo);

        // Tạo danh sách User và gán tổng tiền vào thuộc tính 'amount'
        List<User> users = new ArrayList<>();
        for (Object[] result : results) {
            User user = (User) result[0];
            Double totalPayment = (Double) result[1];
            user.setAmount(totalPayment);  // Gán tổng tiền cho 'amount'
            users.add(user);
        }

        // Thêm danh sách users vào model
        model.addAttribute("newUser", new User());
        model.addAttribute("users", userPage.getContent());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("totalItems", userPage.getTotalElements());
        model.addAttribute("search", search); // Thêm giá trị search vào model

        return "admin/user/user";
    }

    @PostMapping(value = "/create/user")
    public String createUser(@Valid @ModelAttribute("newUser") User user, BindingResult bindingResult) {
        if(userService.existsByUserEmail(user.getEmail())) {
            bindingResult.rejectValue("email", "error.user", "Email already exists");
        }

        if(bindingResult.hasErrors()) {
            return "admin/user/user";
        }

        this.userService.saveUser(user);
        return "redirect:/admin/user";
    }

    // Cập nhật người dùng
    @GetMapping("/update/user/{id}")
    public String getUpdateUserForm(@PathVariable("id") Long id, Model model) {
        User userUpdate = userService.getUserById(id); // Lấy thông tin người dùng từ database
        model.addAttribute("newUser", userUpdate); // Đưa thông tin người dùng vào form
        return "admin/user/updateUser"; // Trả về trang form (dùng lại trang thêm mới)
    }

    @PostMapping("/update/user")
    public String updateUser(@ModelAttribute("newUser") User user) {
        this.userService.saveUser(user); // Cập nhật người dùng
        return "redirect:/admin/user"; // Sau khi cập nhật, quay lại trang danh sách người dùng
    }
}
