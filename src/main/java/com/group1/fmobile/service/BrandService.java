package com.group1.fmobile.service;

import com.group1.fmobile.domain.Brand;

import java.util.List;

public interface BrandService {
    List<Brand> getAll();
    Brand getById(long Id);
    void saveOrUpdate(Brand brand);
    void delete(long Id);

}
