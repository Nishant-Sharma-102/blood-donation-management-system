package com.bloodline.servlet;

import com.bloodline.dao.BankStockDao;
import com.bloodline.dao.BloodBankDao;
import com.bloodline.entities.BankStockView;
import com.bloodline.entities.BloodBank;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/bank/stock")
public class BankStockServlet extends HttpServlet {
    private BankStockDao stockDao;
    private BloodBankDao bankDao;

    @Override public void init() { stockDao = new BankStockDao(); bankDao = new BloodBankDao(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int bankId = parseInt(req.getParameter("bankId"), 0);

        try {
            // banks for dropdown
            List<BloodBank> banks = bankDao.findAll();
            req.setAttribute("banks", banks);

            if (bankId == 0 && !banks.isEmpty()) bankId = banks.get(0).getBankId();
            req.setAttribute("bankId", bankId);

            if (bankId != 0) {
                List<BankStockView> stock = stockDao.findByBank(bankId);
                req.setAttribute("stocks", stock);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "DB Error: " + e.getMessage());
        }
        req.getRequestDispatcher("/bank-stock.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action"); // add/use
        int bankId = parseInt(req.getParameter("bankId"), 0);
        String group = req.getParameter("group");
        int units = parseInt(req.getParameter("units"), 0);
        String msg;

        try {
            if ("add".equalsIgnoreCase(action)) {
                stockDao.addUnits(bankId, group, units);
                msg = "Added " + units + " units to " + group;
            } else if ("use".equalsIgnoreCase(action)) {
                stockDao.useUnits(bankId, group, units);
                msg = "Used " + units + " units from " + group;
            } else {
                msg = "Unknown action";
            }
            req.setAttribute("message", msg);
        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }
        doGet(req, resp);
    }

    private int parseInt(String s, int d) {
        try { return Integer.parseInt(s); } catch (Exception e) { return d; }
    }
}
