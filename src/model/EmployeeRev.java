
package model;

/**
 *
 * @author Andy
 */
public class EmployeeRev {
	private int employee;
	private int revenue;
	public EmployeeRev(){};

	public EmployeeRev(int employee, int revenue) {
		this.employee = employee;
		this.revenue = revenue;
	}

	public int getEmployee() {
		return employee;
	}

	public void setEmployee(int employee) {
		this.employee = employee;
	}

	public int getRevenue() {
		return revenue;
	}

	public void setRevenue(int revenue) {
		this.revenue = revenue;
	}
	
}
