package com.group1.fmobile.service.account;



import org.springframework.stereotype.Service;
import java.util.Random;
import java.util.concurrent.TimeUnit;




import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
/**
 * Dịch vụ tạo otp.
 * @author [Ha Van Dat]
 */
@Service
public class OtpService {

    // Cấu hình Cache sử dụng Caffeine
    private final Cache<String, String> otpCache = Caffeine.newBuilder()
            .expireAfterWrite(5, TimeUnit.MINUTES)
            .build();

    /**
     * Tạo một mã OTP mới gồm 6 chữ số.
     *
     * @return Mã OTP mới được tạo.
     */

    public String generateOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    /**
     * Lưu trữ mã OTP vào Caffeine Cache.
     *
     * @param key Khóa để truy cập mã OTP.
     * @param otp Mã OTP cần lưu trữ.
     */
    public void saveOtp(String key, String otp) {
        otpCache.put(key, otp);
    }

    /**
     * Xác minh mã OTP với khóa và mã OTP cung cấp.
     *
     * @param key  Khóa để truy cập mã OTP.
     * @param otp  Mã OTP cần xác minh.
     * @return true nếu mã OTP hợp lệ và chưa hết hạn, false nếu không.
     */
    public boolean verifyOtp(String key, String otp) {
        String cachedOtp = otpCache.getIfPresent(key);
        return cachedOtp != null && cachedOtp.equals(otp);
    }

    /**
     * Xóa mã OTP khỏi bộ nhớ đệm.
     *
     * @param key Khóa để truy cập mã OTP.
     */
    public void removeOtp(String key) {
        otpCache.invalidate(key);
    }
}
