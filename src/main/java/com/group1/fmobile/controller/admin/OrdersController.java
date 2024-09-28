package com.group1.fmobile.controller.admin;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.service.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class OrdersController {
    private final OrdersService ordersService;

    @Autowired
    public OrdersController(OrdersService ordersService) {
        this.ordersService = ordersService;
    }

    @GetMapping(value = "/order")
    public String getOrderPage(Model model,
                               @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                               @RequestParam(name = "search", required = false) String search) {
        // Chuyển đổi pageNo thành trang bắt đầu từ 0
        int page = pageNo > 0 ? pageNo - 1 : 0;

        // Tạo Pageable với kích thước trang là 5
        Pageable pageable = PageRequest.of(page, 5); // Kích thước trang là 5

        // Lấy dữ liệu phân trang theo trạng thái
        Page<Orders> orderPage = ordersService.findOrdersByStatus(search, pageable);

        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", pageNo); // Hiển thị trang bắt đầu từ 1
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("totalItems", orderPage.getTotalElements());
        model.addAttribute("search", search); // Đưa search vào model để hiển thị trong JSP

        return "admin/order/order";
    }


}
