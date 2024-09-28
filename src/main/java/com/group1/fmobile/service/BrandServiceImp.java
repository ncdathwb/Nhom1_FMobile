package com.group1.fmobile.service;

import com.group1.fmobile.domain.Brand;
import com.group1.fmobile.repository.BrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class BrandServiceImp implements BrandService{

    @Autowired
    private BrandRepository brandRepository;

    @Override
    public List<Brand> getAll() {
        return this.brandRepository.findAll();
    }

    @Override
    public Brand getById(long id) {
        Optional<Brand> brandOpt = this.brandRepository.findById(id);
        // Kiểm tra nếu thương hiệu tồn tại, nếu không thì ném ngoại lệ
        return brandOpt.orElseThrow(() -> new IllegalArgumentException("Thương hiệu không tồn tại với ID: " + id));
    }

    @Override
    public void saveOrUpdate(Brand brand) {
        // Kiểm tra tên thương hiệu đã tồn tại
        if (brand.getId() == null) {
            Brand existingBrand = brandRepository.findByBrandName(brand.getBrandName());
            if (existingBrand != null) {
                throw new IllegalArgumentException("Tên thương hiệu đã tồn tại.");
            }
        }
        // Lưu thương hiệu (thêm mới hoặc cập nhật)
        brandRepository.save(brand);
    }

    @Override
    public void delete(long id) {
        // Kiểm tra xem thương hiệu có tồn tại trước khi xóa
        if (!brandRepository.existsById(id)) {
            throw new IllegalArgumentException("Không thể xóa, thương hiệu không tồn tại với ID: " + id);
        }
        brandRepository.deleteById(id);
    }

}
