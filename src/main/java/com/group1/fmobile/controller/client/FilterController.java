package com.group1.fmobile.controller.client;

import com.group1.fmobile.domain.Product;


import com.group1.fmobile.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/client")
public class FilterController {
    @Autowired
    public FilterController(ProductService productService){

        this.productService = productService;
    }

    private final ProductService productService;
    @GetMapping("/filter")
    public String listProducts(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "brands", required = false) List<String> brands,
            @RequestParam(value = "priceRange", required = false) String priceRange,
            @RequestParam(value = "rams", required = false) List<String> rams,
            @RequestParam(value = "color", required = false) String color,
            @RequestParam(value = "searchQuery", required = false) String searchQuery,
            Model model) {

        int pageSize = 6; // Số sản phẩm trên mỗi trang

        // Tính toán khoảng giá dựa trên giá trị price
        Double minPrice = null, maxPrice = null;
        if (priceRange != null && !priceRange.isEmpty()) {
            String[] priceParts = priceRange.split("-");
            if (priceParts.length == 2) {
                minPrice = Double.parseDouble(priceParts[0]);
                maxPrice = Double.parseDouble(priceParts[1]);
            }
        }
        // Lấy dữ liệu phân trang và lọc từ dịch vụ
            Page<Product> productPage = productService.filterProducts(page, pageSize, brands, minPrice, maxPrice, rams, color, searchQuery);

        // Truyền dữ liệu sản phẩm và phân trang tới model
        model.addAttribute("allProducts", productPage.getContent());
        model.addAttribute("currentPage", productPage.getNumber() + 1);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("searchQuery", searchQuery);

        // Truyền lại các tham số lọc hiện tại để giữ trạng thái lọc
            model.addAttribute("selectedBrands", brands);
            model.addAttribute("selectedPriceRange", priceRange);
            model.addAttribute("selectedRams", rams);
            model.addAttribute("selectedColor", color);

        return "client/homepage/allProducts";
    }
}
