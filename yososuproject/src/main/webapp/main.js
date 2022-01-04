
/*//검색
function search(){
	alert("펑션작동");
	var keyword = document.getElementById("keyword").value;
	alert(keyword);
	
	$.ajax({ //페이지 전환이 없음 [ 해당 페이지와 통신 ]
				url : "searchcontroller.jsp",
				data : {keyword : keyword},
				success : function(result){
					if(result){
						alert(result);
						var str =''
						for(var i=0; i<result.length; i++){
							str += '<span>' + result[i].data + '</span><br/>';
						}
						$("#page").html(str);
							 
					}else{
						$("#addr").html('');
						alert("관리자 문의");
					}
				}
			});
}*/

//지도(카카오api)	
//현재 주유소 정보 지도 start	
$(document).ready( function(){ 
	//alert("실행");
	
	var lat = document.getElementById("lat").value;
	//alert(lat);
	var lng = document.getElementById("lng").value;
	//var lng = 129.19361230; var lat =35.81250810;
	//alert(lng);
	
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(lat, lng),
		level: 3
	};

	var map = new kakao.maps.Map(container, options);
	var marker = new kakao.maps.Marker();

	// 타일 로드가 완료되면 지도 중심에 마커를 표시합니다
	kakao.maps.event.addListener(map, 'tilesloaded', displayMarker);
	
	function displayMarker() {
	    
	    // 마커의 위치를 지도중심으로 설정합니다 
	    marker.setPosition(map.getCenter()); 
	    marker.setMap(map); 
	
	    // 아래 코드는 최초 한번만 타일로드 이벤트가 발생했을 때 어떤 처리를 하고 
	    // 지도에 등록된 타일로드 이벤트를 제거하는 코드입니다 
	    // kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
	}
	//현재 주유소 정보 지도 end
	
	
	
	
	//근처 주유소 찾기 start
	$("#findnearbtn").click(function(){
		
		kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 5 // 지도의 확대 레벨 
		    }; 
		
		var map2 = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat2 = position.coords.latitude, // 위도
		            lon2 = position.coords.longitude; // 경도
					alert("lat2 : "+ lat2 + " lon2 : " + lon2);
		        var locPosition = new kakao.maps.LatLng(lat2, lon2), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		            message = '<div class="text-center" style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
					 $.ajax({
						
						url: "apicontroller.jsp" ,
						data:{ lat4 : lat2 , lon4 : lon2 } , 
						success : function(result){
							// controller에서 값이 넘어오면 values에 리스트를 저장 --> values는 리스트 값 each문은 반복
							if(result.code == "OK") { //controller에서 넘겨준 성공여부 코드
                    
			                    values = result.arrr ; //java에서 정의한 ArrayList명을 적어준다.
			                    //for(Array arrays: Arrays) 
			                    $.each(values, function( index, value ) { // 반복문 [주소, 실제 값]
			                       console.log( index + " : " + value.name ); //arr.java 의 변수명을 써주면 된다.
			                    });
			                    
			                    alert("성공");
			                }
							var positions = [result]
							
							for (var i = 0; i < positions.length; i ++) {
								
								var marker = new kakao.maps.Marker({
							        map: map, // 마커를 표시할 지도
							        position: positions[i].latlng, // 마커를 표시할 위치
							        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
							    });
							}
						}
					});
					
		        // 마커와 인포윈도우를 표시합니다
		        displayMarker(locPosition, message);
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = 'geolocation을 사용할수 없어요..'
		        
		    displayMarker(locPosition, message);
		}
		
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
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
	
	
	
	//현재 주유소 표시하기
	$("#currentbtn").click(function(){
		//alert("실행");
		kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		//var lng3 = 129.19361230; var lat3 =35.81250810;
		var lat3 = document.getElementById("lat").value;
		var lng3 = document.getElementById("lng").value;
		//alert(lng);
		var container2 = document.getElementById('map');
		var options2 = {
			center: new kakao.maps.LatLng(lat3, lng3),
			level: 3
		};
	
		var map3 = new kakao.maps.Map(container2, options2);
		var marker3 = new kakao.maps.Marker();
	
		// 타일 로드가 완료되면 지도 중심에 마커를 표시합니다
		kakao.maps.event.addListener(map3, 'tilesloaded', displayMarker2);
		
		function displayMarker2() {
		    
		    // 마커의 위치를 지도중심으로 설정합니다 
		    marker3.setPosition(map3.getCenter()); 
		    marker3.setMap(map3); 
		
		    // 아래 코드는 최초 한번만 타일로드 이벤트가 발생했을 때 어떤 처리를 하고 
		    // 지도에 등록된 타일로드 이벤트를 제거하는 코드입니다 
		    // kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		}
	});
});		

	
		