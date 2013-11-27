package model;

/**
 * 
 * @author James C. Porcelli
 * 
 */
public class Circle {

	private int circleId;
	private int ownerId;
	private String name;
	private String type;
	
	/**
	 * 
	 * @param circleId
	 * @param ownerId
	 * @param name
	 * @param type
	 */
	public Circle(int circleId, int ownerId, String name, String type) {
		this.circleId = circleId;
		this.ownerId = ownerId;
		this.name = name;
		this.type = type;
	}

	public int getCircleId() {
		return circleId;
	}

	public void setCircleId(int circleId) {
		this.circleId = circleId;
	}

	public int getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(int ownerId) {
		this.ownerId = ownerId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String toString() {
		return getName();
	}
}
