package yososuproject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class DataArrays {

	public static ArrayList<Databases> a2 = new ArrayList<>();
	
	public static ArrayList<Databases> getArrayList(){
		return a2;
	}
	
	public static ArrayList<Databases> parselist() {
	int k =0;
	int j =2000;		
	
	 //List<DateItem> dateList = new ArrayList<>();
	 	
		try {
			URL url;
			url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page="+k+"&perPage="+j+"&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			 String rs = bf.readLine();
			 
			 JSONParser jsonParser = new JSONParser();
			 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
			 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
			 for(int i2 =0; i2<DEFArray.size(); i2++){
				 JSONObject DEFobject = (JSONObject) DEFArray.get(i2);
				 String lat = (String)DEFobject.get("lat");
				 String lng = (String)DEFobject.get("lng");
				 String name = (String)DEFobject.get("name");
				 
				 Databases databases2 = new Databases(lat, lng, name);
				 a2.add(databases2);
				 
			 } 
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
			 
			 //System.out.print("lng : " + lng + " lat : " + lat +" name : " +name);
			 
		return a2;
	}
}
