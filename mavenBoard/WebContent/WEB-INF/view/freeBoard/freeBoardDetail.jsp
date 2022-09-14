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
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<input type="hidden" name="codeType" value="${freeBoardDto.codeType }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType" id="codeType">
							<option value="01">����</option>
							<option value="02">�͸�</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="����" onclick="modify()">
					<input type="button" value="����" id="deleteid" onclick="deletes()">
					<input type="button" value="���" onclick="can()">
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
			if(confirm("���� �����Ͻðڽ��ϱ�? ")){
				if(title == "" || content == ""){
					alert("��ĭ�� ä���ּ���.");
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
								if(!confirm("������ �Ϸ� �Ǿ����ϴ�. ���� �������� �̵��Ϸ��� 'Ȯ��'�� ����ؼ� ������ �ϰ�ʹٸ� '���'�� ������ �ּ���")){
									alert("��Ҹ� �����߽��ϴ�.");
								}else{
									alert("Ȯ���� �����߽��ϴ�.");	
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
			if(confirm("������ �輼�Ͻðڽ��ϱ�?")){
				$.ajax({
					url : "./freeBoardDelete.ino",
					type : "post",
					data : {"num" : $("input[name=num]").val()},
					success : function (data) {
						if(data.tf){
							alert("���������� �����Ǿ����ϴ�.");
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
				alert("��Ҹ� �����߽��ϴ�.");
			}
		}
		
		function can() {
			if(confirm("Ȯ���� Ŭ���ϸ� ���� �������� �ʰ� �������� ���ư��ϴ�.")){
				if(true){
					alert("Ȯ���� Ŭ���Ͽ����ϴ�. ���� ȭ������ ���ư��ϴ�.");
					location.href = "./main.ino";
				}else{
					alert("��Ҹ� Ŭ���Ͽ����ϴ�.");
					false;
				}
			}
		}
		
	</script>


</body>
</html>