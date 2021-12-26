
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
$(document).ready( function(){ 
	//alert("실행");
	
	//var lat = document.getElementById("lat").value;
	//alert(lat);
	//var lng = document.getElementById("lng").value;
	var lng = 129.19361230; var lat =35.81250810;
	//alert(lng);
	//총 요소수 주유소 개수
	var totalcount2 = document.getElementById('totalcount2').value+0;
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
	//근처 주유소 찾기
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
		        var locPosition = new kakao.maps.LatLng(lat2, lon2), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		            message = '<div class="text-center" style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
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
		
		/*//경도 위도 +0.1 -0.1 만큼 범위의 주유소 찾기
			var c_lat = lat2+0.1; // 현재 위도 + 0.1
			var c_lng = lon2+0.1; // 현재 경도 + 0.1
			var c_lat2 = lat2-0.1; // 현재 위도 - 0.1
			var c_lng2 = lon2-0.1; // 현재 경도 - 0.1
        
        	//요소수 주유소의 개수 만큼 for 문 돌려서
        	for(i =0; i<totalcount2; i++){
				//현재위도와 경도가 각각 +0.1, -0.1한 거보다 크거나 작다면
				if(lat>c_lat && lng>c_lng || lat<c_lat2 && lng<c_lng2){
					//안의 내용 버리기
					flush();
				}else{//아니라면
					// 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다 
					var points = [
					    new kakao.maps.LatLng(33.452278, 126.567803),
					    new kakao.maps.LatLng(33.452671, 126.574792),
					    new kakao.maps.LatLng(33.451744, 126.572441)
					];
					
					// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
					var bounds = new kakao.maps.LatLngBounds();    
					
					var j, marker;
					for (j = 0; j < points.length; j++) {
					    // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
					    marker =     new kakao.maps.Marker({ position : points[j] });
					    marker.setMap(map);
					    
					    // LatLngBounds 객체에 좌표를 추가합니다
					    bounds.extend(points[j]);
					}
					
					function setBounds() {
					    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
					    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
					    map.setBounds(bounds);
					}
				}
			}*/
		
		//d = acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon1-lon2))
	
	});
	
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

	
		