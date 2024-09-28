package com.group1.fmobile.controller.admin;

import com.group1.fmobile.service.OrdersService;
import com.group1.fmobile.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/admin")
public class DashboardController {
    private final OrdersService ordersService;

    private final UserService userService;

    @Autowired
    public DashboardController(OrdersService ordersService, UserService userService) {
        this.ordersService = ordersService;
        this.userService = userService;
    }

    @GetMapping("/home")
    public String getDashboardPage(Model model){
        Long totalUsers = userService.countTotalUsers();
        Long totalOrders = ordersService.countTotalOrder();
        Double totalRevenue = ordersService.countTotalRevenue();

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevene", totalRevenue);
        return "admin/dashboard/dashboard";
    }

}