//1. 글쓰기
function boardwrite() {
	alert("알림");
    var b_title = document.getElementById("b_title").value;
    var b_contents = document.getElementById("b_contents").value;
    var b_writer = document.getElementById("b_writer").value;
    var b_password = document.getElementById("b_password").value;
	//alert(b_title);
	//alert(b_contents);
	//alert(b_writer);
	//alert(b_password);
    $.ajax({
        url: "../controller/boardwritecontroller.jsp",
        data: {
            b_title: b_title,
            b_contents: b_contents,
            b_writer: b_writer,
            b_password: b_password
        },
        success: function (result) {
            if (result == 1) {
                location.href = "Main.jsp?#boardlist";
            }else{
				alert("오류발생! 다시 입력해주세요.");
			}
        }
    });
}

//2. 글 수정
function boardupdate(b_no, b_writer, b_createdDate, b_count, b_contents, b_title, b_password ) {
	alert("알림");
	alert(b_no+" "+b_writer+" "+ b_createdDate+" "+ b_count +" "+b_contents + " " + b_title+ " "+b_password);
}

//3. 글 삭제