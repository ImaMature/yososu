package dto;

import java.util.ArrayList;
import java.util.Arrays;

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
	private double distance; 
	
	public ArrayList<Databases> DataArray = new ArrayList<>();
	
	public Databases() {
		
	}
	
	//이름하고 거리 담기 //이름으로 비교
	public Databases(String addr, double distance) {
		super();
		this.addr = addr;
		this.distance = distance;
	}

	//두 arraylist 비교해서 3번째 arraylist arr3에 담을 필드
	
	

	//메인 파싱용
	public Databases(String name, String inventory, String addr, String price, String regDt, String lat, String lng,
			String tel, String openTime, double distance) {
		this.name = name;
		this.inventory = inventory;
		this.addr = addr;
		this.price = price;
		this.regDt = regDt;
		this.lat = lat;
		this.lng = lng;
		this.tel = tel;
		this.openTime = openTime;
		this.distance = distance;
	}
	
	public Databases(String name, String inventory, String addr, String price, String regDt, String lat, String lng,
			String tel, String openTime) {
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
	
	
	public Databases(String name, String lat, String lng  ) {
		this.name = name;
		this.lat = lat;
		this.lng = lng;
	}
	
	
	//js에 넘겨주기용
	public Databases(String name, String inventory, String addr, String price, String lat, String lng, String tel,
			String openTime, double distance) {
		super();
		this.name = name;
		this.inventory = inventory;
		this.addr = addr;
		this.price = price;
		this.lat = lat;
		this.lng = lng;
		this.tel = tel;
		this.openTime = openTime;
		this.distance = distance;
	}
	
	//새로운 파싱용
	public Databases(String name, String inventory, String addr, String price, String lat, String lng, String tel,
			String openTime) {
		super();
		this.name = name;
		this.inventory = inventory;
		this.addr = addr;
		this.price = price;
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
	
	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		String aa = builder.append(lat+"_"+lng+"_"+name+"_"+inventory+"_"+addr+"_"+tel+"_"+openTime).toString();
		return aa;
	}
	
	

	
	
	
}
