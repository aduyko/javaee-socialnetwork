
package model;

/**
 *
 * @author Andy
 */
public class RevenueModel {
	private int revenue;
	private int unitsSold;
	private int numSales;
	private int numTypes;
	private int unitPrice;
	
	public RevenueModel(){};

	public int getRevenue() {
		return revenue;
	}

	public void setRevenue(int revenue) {
		this.revenue = revenue;
	}

	public int getUnitsSold() {
		return unitsSold;
	}

	public void setUnitsSold(int unitsSold) {
		this.unitsSold = unitsSold;
	}

	public int getNumSales() {
		return numSales;
	}

	public void setNumSales(int numSales) {
		this.numSales = numSales;
	}

	public int getNumTypes() {
		return numTypes;
	}

	public void setNumTypes(int numTypes) {
		this.numTypes = numTypes;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}
	
}
