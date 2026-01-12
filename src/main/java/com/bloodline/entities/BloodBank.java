package com.bloodline.entities;

import java.sql.Date;

public class BloodBank {
    private int bankId;
    private String name;
    private String city;
    private String address;
    private String phone;
    private String email;
    private String licenseNo;
    private Date establishedDate;
    private boolean active;

    public int getBankId() { return bankId; }
    public void setBankId(int bankId) { this.bankId = bankId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLicenseNo() { return licenseNo; }
    public void setLicenseNo(String licenseNo) { this.licenseNo = licenseNo; }

    public Date getEstablishedDate() { return establishedDate; }
    public void setEstablishedDate(Date establishedDate) { this.establishedDate = establishedDate; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
