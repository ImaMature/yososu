package yososuproject;

public class Databases {

	private String name;
	private String inventory;
	private String addr;
	private String price;
	private String regDt;
	private String lat;
	private String lng;
	private String tel;
	private String openTime;
	
	public Databases() {
		
	}
	
	public Databases(String name, String inventory, String addr, String price, String regDt, String lat, String lng,
			String tel, String openTime) {
		super();
		this.name = name;
		this.inventory = inventory;
		this.addr = addr;
		this.price = price;
		this.regDt = regDt;
		this.lat = lat;
		this.lng = lng;
		this.tel = tel;
		this.openTime = openTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInventory() {
		return inventory;
	}

	public void setInventory(String inventory) {
		this.inventory = inventory;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}
	
	
	
	
}
