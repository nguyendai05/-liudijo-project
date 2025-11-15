package com.liudijo.repository;

import com.liudijo.model.User;
import com.liudijo.util.DBConnection;

import java.sql.*;

public class UserRepository {

    public User findByEmail(String email) {
        String sql = "SELECT TOP 1 UserId, Email, FullName, (SELECT Name FROM Roles WHERE RoleId=u.RoleId) as Role, IsActive " +
                     "FROM Users u WHERE Email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getLong("UserId"));
                    u.setEmail(rs.getString("Email"));
                    u.setFullName(rs.getString("FullName"));
                    u.setRole(rs.getString("Role"));
                    u.setActive(rs.getBoolean("IsActive"));
                    return u;
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public byte[] getPasswordHash(long userId) {
        String sql = "SELECT PasswordHash FROM Users WHERE UserId=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBytes(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public byte[] getPasswordHashByEmail(String email) {
        String sql = "SELECT PasswordHash FROM Users WHERE Email=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBytes(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public User findById(long id) {
        String sql = "SELECT UserId, Email, FullName, (SELECT Name FROM Roles WHERE RoleId=u.RoleId) as Role, IsActive FROM Users u WHERE UserId=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getLong("UserId"));
                    u.setEmail(rs.getString("Email"));
                    u.setFullName(rs.getString("FullName"));
                    u.setRole(rs.getString("Role"));
                    u.setActive(rs.getBoolean("IsActive"));
                    return u;
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public long create(String email, String fullName, byte[] passwordHash) {
        String sql = "INSERT INTO Users (Email, PasswordHash, FullName, RoleId, IsActive) " +
                     "VALUES (?, ?, ?, (SELECT RoleId FROM Roles WHERE Name='CUSTOMER'), 1)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, email);
            ps.setBytes(2, passwordHash);
            ps.setString(3, fullName);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return 0;
    }
}
