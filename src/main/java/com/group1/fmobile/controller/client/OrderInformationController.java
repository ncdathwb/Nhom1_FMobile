package com.group1.fmobile.controller.client;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.service.OrderInformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("client/homepage/")
public class OrderInformationController {
    private final OrderInformationService orderInformationService;
    @Autowired
    public OrderInformationController(OrderInformationService orderInformationService) {
        this.orderInformationService = orderInformationService;
    }

    @GetMapping("/orderinformation")
    public String getOrderInformation(@RequestParam("id") Long orderId, Model model) {
        Optional<Orders> orderOptional = orderInformationService.getOrderById(orderId);
        if (orderOptional.isPresent()) {
            model.addAttribute("order", orderOptional.get());
            return "client/homepage/orderinformation";
        } else {
            // Xử lý trường hợp không tìm thấy đơn hàng
            return "error/ordernotfound";
        }
    }
}
