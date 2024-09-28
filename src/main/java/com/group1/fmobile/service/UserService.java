package com.group1.fmobile.service;

import com.group1.fmobile.domain.Role;
import com.group1.fmobile.domain.RoleType;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;



/**
 * Lớp Service này cung cấp các phương thức để thao tác với đối tượng User
 * như tìm kiếm, lưu trữ, và kiểm tra sự tồn tại của email trong cơ sở dữ liệu.
 * @author [Ha Van Dat]
 */
@Service
public class UserService {
    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;
    /**
     * Hàm khởi tạo UserService.
     *
     * @param userRepository đối tượng UserRepository cung cấp phương thức thao tác với cơ sở dữ liệu
     */

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }



    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    /**
     * Tìm kiếm người dùng bằng email.
     *
     * @param email email của người dùng cần tìm kiếm
     * @return đối tượng User tương ứng với email, hoặc null nếu không tìm thấy
     */

    @Transactional
    public User findByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }



    /**
     * Lưu đối tượng User vào cơ sở dữ liệu.
     *
     * @param user đối tượng User cần lưu
     * @return đối tượng User sau khi được lưu vào cơ sở dữ liệu
     */

    @Transactional
    public User saveUser(User user) {
        user.setRoles(new HashSet<>(List.of(new Role(1, RoleType.USER))));
        user.setCreationDate(LocalDate.now());
        user.setUpdatedAt(LocalDateTime.now());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return this.userRepository.save(user);
    }
    @Transactional
    public User saveAccount(User user) {
        return this.userRepository.save(user);
    }

    public List<User> getAllUser() {
        return this.userRepository.findAll();
    }

    public List<Object[]> findTotalPaymentsByUser() {
        return userRepository.findTotalPaymentsByUser();
    }

    // Lấy tổng tiền của người dùng kèm tìm kiếm theo tên đầy đủ
    public List<Object[]> findTotalPaymentsByUserWithSearch(String search) {
        return userRepository.findTotalPaymentsByUserWithSearch(search);
    }

    public Page<User> getAllPage(String search, Integer pageNo) {
        PageRequest pageRequest = PageRequest.of(pageNo - 1, 5);

        if (search != null && !search.isEmpty()) {
            return userRepository.searchUsersByFullName(search, pageRequest);
        } else {
            return userRepository.findAll(pageRequest);
        }
    }

    public Long countTotalUsers() {
        return this.userRepository.countTotalUsers();
    }

    public boolean checkEmailExist(String email){
        return this.userRepository.existsByEmail(email);
    }
    public String getPasswordByEmail(String email) {
        User user = userRepository.findByEmail(email);

        if (user == null) {
            throw new UsernameNotFoundException("Email không tồn tại");
        }
        return user.getPassword();
    }



    public Boolean existsByUserEmail(String email) {
        return this.userRepository.existsByEmail(email);
    }

    /**
     * Kiểm tra xem email đã tồn tại trong cơ sở dữ liệu hay chưa.
     *
     * @param email email cần kiểm tra
     * @return true nếu email đã tồn tại, ngược lại trả về false
     */

    /**
     * Lấy mật khẩu của người dùng dựa trên email.
     *
     * @param email email của người dùng cần lấy mật khẩu
     * @return chuỗi mật khẩu của người dùng
     * @throws UsernameNotFoundException nếu email không tồn tại trong cơ sở dữ liệu
     */

    public User updateUserProfile(String email, String fullName, String phone, String address) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            return userRepository.save(user);
        }
        return null;
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public Optional<User> findByFullName(String fullName) {
        return userRepository.findByFullName(fullName);
    }

}
