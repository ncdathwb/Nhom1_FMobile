package com.group1.fmobile.controller.client;

import com.group1.fmobile.domain.dto.OrderDTO;
import com.group1.fmobile.domain.dto.OrderHistoryDTO;
import com.group1.fmobile.service.PurchaseHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("client/homepage/purchase-history")
public class PurchaseController {
    private final PurchaseHistoryService purchaseHistoryService;

    @Autowired
    public PurchaseController(PurchaseHistoryService purchaseHistoryService) {
        this.purchaseHistoryService = purchaseHistoryService;
    }


    @GetMapping
    public String getPurchaseHistory(Model model, Principal principal) {
        String userEmail = principal.getName();
        List<OrderHistoryDTO> orders = purchaseHistoryService.getPurchaseHistory(userEmail);
        model.addAttribute("orders", orders);
        return "client/homepage/purchase-history";  // Tên của file JSP
    }

    @PostMapping("/delete/{orderId}")
    @ResponseBody
    public ResponseEntity<String> deleteOrder(@PathVariable Long orderId, Principal principal) {
        String userEmail = principal.getName();
        boolean deleted = purchaseHistoryService.deleteOrder(orderId, userEmail);
        if (deleted) {
            return ResponseEntity.ok("Order deleted successfully");
        } else {
            return ResponseEntity.badRequest().body("Failed to delete order");
        }
    }

}
