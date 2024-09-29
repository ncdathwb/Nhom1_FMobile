package com.group1.fmobile.controller.guest;

import com.group1.fmobile.domain.*;
import com.group1.fmobile.domain.dto.OrderDTO;
import com.group1.fmobile.repository.*;
import com.group1.fmobile.service.PaymentMethodService;
import com.group1.fmobile.service.ProductServices;
import com.group1.fmobile.service.account.MailService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/checkout")
@Transactional
public class GuestCheckOutController {

    private final ProductServices productServices;
    private final UserRepository userRepository;
    private final PaymentMethodService paymentMethodService;
    private final PaymentMethodRepository paymentMethodRepository;
    private final DiscountRepository discountRepository;
    private final OrderRepository orderRepository;
    private final OrdersDetailRepository orderDetailRepository;
    private final MailService mailService;
    private final ProductRepository productRepository;

    private static final Logger logger = LoggerFactory.getLogger(GuestCheckOutController.class);

    public GuestCheckOutController(ProductServices productServices, UserRepository userRepository,
                                   PaymentMethodService paymentMethodService, PaymentMethodRepository paymentMethodRepository,
                                   DiscountRepository discountRepository, OrderRepository orderRepository,
                                   OrdersDetailRepository orderDetailRepository, MailService mailService,
                                   ProductRepository productRepository) {
        this.productServices = productServices;
        this.userRepository = userRepository;
        this.paymentMethodService = paymentMethodService;
        this.paymentMethodRepository = paymentMethodRepository;
        this.discountRepository = discountRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.mailService = mailService;
        this.productRepository = productRepository;
    }

    @GetMapping
    public String checkout(HttpSession session,
                           @RequestParam(value = "productId[]", required = false) String[] productIds,
                           @RequestParam(value = "productQuantity[]", required = false) String[] quantities,
                           @RequestParam(value = "totalAmount", required = false) String total,
                           Model model, Principal principal) {
        Map<Product, Long> cartProducts = createCartProducts(productIds, quantities);
        Double totalAmount = Double.parseDouble(total);

        setSessionAttributes(session, cartProducts, totalAmount);

        if (principal != null) {
            String username = principal.getName();
            User user = userRepository.findByEmail(username);
            if (user != null) {
                OrderDTO orderDTO = new OrderDTO();
                orderDTO.setFullName(user.getFullName());
                orderDTO.setAddress(user.getAddress());
                orderDTO.setPhone(user.getPhone());
                orderDTO.setEmail(user.getEmail());
                model.addAttribute("orderDTO", orderDTO);
                model.addAttribute("user", user);

                // Áp dụng giảm giá chỉ cho người dùng đã đăng nhập
                Discount discount = applyDiscount(totalAmount);
                if (discount != null) {
                    model.addAttribute("discount", discount);
                    model.addAttribute("discountedAmount", totalAmount - discount.getDiscountValue());
                }

                // Tính tổng tiền mua từ trước đến giờ
                double totalSpent = calculateTotalSpent(user);
                model.addAttribute("totalSpent", totalSpent);
            }
        }

        setModelAttributes(model, cartProducts, totalAmount, principal);
        return "guest/searchpage/checkout";

    }

    @PostMapping("/checkout-not-login")
    @Transactional
    public String createOrderNotLogin(HttpSession session, Model model,
                                      @RequestParam(value = "paymentId") Long paymentId,
                                      @RequestParam(value = "phone") String phone,
                                      @RequestParam(value = "address") String address,
                                      @RequestParam(value = "fullName") String fullName,
                                      @RequestParam(value = "email") String email) {
        Map<Product, Long> cartProducts = getCartProducts(session);
        if (isCartEmpty(cartProducts, model)) {
            return "guest/searchpage/checkout";
        }

        PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentId).orElseThrow();
        Double total = calculateTotal(cartProducts);

        if (!updateProductQuantities(cartProducts, model)) {
            return "guest/searchpage/checkout";
        }

        Orders order = createOrder(null, paymentMethod, address, total, fullName, phone, email);
        saveOrderDetails(order, cartProducts);
        sendConfirmationEmail(order, email);

        clearCart(session);
        logger.info("After clearCart - Session attributes: {}", safeToString(Collections.list(session.getAttributeNames())));
        return "redirect:/";
    }

    @PostMapping
    @Transactional
    public String createOrder(@Valid @ModelAttribute("orderDTO") OrderDTO orderDTO,
                              HttpSession session, Model model, Principal principal,
                              @RequestParam(value = "paymentId") Long paymentId,
                              @RequestParam(value = "phone") String phone,
                              @RequestParam(value = "address") String address,
                              @RequestParam(value = "fullName") String fullName) {
        if (principal == null) {
            return "redirect:/login";
        }

        String username = principal.getName();
        User user = userRepository.findByEmail(username);
        try {
            Map<Product, Long> cartProducts = getCartProducts(session);
            if (isCartEmpty(cartProducts, model)) {
                return "guest/searchpage/checkout";
            }
            PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentId).orElseThrow();
            Double total = calculateTotal(cartProducts);

            // Áp dụng giảm giá chỉ cho người dùng đã đăng nhập
            Discount discount = applyDiscount(total);
            if (discount != null) {
                total -= discount.getDiscountValue();
            }

            if (!updateProductQuantities(cartProducts, model)) {
                return "guest/searchpage/checkout";
            }


            Orders order = createOrder(user, paymentMethod, address, total, fullName, phone, user.getEmail());

            order.setDiscount(discount);  // Lưu thông tin giảm giá vào đơn hàng

            saveOrderDetails(order, cartProducts);
            sendConfirmationEmail(order, user.getEmail());

            // Cập nhật tổng tiền mua của user
            updateUserAmount(user, total);

            clearCart(session);
            logger.info("After clearCart - Session attributes: {}", safeToString(Collections.list(session.getAttributeNames())));
//            return "redirect:/?orderSuccess=true";

            // thêm nếu có order
            return "redirect:/client/order";

//            --------
        } catch (Exception e) {
            logger.error("Error in createOrder: ", e);
            setMessage(model, session, "An error occurred while processing your order. Please try again.", "orderError");
            return "guest/searchpage/checkout";
        }
    }

    private Map<Product, Long> createCartProducts(String[] productIds, String[] quantities) {
        Map<Product, Long> cartProducts = new HashMap<>();
        if (productIds != null && quantities != null) {
            for (int i = 0; i < productIds.length; i++) {
                Product product = productServices.getProductById(Long.parseLong(productIds[i]));
                if (product != null) {
                    cartProducts.put(product, Long.parseLong(quantities[i]));
                }
            }
        }
        return cartProducts;
    }

    private void setSessionAttributes(HttpSession session, Map<Product, Long> cartProducts, Double totalAmount) {
        session.setAttribute("cartProducts", cartProducts);
        session.setAttribute("totalAmount", totalAmount);
    }

    private void setModelAttributes(Model model, Map<Product, Long> cartProducts, Double totalAmount, Principal principal) {
        model.addAttribute("cart", cartProducts);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("payment", paymentMethodService.findAll());
        model.addAttribute("paymentMethods", paymentMethodService.findAll());
        model.addAttribute("orderDTO", createOrderDTO(cartProducts, principal));
    }

    private OrderDTO createOrderDTO(Map<Product, Long> cartProducts, Principal principal) {
        OrderDTO orderDTO = new OrderDTO();
        if (principal != null) {
            User user = userRepository.findByEmail(principal.getName());
            if (user != null) {
                orderDTO.setFullName(user.getFullName());
                orderDTO.setAddress(user.getAddress());
                orderDTO.setPhone(user.getPhone());
                orderDTO.setEmail(user.getEmail());
            }
        }
        return orderDTO;
    }

    @SuppressWarnings("unchecked")
    private Map<Product, Long> getCartProducts(HttpSession session) {
        return (Map<Product, Long>) session.getAttribute("cartProducts");
    }

    private boolean isCartEmpty(Map<Product, Long> cartProducts, Model model) {
        if (cartProducts == null || cartProducts.isEmpty()) {
            model.addAttribute("errorQuantityCart", "Cart quantity must be > 0");
            return true;
        }
        return false;
    }

    private Double calculateTotal(Map<Product, Long> cartProducts) {
        return cartProducts.entrySet().stream()
                .mapToDouble(entry -> entry.getKey().getPrice() * entry.getValue())
                .sum();
    }

    private Orders createOrder(User user, PaymentMethod paymentMethod, String address, Double total,
                               String fullName, String phone, String email) {
        Orders order = new Orders();
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("Waiting");
        order.setPaymentMethod(paymentMethod);
        order.setUser(user);
        order.setShippingAddress(address);
        order.setTotalPayment(total);
        order.setFullName(fullName);
        order.setPhone(phone);
        order.setEmail(email);

        return orderRepository.save(order);
    }


    private void saveOrderDetails(Orders order, Map<Product, Long> cartProducts) {
        for (Map.Entry<Product, Long> entry : cartProducts.entrySet()) {
            Product product = productRepository.findById(entry.getKey().getId()).orElseThrow(() -> new EntityNotFoundException("Product not found"));
            OrdersDetail ordersDetail = new OrdersDetail();
            ordersDetail.setOrders(order);
            ordersDetail.setPrice(product.getPrice());
            ordersDetail.setProduct(product);
            ordersDetail.setQuantity(entry.getValue().intValue());
            orderDetailRepository.save(ordersDetail);
        }
    }
    private void sendConfirmationEmail(Orders order, String email) {
        String emailContent = String.format(
                "Thank you for your order: [ %s ].\n\nOrder Details\nOrder ID: %s\nShipping Address: %s\nPhone: %s\n",
                order.getUser() != null ? order.getUser().getFullName() : order.getFullName(),
                order.getId(),
                order.getShippingAddress(),
                order.getUser() != null ? order.getUser().getPhone() : order.getPhone()
        );
        mailService.sendMail(email, "Order Confirmation", emailContent);
    }

    private void clearCart(HttpSession session) {
        logger.info("Clearing cart from session...");

        logger.info("Before clearing - Session attributes: {}",
                Collections.list(session.getAttributeNames()));

        logger.info("Before clearing - Cart products: {}", safeToString(session.getAttribute("cartProducts")));
        logger.info("Before clearing - Total amount: {}", session.getAttribute("totalAmount"));

        List<String> attributesToKeep = Arrays.asList(
                "org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN",
                "SPRING_SECURITY_CONTEXT"
        );

        Collections.list(session.getAttributeNames()).stream()
                .filter(attr -> !attributesToKeep.contains(attr))
                .forEach(session::removeAttribute);

        List<String> remainingAttributes = Collections.list(session.getAttributeNames());
        logger.info("After clearing - Session attributes: {}", remainingAttributes);

        for (String attr : remainingAttributes) {
            logger.info("Remaining attribute: {} - Type: {}", attr,
                    session.getAttribute(attr) != null ? session.getAttribute(attr).getClass().getSimpleName() : "null");
        }

        if (session.getAttribute("cartProducts") == null) {
            logger.info("Cart products successfully removed from session");
        } else {
            logger.warn("Cart products still present in session");
        }

        if (session.getAttribute("totalAmount") == null) {
            logger.info("Total amount successfully removed from session");
        } else {
            logger.warn("Total amount still present in session");
        }

        logger.info("Cart cleared after successful order creation");
    }

    private void setMessage(Model model, HttpSession session, String message, String attributeName) {
        model.addAttribute(attributeName, message);
        session.setAttribute(attributeName, message);
    }

    private boolean updateProductQuantities(Map<Product, Long> cartProducts, Model model) {
        for (Map.Entry<Product, Long> entry : cartProducts.entrySet()) {
            Product product = entry.getKey();
            Long quantityToReduce = entry.getValue();

            if (product.getQuantity() < quantityToReduce) {
                setMessage(model, null, "Not enough stock available for " + product.getProductName(), "stockError");
                return false;
            }

            product.setQuantity(product.getQuantity() - quantityToReduce.intValue());
            product.setSold(product.getSold() + quantityToReduce.intValue());
            productRepository.save(product);
        }
        return true;
    }

    private String safeToString(Object obj) {
        if (obj instanceof Map) {
            return "Map with " + ((Map<?, ?>) obj).size() + " entries";
        }
        if (obj instanceof Collection) {
            return "Collection with " + ((Collection<?>) obj).size() + " items";
        }
        return String.valueOf(obj);
    }

    private Discount applyDiscount(Double totalAmount) {
        List<Discount> discounts = discountRepository.findByAmount(totalAmount);
        return discounts.isEmpty() ? null : discounts.get(0);
    }

    private double calculateTotalSpent(User user) {
        List<Orders> userOrders = orderRepository.findByUser(user);
        return userOrders.stream()
                .mapToDouble(Orders::getTotalPayment)
                .sum();
    }

    private void updateUserAmount(User user, Double orderTotal) {
        user.setAmount(user.getAmount() + orderTotal);
        userRepository.save(user);
    }
}