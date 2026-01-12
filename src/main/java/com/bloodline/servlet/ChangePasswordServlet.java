package com.bloodline.servlet;

import org.mindrot.jbcrypt.BCrypt;

import com.bloodline.entities.User;
import com.bloodline.entities.Message;
import com.bloodline.helper.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) { resp.sendRedirect("login.jsp"); return; }

        User user = (User) session.getAttribute("currentUser");
        if (user == null) { resp.sendRedirect("login.jsp"); return; }

        String oldPass = req.getParameter("currentPassword");
        String newPass = req.getParameter("newPassword");
        String confirmPass = req.getParameter("confirmPassword");

        if (!newPass.equals(confirmPass)) {
            session.setAttribute("msg", new Message("Passwords do not match!", "alert-danger", null));
            resp.sendRedirect("profile.jsp");
            return;
        }

        try (Connection con = ConnectionProvider.getConnection()) {

            // Load stored password hash using email
            PreparedStatement ps = con.prepareStatement(
                    "SELECT password FROM users WHERE email=?");
            ps.setString(1, user.getEmai());
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                session.setAttribute("msg", new Message("User not found!", "alert-danger", null));
                resp.sendRedirect("profile.jsp");
                return;
            }

            String storedHash = rs.getString("password");

            // Verify old password
            if (!BCrypt.checkpw(oldPass, storedHash)) {
                session.setAttribute("msg", new Message("Incorrect current password!", "alert-danger", null));
                resp.sendRedirect("profile.jsp");
                return;
            }

            // Hash the new password
            String hashed = BCrypt.hashpw(newPass, BCrypt.gensalt());

            PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE users SET password=? WHERE email=?");
            ps2.setString(1, hashed);
            ps2.setString(2, user.getEmai());
            ps2.executeUpdate();

            session.setAttribute("msg",
                    new Message("Password updated successfully!", "alert-success", null));

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg",
                    new Message("Error updating password!", "alert-danger", null));
        }

        resp.sendRedirect("profile.jsp");
    }
}
