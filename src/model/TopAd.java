
package model;

/**
 *
 * @author Andy
 */
public class TopAd {
	private int adId;
	private int numSales;
	private int numUnits;
	public TopAd(){};

	public TopAd(int adId, int numSales, int numUnits) {
		this.adId = adId;
		this.numSales = numSales;
		this.numUnits = numUnits;
	}

	public int getAdId() {
		return adId;
	}

	public void setAdId(int adId) {
		this.adId = adId;
	}

	public int getNumSales() {
		return numSales;
	}

	public void setNumSales(int numSales) {
		this.numSales = numSales;
	}

	public int getNumUnits() {
		return numUnits;
	}

	public void setNumUnits(int numUnits) {
		this.numUnits = numUnits;
	}
	
}
