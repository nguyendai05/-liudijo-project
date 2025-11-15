package com.liudijo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Simple JDBC connection helper for SQL Server. */
public class DBConnection {
    private static final String URL = System.getenv().getOrDefault("DB_URL",
        "jdbc:sqlserver://localhost:15000;databaseName=liudijo;encrypt=true;trustServerCertificate=true");
    private static final String USER = System.getenv().getOrDefault("DB_USER", "sa");
    private static final String PASS = System.getenv().getOrDefault("DB_PASS", "StrongPassword!");

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("SQLServerDriver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url  = "jdbc:sqlserver://localhost:15000;"
                + "databaseName=liudijo;"
                + "encrypt=true;"
                + "trustServerCertificate=true;";
        String user = "sa";
        String pass = "kjm03459119479dp@";   // ĐỔI THÀNH MẬT KHẨU THẬT CỦA BẠN

        return DriverManager.getConnection(url, user, pass);
    }
}
