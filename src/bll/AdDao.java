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
import java.sql.PreparedStatement;
import model.Advertisement;
import model.Employee;
import model.Transaction;
import model.User;
/**
 *
 * @author Andy
 */
public class AdDao {
	
	public static ArrayList<Advertisement> getEmployeeAds(int empId) {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		Statement ps;

		System.out.println("Log: Obtaining employee ads");

		String query = "select * from Advertisement where employee = " + empId + ";";
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
		PreparedStatement ps;
		
		System.out.println("Log: Inserting ad");

		String query = "insert into Advertisement values (?,?,?,?,?,?,?,?,?);";
		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, initAd.getAdId());
			ps.setInt(2, initAd.getEmployee());
			ps.setString(3, initAd.getType());
			ps.setDate(4, new Date(System.currentTimeMillis()));
			ps.setString(5, initAd.getCompany());
			ps.setString(6, initAd.getItemName());
			ps.setString(7, initAd.getContent());
			ps.setInt(8, initAd.getUnitPrice());
			ps.setInt(9, initAd.getAvailableUnits());

			ps.execute();
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
		PreparedStatement ps;
		
		System.out.println("Log: Deleting ad");

		String query = "delete from Advertisement where advertisement_id = ?;";
		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			ps.execute();
			
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static Transaction newTransaction(Transaction initTran) {
		Transaction transaction = new Transaction();
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Inserting ad");

		String query = "insert into Purchase values (?,?,?,?,?);";
		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, initTran.getTranId());
			ps.setDate(2, new Date(System.currentTimeMillis()));
			ps.setInt(3, initTran.getAd());
			ps.setInt(4, initTran.getNumUnits());
			ps.setInt(5, initTran.getAccount());
			ps.execute();

			ps.close();
			conn.close();
			return transaction;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	/*
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
