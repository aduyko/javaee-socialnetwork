package model;

/**
 * 
 * @author James C. Porcelli
 *
 */
public class CircleMember {

	private int userId;
	private int circleId;
	private String circleName;
	private String type;
	private int ownerId;

	/**
	 * 
	 * @param userId
	 * @param circleId
	 */
	public CircleMember(int userId, int circleId, String circleName) {
		this.userId = userId;
		this.circleId = circleId;
		this.circleName = circleName;
	}

	/**
	 * 
	 * @param userId
	 * @param circleId
	 * @param circleName
	 * @param type
	 * @param ownerId
	 */
	public CircleMember(int userId, int circleId, String circleName,
			String type, int ownerId) {
		super();
		this.userId = userId;
		this.circleId = circleId;
		this.circleName = circleName;
		this.type = type;
		this.ownerId = ownerId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(int ownerId) {
		this.ownerId = ownerId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getCircleId() {
		return circleId;
	}

	public void setCircleId(int circleId) {
		this.circleId = circleId;
	}

	public String getCircleName() {
		return circleName;
	}

	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}

	public String toString() {
		return getCircleName();
	}

}
