<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*,  myRest.SQLConnection, java.net.*"
%>
<jsp:useBean id="rv" class="myRest.ReviewDTO" />
<jsp:setProperty name="rv" property="*" />
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql ="";
%>
<%
	//IP주소
	try{
		local = InetAddress.getLocalHost();
	}catch(Exception e) {}
	if(local !=null ) ip=local.getHostAddress();
	
	sql = "insert into review (rnum, unum, star, content, writeip) values (?, ?, ?, ?, ?)";
	conn = SQLConnection.initConnection();
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt (1, rv.getRnum()); 
		pstmt.setInt (2, rv.getUnum()); 
		pstmt.setInt (3, rv.getStar ()); 
		pstmt.setString(4, rv.getContent());
		pstmt.setString(5, ip);
		
		System.out.println(pstmt);
		
		int rows = pstmt.executeUpdate () ;
		if(rows > 0) {
			out.print(1);
		}else {
			out.print(0);
		}
	}catch(SQLException e){
		
	}finally{
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) {}
		if(pstmt != null) try{ conn.close(); }catch(SQLException e) {}
	}
%>
