package com.liudijo.service;

import com.liudijo.model.User;
import com.liudijo.repository.UserRepository;
import com.liudijo.util.PasswordUtil;

public class UserService {
    private final UserRepository repo = new UserRepository();

    public User register(String email, String fullName, String password) {
        if (email == null || email.isEmpty() || password == null || password.length() < 6) {
            throw new IllegalArgumentException("Invalid input");
        }
        byte[] hash = PasswordUtil.hash(password);
        long id = repo.create(email, fullName, hash);
        return repo.findById(id);
    }

    public User login(String email, String password) {
        User u = repo.findByEmail(email);
        if (u == null) return null;
        byte[] hashed = repo.getPasswordHash(u.getUserId());
        if (com.liudijo.util.PasswordUtil.verify(password, hashed)) return u;
        return null;
    }

    public User getById(long id) {
        return repo.findById(id);
    }
}
