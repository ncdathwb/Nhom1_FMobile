package com.group1.fmobile.controller.client;

import com.group1.fmobile.domain.Product;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;

@Controller
@RequestMapping("/client")
public class CheckOutController {

    @GetMapping("checkout-page")
    public String checkoutPage(HttpSession session, Model model) {
        @SuppressWarnings("unchecked")
        HashMap<Product, Long> cart = (HashMap<Product, Long>) session.getAttribute("cartProducts");
        double totalAmount = (double) session.getAttribute("totalAmount");

        model.addAttribute("cart", cart);
        model.addAttribute("totalAmount", totalAmount);

        return "guest/searchpage/checkout";
    }
}
