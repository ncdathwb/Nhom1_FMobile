package com.group1.fmobile.controller.client;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.repository.OrderRepository;
import com.group1.fmobile.repository.UserRepository;
import com.group1.fmobile.service.account.MailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/client")
public class OrderController {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailService mailService;

    @GetMapping("/order")
    public String orderPage(HttpSession session, Model model, @PageableDefault(size = 5) Pageable pageable) {

        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        String email = session.getAttribute("loggedInUser").toString();
        User user = userRepository.findByEmail(email);
        Page<Orders> page = orderRepository.findByUserId(user.getId(), pageable);

        model.addAttribute("listOrder", page.getContent());
        model.addAttribute("totalPage", page.getTotalPages());
        model.addAttribute("currentPage", pageable.getPageNumber());

        return "client/order/order";
    }

    @PostMapping("/cancel-order")
    public String cancelOrder(@RequestParam(value = "orderID") Long orderId) {
        Orders orders = orderRepository.findById(orderId).get();
        orders.setStatus("Canceled");
        orderRepository.save(orders);

        mailService.sendMail(orders.getUser().getEmail(),
                "Order Cancellation Notice",
                "Your order " + orders.getId() + " has been canceled at " + LocalDateTime.now());

        return "redirect:/order";
    }
}
