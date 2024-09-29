package com.group1.fmobile.service;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.repository.ProductRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import java.util.*;


@Service
public class ProductServices {
    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    public ProductServices(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    private final ProductRepository productRepository;

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public List<Product> getNewestMobileProducts(int limit) {
        Pageable pageable = PageRequest.of(0, limit);
        return productRepository.findAllMobileByOrderByCreatedAtDesc(pageable);
    }

    public List<Product> getBestSellingMobileProducts(int limit) {
        Pageable pageable = PageRequest.of(0, limit);
        return productRepository.findAllMobileByOrderBySoldDesc(pageable);
    }

    public List<Product> getTabletProducts(int limit) {
        Pageable pageable = PageRequest.of(0, limit);
        return productRepository.findAllTabletByOrderByPriceDesc(pageable);
    }

    public Map<String, Integer> countProductsByCategory(List<Product> products) {
        Map<String, Integer> categoryCounts = new HashMap<>();
        for (Product product : products) {
            String categoryName = product.getProductCategory().getCategoryName().toLowerCase();
            categoryCounts.merge(categoryName, 1, Integer::sum);
        }
        return categoryCounts;
    }

    public Page<Product> findByCategory(String categoryName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return productRepository.findByCategoryName(categoryName, pageable);
    }

    public Page<Product> searchByQuery(String query, int page, int size) {
        // Tạo đối tượng Pageable từ page và size
        Pageable pageable = PageRequest.of(page, size);

        // Tách chuỗi query thành các từ khóa
        String[] keywords = query.toLowerCase().split("\\s+");

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < keywords.length; i++) {
            if (i > 0) {
                sb.append(" AND ");
            }
            sb.append("(")
                    .append("LOWER(p.productName) LIKE CONCAT('%', :keyword").append(i).append(", '%') ")
                    .append("OR LOWER(b.brandName) LIKE CONCAT('%', :keyword").append(i).append(", '%') ")
                    .append("OR LOWER(c.categoryName) LIKE CONCAT('%', :keyword").append(i).append(", '%')")
                    .append(")");
        }

        String finalQuery = "SELECT DISTINCT p FROM Product p " +
                "LEFT JOIN p.productCategory c " +
                "LEFT JOIN p.brand b " +
                "WHERE " + sb.toString();

        TypedQuery<Product> typedQuery = entityManager.createQuery(finalQuery, Product.class);
        for (int i = 0; i < keywords.length; i++) {
            typedQuery.setParameter("keyword" + i, keywords[i]);
        }

        // Lấy danh sách sản phẩm từ truy vấn
        List<Product> productList = typedQuery.getResultList();

        // Phân trang kết quả
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), productList.size());

        return new PageImpl<>(productList.subList(start, end), pageable, productList.size());
    }


    public List<Product> filterProduct(String brands, String minPriceStr, String maxPriceStr, String rams, int productCategoryId) {

        // Tạo query ban đầu
        String query = "SELECT p FROM Product p WHERE p.productCategory.id = :productCategoryId";

        // Xử lý brands
        List<String> brandList = null;
        if (brands != null && !brands.isEmpty()) {
            brandList = Arrays.asList(brands.split(","));
            query += " AND p.brand.brandName IN :brands";
        }

        // Xử lý rams
        List<String> ramList = null;
        if (rams != null && !rams.isEmpty()) {
            ramList = Arrays.asList(rams.split(","));
            query += " AND p.ram IN :rams";
        }

        // Xử lý giá
        List<Double[]> priceRanges = new ArrayList<>();


        // Tách chuỗi minPrice và maxPrice thành mảng các giá trị
        if ((minPriceStr != null && !minPriceStr.isEmpty()) && (maxPriceStr != null && !maxPriceStr.isEmpty())) {
            String[] minPrices = minPriceStr.split(",");
            String[] maxPrices = maxPriceStr.split(",");

            for (int i = 0; i < minPrices.length && i < maxPrices.length; i++) {
                Double minPrice = Double.parseDouble(minPrices[i]);
                Double maxPrice = Double.parseDouble(maxPrices[i]);
                priceRanges.add(new Double[]{minPrice, maxPrice});
            }
        } else {
            Double minPrice = 0.0;
            Double maxPrice = Double.MAX_VALUE;
            priceRanges.add(new Double[]{minPrice, maxPrice});
        }

        // Thêm điều kiện lọc theo khoảng giá
        if (!priceRanges.isEmpty()) {
            query += " AND (";
            for (int i = 0; i < priceRanges.size(); i++) {
                if (i > 0) {
                    query += " OR ";
                }
                query += "(p.price BETWEEN :minPrice" + i + " AND :maxPrice" + i + ")";
            }
            query += ")";
        }

        // Sau khi hoàn tất việc xây dựng query, tạo TypedQuery
        TypedQuery<Product> typedQuery = entityManager.createQuery(query, Product.class);

        // Gán các tham số vào query
        typedQuery.setParameter("productCategoryId", productCategoryId);

        // Gán các tham số vào query
        if (brandList != null) {
            typedQuery.setParameter("brands", brandList);
        }

        if (ramList != null) {
            typedQuery.setParameter("rams", ramList);
        }

        // Thiết lập các tham số khoảng giá
        for (int i = 0; i < priceRanges.size(); i++) {
            Double[] range = priceRanges.get(i);
            typedQuery.setParameter("minPrice" + i, range[0]);
            typedQuery.setParameter("maxPrice" + i, range[1]);
        }
        return typedQuery.getResultList();
    }

}
