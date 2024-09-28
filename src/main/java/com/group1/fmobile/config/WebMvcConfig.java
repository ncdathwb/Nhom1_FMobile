package com.group1.fmobile.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
/**
 * Cấu hình cho Spring MVC trong ứng dụng.
 */
@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {
    /**
     * Tạo bean ViewResolver để xử lý việc phân giải view (tìm kiếm và hiển thị các tệp JSP).
     *
     * @return Đối tượng InternalResourceViewResolver đã được cấu hình.
     */
    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        return bean;
    }
    /**
     * Cấu hình ViewResolver cho Spring MVC.
     *
     * @param registry Đối tượng ViewResolverRegistry để đăng ký ViewResolver.
     */
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }
    /**
     * Thêm các trình xử lý tài nguyên (ResourceHandler) để ánh xạ các đường dẫn URL tới các vị trí thực tế trên đĩa hoặc trong classpath.
     *
     * @param registry Đối tượng ResourceHandlerRegistry để đăng ký ResourceHandler.
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");
        registry.addResourceHandler("/img/**").addResourceLocations("classpath:/resources/imgages/");
        registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/");
        registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/product");
        registry.addResourceHandler("/client/**").addResourceLocations("/resources/client/");
    }
    // validation Duy
    @Bean
    public MessageSource messageSource(){
        ReloadableResourceBundleMessageSource bundleMessageSource = new ReloadableResourceBundleMessageSource();
        bundleMessageSource.setBasename("classpath:messages");
        return bundleMessageSource;
    }

}
