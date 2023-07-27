<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection" %>


<%
   boolean ok = false;
   String uid = request.getParameter("userid");
  
  //접속
   Connection conn = SQLConnection.initConnection();
   String sql = "select userid from members where userid = ?";
   
   try{
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, uid);

      ResultSet rs = pstmt.executeQuery();
      if(rs.next()){
         ok = true;
      }
      
   }catch(Exception e){
      
   }finally{
      if(conn != null) {
      try{
         conn.close();
      }catch(SQLException e){
         
      }
   }
 }
   if(ok) { 
%>
	0
<% 
   }else{
%>
	1
<%
   }
%>