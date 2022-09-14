<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form action="./freeBoardInsertPro.ino" id="frm" name="frm" method="post">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType" id="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" onclick="writes()">
					<input type="button" value="다시쓰기" onclick="resets()">
					<input type="button" value="취소" onclick="can()">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>
	</form>

	<script type="text/javascript">
		function writes() {
			let name = $('input[name=name]').val();
			let title = $('input[name=title]').val();
			let content = $('textarea[name=content]').val();
			let codeType = $('select[name=codeType].option:selected').val(); 
			var formData = $('#frm').serialize();
			formData = decodeURIComponent(formData);
			console.log(formData);
			if(confirm("글을 작성하시겠습니까? ")){
				if(name == "" || title == "" || content == ""){
					alert("빈칸을 채워주세요");
					false;
				}else{
					$.ajax({
						url : "./freeBoardInsertPro.ino",
						type : "post",
						cache: false,
				        data: formData,
				        success: function(data){
				        	console.log(data);
				        	if(data.tf){
				        		if(confirm("메인 페이지로 이동하고 싶다면 '확인'을 작성 페이지로 이동하고 싶다면 '취소'를 클릭해 주세요.")){
				        			alert("확인을 클릭하였습니다.");
				        			location.href = "./main.ino";
				        		}else{
				        			alert("취소를 클릭하였습니다.");
				        			location.href = "./freeBoardDetail.ino?num="+data.num;
				        		}
				        	}else{
				        		alert(JSON.stringify(data.msg));
				        	}
				        },
					 	error : function(request, status, error) {
			                console.log(error);
			            }
					})
				}
			}else{
				false;
			}
		}
		function resets() {
			if(confirm("다시쓰기를 클릭하면 모든 내용이 사라집니다. 그래도 다시쓰시겠습니까?")){
				if(true){
					alert("확인을 클릭하였습니다.");
					$('input[name=name]').val("");
					$('input[name=title]').val("");
					$('textarea[name=content]').val("");
					$("#codeType option:eq(0)").prop("selected", true);
				}else{
					alert("취소을 클릭하였습니다.");
				}
			}
		}
		function can() {
			if(confirm("확인을 클릭하면 작성된 내용은 사라지고 메인으로 돌아갑니다.")){
				if(true){
					alert("확인을 클릭하였습니다. 메인 화면으로 돌아갑니다.");
					location.href = "./main.ino";
				}else{
					alert("취소를 클릭하였습니다.");
					false;
				}
			}
		}
	</script>


</body>
</html>