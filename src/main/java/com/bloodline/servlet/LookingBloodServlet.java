package com.bloodline.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bloodline.dao.UserDao;
import com.bloodline.entities.Message;
import com.bloodline.entities.User;
import com.bloodline.helper.ConnectionProvider;

/**
 * Servlet implementation class LookingBloodServlet
 */
@WebServlet("/LookingBloodServlet")
public class LookingBloodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LookingBloodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try (PrintWriter out=response.getWriter()){
			out.println("<!DOCTYPE html> ");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Login Servlet</title>");
			out.println("</head>");
			out.println("<body>");
			
			
			String bloodGroup=request.getParameter("blood_group");
			String userCity=request.getParameter("city");
			UserDao dao=new UserDao(ConnectionProvider.getConnection());
			User u= (User) dao.getBloodInfo(bloodGroup,userCity);
			
			System.out.println(u);
			if(u==null) {
				
				Message msg= new Message("Invalid   Details ! Try with another","error","alert-danger");
				
				HttpSession s=request.getSession();
				s.setAttribute("msg", msg);
				
				
				response.sendRedirect("lookingBlood.jsp");
			}
			else {
				HttpSession s=request.getSession();
				s.setAttribute("currentUser", u);
				response.sendRedirect("BloodInfoPage.jsp");
				//response.sendRedirect("profile.jsp");
			}
		
			
			
			
			
			
			
			out.println("</body>");
			out.println("</html>");
			
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		
	}

}
