package com.group1.fmobile.service;

import com.group1.fmobile.domain.Image;
import com.group1.fmobile.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ImageServiceImp implements ImageService{
    @Autowired
    private ImageRepository imageRepository;

    @Override
    public List<Image> getAll() {
        return this.imageRepository.findAll();
    }

    @Override
    public Image getById(long id) {
        Optional<Image> imageOpt = this.imageRepository.findById(id);
        // Kiểm tra nếu hình ảnh tồn tại, nếu không thì ném ngoại lệ
        return imageOpt.orElseThrow(() -> new IllegalArgumentException("Hình ảnh không tồn tại với ID: " + id));
    }

    @Override
    public void saveOrUpdate(Image image) {
        // Kiểm tra xem hình ảnh có ID không và có tồn tại không trước khi cập nhật
        if (image.getId() != null) {
            if (!imageRepository.existsById(image.getId())) {
                throw new IllegalArgumentException("Hình ảnh không tồn tại để cập nhật với ID: " + image.getId());
            }
        }
        imageRepository.save(image);
    }

    @Override
    public void delete(long id) {
        // Kiểm tra xem hình ảnh có tồn tại trước khi xóa
        if (!imageRepository.existsById(id)) {
            throw new IllegalArgumentException("Không thể xóa, hình ảnh không tồn tại với ID: " + id);
        }
        imageRepository.deleteById(id);
    }

    @Override
    public List<Image> searchImages(String keyword) {
        return this.imageRepository.searchImage(keyword);
    }

    @Override
    public Page<Image> getAll(Integer pageNo) {
        Pageable pageable = PageRequest.of(pageNo-1,5);
        return this.imageRepository.findAll(pageable);
    }

    @Override
    public Page<Image> searchAndPaginationImage(String keyword, Integer pageNo) {
        // lay list toan bo imgae
        List list = this.searchImages(keyword);
        Pageable pageable = PageRequest.of(pageNo-1,5);
        Integer start = (int) pageable.getOffset();
        Integer end = (int) ((pageable.getOffset() + pageable.getPageSize()) > list.size() ? list.size() :  pageable.getOffset() + pageable.getPageSize());
        list = list.subList(start,end);
        return new PageImpl<Image>(list,pageable,this.searchImages(keyword).size());
    }
}
