package com.bloodline.dao;
import java.sql.*;



import com.bloodline.entities.User;

public class UserDao {
	
	private Connection con;
	public UserDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con=con;
	}
	
	public UserDao() {
		
	}

	
	
	public boolean saveUser(User user) {
		boolean f=false;
		try {
			
			
			
			String q="insert into registration (firstname,lastname,email,mobile,password,bloodgroup,dateofbirthday,state,city,gender,positiveforhiv) values(?,?,?,?,?,?,?,?,?,?,?)";
			
			PreparedStatement pstmt=this.con.prepareStatement(q);
			//pstmt.setInt(1, user.getId());
			pstmt.setString(1, user.getFname());
			pstmt.setString(2, user.getLame());
			
			pstmt.setString(3, user.getEmai());
			pstmt.setString(4, user.getMobile());
			pstmt.setString(5, user.getPassword());
			pstmt.setString(6, user.getBloodGroup());
			pstmt.setString(7, user.getDob());
			pstmt.setString(8, user.getState());
			pstmt.setString(9, user.getUserCity());
			pstmt.setString(10, user.getGender());
			pstmt.setString(11, user.getPositivHIV());
			
			
			pstmt.executeUpdate();
			
			f=true;
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return f;
		
	}
	
	
	
	//by user email and password
	
	public User getUserEmailAndPassword(String email, String password) {

		User user=null;
		try {
			String q="select *from registration where email=? and password=?";
			PreparedStatement pstmt=con.prepareStatement(q);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			ResultSet set=pstmt.executeQuery();
			if(set.next()) {
				user=new User();
				String name=set.getString("firstname");
				user.setFname(name);
				
				user.setEmai(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setBloodGroup(set.getString("bloodgroup"));
				user.setState(set.getString("state"));
				user.setUserCity(set.getString("city"));
				user.setDob(set.getString("dateofbirthday"));
				user.setMobile(set.getString("mobile"));
				
				//user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return user;
		
	}
	
	
	
	
	public User getBloodInfo(String bloodGroup,String city) {

		User user=null;
		try {
			String q="select *from registration where bloodgroup=? and city=?";
			PreparedStatement pstmt=con.prepareStatement(q);
			pstmt.setString(1, bloodGroup);
			pstmt.setString(2, city);
			
			
			ResultSet set=pstmt.executeQuery();
			while(set.next()) {
				System.out.println(set.getString("firstname")+" "+set.getString("bloodgroup"));
				user=new User();
				String name=set.getString("firstname");
				user.setFname(name);
				
				/*user.setEmai(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				*/
				user.setBloodGroup(set.getString("bloodgroup"));
				user.setState(set.getString("state"));
				user.setUserCity(set.getString("city"));
			//	user.setDob(set.getString("dateofbirthday"));
				user.setMobile(set.getString("mobile"));
				
				//user.setDateTime(set.getTimestamp("rdate"));
				//user.setProfile(set.getString("profile"));
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return user;
		
	}
	/*
	public boolean updateUser(User user) {
		boolean f=false;
		try {
			
			String q="update registration set name=? , email=? , password=? , gender=? , about=? , profile=? where id=?";
			PreparedStatement p=con.prepareStatement(q);
			p.setString(1, user.getName());
			p.setString(2, user.getEmai());
			p.setString(3, user.getPassword());
			p.setString(4, user.getGender());
			p.setString(5, user.getAbout());
			p.setString(6, user.getProfile());
			p.setInt(7, user.getId());
			p.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
		
	}*/
	
}
