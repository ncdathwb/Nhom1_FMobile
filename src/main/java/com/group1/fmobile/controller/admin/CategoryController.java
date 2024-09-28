package com.group1.fmobile.controller.admin;

import com.group1.fmobile.domain.ProductCategory;
import com.group1.fmobile.repository.CategoryRepository;
import com.group1.fmobile.service.CategoryService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CategoryRepository categoryRepository; // Tiêm CategoryRepository

    // Hiển thị danh sách danh mục và form thêm mới
    @RequestMapping("/category")
    public String listCategory(Model model) {
        List<ProductCategory> list = categoryService.getAll();
        model.addAttribute("categories", list);
        model.addAttribute("isEdit", false);
        model.addAttribute("category", new ProductCategory());
        return "admin/category/category";
    }

    // Xử lý thêm mới hoặc cập nhật danh mục
    @PostMapping("/category/saveOrUpdate")
    public String saveOrUpdateCategory(@ModelAttribute("category") @Valid ProductCategory category,
                                       BindingResult bindingResult, Model model) {
        // Kiểm tra xem tên danh mục đã tồn tại chưa
        if (categoryRepository.findByCategoryName(category.getCategoryName()) != null) {
            bindingResult.rejectValue("categoryName", "error.categoryName", "Category name already exists!");
        }

        // Kiểm tra lỗi từ Validation
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.getAll()); // Cập nhật lại danh sách danh mục
            return "admin/category/category";  // Trả về trang form nếu có lỗi
        }

        categoryService.saveOrUpdate(category); // Lưu danh mục (thêm mới hoặc cập nhật)
        return "redirect:/admin/category"; // Quay lại trang quản lý sau khi lưu
    }

    // Chỉnh sửa danh mục (lấy thông tin để đưa lên form)
    @GetMapping("/category/edit/{id}")
    public String editCategory(@PathVariable("id") Long id, Model model) {
        ProductCategory category = categoryService.getById(id);
        model.addAttribute("category", category);
        model.addAttribute("isEdit", true);
        model.addAttribute("categories", categoryService.getAll());
        return "admin/category/category";
    }

    // Xóa danh mục
    @GetMapping("/category/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id) {
        categoryService.delete(id);
        return "redirect:/admin/category"; // Quay lại trang quản lý sau khi xóa
    }
}
