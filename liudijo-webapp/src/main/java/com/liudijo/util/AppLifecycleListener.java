package com.liudijo.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Enumeration;
import java.util.logging.Logger;

@WebListener
public class AppLifecycleListener implements ServletContextListener {
    private static final Logger log = Logger.getLogger(AppLifecycleListener.class.getName());

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            // Gỡ đăng ký mọi JDBC driver do webapp nạp để tránh leak
            Enumeration<Driver> drivers = DriverManager.getDrivers();
            while (drivers.hasMoreElements()) {
                Driver d = drivers.nextElement();
                try {
                    DriverManager.deregisterDriver(d);
                    log.info("Deregistered JDBC driver " + d);
                } catch (Exception e) {
                    log.warning("Error deregistering driver " + d + ": " + e.getMessage());
                }
            }
        } catch (Exception e) {
            log.warning("JDBC driver cleanup failed: " + e.getMessage());
        }
    }
}
