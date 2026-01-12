package com.bloodline.entities;

import java.security.Timestamp;
import java.time.LocalDateTime;

public class User {

	




	
	private String fname;
	private String lame;
	private String emai;
    public User(String fname, String lame, String emai, String mobile, String password, String bloodGroup,
			String dob, String state,String userCity,String gender, String positivHIV) {
		super();
		this.fname = fname;
		this.lame = lame;
		this.emai = emai;
		this.mobile = mobile;
		this.password = password;
		
		this.bloodGroup = bloodGroup;
		this.dob = dob;
		this.state = state;
		this.userCity=userCity;
		this.gender = gender;
		this.positivHIV = positivHIV;
	}








	private String mobile;
	private String password;
	private String gender;
	private String bloodGroup;
	private String dob;
	private String state;
	private String positivHIV;
	
	private String userCity;
	
	
	








	






 private LocalDateTime userDate;

	public String getUserCity() {
		return userCity;
	}






public LocalDateTime getUserDate() {
	return userDate;
}

public void setUserDate(LocalDateTime userDate) {
	this.userDate = userDate;
}

	public void setUserCity(String userCity) {
		this.userCity = userCity;
	}








	private String profile;
	
	
	
	
	
	
	
	
	public User() {
		// TODO Auto-generated constructor stub
	}








	public String getFname() {
		return fname;
	}








	public void setFname(String fname) {
		this.fname = fname;
	}








	public String getLame() {
		return lame;
	}








	public void setLame(String lame) {
		this.lame = lame;
	}








	public String getEmai() {
		return emai;
	}








	public void setEmai(String emai) {
		this.emai = emai;
	}








	public String getMobile() {
		return mobile;
	}








	public void setMobile(String mobile) {
		this.mobile = mobile;
	}








	public String getPassword() {
		return password;
	}








	public void setPassword(String password) {
		this.password = password;
	}








	public String getGender() {
		return gender;
	}








	public void setGender(String gender) {
		this.gender = gender;
	}








	public String getBloodGroup() {
		return bloodGroup;
	}








	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}








	public String getDob() {
		return dob;
	}








	public void setDob(String dob) {
		this.dob = dob;
	}








	public String getState() {
		return state;
	}








	public void setState(String state) {
		this.state = state;
	}








	public String getPositivHIV() {
		return positivHIV;
	}








	public void setPositivHIV(String positivHIV) {
		this.positivHIV = positivHIV;
	}








	public String getProfile() {
		return profile;
	}








	public void setProfile(String profile) {
		this.profile = profile;
	}






	@Override
	public String toString() {
	    return "User{" +
	            "fname='" + fname + '\'' +
	            ", lame='" + lame + '\'' +
	            ", emai='" + emai + '\'' +
	            ", mobile='" + mobile + '\'' +
	            ", gender='" + gender + '\'' +
	            ", bloodGroup='" + bloodGroup + '\'' +
	            ", state='" + state + '\'' +
	            ", userCity='" + userCity + '\'' +
	            ", userDate='" +userDate +'\''  +
	            '}';
	}

	
	







	



	
	
	
	
	
	
	
}

