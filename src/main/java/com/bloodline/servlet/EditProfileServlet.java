package com.bloodline.servlet;

import com.bloodline.entities.User;
import com.bloodline.entities.Message;
import com.bloodline.helper.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * EditProfileServlet (fixed)
 *
 * - Expects table name "registration" (change TABLE_NAME if different)
 * - Form fields expected (names must match form): fname, lname, email, mobile, city, state, bloodGroup, image
 * - Saves uploaded image to webapp/pics/ (creates dir if missing) and stores filename in DB column "profile"
 */
@WebServlet("/EditProfileServlet")
@MultipartConfig
public class EditProfileServlet extends HttpServlet {

    private static final String TABLE_NAME = "registration"; // change if your table name differs

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) { resp.sendRedirect("login.jsp"); return; }

        User user = (User) session.getAttribute("currentUser");
        if (user == null) { resp.sendRedirect("login.jsp"); return; }

        // --- Read form parameters (names MUST match form inputs in profile.jsp) ---
        String fname = req.getParameter("fname");
        String lname = req.getParameter("lname");   // fixed param name
        String email = req.getParameter("email");   // fixed param name
        String mobile = req.getParameter("mobile");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String blood = req.getParameter("bloodGroup");

        // --- Optional file upload handling ---
        Part part = null;
        String fileName = null;
        try {
            part = req.getPart("image"); // input name="image"
        } catch (Exception ignored) { /* no part */ }

        if (part != null && part.getSize() > 0) {
            fileName = new File(part.getSubmittedFileName()).getName(); // sanitize
            String uploadPath = req.getServletContext().getRealPath("/pics");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            Files.copy(part.getInputStream(), new File(uploadDir, fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // --- Determine the identifier to update. Here we use the email from session User (best-effort) ---
        String oldEmail = null;
        try {
            // try common getter names for email on User object
            try {
                Method m = user.getClass().getMethod("getEmail");
                oldEmail = (String) m.invoke(user);
            } catch (NoSuchMethodException nsme) {
                // fallback to nonstandard getter name
                try {
                    Method m2 = user.getClass().getMethod("getEmai");
                    oldEmail = (String) m2.invoke(user);
                } catch (Exception ignored) { }
            }
        } catch (Exception e) {
            oldEmail = null;
        }

        if (oldEmail == null || oldEmail.trim().isEmpty()) {
            // TODO: adjust Message constructor if your Message class signature differs
            session.setAttribute("msg", new Message("Cannot determine your account email; update aborted.", "alert-danger", null));
            resp.sendRedirect("profile.jsp");
            return;
        }

        // --- Build SQL (only include profile column if a file was uploaded) ---
        String sql = "UPDATE " + TABLE_NAME + " SET firstname = ?, lastname = ?, email = ?, mobile = ?, city = ?, state = ?, bloodgroup = ?"
                + (fileName != null ? ", profile = ?" : "")
                + " WHERE email = ?";

        try (Connection con = ConnectionProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int idx = 1;
            ps.setString(idx++, fname);
            ps.setString(idx++, lname);
            ps.setString(idx++, email);
            ps.setString(idx++, mobile);
            ps.setString(idx++, city);
            ps.setString(idx++, state);
            ps.setString(idx++, blood);

            if (fileName != null) {
                ps.setString(idx++, fileName);
            }

            ps.setString(idx++, oldEmail); // WHERE email = oldEmail

            int updated = ps.executeUpdate();
            if (updated <= 0) {
                session.setAttribute("msg", new Message("No row updated — please check your account.", "alert-danger", null));
                resp.sendRedirect("profile.jsp");
                return;
            }

            // --- re-fetch authoritative row from DB using the (new) email if provided else oldEmail ---
            String fetchSql = "SELECT * FROM " + TABLE_NAME + " WHERE email = ?";
            try (PreparedStatement fetchPs = con.prepareStatement(fetchSql)) {
                String emailToFetch = (email != null && !email.trim().isEmpty()) ? email : oldEmail;
                fetchPs.setString(1, emailToFetch);

                try (ResultSet rs = fetchPs.executeQuery()) {
                    if (!rs.next()) {
                        session.setAttribute("msg", new Message("Profile updated, but couldn't load the updated data.", "alert-warning", null));
                    } else {
                        // Helper to try multiple possible column names (first non-null returned)
                        java.util.function.Function<String[], String> getCol = (String[] names) -> {
                            for (String n : names) {
                                try {
                                    String v = rs.getString(n);
                                    if (v != null) return v;
                                } catch (Exception ignored) {}
                            }
                            return "";
                        };

                        String dbFname = getCol.apply(new String[] {"firstname","fname","first_name","name"});
                        String dbLname = getCol.apply(new String[] {"lastname","lname","lame","last_name"});
                        String dbEmail = getCol.apply(new String[] {"email","emai","user_email","mail"});
                        String dbMobile = getCol.apply(new String[] {"mobile","phone","contact","phone_number"});
                        String dbCity = getCol.apply(new String[] {"city","user_city","town"});
                        String dbState = getCol.apply(new String[] {"state","region"});
                        String dbBlood = getCol.apply(new String[] {"bloodgroup","blood_group","bloodGroup","blood","bg"});
                        String dbProfile = getCol.apply(new String[] {"profile","profile_image","image","photo"});

                        // set session attributes used by profile.jsp
                        session.setAttribute("profile_fname", dbFname);
                        session.setAttribute("profile_lname", dbLname);
                        session.setAttribute("profile_email", dbEmail);
                        session.setAttribute("profile_mobile", dbMobile);
                        session.setAttribute("profile_city", dbCity);
                        session.setAttribute("profile_state", dbState);
                        session.setAttribute("profile_blood", dbBlood);
                        session.setAttribute("profile_profile", dbProfile);

                        // Best-effort: update currentUser object via common setters (if present)
                        try {
                            Object sessionUser = session.getAttribute("currentUser");
                            if (sessionUser != null) {
                                Class<?> c = sessionUser.getClass();
                                try { c.getMethod("setFname", String.class).invoke(sessionUser, dbFname); } catch (Exception ignored) {}
                                try { c.getMethod("setLname", String.class).invoke(sessionUser, dbLname); } catch (Exception ignored) {}
                                try { c.getMethod("setEmail", String.class).invoke(sessionUser, dbEmail); } catch (Exception ignored) {}
                                try { c.getMethod("setMobile", String.class).invoke(sessionUser, dbMobile); } catch (Exception ignored) {}
                                try { c.getMethod("setUserCity", String.class).invoke(sessionUser, dbCity); } catch (Exception ignored) {}
                                try { c.getMethod("setState", String.class).invoke(sessionUser, dbState); } catch (Exception ignored) {}
                                try { c.getMethod("setBloodGroup", String.class).invoke(sessionUser, dbBlood); } catch (Exception ignored) {}
                                try { c.getMethod("setProfile", String.class).invoke(sessionUser, dbProfile); } catch (Exception ignored) {}
                                session.setAttribute("currentUser", sessionUser);
                            }
                        } catch (Exception ignore) { /* non-fatal */ }

                        session.setAttribute("msg", new Message("Profile updated successfully!", "alert-success", null));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msg", new Message("Profile updated, but error while refreshing session: " + e.getMessage(), "alert-warning", null));
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", new Message("Error updating profile: " + e.getMessage(), "alert-danger", null));
        }

        // Redirect so profile.jsp reads fresh session attributes
        resp.sendRedirect("profile.jsp");
    }
}
