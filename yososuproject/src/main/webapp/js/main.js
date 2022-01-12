
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
					//현재 위치 테스트
					//alert("lat2 : "+ lat2 + " lon2 : " + lon2);
					
		        var locPosition = new kakao.maps.LatLng(lat2, lon2), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		        message = '<div class="text-center" style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
				arr = [];
				arr2 = [];
					 $.ajax({
						
						url: "locationController.jsp" ,
						data:{ lat4 : lat2 , lon4 : lon2 } , 
						success : function(result){
							arr = result.split(",");  //0~8 
							for(i=0; i<arr.length; i++){
								arr2[i] = arr[i].split("_");
								//alert(arr2[i]);
							}
							
							for(j=0; j<arr2.length; j++){
								/*alert(arr2[j][0]) // 경도
								alert(arr2[j][1]) // 위도
								alert(arr2[j][2]) // 이름 */
								//alert(arr2[j].length)
								//alert(arr2[j][0]+" "+ arr2[j][1]);
								if(j==0){
									//[가 붙은 인덱스의 위치 찾기
									var hi =arr2[j][0].indexOf("["); 
									//20이 나옴
									//alert(arr2[j][0].split("[")[1]);
									//첫번째 주유소를 찾기 위해서 첫번재 좌표에서 "["을 기준으로 1번째 인덱스 가져오기
									arr2[j][0]=arr2[j][0].split("[")[1];
									//첫번째 주유소의 좌표의 경도가 나온다.
									alert(arr2[j][0]);
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
				 
				map2.setCenter(locPosition2); 
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
		    });
		    
		    // 인포윈도우를 마커위에 표시합니다 
		    infowindow.open(map2, marker2);
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map2.setCenter(locPosition);  
		} //근처 주유소 찾기 end(그러나 현재 내 위치만 나옴)  
	});
	//근처 주유소 찾기 end
	
	
	
//a태그 누르면 해당 주유소 표시하기
function detailmap(laat, lnng){
	alert("실행");
	//var lng3 = 129.19361230; var lat3 =35.81250810;
	var lat3 = laat;
	var lng3 = lnng;
	alert(lat3);
	alert(lng3);
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

	//alert(map3);
	// 타일 로드가 완료되면 지도 중심에 마커를 표시합니다
	kakao.maps.event.addListener(map3, 'tilesloaded', displayMarker2);
	
	function displayMarker2() {
	   // alert("displayMarker2");
	    // 마커의 위치를 지도중심으로 설정합니다 
	    //marker3.setPosition(map3.getCenter()); 
	    marker3.setMap(map3); 

	}
}



		