<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

	<form name="insertForm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<input type="hidden" name="codeType" value="${freeBoardDto.codeType }" />
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
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" onclick="modify()">
					<input type="button" value="삭제" id="deleteid" onclick="deletes()">
					<input type="button" value="취소" onclick="can()">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>
	
	<script type="text/javascript">
		
		$(function() {
			$("#codeType").val($('input[name=codeType]').val());
		});
	
		function modify() {
			let title = $('input[name=title]').val();
			let content = $("textarea[name=content]").val();
			let codeType = $('select[name=codeType] option:selected').val();
			let num = $('input[name=num]').val();
			if(confirm("글을 수정하시겠습니까? ")){
				if(title == "" || content == ""){
					alert("빈칸을 채워주세요.");
					false;
				}else{
					$.ajax({
						url : "./freeBoardModify.ino",
						type : "post",
						cache: false,
						data: {"num" : num, "name" : name, "title" : title, "codeType" : codeType, "content" : content},
						success: function(data){
							console.log(data);
							if(data.tf){
								if(!confirm("수정이 완료 되었습니다. 메인 페이지로 이동하려면 '확인'을 계속해서 수정을 하고싶다면 '취소'를 선택해 주세요")){
									alert("취소를 선택했습니다.");
								}else{
									alert("확인을 선택했습니다.");	
									location.href = "./main.ino";
								}
							}else{
								alert(JSON.stringify(data.msg));
							}
						},
				        error: function (request, status, error){        
				            console.log(error);
				        }
					})
				}
			}else{
				false;
			}
		}
		
		function deletes() {
			if(confirm("정말로 삭세하시겠습니까?")){
				$.ajax({
					url : "./freeBoardDelete.ino",
					type : "post",
					data : {"num" : $("input[name=num]").val()},
					success : function (data) {
						if(data.tf){
							alert("정상적으로 삭제되었습니다.");
							location.href = "./main.ino";
						}else{
							alert(JSON.stringify(data.msg));
						}
					},
			        error: function (request, status, error){        
			            console.log(error);
			        }
				})
			}else{
				alert("취소를 선택했습니다.");
			}
		}
		
		function can() {
			if(confirm("확인을 클릭하면 글이 수정되지 않고 메인으로 돌아갑니다.")){
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