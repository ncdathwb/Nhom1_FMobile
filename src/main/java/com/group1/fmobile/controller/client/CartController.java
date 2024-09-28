//package com.group1.fmobile.controller.client;
//
//import com.group1.fmobile.domain.Product;
//
//import com.group1.fmobile.service.ProductService;
//import jakarta.servlet.http.HttpSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Controller
//@RequestMapping("/cart")
//public class CartController {
//
//    @Autowired
//    private ProductService productService;

//    @GetMapping("/add")
//    public String addToCart(@RequestParam("productId") Long productId, HttpSession session) {
//        // Lấy giỏ hàng từ session
//        HashMap<Long, Integer> cart = (HashMap<Long, Integer>) session.getAttribute("cart");
//
//        if (cart == null) {
//            cart = new HashMap<>(); // Khởi tạo giỏ hàng nếu chưa có
//        }
//
//        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
//        if (cart.containsKey(productId)) {
//            // Tăng số lượng sản phẩm nếu đã có
//            cart.put(productId, cart.get(productId) + 1);
//        } else {
//            // Thêm sản phẩm mới với số lượng là 1
//            cart.put(productId, 1);
//        }

//        // Tính tổng số lượng sản phẩm trong giỏ
//        int totalQuantity = cart.values().stream().mapToInt(Integer::intValue).sum();
//
//        // Lưu giỏ hàng và tổng số lượng sản phẩm vào session
//        session.setAttribute("cart", cart);
//        session.setAttribute("cartCount", totalQuantity);
//
//        // Chuyển hướng về trang hiện tại hoặc trang giỏ hàng
//        return "redirect:/";
//    }


//    @PostMapping("/checkout")
//    public String checkout(HttpSession session, @RequestParam("productId[]") String[] productIds,
//                           @RequestParam("productQuantity[]") String[] quantities,
//                           @RequestParam("totalAmount") String total) {
//        HashMap<Product, Long> cartProducts = new HashMap<Product, Long>();
//        Double totalAmount = Double.parseDouble(total);
//        for (int i = 0; i < productIds.length; i++) {
//            Long id = Long.parseLong(productIds[i]);
//            Long quantity = Long.parseLong(quantities[i]);
//            Product product = productService.getProductById(id);
//            if (product != null) {
//                cartProducts.put(product, quantity);
//            }
//        }
//        session.setAttribute("cartProducts", cartProducts);
//        session.setAttribute("totalAmount", totalAmount);
//        return "redirect:/checkout-page";
//    }
//}
