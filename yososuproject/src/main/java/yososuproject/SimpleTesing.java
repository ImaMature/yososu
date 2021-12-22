package yososuproject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class SimpleTesing {
   public static class DateItem {
        String datetime;
        
        DateItem(String date) {
            this.datetime = date;
        }
    }

    public static class SortByDate implements Comparator<DateItem> {
        @Override
        public int compare(DateItem a, DateItem b) {
            return a.datetime.compareTo(b.datetime);
        }
    }

    public static void main(String args[]) {
    	
    	String [][] aa = new String [5000][5000];
    	String [][] bb = new String [5000][5000];
		 List<DateItem> dateList = new ArrayList<>();
		
		 try{
			 URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page=1&perPage=1000&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
			 BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			 String rs = bf.readLine();
			 
			 JSONParser jsonParser = new JSONParser();
			 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
			 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
			 
			 for(int i=1; i < DEFArray.size(); i++){
				 
					JSONObject DEFobject = (JSONObject) DEFArray.get(i);
					DEFobject.get("regDt");
					aa[i][0] = (String)DEFobject.get("regDt");
					aa[0][i] = (String)DEFobject.get("name");
					
					dateList.add(new DateItem(aa[i][0]));
					//dateList.add(new DateItem(aa[0][i]));
					System.out.println(aa[i][0]);
				}
			 
			 
//	        dateList.add(new DateItem("2020-03-25"));
//	        dateList.add(new DateItem("2019-01-27"));
//	        dateList.add(new DateItem("2020-03-26"));
//	        dateList.add(new DateItem("2020-02-26"));
			 //참고한거 https://www.delftstack.com/ko/howto/java/how-to-sort-objects-in-arraylist-by-date-in-java/
	        Collections.sort(dateList ,new SortByDate());
	        
	        for(int i =0; i<dateList.size(); i++) {
	        	bb[i][0] = dateList.get(i).datetime; // 정렬된 데이터 저장 
	        	System.out.println(bb[i][0] + "dsafsd");
//	        	for(int j = 0; j<bb.length; j++) {
//	        		if(bb[1][0].contains(aa[i][0])) {
//	        			
//        			System.out.println(aa[0][j] + "fasdfsdafdsaf");
//	        			
//	        		}
//	        	}
//	        	int num = bb.length;
//	        	System.out.println(num + " : num");
//	        	System.out.print(bb[bb.length][0] + "fasdfsd");
	        	
	        }
	       
	        
	        
	        
//	        for(int i =0; i<dateList.size(); i++) {
//	        	System.out.println(dateList.get(i).datetime );
//	        	System.out.println(dateList.get(i).datetime.split("num:") + "adsfdasfds");
//	        	//System.out.println(dateList.get(i).datetime.substring(25) );
//	        }
	       
	        dateList.forEach(date -> {
	            System.out.println(date.datetime);
	            
	            
	        });
	        DateItem enddate = dateList.get( dateList.size()-1 );
	        System.out.println( enddate.datetime );
	        
		 }catch (Exception e) {
			// TODO: handle exception
		}
    }
}  
