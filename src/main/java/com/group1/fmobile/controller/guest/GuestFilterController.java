package com.group1.fmobile.controller.guest;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.service.ProductServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/guest")
public class GuestFilterController {
    @Autowired
    public GuestFilterController(ProductServices productServices) {
        this.productServices = productServices;
    }

    private final ProductServices productServices;

    @GetMapping("/filter")
    public String filterProducts(
            @RequestParam(value = "brands", required = false) String brands,
            @RequestParam(value = "rams", required = false) String rams,
            @RequestParam(value = "minPrice", required = false) String minPriceStr,
            @RequestParam(value = "maxPrice", required = false) String maxPriceStr,
            @RequestParam(value = "productCategory", required = false) String productCategoryStr,
            Model model) {

        int productCategoryId = Integer.parseInt(productCategoryStr);
        List<Product> listProducts = productServices.filterProduct(brands, minPriceStr, maxPriceStr, rams, productCategoryId);

        model.addAttribute("products", listProducts);
        return "guest/searchpage/fragments/productList";
    }

}

