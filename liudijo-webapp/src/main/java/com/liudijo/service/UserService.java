package com.liudijo.service;

import com.liudijo.model.User;
import com.liudijo.repository.UserRepository;
import com.liudijo.util.EmailUtil;
import com.liudijo.util.PasswordUtil;

import java.util.List;

public class UserService {
    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    /**
     * Register a new user
     */
    public boolean register(String username, String email, String password, String fullName, String phone) {
        // Check if username already exists
        if (userRepository.findByUsername(username) != null) {
            return false;
        }

        // Check if email already exists
        if (userRepository.findByEmail(email) != null) {
            return false;
        }

        // Validate password
        if (!PasswordUtil.isValidPassword(password)) {
            return false;
        }

        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setRole("CUSTOMER");
        user.setActive(true);

        boolean saved = userRepository.save(user);

        if (saved) {
            // Send welcome email
            EmailUtil.sendWelcomeEmail(email, username);
        }

        return saved;
    }

    /**
     * Login user
     */
    public User login(String username, String password) {
        User user = userRepository.findByUsername(username);

        if (user == null) {
            return null;
        }

        if (!user.isActive()) {
            return null;
        }

        if (PasswordUtil.verifyPassword(password, user.getPassword())) {
            return user;
        }

        return null;
    }

    /**
     * Get user by ID
     */
    public User getUserById(Long id) {
        return userRepository.findById(id);
    }

    /**
     * Get user by username
     */
    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /**
     * Get all users
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Update user profile
     */
    public boolean updateProfile(Long userId, String email, String fullName, String phone) {
        User user = userRepository.findById(userId);
        if (user == null) {
            return false;
        }

        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhone(phone);

        return userRepository.update(user);
    }

    /**
     * Change password
     */
    public boolean changePassword(Long userId, String oldPassword, String newPassword) {
        User user = userRepository.findById(userId);
        if (user == null) {
            return false;
        }

        if (!PasswordUtil.verifyPassword(oldPassword, user.getPassword())) {
            return false;
        }

        if (!PasswordUtil.isValidPassword(newPassword)) {
            return false;
        }

        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        return userRepository.updatePassword(userId, hashedPassword);
    }

    /**
     * Update user role (admin only)
     */
    public boolean updateUserRole(Long userId, String role) {
        User user = userRepository.findById(userId);
        if (user == null) {
            return false;
        }

        user.setRole(role);
        return userRepository.update(user);
    }

    /**
     * Activate/deactivate user (admin only)
     */
    public boolean toggleUserStatus(Long userId) {
        User user = userRepository.findById(userId);
        if (user == null) {
            return false;
        }

        user.setActive(!user.isActive());
        return userRepository.update(user);
    }

    /**
     * Delete user (admin only)
     */
    public boolean deleteUser(Long userId) {
        return userRepository.delete(userId);
    }
}
