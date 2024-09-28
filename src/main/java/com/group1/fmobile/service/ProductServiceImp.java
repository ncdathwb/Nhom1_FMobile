package com.group1.fmobile.service;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public class ProductServiceImp implements IProductService{
    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<Product> getAll() {
        return this.productRepository.findAll();
    }

    @Override
    public Product getById(long Id) {
        return this.productRepository.findById(Id).get();
    }

    @Override
    @Transactional
    public void saveOrUpdate(Product product) {
        productRepository.save(product);
    }

    @Override
    public void delete(long Id) {
        productRepository.deleteById(Id);
    }

    @Override
    public Page<Product> getAll(Integer pageNo) {
        Pageable pageable = PageRequest.of(pageNo-1,5);
        return this.productRepository.findAll(pageable);
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        return this.productRepository.searchProduct(keyword);
    }

    @Override
    public Page<Product> searchAndPaginationProduct(String keyword, Integer pageNo) {
        List list = this.searchProducts(keyword);
        Pageable pageable = PageRequest.of(pageNo-1,5);
        Integer start = (int) pageable.getOffset();
        Integer end =(int) ((pageable.getOffset() + pageable.getPageSize()) > list.size() ? list.size() :  pageable.getOffset() + pageable.getPageSize());
        list = list.subList(start,end);
        return new PageImpl<Product>(list,pageable,this.searchProducts(keyword).size());

    }
}
