<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
form{
  padding:30px;
  text-align:center;
}
</style>
</head>
<body>
<%
   boolean ok = false;
   String uid = request.getParameter("uid");
   
   if(uid == "") {
%>
   <script>
     alert("아이디를 입력하지 않으셨습니다. 이러깁니까?");
     self.close();
   </script>
<%      
     return;
   }
   
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
  <form>
     <p><%=uid %>는 사용할 수 없습니다.<br> 다시 검색 하세요.</p>
     <input type="text" name="uid" placeholder="아이디입력">
     <button type="submit"> 검색 </button>
  </form>
<%
   }else{

%>
  <p style="text-align:center">
     <a href="javascript:void(0)" onclick="ok();"><%=uid %>는 사용할 수 있습니다.</a>
  </p>
<%
   }
%>
<script>
   function ok() {
      opener.document.memberform.userid.value="<%=uid%>";
      opener.document.memberform.idok.value="ok";
      self.close();
   }
</script>

</body>
</html>