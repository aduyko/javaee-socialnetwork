
package model;

/**
 *
 * @author Andy
 */
public class CustomerRev {
	private int user;
	private int account;
	private int revenue;
	
	public CustomerRev(){}

	public CustomerRev(int user, int account, int revenue) {
		this.user = user;
		this.account = account;
		this.revenue = revenue;
	}

	public int getUser() {
		return user;
	}

	public void setUser(int user) {
		this.user = user;
	}

	public int getAccount() {
		return account;
	}

	public void setAccount(int account) {
		this.account = account;
	}

	public int getRevenue() {
		return revenue;
	}

	public void setRevenue(int revenue) {
		this.revenue = revenue;
	}
	
	
}
