package com.group1.fmobile.controller.guest;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.service.ProductServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class GuestHomePageController {

    @Autowired
    public GuestHomePageController(ProductServices productServices){
        this.productServices = productServices;
    }

    private final ProductServices productServices;

    @GetMapping("/")
    public String getHome(Model model) {
        List<Product> newestMobileProducts = productServices.getNewestMobileProducts(4);
        List<Product> bestSellingMobileProducts = productServices.getBestSellingMobileProducts(8);
        List<Product> tabletProducts = productServices.getTabletProducts(4);
        model.addAttribute("newestMobileProducts", newestMobileProducts);
        model.addAttribute("bestSellingMobileProducts", bestSellingMobileProducts);
        model.addAttribute("tabletProducts", tabletProducts);
        return "guest/homepage/guestIndex";
    }
}
