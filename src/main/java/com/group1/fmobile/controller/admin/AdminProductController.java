package com.group1.fmobile.controller.admin;

import com.group1.fmobile.domain.Brand;
import com.group1.fmobile.domain.ProductCategory;
import com.group1.fmobile.domain.Product;
import com.group1.fmobile.repository.ProductRepository;
import com.group1.fmobile.service.BrandService;
import com.group1.fmobile.service.CategoryService;
import com.group1.fmobile.service.IProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminProductController {
    @Autowired
    private IProductService productService;

    @Autowired
    private BrandService brandService;

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductRepository productRepository;
    // Hiển thị danh sách san pham và form thêm mới
    @RequestMapping("/product")
    public String listProduct(Model model, @Param("keyword") String keyword,
                                            @RequestParam(name = "pageNo",
                                      defaultValue = "1") Integer pageNo) {
        Page<Product> products = productService.getAll(pageNo);
        List<Brand> brands = brandService.getAll();
        List<ProductCategory> categories = categoryService.getAll();
        if (keyword != null){
            products = this.productService.searchAndPaginationProduct(keyword,pageNo);
            model.addAttribute("keyword",keyword);
        }
        model.addAttribute("totalPage", products.getTotalPages());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("isEdit", false);  // Đặt biến cho trường hợp thêm mới
        model.addAttribute("products",products.getContent());
        model.addAttribute("brands", brands);  // Truyền danh sách thương hiệu
        model.addAttribute("categories", categories);  // Truyền danh sách danh mục
        model.addAttribute("product", new Product());  // Tạo đối tượng trống cho thêm mới
        return "admin/product/product";  // Luôn hiển thị form thêm mới mặc định
    }
    // Xử lý thêm mới hoặc cập nhật san pham
    @PostMapping("/product/saveOrUpdate")
    public String saveOrUpdateProduct(@ModelAttribute("product") @Valid Product product,
                                      BindingResult bindingResult, RedirectAttributes redirectAttributes, Model model) {
        // Lấy danh sách thương hiệu và danh mục để truyền lại nếu có lỗi
        List<Brand> brands = brandService.getAll();
        List<ProductCategory> categories = categoryService.getAll();

        // Kiểm tra xem tên sản phẩm đã tồn tại chưa
        if (productRepository.findByProductName(product.getProductName()) != null) {
            bindingResult.rejectValue("productName", "error.productName", "Product name already exists!");
        }

        if (bindingResult.hasErrors()) {
            // Truyền lại thông tin nếu form không hợp lệ
            model.addAttribute("brands", brands);
            model.addAttribute("categories", categories);
            model.addAttribute("product", product);  // Truyền lại sản phẩm với thông tin đã nhập
            return "admin/product/product";  // Quay lại trang nếu có lỗi
        }

        productService.saveOrUpdate(product);  // Lưu sản phẩm (thêm mới hoặc cập nhật)

        // Truyền thông điệp thành công bằng flash attribute
        redirectAttributes.addFlashAttribute("successMessage", "Product saved successfully!");

        return "redirect:/admin/product";  // Quay lại trang quản lý sau khi lưu
    }

    // Chỉnh sửa thương hiệu (lấy thông tin để đưa lên form)
    @GetMapping("/product/edit/{id}")
    public String editProduct(@PathVariable("id") Long id, Model model) {
        Product product = productService.getById(id);
        model.addAttribute("isEdit", true);  // Đặt biến để phân biệt cập nhật
        model.addAttribute("product", product);  // Đối tượng san pham được điền vào form để cập nhật
        List<Product> list = productService.getAll();
        List<Brand> brands = brandService.getAll();
        List<ProductCategory> categories = categoryService.getAll();
        model.addAttribute("brands", brands);  // Truyền danh sách thương hiệu
        model.addAttribute("categories", categories);  // Truyền danh sách danh mục
        return "admin/product/product";  // Hiển thị form với thông tin cập nhật
    }
    // Xóa san pham
    @GetMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id ) {
        productService.delete(id);
        return "redirect:/admin/product";  // Quay lại trang quản lý sau khi xóa
    }
}
