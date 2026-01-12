package com.bloodline.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bloodline.entities.BloodRequestUser;
import com.bloodline.entities.User;



public class BloodRequestUserDao {
	private Connection con;
	public BloodRequestUserDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con=con;
	}
	
	
	
	
	public boolean saveBloodRequestUser(BloodRequestUser bloodRequestUser) {
		boolean f=false;
		try {
			
			
			
			String q="insert into requestblood(patientname,attendeename,attendeemobile,bloodgroup,dob,state,city,pincode,requiredate,gender,requsitionform,additionalnotes) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			PreparedStatement pstmt=this.con.prepareStatement(q);
			pstmt.setString(1, bloodRequestUser.getPatientName());
			pstmt.setString(2, bloodRequestUser.getAttendeeName());
			pstmt.setString(3, bloodRequestUser.getAttendeeMobile());
			pstmt.setString(4, bloodRequestUser.getBloodGroup());
			pstmt.setString(5, bloodRequestUser.getDob());
			pstmt.setString(6, bloodRequestUser.getState());
			pstmt.setString(7, bloodRequestUser.getCity());
			pstmt.setString(8, bloodRequestUser.getPincode());
			pstmt.setString(9, bloodRequestUser.getRequiredate());
			pstmt.setString(10, bloodRequestUser.getGender());
			pstmt.setString(11, bloodRequestUser.getRequsitionForm());
			pstmt.setString(12, bloodRequestUser.getAddtionalNotes());
			
			
			pstmt.executeUpdate();
			
			f=true;
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return f;
		
	}
	
	
	
	
}
