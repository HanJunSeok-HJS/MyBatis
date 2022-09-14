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
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form action="./freeBoardInsertPro.ino" id="frm" name="frm" method="post">
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
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="�۾���" onclick="writes()">
					<input type="button" value="�ٽþ���" onclick="resets()">
					<input type="button" value="���" onclick="can()">
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
			if(confirm("���� �ۼ��Ͻðڽ��ϱ�? ")){
				if(name == "" || title == "" || content == ""){
					alert("��ĭ�� ä���ּ���");
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
				        		if(confirm("���� �������� �̵��ϰ� �ʹٸ� 'Ȯ��'�� �ۼ� �������� �̵��ϰ� �ʹٸ� '���'�� Ŭ���� �ּ���.")){
				        			alert("Ȯ���� Ŭ���Ͽ����ϴ�.");
				        			location.href = "./main.ino";
				        		}else{
				        			alert("��Ҹ� Ŭ���Ͽ����ϴ�.");
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
			if(confirm("�ٽþ��⸦ Ŭ���ϸ� ��� ������ ������ϴ�. �׷��� �ٽþ��ðڽ��ϱ�?")){
				if(true){
					alert("Ȯ���� Ŭ���Ͽ����ϴ�.");
					$('input[name=name]').val("");
					$('input[name=title]').val("");
					$('textarea[name=content]').val("");
					$("#codeType option:eq(0)").prop("selected", true);
				}else{
					alert("����� Ŭ���Ͽ����ϴ�.");
				}
			}
		}
		function can() {
			if(confirm("Ȯ���� Ŭ���ϸ� �ۼ��� ������ ������� �������� ���ư��ϴ�.")){
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