package com.group1.fmobile.service;

import com.group1.fmobile.domain.PaymentMethod;
import com.group1.fmobile.repository.PaymentMethodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PaymentMethodService {

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    public List<PaymentMethod> findAll(){
        return paymentMethodRepository.findAll();
    }
}
