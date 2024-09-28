package com.group1.fmobile.service;

import com.group1.fmobile.domain.Role;
import com.group1.fmobile.domain.RoleType;
import com.group1.fmobile.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * Lớp Service này cung cấp các phương thức để thao tác với đối tượng Role
 * như lưu trữ và tìm kiếm theo tên của Role.
 */
@Service
public class RoleService {
    private final RoleRepository roleRepository;

    /**
     * Hàm khởi tạo RoleService.
     *
     * @param roleRepository đối tượng RoleRepository cung cấp các phương thức thao tác với cơ sở dữ liệu.
     */
    @Autowired
    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    /**
     * Lưu đối tượng Role vào cơ sở dữ liệu.
     *
     * @param role đối tượng Role cần lưu
     * @return đối tượng Role sau khi được lưu vào cơ sở dữ liệu
     */
    @Transactional
    public Role save(Role role) {
        return this.roleRepository.save(role);
    }

    /**
     * Tìm kiếm đối tượng Role dựa trên tên của Role.
     *
     * @param name tên Role cần tìm kiếm
     * @return một Optional chứa Role nếu tìm thấy, ngược lại trả về Optional trống
     */
    @Transactional
    public Optional<Role> findByName(RoleType name) {
        return this.roleRepository.findByName(name);
    }
}
