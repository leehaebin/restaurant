<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import= "java.sql.*, myRest.SQLConnection, java.net.*" %>
<%!
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = "";
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>맛집검색</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Tilt+Prism&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery.mobile-1.3.2.min.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="js/jquery-1.12.4.min.js"></script>
    <script src="js/jquery.mobile-1.3.2.min.js"></script>
    <script src="js/members.js"></script>
    <script src="js/script.js"></script>
    

</head>
<body>
	<div id="main" data-role="page" data-theme="c">
	<%@ include file="include/header.jsp" %>
	
	<!-- pop -->
	<div id="popupPostcode" style="display:none;position:fixed;overflow:hidden;z-index:100;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
	<!-- /pop -->
	
	
	
        <div data-role="content">
            <div id="brand">
                <h1><span>맛집</span> <span>검색</span></h1>
            </div>
            
            <h1>회원가입</h1>
			<p>아래 내용을 충실히 기입해 주시면 기분 좋으면 회원으로 가입시켜 드립니다.</p>
            
            <form name="memberform" id="memberform" action="member.jsp" method="post" onSubmit="return checkForm();">
		
		<ul data-role="listview" data-inset="true">
			<li data-role="fieldcontain">
				<label for="username">이름</label>
				<input type="text" name="username" id="username" data-clear-btn="true"/>
			</li>
			<li data-role="fieldcontain">
				<label for="userid">아이디</label>
				<input type="text" name="userid" id="userid" data-clear-btn="true" />
				<p id="idtext"></p>
				<input type="hidden" name="idok" id="idok" />
			</li>
			<li data-role="fieldcontain">
				<label for="userpass">비밀번호</label>
				<input type="password" name="userpass" id="userpass" data-clear-btn="true" />
			</li>
			<li data-role="fieldcontain">
				<label for="gender">성별</label>
				<select name="gender" id="gender" data-role="slider">
					<option value="남자" selected>남자</option>
					<option value="여자">여자</option>
				</select>
			</li>
			
			<li data-role="fieldcontain">
			  <label for="postcode" class="pcode">우편번호</label>
              <input type="search" name="postcode" id="postcode" placeholder="우편번호찾기" />
              
          </li> 
          <li class="addressbox">
              <input type="text" name="address" id="address" readonly placeholder="주소" /><br>
              <input type="text" name="detailAddress"  id="detailAddress" placeholder="상세주소" />
          </li>
          
			<li data-role="fieldcontain">
				<label for="job">직업</label>
				<select name="job" id="job">
					<option value="">직업을 선택하세요</option>
					<option value="프론트엔드 프로그래머">프론트엔드 프로그래머</option>
					<option value="백엔드 프로그래머">백엔드 프로그래머</option>
					<option value="풀스택 프로그래머">풀스택 프로그래머</option>
					<option value="UI 디자이너">UI 디자이너</option>
					<option value="입만 프로그래머">입만 프로그래머</option>
				</select>
			</li>
			<li data-role="fieldcontain">
				<fieldset data-role="controlgroup" id="hobby">
				<legend>취미</legend>
				<input type="checkbox" name="hobby" id="hobby1" value="운동"/>
				<label for="hobby1"> 운동</label>
				<input type="checkbox" name="hobby" id="hobby2" value="여행"/>
				<label for="hobby2"> 여행</label>
				<input type="checkbox" name="hobby" id="hobby3" value="독서"/>
				<label for="hobby3"> 독서</label>
				<input type="checkbox" name="hobby" id="hobby4" value="음악감상"/>
				<label for="hobby4"> 음악감상</label>
				<input type="checkbox" name="hobby" id="hobby5" value="쇼핑"/>
				<label for="hobby5"> 쇼핑</label>
				</fieldset>
			</li>
				<li data-role="fieldcontain">
					<label for="leftright">좌우명</label>
					<input type="text" name="leftright" id="leftright"/>
				</li>
			</ul>
	 		<div class="btnbox">
	 			<button type="submit" class="submit"> 전 송 </button>
			</div>
		</form>

		</div>
		<!-- page -->
		
<%@ include file="include/footer.jsp" %>  



  
</div>




