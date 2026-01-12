package com.bloodline.servlet;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

@MultipartConfig
@WebServlet("/forms/contact.php")
public class ContactServlet extends HttpServlet {

  // === Your Email Details ===
  private static final String TO = "kaushiknishant2002@gmail.com";      // where you'll receive messages
  private static final String SMTP_USER = "kaushiknishant2002@gmail.com"; // Gmail account used to SEND
  private static final String SMTP_PASS = "abcdefghijklmnop";             // 16-character Gmail App Password

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
          throws ServletException, IOException {

      req.setCharacterEncoding("UTF-8");
      resp.setContentType("text/plain; charset=UTF-8");
      PrintWriter out = resp.getWriter();

      // --- Read form fields ---
      String name    = trim(req.getParameter("name"));
      String email   = trim(req.getParameter("email"));
      String subject = trim(req.getParameter("subject"));
      String message = trim(req.getParameter("message"));

      System.out.println("DEBUG -> name=" + name + ", email=" + email + ", subject=" + subject + ", message=" + message);

      // --- Basic validation ---
      if (isBlank(name) || isBlank(email) || isBlank(message)) {
          resp.setStatus(400);
          out.print("Please fill in required fields (name, email, message).");
          return;
      }
      if (isBlank(subject)) subject = "Website contact";

      // --- Send email via Gmail SMTP ---
      try {
          Properties props = new Properties();
          props.put("mail.smtp.auth", "true");
          props.put("mail.smtp.starttls.enable", "true");
          props.put("mail.smtp.host", "smtp.gmail.com");
          props.put("mail.smtp.port", "587");

          Session session = Session.getInstance(props, new Authenticator() {
              @Override
              protected PasswordAuthentication getPasswordAuthentication() {
                  return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
              }
          });

          Message msg = new MimeMessage(session);
          msg.setFrom(new InternetAddress(SMTP_USER, name));
          msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(TO, false));
          msg.setReplyTo(new Address[]{ new InternetAddress(email) });
          msg.setSubject(subject);
          msg.setText("You received a new message from your website contact form:\n\n"
                    + "Name: " + name + "\n"
                    + "Email: " + email + "\n"
                    + "Subject: " + subject + "\n\n"
                    + "Message:\n" + message);

          Transport.send(msg);
          System.out.println("✅ Email sent successfully to " + TO);
          out.print("OK");

      } catch (Exception e) {
          e.printStackTrace();
          resp.setStatus(500);
          out.print("Error: " + e.getMessage());
      }
  }

  // --- Utility methods ---
  private static boolean isBlank(String s) {
      return s == null || s.trim().isEmpty();
  }

  private static String trim(String s) {
      return s == null ? null : s.trim();
  }

  // --- Handle GET for testing ---
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
          throws ServletException, IOException {
      resp.setContentType("text/plain;charset=UTF-8");
      resp.getWriter().println("ContactServlet OK (GET) at /forms/contact.php");
  }
}
