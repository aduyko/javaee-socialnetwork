package bll;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import database.Database;
import model.Advertisement;
/**
 *
 * @author Andy
 */
public class AdDao {
	public static ArrayList<Advertisement> getRandomAds() {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = database.Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement";
		try {
			ps = conn.prepareStatement(query);
			ResultSet res = ps.executeQuery();
			while (res.next()) {
				Advertisement ad = new Advertisement();
				
				int adId = res.getInt("Advertisement_Id");
				int employee = res.getInt("Employee");
				String type = res.getString("Type");
				Date timePosted = res.getDate("Date");
				String company = res.getString("Company");
				String itemName = res.getString("Item_Name");
				String content = res.getString("Content");
				int unitPrice = res.getInt("Unit_Price");
				int availableUnits = res.getInt("Available_Units");
				
				ad.setAdId(adId);
				ad.setAvailableUnits(availableUnits);
				ad.setCompany(company);
				ad.setContent(content);
				ad.setEmployee(employee);
				ad.setItemName(itemName);
				ad.setTimePosted(timePosted);
				ad.setType(type);
				ad.setUnitPrice(unitPrice);
				
				advertisements.add(ad);
				}
			ps.close();
			conn.close();
			return advertisements;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
