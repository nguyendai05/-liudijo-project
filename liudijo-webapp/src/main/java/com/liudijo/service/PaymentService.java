package com.liudijo.service;

public class PaymentService {
    /** Mock payment: always success and returns a fake transaction id. */
    public String createMockPayment(long orderId) {
        return "MOCKTX-" + System.currentTimeMillis();
    }
}
