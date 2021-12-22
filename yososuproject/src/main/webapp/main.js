
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
	var lat = document.getElementById("lat").value;
	//alert(lat);
	var lng = document.getElementById("lng").value;
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
});		

	
		