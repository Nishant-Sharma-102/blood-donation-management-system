package com.bloodline.servlet;

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bloodline.dao.BloodRequestUserDao;
import com.bloodline.entities.BloodRequestUser;
import com.bloodline.helper.ConnectionProvider;


/**
 * Servlet implementation class RequestBlood
 */
@WebServlet("/RequestBlood")
public class RequestBlood extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestBlood() {
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		

		try (PrintWriter out=response.getWriter()){
			out.println("<!DOCTYPE html> ");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Request Blood</title>");
			out.println("</head>");
			out.println("<body>");
		
			out.println("<h1>Welcome to Request Blood</h1>");
			
			
			

			String check=request.getParameter("check");
			if(check==null) {
				out.println("box not check");
			}
			else {
				String patientName =request.getParameter("patient_name");
				String attendeeName =request.getParameter("attendee_name");
				String attendeeMobile =request.getParameter("attendee_mobile");
				String bloodGroup =request.getParameter("blood_group");
				String patientDob =request.getParameter("patient_dob");
				String patientState =request.getParameter("patient_state");
				String cityName =request.getParameter("city_name");
				String pinCode =request.getParameter("pin_code");
				
				String requireDate =request.getParameter("require_date");
				String gender =request.getParameter("gender");
				String form =request.getParameter("form");
				String additionalNote =request.getParameter("additional_note");
				
				//create user object and set all data to that object
				
				
				BloodRequestUser bloodRequestUser=new BloodRequestUser(patientName, attendeeName, attendeeMobile, bloodGroup, patientDob, patientState, cityName, pinCode, requireDate, gender, form, additionalNote);
				
				
				
				// create userDao Object
				
				BloodRequestUserDao dao=new BloodRequestUserDao(ConnectionProvider.getConnection());
			  if(dao.saveBloodRequestUser(bloodRequestUser)) {
				  out.println("done it");
				  System.out.println("blood request sent");
			  }
			  else {
				out.println("Error");
			}
			}

			out.println("</body>");
			out.println("</html>");
			
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		
		
	}

}
