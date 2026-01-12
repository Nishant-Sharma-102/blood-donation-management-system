package com.bloodline.entities;

import java.sql.Timestamp;

public class BloodRequestUser {
	
	private String patientName;
	private String attendeeName;
	private String attendeeMobile;
	private String bloodGroup;
	private String dob;
	private String state;
	private String city;
	private String pincode;
	private String requiredate;
	private String gender;
	private String requsitionForm;
	private String addtionalNotes;
	private Timestamp timestamp;
	
	
	
	
	
	
	
	
	
	
	public BloodRequestUser(String patientName, String attendeeName, String attendeeMobile, String bloodGroup, String dob,
			String state, String city, String pincode, String requiredate, String gender, String requsitionForm,
			String addtionalNotes) {
		super();
		this.patientName = patientName;
		this.attendeeName = attendeeName;
		this.attendeeMobile = attendeeMobile;
		this.bloodGroup = bloodGroup;
		this.dob = dob;
		this.state = state;
		this.city = city;
		this.pincode = pincode;
		this.requiredate = requiredate;
		this.gender = gender;
		this.requsitionForm = requsitionForm;
		this.addtionalNotes = addtionalNotes;
	}
	public BloodRequestUser() {
		super();
		
	}
	public BloodRequestUser(String patientName, String attendeeName, String attendeeMobile, String bloodGroup, String dob,
			String state, String city, String pincode, String requiredate, String gender, String requsitionForm,
			String addtionalNotes, Timestamp timestamp) {
		super();
		this.patientName = patientName;
		this.attendeeName = attendeeName;
		this.attendeeMobile = attendeeMobile;
		this.bloodGroup = bloodGroup;
		this.dob = dob;
		this.state = state;
		this.city = city;
		this.pincode = pincode;
		this.requiredate = requiredate;
		this.gender = gender;
		this.requsitionForm = requsitionForm;
		this.addtionalNotes = addtionalNotes;
		this.timestamp = timestamp;
	}
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public String getAttendeeName() {
		return attendeeName;
	}
	public void setAttendeeName(String attendeeName) {
		this.attendeeName = attendeeName;
	}
	public String getAttendeeMobile() {
		return attendeeMobile;
	}
	public void setAttendeeMobile(String attendeeMobile) {
		this.attendeeMobile = attendeeMobile;
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public String getRequiredate() {
		return requiredate;
	}
	public void setRequiredate(String requiredate) {
		this.requiredate = requiredate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getRequsitionForm() {
		return requsitionForm;
	}
	public void setRequsitionForm(String requsitionForm) {
		this.requsitionForm = requsitionForm;
	}
	public String getAddtionalNotes() {
		return addtionalNotes;
	}
	public void setAddtionalNotes(String addtionalNotes) {
		this.addtionalNotes = addtionalNotes;
	}
	public Timestamp getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}
	
	
	
	
	
	
}
