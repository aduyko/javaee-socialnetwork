package model;

import java.sql.Date;

/**
 * 
 * @author James C. Porcelli
 * 
 */
public class User {

	private int userId;
	private String firstName;
	private String lastName;
	private String emailAddress;
	private String password;
	private String address;
	private String city;
	private String state;
	private String zipCode;
	private String telephone;
	private String gender;
	private Date dateOfBirth;
	private int rating;

	/**
	 * 
	 * @param userId
	 * @param firstName
	 * @param lastName
	 * @param emailAddress
	 * @param password
	 * @param address
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param telephone
	 * @param gender
	 * @param dateOfBirth
	 * @param rating
	 */
	public User(int userId, String firstName, String lastName,
			String emailAddress, String password, String address, String city,
			String state, String zipCode, String telephone, String gender,
			Date dateOfBirth, int rating) {
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailAddress = emailAddress;
		this.password = password;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zipCode = zipCode;
		this.telephone = telephone;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.rating = rating;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
}
