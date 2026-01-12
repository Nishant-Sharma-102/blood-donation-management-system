package com.bloodline.servlet;

import com.bloodline.dao.BloodBankDao;
import com.bloodline.entities.BloodBank;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/banks")
public class BanksServlet extends HttpServlet {
    private BloodBankDao dao;

    @Override public void init() { dao = new BloodBankDao(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<BloodBank> banks = dao.findAll();
            req.setAttribute("banks", banks);
        } catch (SQLException e) {
            req.setAttribute("error", "DB Error: " + e.getMessage());
        }
        req.getRequestDispatcher("/banks.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        BloodBank b = new BloodBank();
        b.setName(req.getParameter("name"));
        b.setCity(req.getParameter("city"));
        b.setAddress(req.getParameter("address"));
        b.setPhone(req.getParameter("phone"));
        b.setEmail(req.getParameter("email"));
        b.setLicenseNo(req.getParameter("licenseNo"));
        String est = req.getParameter("establishedDate");
        b.setEstablishedDate(est == null || est.isEmpty() ? null : Date.valueOf(est));
        b.setActive(true);

        try {
            int newId = dao.create(b);
            req.setAttribute("message", "Created bank: " + b.getName());

            // Initialize the 8 groups for this bank in bank_stock
            // (optional convenience)
            req.setAttribute("initBankId", newId);
        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }
        doGet(req, resp);
    }
}
