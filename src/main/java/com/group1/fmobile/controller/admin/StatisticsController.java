package com.group1.fmobile.controller.admin;

import com.group1.fmobile.domain.dto.DailyRevenueDTO;
import com.group1.fmobile.service.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping(value = "/api/statistics")
public class StatisticsController {
    private final OrdersService ordersService;

    @Autowired
    public StatisticsController(OrdersService ordersService) {
        this.ordersService = ordersService;
    }

    @GetMapping("/revenue/range")
    public ResponseEntity<List<DailyRevenueDTO>> getRevenueInRange(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDateTime endDate) {
        List<DailyRevenueDTO> dailyRevenue = ordersService.getRevenueInRange(startDate, endDate);
        return ResponseEntity.ok(dailyRevenue);
    }
}
