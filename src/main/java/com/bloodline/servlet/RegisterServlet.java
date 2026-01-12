package com.bloodline.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.bloodline.dao.UserDao;
import com.bloodline.entities.Message;
import com.bloodline.entities.User;
import com.bloodline.helper.ConnectionProvider;

@MultipartConfig
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For safety, redirect GETs to register page
        response.sendRedirect("register_page.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ensure correct encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Detect AJAX request (jQuery sets X-Requested-With: XMLHttpRequest)
        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"));

        // When returning simple text for AJAX, set content type
        if (isAjax) {
            response.setContentType("text/plain;charset=UTF-8");
        } else {
            // non-AJAX: regular browser navigation
            response.setContentType("text/html;charset=UTF-8");
        }

        PrintWriter out = response.getWriter();

        try {
            String check = request.getParameter("check");
            if (check == null) {
                // user did not accept terms
                if (isAjax) {
                    out.print("Please accept the terms");
                    return;
                } else {
                    Message msg = new Message("Please check the terms & conditions", "error", "alert-danger");
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", msg);
                    response.sendRedirect("register_page.jsp");
                    return;
                }
            }

            // Collect parameters (names preserved)
            String fName = request.getParameter("user_fname");
            String lName = request.getParameter("user_lname");
            String email = request.getParameter("user_email");
            String mobile = request.getParameter("user_mobile");
            String password = request.getParameter("user_password");
            String bloodGroup = request.getParameter("user_blood");
            String dob = request.getParameter("user_dob");
            String state = request.getParameter("user_state");
            String city = request.getParameter("user_city");
            String gender = request.getParameter("gender");
            String HIV = request.getParameter("positive");

            // Basic server-side validation
            if (fName == null || fName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

                if (isAjax) {
                    out.print("Missing required fields");
                    return;
                } else {
                    Message msg = new Message("Missing required fields", "error", "alert-danger");
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", msg);
                    response.sendRedirect("register_page.jsp");
                    return;
                }
            }

            // Create user and try save
            User user = new User(fName, lName, email, mobile, password, bloodGroup, dob, state, city, gender, HIV);

            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean saved = dao.saveUser(user);

            if (saved) {
                // success
                if (isAjax) {
                    out.print("done");             // frontend expects exact "done"
                    return;
                } else {
                    // non-AJAX: set session or redirect to login
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", new Message("Registration successful. Please login.", "success", "alert-success"));
                    response.sendRedirect("login.jsp");
                    return;
                }
            } else {
                // save failed (duplicate email or DB error)
                if (isAjax) {
                    out.print("Could not register user");
                    return;
                } else {
                    Message msg = new Message("Invalid Details! Try another.", "error", "alert-danger");
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", msg);
                    response.sendRedirect("register_page.jsp");
                    return;
                }
            }
        } catch (Exception e) {
            // log server-side
            e.printStackTrace();

            if (isAjax) {
                out.print("Internal server error");
            } else {
                HttpSession s = request.getSession();
                s.setAttribute("msg", new Message("Internal server error. Contact admin.", "error", "alert-danger"));
                response.sendRedirect("register_page.jsp");
            }
        } finally {
            out.close();
        }
    }
}
