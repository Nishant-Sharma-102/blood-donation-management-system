package com.bloodline.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
    
    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://localhost:3306/collegeproject?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                String username = "root";
                String password = "Pass@123";  // ✅ your MySQL password

                con = DriverManager.getConnection(url, username, password);
                System.out.println("✅ Database connected successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Connection failed!");
        }

        return con;
    }
}
