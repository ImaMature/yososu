# Youtube
## contentes
[1. 개요](#1-개요)   
[2. 개발 환경](#2-개발-환경)  
[3. 개발 일정](#3-개발-일정)   
[4. 주요 기능](#4-주요-기능)  
[5. Package 구조도 ](#5-Package-구조도)
 

## 1. 개요

### 1.1. 목적 : 요소수에 대한 정보 전달.
### 1.2. 주 타겟 고객 : 요소수 자주 이용하는 운전 기사님들.
  
## 2. 개발 환경
- 운영체제 : Windows10
- Front-end : html, CSS, Bootstrap, javaScript, JQuery
- Back-end : JDK 11, Eclipse EE 2021-09
- Server : Apache Tomcat 9.0
- Version Control : Git
- API : [Kakao Map API](https://developers.kakao.com/product/map) , [공공데이터 요소수 API](https://www.data.go.kr/data/15095040/openapi.do)  

## 3. 개발 일정
- 기간 : 2021.12.13 ~ 2021.01.14  
- History

|날짜|내용|
|----|----|
|2021.12.12|주제 선정|
|2021.12.13|Front 초안 설계|
|2021.12.13 ~ 2021.12.15|Front 초안 구현<br>패키지 구성|
|2021.12.21|요소수 API Parsing|
|2021.12.22|요소수 테이블 구현<br>페이징 추가<br>검색 기능 추가|
|2021.12.23|검색 기능 추가|
|2021.12.23 ~ 2021.12.24|뉴스 크롤링|
|2021.12.26|크롤링 버그 수정|
|2021.12.27|현재 위치 근처 주유소 찾기 기능 추가<br>주유소 위치 지도 표시 기능 추가|
|2021.12.28 ~ 2022.01.06|위치 찾기 & 지도 버그 수정|
|2022.01.07 ~ 2022.01.10|프론트 디자인 변경<br>기능 연결 수정|
|2022.01.10|현재 주유소 위치 연결|
|2022.01.11 ~ 2022.01.14|프로젝트 오류 수정 및 완성|

## 4. 주요 기능
<details>
<summary>여기를 눌러주세요</summary>
    
### 가장 주요했던 기능은 2개였습니다.

둘다 지도를 사용했던 기능인데, 모두 카카오 지도 API를 사용했습니다.

### 1. 표에서 상호명을 누르면 해당 주유소와 일치하는 지도를 자동으로 스크롤 내려서 나타내기
 
 ![Untitled](https://user-images.githubusercontent.com/88884623/149661459-5e6cd15d-da73-4e00-bab7-5ecce61d2c2e.png)

주유소의 상호명, 주소, 요소수 가격, 전화번호, 요소수 재고량이 나와있는 테이블 jsp 코드이다.

프론트로 보자면 이렇습니다.

![Untitled (1)](https://user-images.githubusercontent.com/88884623/149661492-ce9bbf42-e142-4554-b8a8-909a0306e1a6.png)

이 페이지에서 상호명을 누르면 oncllick메소드가 실행되며 위도와 경도를 js로 넘겨줍니다. 그리고 동시에 프론트에서는 지도 페이지로 스크롤이 됩니다. (a href="#mainmap”로 해당 id가 있는 div로 이동이 가능합니다!!)

```jsx
//a태그 누르면 해당 주유소 표시하기
function detailmap(laat, lnng){
	var lat3 = laat;
	var lng3 = lnng;
	var container2 = document.getElementById('map');
	var options2 = {
		center: new kakao.maps.LatLng(lat3, lng3),
		level: 3
	};

	var map3 = new kakao.maps.Map(container2, options2);
	var markerPosition  = new kakao.maps.LatLng(lat3, lng3); 
	// 마커를 생성합니다
	var marker3 = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 타일 로드가 완료되면 지도 중심에 마커를 표시합니다
	kakao.maps.event.addListener(map3, 'tilesloaded', displayMarker2);
	
	function displayMarker2() {
	    // 마커의 위치를 지도중심으로 설정합니다 
	    marker3.setMap(map3); 
	}
}
```

넘겨받은 위도(laat)와 경도(lnng)를 options2에 담습니다. 저 options2는 지도를 표시하기 위한 속성들이 있는 객체입니다. center로 카카오 api로 해당 좌표의 지도를 가운데에 두고 level로 지도의 확대 범위를 설정합니다.

그리고 id가 map인 div를 container2객체에 담아서 map3에 지도 정보로 저장합니다.

그리고 마커를 생선한뒤 지도 중심에 마커를 표시하는 함수와 마커의 위치를 지도 중심으로 설정하는 함수를 실행합니다.

**실행결과**
![Untitled (2)](https://user-images.githubusercontent.com/88884623/149661508-9d02d8f4-fea5-4318-8d49-eaeeb01b5940.png)
![Untitled (3)](https://user-images.githubusercontent.com/88884623/149661511-1c4080f0-8995-470a-9b87-da02e230624c.png)

---

### 2. 지도 페이지에서 근처 주유소 찾기 버튼을 누르면, 페이지 이동 없이 지도에 현재 위치의 마크, 주유소의 정보들이 담긴 메시지 박스를 출력하기


<details>
<summary>js코드 전문</summary>

```jsx
    //근처 주유소 찾기 start
    	$("#findnearbtn").click(function(){
    		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	    mapOption = { 
    	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    	        level:7 // 지도의 확대 레벨 
    	    }; 
    		bounds = new kakao.maps.LatLngBounds();
    		var map2 = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    		
    		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
    		if (navigator.geolocation) {
    		    
    		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    		    navigator.geolocation.getCurrentPosition(function(position) {
    				//현재 위치
    		        var lat2 = position.coords.latitude, // 위도
    		            lon2 = position.coords.longitude; // 경도
    		        var locPosition = new kakao.maps.LatLng(lat2, lon2), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
    		        message = '<div class="text-center" style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
    				arr = [];
    				arr2 = [];
    					 $.ajax({
    						url: "../controller/locationController.jsp" ,
    						data:{ lat4 : lat2 , lon4 : lon2 } , 
    						success : function(result){
    							arr = result.split(",");
    							for(i=0; i<arr.length; i++){
    								arr2[i] = arr[i].split("_");
    							}
    							
    							for(j=0; j<arr2.length; j++){
    								/*alert(arr2[j][0]) // 경도
    								alert(arr2[j][1]) // 위도
    								alert(arr2[j][2]) // 이름 
    								alert(arr2[j].length);
    								alert(arr2[j][0]+" "+ arr2[j][1]);*/
    								if(j==0){
    									//[가 붙은 인덱스의 위치 찾기
    									//var hi =arr2[j][0].indexOf("["); 
    									//20이 나옴
    									//alert(arr2[j][0].split("[")[1]);
    									//첫번째 주유소를 찾기 위해서 첫번재 좌표에서 "["을 기준으로 1번째 인덱스 가져오기
    									arr2[j][0]=arr2[j][0].split("[")[1];
    									//첫번째 주유소의 좌표의 경도가 나온다.
    									//alert(arr2[j][0]);
    								}
    								else if(j==arr2.length-1){
    									//alert(arr2[j][arr2.length-1].split("]")[0]);
    									arr2[j][arr2.length-1]=arr2[j][arr2.length-1].split("]")[0];
    									//alert(arr2[j][arr2.length-1]);										
    								}
    								var locPosition2 = new kakao.maps.LatLng(arr2[j][0], arr2[j][1])
    								message2 = '<div class="text" style="padding:1rem 1.6rem 1rem 1.6rem; font-size:0.7rem;">'+arr2[j][2]+'<br>'+'가격 : '+arr2[j][3]+'<br>'+arr2[j][5]+'</div>';
    					        	displayMarker(locPosition2, message2);
    							}							
    							displayMarker(locPosition, message);
    						}
    					})
    				map2.setCenter(locPosition); 
    		      });
    		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
    		        message = 'geolocation을 사용할수 없어요..'
    		    displayMarker(locPosition, message);
    		}
    		
    		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
    		kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
    		function displayMarker(locPosition, message) {
    		    // 마커를 생성합니다
    		    var marker2 = new kakao.maps.Marker({  
    		        map2: map2, 
    		        position: locPosition
    		    }); 
    		    
    		    var iwContent = message, // 인포윈도우에 표시할 내용
    		        iwRemoveable = true;
    		
    		    // 인포윈도우를 생성합니다
    		    var infowindow = new kakao.maps.InfoWindow({
    		        content : iwContent,
    		        removable : iwRemoveable
    		    })
    		    // 인포윈도우를 마커위에 표시합니다 
    		    infowindow.open(map2, marker2);
    		    // 지도 중심좌표를 접속위치로 변경합니다
    		    map2.setCenter(locPosition);  
    		} //근처 주유소 찾기 end(그러나 현재 내 위치만 나옴)  
    	});
    	//근처 주유소 찾기 end
```
</details><br>
   

위 토글은 근처 주유소를 찾아주는 javascript문의 전문입니다. 너무 길어서 숨겼습니다.

아이디가 findnearbtn인 버튼을 프론트에서 눌렀다면, 이곳이 실행됩니다.

지도를 먼저 div에 띄워서 보여줘야 합니다. 그렇지 않으면 지도가 빈칸으로 나오며 실행되지 않습니다.

![Untitled (5)](https://user-images.githubusercontent.com/88884623/149661555-6973558e-3b2c-4000-a726-44069dc82d6f.png)

level 로 지도의 확대 크기를 정할 수 있고, 지도가 표시되는 중심좌표를 정할 수 있습니다.

그 다음에 GPS로 현재의 위치를 알아내야 합니다.

알아낸 위도와 경도들로 좌표들을 설정합니다. message에는 원하는 HTML을 저장할 수 있습니다.

```jsx
if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
				//현재 위치
		        var lat2 = position.coords.latitude, // 위도
		            lon2 = position.coords.longitude; // 경도
					//현재 위치 테스트
					
		        var locPosition = new kakao.maps.LatLng(lat2, lon2), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		        message = '<div class="text-center" style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
```

이후에 ajax문을 사용했습니다. 

왜냐하면 프론트에서 버튼을 누르면 페이지 이동없이 비동기식으로 지도를 띄우고 싶었기 때문입니다.

그래서 위의 현재 위치 위도 경도를 locationController로 전달해 주었습니다.

![Untitled (6)](https://user-images.githubusercontent.com/88884623/149661565-00c0b268-7769-484e-a1a3-0d5a58a5fcce.png)

 locationController.jsp
 ![image](https://user-images.githubusercontent.com/88884623/149662322-3135b74e-0eb1-4a42-a126-f295f3aef4d6.png)
<br>
 ![image](https://user-images.githubusercontent.com/88884623/149662335-f79898ad-0d7b-4286-8383-d1b53567560b.png)
<br>
 ![image](https://user-images.githubusercontent.com/88884623/149662359-3eeee9fa-81b9-46fe-987b-ab081e700b01.png)

     

컨트롤러에서 
![Untitled (8)](https://user-images.githubusercontent.com/88884623/149662431-e03aee1c-efd6-40fb-80c9-a3237bd0061b.png)

경도와 위도를 double로 받아온 뒤에

리스트를 3개 선언했습니다.

Databases는 요소수 객체들을 (캡슐화)객체화시키기 위한 클래스로, 요소수 api 데이터의 속성값들의 객체, 생성자,  get set메소드들이 있습니다.

<details>
<summary> Databases</summary>
    
```java
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
    	
    	public Databases() {}
    	
    	//이름하고 거리 담기 //이름으로 비교
    	public Databases(String addr, double distance) {
    		super();
    		this.addr = addr;
    		this.distance = distance;
    	}
    
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
 ```
 </details>
    

![Untitled (9)](https://user-images.githubusercontent.com/88884623/149662551-1868ed93-b15c-4608-9e7f-c6fe9c4fac81.png)


하나는 api에서 새로 파싱한 정보를 담을 리스트고

두번째는 파싱한 사이즈 만큼 반복문을 돌려 나온 이름과 거리가 담긴 리스트입니다.

마지막은 두 리스트를 비교해서 값을 담아 js로 넘겨줄 리스트입니다.

<details>
 <summary>이름과 거리 담기</summary>
    
```java
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
```
</details>
    
    파싱한 사이즈만큼 반복문을 돌리고, 전체 데이터로부터 모든 위도, 경도들을 객체화하였습니다.
    
    그 다음 위치를 구하는 코드들을 실행한 뒤, 나온 주소[ arr.get(u).getAddr() ]와 거리[distance]를 객체화해서 두번째 ArrayList에 담았습니다.
    

위에서 담은 모든 파싱한 정보가 담긴 리스트와 두번째 이름과 거리가 담긴 리스트를 비교하여 

```java
for(int y = 0; y<arr.size(); y++){
	for(int m=0; m<arr2.size(); m++){
		//두 arraylist의 이름이 같고 거리가 4km보다 작다면
		if(arr.get(y).getAddr().equals(arr2.get(m).getAddr()) && arr2.get(m).getDistance() < 4){ 
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
<%out.print(arr3);%>
```

3번째 리스트에 담아 ajax로 넘겨주었습니다.

그런데 넘길때, 메모리주소 값들만 나오는 것이었습니다.

그래서 Databases 클래스에 @Override를 해서

```java
@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		String aa = builder.append(lat+"_"+lng+"_"+name+"_"+price+"_"+addr+"_"+tel+"_"+openTime).toString();
		return aa;
	}
```

toString()메소드로 String화 하고 Stringbuilder를 이용해 값들(경도, 위도, 상호명, 재고, 주소, 전화번호, 영업시간)을 aa 객체에 담아 반환했습니다.

그러니까, 통신한 결과 값들이 정상적으로 출력되었습니다.

---

- 통신 이후 코드
    
    ```jsx
    arr = [];
    arr2 = [];
    	 $.ajax({
    		url: "../controller/locationController.jsp" ,
    		data:{ lat4 : lat2 , lon4 : lon2 } , 
    		success : function(result){
    			arr = result.split(",");
    			for(i=0; i<arr.length; i++){
    				arr2[i] = arr[i].split("_");
    			}
    			
    			for(j=0; j<arr2.length; j++){
    				/*alert(arr2[j][0]) // 경도
    				alert(arr2[j][1]) // 위도
    				alert(arr2[j][2]) // 이름 
    				alert(arr2[j].length);
    				alert(arr2[j][0]+" "+ arr2[j][1]);*/
    				if(j==0){
    					//[가 붙은 인덱스의 위치 찾기
    					//var hi =arr2[j][0].indexOf("["); 
    					//20이 나옴
    					//alert(arr2[j][0].split("[")[1]);
    					//첫번째 주유소를 찾기 위해서 첫번재 좌표에서 "["을 기준으로 1번째 인덱스 가져오기
    					arr2[j][0]=arr2[j][0].split("[")[1];
    					//첫번째 주유소의 좌표의 경도가 나온다.
    					//alert(arr2[j][0]);
    				}
    				else if(j==arr2.length-1){
    					//alert(arr2[j][arr2.length-1].split("]")[0]);
    					arr2[j][arr2.length-1]=arr2[j][arr2.length-1].split("]")[0];
    					//alert(arr2[j][arr2.length-1]);										
    				}
    				var locPosition2 = new kakao.maps.LatLng(arr2[j][0], arr2[j][1])
    				//alert(locPosition2);
    				message2 = '<div class="text" style="padding:1rem 1.6rem 1rem 1.6rem; font-size:0.7rem;">'+arr2[j][2]+'<br>'+'가격 : '+arr2[j][3]+'<br>'+arr2[j][5]+'</div>';
    	        	displayMarker(locPosition2, message2);
    					
    			}
    			
    			displayMarker(locPosition, message);
    		}
    	});
     
    map2.setCenter(locPosition); 
      });
    ```
    

넘겨받은 값들을 `콤마(,)`를 기준으로 `split`하고, 다시 `언더바(_)`기준으로 `split`하였습니다.

첫번째 인덱스가 ‘`[`’이 붙어있길래, [값을 제거해주었고, 마지막에 있는 ‘`]`’도 역시 제거해주었습니다.

그 다음 위도와 경도를 마커가 표시될 위치를 나타내는 객체인 `locposition2`에 담아주었고,

`message`에는 띄울 html 코드(상호명, 가격, 전화번호)를 담아주었습니다.

그리고 나서 displayMarker 로 띄울 마커 변수에 담았습니다.

두번째 displayMarker는 처음에 gps로 받아온 현재 위치를 지도에 표시하기 위한 마커 변수입니다..

그리고 map2.setCenter(locPosition)으로 지도의 중심 위치를 현재 위치로 설정했습니다.

```java
// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		function displayMarker(locPosition, message) {
		    // 마커를 생성합니다
		    var marker2 = new kakao.maps.Marker({  
		        map2: map2, 
		        position: locPosition
		    }); 
		    
		    var iwContent = message, // 인포윈도우에 표시할 내용
		        iwRemoveable = true;
		
		    // 인포윈도우를 생성합니다
		    var infowindow = new kakao.maps.InfoWindow({
		        content : iwContent,
		        removable : iwRemoveable
		    });
		    
		    // 인포윈도우를 마커위에 표시합니다 
		    infowindow.open(map2, marker2);
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map2.setCenter(locPosition);  
		} //근처 주유소 찾기 end(그러나 현재 내 위치만 나옴)  
	});
	//근처 주유소 찾기 end
```

그 후에 지도에 마커와 인포윈도우(message)를 표시하기 위해 함수를 호출했습니다.

</details>

 
## 5. Package 구조도
![image](https://user-images.githubusercontent.com/88884623/149659785-486bf510-8970-4bfc-a3c7-15821179f609.png)   


### 6. Font : 노토 산스 
- 눈누 CDN([링크](https://noonnu.cc/font_page/34))

