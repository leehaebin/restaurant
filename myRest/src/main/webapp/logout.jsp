<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	response.setHeader("Cache-Control", "no-cache, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	session.removeAttribute("UID");
	session.removeAttribute("UNUM");
	session.invalidate();
	out.print("<script>alert('로그아웃되었습니다.');location.href='index.jsp';</script>");
	
	
	/*  //세션삭제확인
	if(session == null || !request.isRequestedSessionIdValid()){
		System.out.println("세션을 삭제했습니다."+request.isRequestedSessionIdValid());
	}
	*/
%>
