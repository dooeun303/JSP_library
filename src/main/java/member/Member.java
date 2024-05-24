package member;



public class Member {

	private String memberID;

	private String memberName;

	private String memberPW;

	private int memberSN;

	private String birthDate;
	
	private int isAdmin;

	


	//getter & setter
	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPW() {
		return memberPW;
	}

	public void setMemberPW(String memberPW) {
		this.memberPW = memberPW;
	}

	public int getMemberSN() {
		return memberSN;
	}

	public void setMemberSN(int memberSN) {
		this.memberSN = memberSN;
	}

	public String getBirthDate() {
		return birthDate;
	}
	
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	} 
	
	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

}