
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
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
				//현재 위치
		        var lat2 = position.coords.latitude, // 위도
		            lon2 = position.coords.longitude; // 경도
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(lat2, lon2), // 지도의 중심좌표
		        level: 5 // 지도의 확대 레벨 
		    }; 
		        
					//현재 위치 테스트
					alert("lat2 : "+ lat2 + " lon2 : " + lon2);
					
				arr = [];
				arr2 = [];
					 $.ajax({
						
						url: "apicontroller.jsp" ,
						data:{ lat4 : lat2 , lon4 : lon2 } , 
						success : function(result){
							arr = result.split(",");  //0~8 
							for(i=0; i<arr.length; i++){
								arr2[i] = arr[i].split("_");
							}
							for(j=0; j<arr2.length; j++){
								/*alert(arr2[j][0]) // 경도
								alert(arr2[j][1]) // 위도
								alert(arr2[j][2]) // 이름 */
								message = '<div class="text-center" style="padding:5px;">'+arr2[j][2]+'<br>'+arr2[j][3]+'<br>'+arr2[j][5]+'</div>';
								var marker = new kakao.maps.Marker({
								    map: map, 
								    position: new kakao.maps.LatLng(arr2[j][0], arr2[j][1])
								});
								
							}
							
							
						}
					});
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
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
	function currentbtn(lat, lng){
		//alert("실행");
		kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		//var lng3 = 129.19361230; var lat3 =35.81250810;
		var lat = document.getElementById("lat").value;
		var lng = document.getElementById("lng").value;
		alert(lng);
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
		    marker3.setPosition(map.getCenter()); 
		    marker3.setMap(map); 
		
		    // 아래 코드는 최초 한번만 타일로드 이벤트가 발생했을 때 어떤 처리를 하고 
		    // 지도에 등록된 타일로드 이벤트를 제거하는 코드입니다 
		    // kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		}
		}
});		


	
		