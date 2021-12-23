package yososuproject;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Date;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class test {

	public static void main(String[] args) {
		try {

    		URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page=1&perPage=1000&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
    		
			 BufferedReader bf;
			 
			 bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
    		
    		String result = bf.readLine();
    		//System.out.println(result);
    		JSONParser jsonParse = new JSONParser(); 
    		//JSONParse에 json데이터를 넣어 파싱한 다음 JSONObject로 변환한다. 
    		JSONObject jsonObj = (JSONObject) jsonParse.parse(result); 
    		//JSONObject에서 PersonsArray를 get하여 JSONArray에 저장한다. 
    		JSONArray DEFArray = (JSONArray) jsonObj.get("data");
    		//System.out.println( personArray );
    		
    	
    			System.out.println("지역을 입력해주세요."); String address = .sc.next();
    			
    			//필요한건 주소 (addr), 상호명(name), 가격(price), 전화번호(tel), 재고량(inventory)
    			for(int i=0; i < DEFArray.size(); i++) { 
        			JSONObject DEFobject = (JSONObject) DEFArray.get(i);
        			String addr = (String) DEFobject.get("addr");	//주소
        			String name = (String) DEFobject.get("name");	//상호명
        			String price = (String) DEFobject.get("price");	//가격
        			String tel = (String) DEFobject.get("tel");		//전화번호
        			String inventory = (String) DEFobject.get("inventory");	//재고량
        			Date date = new Date();
        			
        			
        			if(addr.contains(address)) {	
        				StringBuffer sb = new StringBuffer();
        				sb.append("-------------------------------------------------------\n"+
        						" | 상호명 : " + name + "\n | 주소 : " + addr +"\n | 전화번호 : " + tel + "\n | 요소수 가격 : "+price + "\n | 재고량 : " + inventory +"\n"+
        						"--------------------------------------------------------\n");
        				
	    				String addrSplit [] = addr.split(address);
	    				String addrSplit1 = addrSplit[0];
	    				String addrSplit2 = addrSplit[1];
	    				if( addrSplit2.charAt(0)== ' ' || addrSplit2.charAt(0)== '광') {
	    					System.out.print( sb.toString() );
	    				}
	    				else if( addrSplit2.charAt(0)== ' ' || addrSplit2.charAt(0)== '특') {
	    					System.out.print( sb.toString() );
	    				}
	    				else if( addrSplit2.charAt(0)== ' ' || addrSplit2.charAt(0)== '시') {
	    					System.out.print( sb.toString() );
	    				}
    	    		}
        		}
        		bf.close();
	}

