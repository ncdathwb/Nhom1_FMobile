package com.group1.fmobile.controller.guest;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.service.ProductServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/guest")
public class GuestSearchPageController {
    @Autowired
    public GuestSearchPageController(ProductServices productServices){
        this.productServices = productServices;
    }

    private final ProductServices productServices;

    @GetMapping("/search")
    public String search(@RequestParam("query") String query,
                         @RequestParam(defaultValue  = "0") int page,
                         Model model) {
    int size = 16;
        if (query == null || query.trim().isEmpty()) {
            return "guest/errorpage/noDataFound";
        }
        String category = query.toLowerCase();
        Page<Product> productPage;
        long totalProducts = 0L;
        switch (category) {
            case "mobile":
            case "laptop":
            case "tablet":
            case "accessories":
                productPage = productServices.findByCategory(category, page, size);
                totalProducts = productPage.getTotalElements();
                if(totalProducts != 0){
                    model.addAttribute("products", productPage.getContent());
                    model.addAttribute("currentPage", productPage.getNumber());
                    model.addAttribute("totalPages", productPage.getTotalPages());
                    model.addAttribute("results", totalProducts);
                    return "guest/searchpage/" + category;
                }
            default:
                break;
        }
        productPage = productServices.searchByQuery(query.trim(), page, 15);
        totalProducts = productPage.getTotalElements();
        if(totalProducts!=0){
            model.addAttribute("products", productPage.getContent());
            model.addAttribute("currentPage", productPage.getNumber());
            model.addAttribute("totalPages", productPage.getTotalPages());
            model.addAttribute("results", totalProducts);
            return "guest/searchpage/allProducts";
        }else{
            return "guest/errorpage/noDataFound";
        }

    }

}

