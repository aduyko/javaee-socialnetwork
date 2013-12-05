package bll;

import java.sql.Connection;
import java.sql.Date;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import database.Database;
import model.Advertisement;
import model.Employee;
import model.Transaction;
import model.User;
/**
 *
 * @author Andy
 */
public class AdDao {
	
	public static Advertisement findAd(int id) {
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Inserting ad");
		
		String query = "select * from Advertisement where advertisement_id = "+id;
		try {
			ps = conn.createStatement();
			ResultSet res = ps.executeQuery(query);
			Advertisement ad = new Advertisement();
			
			while (res.next()) {
				int adId = res.getInt("Advertisement_Id");
				int employee = res.getInt("Employee");
				String type = res.getString("Type");
				Date timePosted = res.getDate("Date");
				String company = res.getString("Company");
				String itemName = res.getString("Item_Name");
				String content = res.getString("Content");
				int unitPrice = res.getInt("Unit_Price");
				int availableUnits = res.getInt("Available_Units");
				
				ad = new Advertisement(adId,employee,type,timePosted,
						company,itemName,content,unitPrice,availableUnits);
			}
			ps.close();
			conn.close();
			return ad;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static Advertisement newAd(Advertisement initAd) {
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Inserting ad");
		String props = "";
		props += initAd.getAdId() + ", " +
				 initAd.getEmployee() + ", " +
				 initAd.getType() + ", " +
				 initAd.getTimePosted() + ", " +
				 initAd.getCompany() + ", " +
				 initAd.getItemName() + ", " +
				 initAd.getContent() + ", " +
				 initAd.getUnitPrice() + ", " +
				 initAd.getAvailableUnits();
		String query = "insert into Advertisement values "+props;
		try {
			ps = conn.createStatement();
			ps.executeQuery(query);
			ps.close();
			conn.close();
			return initAd;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void deleteAd(int id) {
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Deleting ad");

		String query = "delete from Advertisement where advertisement_id = " + id;
		try {
			ps = conn.createStatement();
			ResultSet res = ps.executeQuery(query);
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/*
	public static Transaction recordTransaction() {
		Transaction transaction = new Transaction();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return transaction;
	}
	public static ArrayList<Transaction> getSalesReport(int month) {
		ArrayList<Transaction> transactions = new ArrayList<Transaction>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return transactions;
	}
	public static ArrayList<Advertisement> getAllAds() {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return advertisements;
	}
	//type = 1 is item name, 2 is customer
	public static ArrayList<Transaction> getTransactions(String name, int type) {
		ArrayList<Transaction> transactions = new ArrayList<Transaction>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return transactions;
	}
	//1 = item name 2 = item type, 3 = customer 
	public static ArrayList<Transaction> getRevenue(String name, int type) {
		ArrayList<Transaction> transactions = new ArrayList<Transaction>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return transactions;
	}
	public static Employee getBestEmployee() {
		Employee employee = new Employee();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return employee;
	}
	public static User getBestUser() {
		User user = new User();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return user;
	}
	public static ArrayList<Advertisement> getMostActiveAds() {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return advertisements;
	}
	public static ArrayList<User> getBuyers(int id) {
		ArrayList<User> users = new ArrayList<User>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return users;
	}
	public static ArrayList<Advertisement> getCompanyAds (String company) {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		Statement ps;
		
		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT ?";
		try {
			ps = conn.createStatement();
			
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad = new Advertisement();
			}
			ps.close();
			conn.close();
			return advertisement;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
		return advertisements;
	}
	*/
	public static ArrayList<Advertisement> getRandomAds(int limit) {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		Statement ps;

		System.out.println("Log: Obtaining random ads");

		String query = "select * from Advertisement LIMIT " + limit;
		try {
			ps = conn.createStatement();
			ResultSet res = ps.executeQuery(query);
			while (res.next()) {
				Advertisement ad;
				
				int adId = res.getInt("Advertisement_Id");
				int employee = res.getInt("Employee");
				String type = res.getString("Type");
				Date timePosted = res.getDate("Date");
				String company = res.getString("Company");
				String itemName = res.getString("Item_Name");
				String content = res.getString("Content");
				int unitPrice = res.getInt("Unit_Price");
				int availableUnits = res.getInt("Available_Units");
				
				ad = new Advertisement(adId,employee,type,timePosted,
						company,itemName,content,unitPrice,availableUnits);
				
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
