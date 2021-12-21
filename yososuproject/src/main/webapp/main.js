/**
 * 
 */

function search(){
	alert("펑션작동");
	var keyword = document.getElementById("keyword").value;
	alert(keyword);
	
	$.ajax({ //페이지 전환이 없음 [ 해당 페이지와 통신 ]
				url : "searchcontroller.jsp",
				data : {keyword : keyword},
				success : function(result){
					if(result){
						
						var str =''
						for(var i=0; i<result.length; i++){
							str += '<span>' + result[i].data + '</span><br/>';
						}
						$("#addr").html(str);
							 
					}else{
						$("#addr").html('');
						alert("관리자 문의");
					}
				}
			});
			
			
}