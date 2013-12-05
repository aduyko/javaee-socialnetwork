
package model;

import java.sql.Date;

/**
 *
 * @author Andy
 */
public class Employee {
	private int empId;
	private int SSN;
	private String password;
	private String fname;
	private String lname;
	private int rate;
	private Date startDate;
	private String role;
	private String address;
	private String city;
	private String state;
	private String ZIP;
	private int telephone;
	
	public Employee() {}

	public Employee(int empId, int SSN, String password, String fname, String lname, int rate, Date startDate, String role, String address, String city, String state, String ZIP, int telephone) {
		this.empId = empId;
		this.SSN = SSN;
		this.password = password;
		this.fname = fname;
		this.lname = lname;
		this.rate = rate;
		this.startDate = startDate;
		this.role = role;
		this.address = address;
		this.city = city;
		this.state = state;
		this.ZIP = ZIP;
		this.telephone = telephone;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public int getSSN() {
		return SSN;
	}

	public void setSSN(int SSN) {
		this.SSN = SSN;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZIP() {
		return ZIP;
	}

	public void setZIP(String ZIP) {
		this.ZIP = ZIP;
	}

	public int getTelephone() {
		return telephone;
	}

	public void setTelephone(int telephone) {
		this.telephone = telephone;
	}
}
