package com.group1.fmobile.service;

import com.group1.fmobile.domain.Image;
import com.group1.fmobile.domain.ProductCategory;
import com.group1.fmobile.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImp implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<ProductCategory> getAll() {
        return this.categoryRepository.findAll();
    }

    @Override
    public ProductCategory getById(long id) {
        Optional<ProductCategory> categoryOpt = this.categoryRepository.findById(id);
        // Kiểm tra nếu danh mục tồn tại, nếu không thì ném ngoại lệ
        return categoryOpt.orElseThrow(() -> new IllegalArgumentException("Danh mục không tồn tại với ID: " + id));
    }

    @Override
    public void saveOrUpdate(ProductCategory category) {
        if (category.getId() != null) {
            // Nếu danh mục đã có ID, kiểm tra xem nó có tồn tại không
            if (!categoryRepository.existsById(category.getId())) {
                throw new IllegalArgumentException("Danh mục không tồn tại để cập nhật với ID: " + category.getId());
            }
        }
        // Sử dụng save() cho cả thêm mới và cập nhật
        categoryRepository.save(category);
    }

    @Override
    public void delete(long id) {
        // Kiểm tra xem danh mục có tồn tại trước khi xóa
        if (!categoryRepository.existsById(id)) {
            throw new IllegalArgumentException("Không thể xóa, danh mục không tồn tại với ID: " + id);
        }
        categoryRepository.deleteById(id);
    }
}
