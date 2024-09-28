package com.group1.fmobile.service;


import com.group1.fmobile.domain.Image;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ImageService {
    List<Image> getAll();
    Image getById(long Id);
    void saveOrUpdate(Image image);
    void delete(long Id);

    List<Image> searchImages(String keyword);
    Page<Image> getAll(Integer pageNo);
    Page<Image> searchAndPaginationImage(String keyword, Integer pageNo);
}
