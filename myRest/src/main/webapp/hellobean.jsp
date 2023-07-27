<%@page import="myRest.HelloBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:useBean id="hello" class="myRest.HelloBean" scope="page" />
 <jsp:useBean id="time" class="java.util.Date" scope="page" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%=hello.getName() %>
	<hr />
	지금 시간은 <%=time.toLocaleString() %>

</body>
</html>