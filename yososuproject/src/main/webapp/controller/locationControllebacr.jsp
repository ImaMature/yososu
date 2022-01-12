<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="yososuproject.Databases"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*다른페이지 

근처 요소수 주유소 찾기 버튼 클릭  1단계
해당 거리에 맞는 주유소 출력 
(여기까지는 distance로 해결했음) 

해당 거리에 맞는 주유소를 마킹한다 2단계 
(해당 거리에 맞는 이름 리스트를 알고있으니까 리스트를 하나씩 대입해서 검색해서 좌표값을 알아낸다)
원래 가지고있던 (리스트 arr을 기준으로 arr2의 name equals) --> 해당 주유소의 모든 정보가 나옴 
--> 좌표값만 파싱해서 지도에 뿌린다.  

좌표값을 지도에 뿌려준다. 3단계 */ 

double c_lat = 0; 
double c_lng = 0; 
double c_lat2 = 0;
double c_lng2 = 0; 

int k =0;
int j =2000;
URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page="+k+"&perPage="+j+"&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
String rs = bf.readLine();

JSONParser jsonParser = new JSONParser();
JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
JSONArray DEFArray = (JSONArray) jsonObject.get("data");

//객체로 담아서 해당 반경의 주유소 찾기
double lat = Double.parseDouble(request.getParameter("lat4")); //경도
double lng = Double.parseDouble(request.getParameter("lon4")); //위도
System.out.println("js에서 넘어온 현재 경도 : "+lat);
System.out.println("js에서 넘어온 현재 위도 : "+lng);

//api 파싱한 정보가 담긴 리스트
ArrayList<Databases> arr = new ArrayList<>();
//파싱한 사이즈만큼 반복문 돌려서 나온 이름과 거리가 담긴 리스트
ArrayList<Databases> arr2 = new ArrayList<>();
//위 두 리스트를 비교해서 값을 담아서 js로 넘겨줄 리스트
ArrayList<Databases> arr3 = new ArrayList<>();

//api 새로 가져와서 리스트에 담기
for(int i =0; i<DEFArray.size();i++){
	//System.out.print("getLat : "+arr.get(i).getLat());
	JSONObject DEFobject = (JSONObject) DEFArray.get(i);
	String name = (String)DEFobject.get("name");
	String lat2 = (String)DEFobject.get("lat");
	String lng2 = (String)DEFobject.get("lng");
	String addr = (String)DEFobject.get("addr");
	String openTime = (String)DEFobject.get("openTime");
	String tel = (String)DEFobject.get("tel");
	String inventory = (String)DEFobject.get("inventory");
	String price = (String)DEFobject.get("price");
	Databases databases = new Databases(name,inventory,addr,price,lat2,lng2,tel,openTime);
	//이름 위도 경도 담기
	arr.add(databases);
}

//파싱한 사이즈 만큼 반복문 돌려서 거리 구하기
for(int u=0; u<arr.size(); u++){
	
	//위도 경도로 거리 구해서  arraylist에 이름과 거리 담기
	double lat2 = Double.parseDouble(arr.get(u).getLat());
	double lng2 = Double.parseDouble(arr.get(u).getLng());
	
	c_lat = lat; // 현재 위도
	c_lng = lng; // 현재 경도 
	c_lat2 = lat2; // 모든 위도
	c_lng2 = lng2; // 모든 경도
	
	
    double distance; //거리 객체
    double radius = 6371; // 지구 반지름(km)
    double toRadian = Math.PI / 180;

    double deltaLatitude = Math.abs(c_lat - c_lat2) * toRadian;
    double deltaLongitude = Math.abs(c_lng - c_lng2) * toRadian;

    double sinDeltaLat = Math.sin(deltaLatitude / 2);
    double sinDeltaLng = Math.sin(deltaLongitude / 2);
    double squareRoot = Math.sqrt(
        sinDeltaLat * sinDeltaLat +
        Math.cos(c_lat * toRadian) * Math.cos(c_lat2 * toRadian) * sinDeltaLng * sinDeltaLng);

    distance = 2 * radius * Math.asin(squareRoot);
    Databases databases2 = new Databases(arr.get(u).getAddr(), distance);
    //이름과 거리 리스트에 저장하기
    arr2.add(databases2);
    
}

//거리 테스트
for(int uu = 0; uu<arr2.size(); uu++){
	if(arr2.get(uu).getDistance() < 4){ // 5km보다 작은 거리에 있는 리스트들을 출력 
		//System.out.println("arr2 : "+arr2.get(uu).getName());
		//System.out.println("arr2거리 : "+arr2.get(uu).getDistance());	
		//System.out.println("arr2주소 : "+arr2.get(uu).getAddr());
	}	
}
//두 arraylist 비교해서 값 3번째 arraylist에 담아서 js에 값 넘기기
for(int y = 0; y<arr.size(); y++){
	for(int m=0; m<arr2.size(); m++){
		//두 arraylist의 이름이 같고 거리가 5km보다 작다면
		if(arr.get(y).getAddr().equals(arr2.get(m).getAddr()) && arr2.get(m).getDistance() < 4){ 
			System.out.println("==========================================");
			System.out.println("arr1 name :" + arr.get(y).getName());
			System.out.println("arr1 재고 : "+arr.get(y).getInventory());
			System.out.println("arr2 주소 : "+arr2.get(m).getAddr());
			System.out.println("arr1 가격 : "+arr.get(y).getPrice());
			System.out.println("arr1 lat : " + arr.get(y).getLat() + "arr1 lng : " + arr.get(y).getLng());
			System.out.println("arr1 전화번호 : "+arr.get(y).getTel());
			System.out.println("arr2 distance :" + arr2.get(m).getDistance()); 
			
			Databases databases2 = new Databases(arr.get(y).getName(), 
												arr.get(y).getInventory(),
												arr2.get(m).getAddr(),
												arr.get(y).getPrice(),
												arr.get(y).getLat(), 
												arr.get(y).getLng(),
												arr.get(y).getTel(),
												arr.get(y).getOpenTime(),
												arr2.get(m).getDistance());
			arr3.add(databases2);
			
			
		}
		
	}
}
%>
<%=arr3%>
