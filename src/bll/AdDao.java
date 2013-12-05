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
import model.Account;
import model.Advertisement;
import model.CustomerRev;
import model.Employee;
import model.EmployeeRev;
import model.RevenueModel;
import model.TopAd;
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
	public static ArrayList<Advertisement> getAllAds() {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining all ads");

		String query = "select * from Advertisement";
		try {
			ps = conn.prepareStatement(query);
			ps.execute();
			ResultSet res = ps.getResultSet();
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
	public static EmployeeRev getBestRep() {
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining best rep");
		String query = "select MAX(r.Revenue) as Revenue, Employee "+
					   "from ("+
							"select SUM(p.number_of_units * a.unit_price) as Revenue, a.Employee "+
							"from purchase p, advertisement a "+
							"where p.Advertisement = a.Advertisement_Id "+
							"group by a.Employee "+
							") as r "+
							"where r.Revenue = (select MAX(d.Revenue) from ("+
								"select SUM(p.number_of_units * a.unit_price) as Revenue, a.Employee "+
								"from purchase p, advertisement a "+
								"where p.Advertisement = a.Advertisement_Id "+
								"group by a.Employee"+
							") as d"+
						")";
		try {
			ps = conn.prepareStatement(query);
			ps.execute();
			ResultSet res = ps.getResultSet();
			EmployeeRev er = new EmployeeRev();
			while (res.next()) {
				er.setEmployee(res.getInt("employee"));
				er.setRevenue(res.getInt("revenue"));
			}
			ps.close();
			conn.close();
			return er;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static CustomerRev getBestUser() {
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining best customer");
		String query = "select MAX(r.Revenue) as Revenue, a.Account_Number, a.User_Id "+
						"from ("+
							"select SUM(p.number_of_units * a.unit_price) as Revenue, p.Account "+
							"from purchase p, advertisement a "+
							"where p.Advertisement = a.Advertisement_Id "+
							"group by p.Account"+
						") as r, account a "+
						"where r.Account = a.Account_Number "+
						"and r.Revenue = (select MAX(d.Revenue) "+ 
						"from ("+
							"select SUM(p.number_of_units * a.unit_price) as Revenue, p.Account "+
							"from purchase p, advertisement a "+
							"where p.Advertisement = a.Advertisement_Id "+
							"group by p.Account "+
							") as d"+
						")";
		try {
			ps = conn.prepareStatement(query);
			ps.execute();
			ResultSet res = ps.getResultSet();
			CustomerRev cr = new CustomerRev();
			while (res.next()) {
				cr.setUser(res.getInt("user_id"));
				cr.setAccount(res.getInt("account_number"));
				cr.setRevenue(res.getInt("revenue"));
			}
			ps.close();
			conn.close();
			return cr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static ArrayList<TopAd> getMostActiveAds() {
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining most active ads");
		String query = "select Advertisement as Advertisement_Id, COUNT(*) as Number_Of_Sales, SUM(Number_Of_Units) as Number_Of_Units "+
						"from purchase p, advertisement a "+
						"where a.available_units > 0 "+
						"group by advertisement "+
						"order by Number_Of_Units DESC, Number_Of_Sales DESC "+
						"limit 5";
		try {
			ps = conn.prepareStatement(query);
			ps.execute();
			ResultSet res = ps.getResultSet();
			ArrayList<TopAd> activeAds = new ArrayList<TopAd>();
			while (res.next()) {
				TopAd ta = new TopAd();
				
				ta.setAdId(res.getInt("advertisement_id"));
				ta.setNumSales(res.getInt("number_of_sales"));
				ta.setNumUnits(res.getInt("number_of_units"));
				
				activeAds.add(ta);
			}
			ps.close();
			conn.close();
			return activeAds;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static ArrayList<Transaction> getSalesReport(int month, int year) {
		ArrayList<Transaction> transactions = new ArrayList<Transaction>();
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining sales report");

		String query = "SELECT p.* "+
					   "from purchase p, advertisement a "+
					   "WHERE p.Advertisement = a.Advertisement_Id and MONTH(p.Date) = "+
					   "? and YEAR(p.Date) = ?";
		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, month);
			ps.setInt(2, year);
			ps.execute();
			ResultSet res = ps.getResultSet();
			while (res.next()) {
				Transaction t = new Transaction();
				
				t.setTranId(res.getInt("transaction_id"));
				t.setDate(res.getDate("date"));
				t.setAd(res.getInt("advertisement"));
				t.setNumUnits(res.getInt("number_of_units"));
				t.setAccount(res.getInt("account"));
				
				transactions.add(t);
			}
			ps.close();
			conn.close();
			return transactions;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//type = 1 is item name, 2 is customer
	public static ArrayList<Transaction> getTransactions(String name, int type) {
		ArrayList<Transaction> transactions = new ArrayList<Transaction>();
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining transactions for " + name);
		
		String query;
		if (type==1){
			query = "SELECT p.* from purchase p, advertisement a "+
					"WHERE p.Advertisement = a.Advertisement_Id AND a.Item_Name = ?";
		} else {
			query = "select pu.* from purchase pu, account a, user u "+
					"where u.First_Name = ? and u.Last_Name = ? and "+
					"u.User_Id = a.User_Id and a.Account_Number "+
					"= pu.Account";
		}
		try {
			ps = conn.prepareStatement(query);
			if (type==1){
				ps.setString(1, name);
			} else {
				String[] names = name.split(" ");
				ps.setString(1, names[0]);
				ps.setString(2, names[1]);
			}
			ps.execute();
			ResultSet res = ps.getResultSet();
			while (res.next()) {
				Transaction t = new Transaction();
				
				t.setTranId(res.getInt("transaction_id"));
				t.setDate(res.getDate("date"));
				t.setAd(res.getInt("advertisement"));
				t.setNumUnits(res.getInt("number_of_units"));
				t.setAccount(res.getInt("account"));
				
				transactions.add(t);
			}
			ps.close();
			conn.close();
			return transactions;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	//1 = item name 2 = item type, 3 = customer 
	public static RevenueModel getRevenue(String name, int type) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining revenue");
		String query;
		if (type==1) {
			query = "select SUM(p.number_of_units * a.unit_price) as Revenue, " + 
					"SUM(p.number_of_units) as Units_Sold, Count(*) as " + 
					"Number_Of_Sales, a.Unit_Price " +
					"from purchase p, advertisement a " +
					"where p.Advertisement = a.Advertisement_Id and " + 
					"a.Item_Name = ? " +
					"group by p.Advertisement";
		} else if (type==2) {
			query = "select SUM(p.number_of_units * a.unit_price) as Revenue, " +
					"Count(*) as Number_Of_Sales, SUM(p.number_of_units) as " +
					"Units_Sold from purchase p, advertisement a " +
					"where p.Advertisement = a.Advertisement_Id and a.Type = ? " +
					"group by a.Type";
		} else {
			query = "select SUM(p.number_of_units * a.unit_price) as Revenue, " +
					"COUNT(*) as Number_Of_Purchases, " +
					"COUNT(Distinct a.Advertisement_Id) as Distinct_Items_Purchased, " +
					"COUNT(DISTINCT a.type) as Types_Of_Items_Purchased " +	
					"from purchase p, advertisement a, account ac, user u " +
					"where p.Advertisement = a.Advertisement_Id and " +
					"p.Account = ac.Account_Number and ac.User_Id = u.user_id and " +
					"u.first_name = ? and u.last_name = ? " +
					"group by u.User_Id";
		}
		try {
			ps = conn.prepareStatement(query);
			if (type==1 || type==2){
				ps.setString(1, name);
			} else {
				String[] names = name.split(" ");
				ps.setString(1, names[0]);
				ps.setString(2, names[1]);
			}
			ps.execute();
			ResultSet res = ps.getResultSet();
			RevenueModel rm = new RevenueModel();
			while (res.next()) {
				if (type==1 || type==2){
					rm.setRevenue(res.getInt("revenue"));
					rm.setNumSales(res.getInt("number_of_sales"));
					rm.setUnitsSold(res.getInt("units_sold"));
				} else {
					rm.setRevenue(res.getInt("revenue"));
					rm.setNumSales(res.getInt("number_of_purchases"));
					rm.setUnitsSold(res.getInt("distinct_items_purchased"));
					rm.setNumTypes(res.getInt("types_of_items_purchased"));
				}
				if (type==1) {
					rm.setUnitPrice(res.getInt("unit_price"));
				}
			}
			ps.close();
			conn.close();
			return rm;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static ArrayList<Account> getBuyers(String name) {
		ArrayList<Account> users = new ArrayList<Account>();
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining buyers for " + name);

		String query = "select a.account_number, a.user_id, a.account_creation_date " +
					   "from purchase p, account a, advertisement ad " +
					   "where p.advertisement = ad.advertisement_id " +
					   "and P.account = A.account_number " +
					   "and ad.item_name = ? ;";
		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, name);
			ps.execute();
			ResultSet res = ps.getResultSet();
			while (res.next()) {
				Account a = new Account();
				a.setAccountNumber(res.getInt("account_number"));
				a.setCreationDate(res.getDate("account_creation_date"));
				a.setUserId(res.getInt("user_id"));
				users.add(a);
			}
			ps.close();
			conn.close();
			return users;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static ArrayList<Advertisement> getCompanyAds (String company) {
		ArrayList<Advertisement> advertisements = new ArrayList<Advertisement>();
		Connection conn = Database.getConnection();
		PreparedStatement ps;
		
		System.out.println("Log: Obtaining ads for " + company);

		String query = "Select * From Advertisement A Where A.Company = ?";
		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, company);
			ps.execute();
			ResultSet res = ps.getResultSet();
			while (res.next()) {
				Advertisement ad;
				
				int adId = res.getInt("Advertisement_Id");
				int employee = res.getInt("Employee");
				String type = res.getString("Type");
				Date timePosted = res.getDate("Date");
				String comp = res.getString("Company");
				String itemName = res.getString("Item_Name");
				String content = res.getString("Content");
				int unitPrice = res.getInt("Unit_Price");
				int availableUnits = res.getInt("Available_Units");
				
				ad = new Advertisement(adId,employee,type,timePosted,
						comp,itemName,content,unitPrice,availableUnits);
				
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
