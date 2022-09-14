<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	
	<div>
		<select id="selectbox" name="selectbox">
			<option value="0">전체</option>
			<option value="1">글타입</option> <!-- selectbox -->
			<option value="2">글번호</option> <!-- input type text 검색버튼 클릭시 숫자인지 체크할것. -->
			<option value="3">글내용</option> <!-- input type text -->
			<option value="4">글쓴이</option> <!-- input type text -->
			<option value="5">글제목</option> <!-- input type text -->
			<option value="6">기간</option> <!-- input type text input type text 검색버튼 클릭시 숫자인지 체크할것. 자릿수 체크 20220905 8자리 -->
		</select>
		<button type="button" onclick="search()">검색</button>
	</div>
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino" onclick = "return confirm('글쓰기로 이동하시겠습니까?')">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td> <input type="checkbox" name="chall" id="chall">  </td>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<table border="1" id="lsitTable">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
					<input type="hidden" name="lists" id="lists" value="${dto}">
						<tr>
							<td> <input type="checkbox" name="ch" id="ch" value="${dto.num}" >  </td>
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
	</div>
	<input style = "margin-left: 580px; margin-top: 10px;" type="button" value="삭제" id="deleteid" onclick="deletes()" >
	
	<script type="text/javascript">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		$("#selectbox").click(function() { // 셀렉트 클릭 이벤트
			
			var remover =  $("#textBar").remove(); // remove 사용하여 없엠
				remover += $("#between").remove();
				remover += $("#between2").remove();
				remover += $("#types").remove();
			
			var result = $('#selectbox option:selected').val(); // 셀렉트 value 값 가져옴
			
			if(result == 0){ // 0번일시 
				remover; // 리셋
			}else if(result == 1){ // 1번일시
		    	remover; // 리셋 후
		    	$("#selectbox").after( // after 사용하여 1번 클릭시 type출력
		    	 	"<select name='types' id='types'>" +
		    		"<option value = '01'> 자유 </option>" +
		    		"<option value = '02'> 익명 </option>" +
		    		"<option value = '03'> QnA </option>" +
		    		"</select>"
		    	)
		    	/* $("#selectbox").unbind( "click" ); */
		    }else if(result > 1 && result < 6){ // 1보다 크거나 6보다 작으면
				if(!document.getElementById('textBar')){ // remover가 아니라면
					remover; // remover해준뒤 input박스 출력
					$("#selectbox").after('<input type="text" name="textBar" id="textBar" />');
				}
			}else if(result == 6 && !document.getElementById('between')){ // result가 6과 같고 remover가 아니라면
		   		remover; // 리셋 후 after 후 출력
				$("#selectbox").after('<input type="text" name="between" id="between" />  <input type="text" name="between2" id="between2" />');
			};
		});
		
		function search() {
			var result = $('#selectbox option:selected').val(); // 셀렉트 value 값 가져옴
			
			if(result == 2){
				var check = /^[0-9]*$/; // 정규식 사용 0~9 사용 가능
				if(!check.test($("#textBar").val())){ // test사용하여 검사
					alert("숫자만 검색이 가능합니다");
					false;
				}else{
					true
				}
			}else if(result == 6){
				var check = /^[0-9]{8}$/; // 정규식 사용하여 0~9의 숫자 중 8자리 숫자만 사용 가능
				if(!check.test($("#between").val() || !check.test($("#between2").val()))){ // test사용하여 검사
					alert("8자리의 숫자만 검색이 가능합니다.");
					false;
				}else{
					true
				}
			}
			
			if(true){
				$.ajax({
					url:'./search.ino',
					type: 'POST',
					contentType: 'application/json',
					data:JSON.stringify ({ // JSON.stringify : 자바스크립트의 값을 json문자열로 변환
						"selectbox" : $("#selectbox").val(),
						"types" : $("#types").val(),
						"textBar" : $("#textBar").val(),
						"between" : $("#between").val(),
						"between2" : $("#between2").val()
					}),
					success : function(data) {
						console.log(data);
						$("#tb").remove(); // tb이름값을 가진 테이블을 삭제
						$("#lsitTable").prepend("<tbody id='tb'></tbody>"); // prepend를 사용하여 lsitTable 이름을 가진 테이블 앞에 tbody를 삽입
						
						var html =""; // 초기값
						
						for(var i=0;i<data.searchdata.length;i++){ // data의 길이를 구해서 for문 사용
							html += "<tr>";
							
							html +="	<td><input type='checkbox' name='check_board' id='check_board' value="+data.searchdata[i].num +"></td>";
							html +="	<td style='width: 55px; padding-left: 30px;' align='center'>" +data.searchdata[i].codeType +"</td>";
							html +=" 	<td style='width: 55px; padding-left: 30px;' align='center'>"+ data.searchdata[i].num +"</td>";
							html +=" 	<td style='width: 125px;  align='center'>";
							html +="	<a href='./freeBoardDetail.ino?num="+	data.searchdata[i].num +"'>";
							html +=		data.searchdata[i].title;
							html += "	</a></td> ";
							html +="	<td style='width: 48px; padding-left: 50px;' align='center'>"+data.searchdata[i].name+ "</td> ";
							html +="	<td style='width: 100px; padding-left: 95px;' align='center'>"+ data.searchdata[i].regdate +"</td>";
							
							html +="</tr>";
						};
						$("#tb").prepend(html); // 결과 출력
					}
				})
			}
		}
		
		
		$(function() {
			var chObj = $("input[name=ch]"); // name값 변수에 저장
			var chCnt = chObj.length; // chObj의 길이를 chCnt담음
			console.log(chObj);
			console.log(chCnt);
			$("input[name=chall]").click(function() { // 모두선택을 클릭할 경우
				var ch_all = $("input[name='ch']"); // 개별 선택의 name을 변수에 담음
				for(var i=0; i<ch_all.length; i++){ // 개별 선택의 최대 길이를 for문으로 돌림
					ch_all[i].checked = this.checked; // 매개 변수와 객체 사진이 가지고 있는 변수의 이름이 같은 경우 이를 구분하기 위해 this를 붙힌다.
				}
			})
			$("input[name='ch']").click(function() { // 개별 선택을 했을 때 실행되는 펑션
				if($("input[name='ch']:checked").length == chCnt){ // 개별선택의 길이와 총 모두 선택의 길이가 같다면					
					$("input[name='chall']")[0].checked = true; // 모두선택 true
				}else{
					$("input[name='chall']")[0].checked = false; // 모두선택 false
				}
			})
		})
		
		function deletes() {
			var url = "./freeBoardDeletes.ino";
			var valueArray = new Array();
			var list = $("input[name='ch']");
			for(var i=0; i<list.length; i++){ // 선택되어 있으면 배열에 값을 저장
				if(list[i].checked == true){ // 선택되어있으면 배열에 저장함
					valueArray.push(list[i].value); // list를 valueArray에 push
				}
			}
			if(valueArray.length == 0){ // 선택된 박스가 없으면
				alert("선택된 글이 없습니다.");
			}else{
				var chk = confirm("정말 삭제하시겠습까?");
				$.ajax({
					url : url,
					type : 'POST',
					traditional : true,// traditional : traditional에 true를 주변 배열의 값을 자바에 넘겨줄 수 있다.
					data : {valueArray : valueArray}, // freeBoardDeletes에 보낼 데이터
					success : function(data) {
						console.log(data);
						if(data.tf){
							alert("선택 글이 삭제되었습니다.");
							location.href = "./main.ino";
						}else{
							alert(JSON.stringify(data.msg));
						} 
					},
			        error: function (request, status, error){        
			            console.log(error);
			        }
				})
			}
		}
	</script>
</body>
</html>