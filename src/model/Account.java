
package model;

import java.sql.Date;

/**
 *
 * @author Andy
 */
public class Account {
	private int accountNumber;
	private int userId;
	private Date creationDate;
	private int ccNum;
	
	public Account(){};

	public Account(int accountNumber, int userId, Date creationDate, int ccNum) {
		this.accountNumber = accountNumber;
		this.userId = userId;
		this.creationDate = creationDate;
		this.ccNum = ccNum;
	}

	public int getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(int accountNumber) {
		this.accountNumber = accountNumber;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public int getCcNum() {
		return ccNum;
	}

	public void setCcNum(int ccNum) {
		this.ccNum = ccNum;
	}
	
}
