package com.liudijo.service;

import com.liudijo.model.StockItem;
import com.liudijo.repository.StockRepository;
import com.liudijo.util.CryptoUtil;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

public class AccountStockService {
    private final StockRepository repo = new StockRepository();

    public long addStock(long productId, String type, String secretPlain, String metaJson) {
        byte[] enc = CryptoUtil.encrypt(secretPlain.getBytes(StandardCharsets.UTF_8));
        return repo.insertOne(productId, type, enc, metaJson);
    }

    public List<String> getDecryptedSecretsByOrder(long orderId) {
        List<StockItem> list = repo.getAssignedByOrder(orderId);
        return list.stream()
                .map(si -> new String(com.liudijo.util.CryptoUtil.decrypt(si.getSecretEncrypted()),
                        java.nio.charset.StandardCharsets.UTF_8))
                .collect(Collectors.toList());
    }
}
