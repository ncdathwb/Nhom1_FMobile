package com.group1.fmobile.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;



@Entity
@Table(name = "PRODUCT")
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id", nullable = false)
    Long id;

    // LK Brand

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    Brand brand;

    // LK Product Category

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_category_id")
    ProductCategory productCategory;

    @NotBlank
    @Size(min = 1, max = 255)
    @Pattern(regexp = "^[a-zA-Z0-9 ]*$")
    @Column(name = "product_name", nullable = false)
    String productName;

    @NotNull
    @Min(value = 1)
    @Max(value = 999999)
    @Column(name = "price", nullable = false)
    double price;

    @NotNull
    @Min(value = 1)
    @Max(value = Integer.MAX_VALUE )
    @Column(name = "quantity", nullable = false)
    int quantity;

    @NotNull
    @Min(value = 1)
    @Max(value = Integer.MAX_VALUE )
    @Column(name = "sold")
    int sold;

    @NotBlank
    @Size(min = 1, max = 255)
    @Pattern(regexp = "^[a-zA-Z]*$")
    @Column(name = "color")
    String color;

    @Size( max = 255)
    @Pattern(regexp = "^$|^(?=.*\\d)(?=.*GB)[a-zA-Z0-9 ]*$")
    @Column(name = "ram", nullable = true)
    String ram;


    @Size(max = 255)
    @Lob
    @Column(name = "description")
    String description;


    @Column(name = "created_at")
    LocalDateTime createdAt;


    @Column(name = "updated_at")
    LocalDateTime updatedAt;


    // LK Image
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    List<Image> images;

    // LK Orders Detail
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    List<OrdersDetail> ordersDetails;

    // Gọi hàm trước khi lưu đối tượng
    @PrePersist
    public void prePersist() {
        LocalDateTime now = LocalDateTime.now();
        this.createdAt = now;
        this.updatedAt = now; // Gán ngày tạo cho ngày cập nhật
    }

    // Gọi hàm trước khi cập nhật đối tượng
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

}