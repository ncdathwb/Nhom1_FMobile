package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.domain.ProductCategory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    @Override
    Optional<Product> findById(Long id);

    @Query("SELECT p FROM Product p WHERE p.productCategory.id = 1 ORDER BY p.createdAt DESC")
    List<Product> findAllMobileByOrderByCreatedAtDesc(Pageable pageable);

    @Query("SELECT p FROM Product p WHERE p.productCategory.id = 1 ORDER BY p.sold DESC")
    List<Product> findAllMobileByOrderBySoldDesc(Pageable pageable);


    // Lấy 4 sản phẩm mới nhất dựa trên product_category_id
    List<Product> findTop4ByProductCategoryIdOrderByCreatedAtDesc(Long productCategoryId);

    List<Product> findTop8ByProductCategoryIdOrderBySoldDesc(Long productCategoryId);

    // Lấy 4 table bán chạy nhất
    @Query("SELECT p FROM Product p WHERE p.productCategory.id = 3 ORDER BY p.sold DESC")
    List<Product> findAllTabletByOrderByPriceDesc(Pageable pageable);

    @Query("SELECT p FROM Product p WHERE p.productCategory.categoryName = :categoryName")
    Page<Product> findByCategoryName(@Param("categoryName") String categoryName, Pageable pageable);

    //Search sản phẩm
    @Query("FROM Product p WHERE p.productName LIKE CONCAT('%', :name, '%') OR p.color LIKE CONCAT('%', :name, '%') OR p.ram LIKE CONCAT('%', :name, '%')")
    Page<Product> searchProducts(@Param("name") String name, Pageable pageable);

    // Đếm số lượng sản phẩm kết quả theo điều kiện tìm kiếm
    @Query("SELECT COUNT(p) FROM Product p WHERE p.productName LIKE %:name% OR p.color LIKE %:name% OR p.ram LIKE %:name%")
    long countSearchResults(@Param("name") String name);

    //Lọc sản phẩm
    @Query("SELECT p FROM Product p WHERE " +
            "(:brands IS NULL OR p.brand.brandName IN :brands) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
            "AND (:rams IS NULL OR p.ram IN :rams) " +
            "AND (:color IS NULL OR p.color = :color) " +
            "AND (:searchQuery IS NULL OR LOWER(p.productName) LIKE LOWER(CONCAT('%', :searchQuery, '%')))")
    Page<Product> filterProducts(
            @Param("brands") List<String> brands,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            @Param("rams") List<String> rams,
            @Param("color") String color,
            @Param("searchQuery") String searchQuery,
            Pageable pageable);

    // search product Duy
    @Query("SELECT p FROM Product p WHERE " +
            "p.productName LIKE %:keyword% OR " +
            "p.color LIKE %:keyword% OR " +
            "p.ram LIKE %:keyword%")
    List<Product> searchProduct(String keyword);
    // tim product de validaton
    Product findByProductName(String productName);

}

