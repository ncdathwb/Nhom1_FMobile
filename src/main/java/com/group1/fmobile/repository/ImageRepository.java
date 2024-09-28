package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    @Query("select i from Image i where i.image_name like %?1%")
    List<Image> searchImage(String keyword);
}
