
package model;

import java.sql.Date;

/**
 *
 * @author Andy
 */
public class Transaction {
	private int tranId;
	private Date date;
	private int ad;
	private int numUnits;
	private int account;
	public Transaction(){};

	public Transaction(int tranId, Date date, int ad, int numUnits, int account) {
		this.tranId = tranId;
		this.date = date;
		this.ad = ad;
		this.numUnits = numUnits;
		this.account = account;
	}

	public int getTranId() {
		return tranId;
	}

	public void setTranId(int tranId) {
		this.tranId = tranId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getAd() {
		return ad;
	}

	public void setAd(int ad) {
		this.ad = ad;
	}

	public int getNumUnits() {
		return numUnits;
	}

	public void setNumUnits(int numUnits) {
		this.numUnits = numUnits;
	}

	public int getAccount() {
		return account;
	}

	public void setAccount(int account) {
		this.account = account;
	}
	
}
