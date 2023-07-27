<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection, java.net.*" %>
<%!
    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet row = null;
    String sql = "", sql2 = "", sql3 = "";
    int pg = 1, allColumn = 0, totalPages = 0;
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
    
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=45b3f6e161e83dd352abace1525573e5"></script>
    <script src="js/jquery-1.12.4.min.js"></script>
    <script src="js/jquery.mobile-1.3.2.min.js"></script>
    <script src="js/custom.js"></script>
</head>
<body>

<%
    String tempPage = request.getParameter("cpage");
    
    //현재 페이지
    if(tempPage == null || tempPage.length() == 0) {
       pg = 1;
    }
    try{
       pg = Integer.parseInt(tempPage);
    }catch(NumberFormatException e){
       pg = 1;
    }
      
    conn = SQLConnection.initConnection();
    String param = URLDecoder.decode(request.getParameter("sectordetail"));
    String param2 = URLDecoder.decode(request.getParameter("city"));
    sql =  "select count(*) from best_restaurant where sectordetail = ? and sigundu = ?";
    sql2 = "select * from best_restaurant where sectordetail = ? and sigundu = ? order by num desc limit ?, 10";
    try{     
       pstmt = conn.prepareStatement(sql);
       pstmt.setString(1, param);
       pstmt.setString(2, param2);     
       row = pstmt.executeQuery();
       if(row.next()){
          allColumn = row.getInt(1);
       }
       pstmt.clearParameters();
        row.close();
       
        int lmt = (pg-1)*10;
        totalPages = allColumn % 10 == 0 ? (int) allColumn / 10 : (int) (allColumn / 10) + 1;
        
       pstmt = conn.prepareStatement(sql2);
       pstmt.setString(1, param);
       pstmt.setString(2, param2);
       pstmt.setInt(3, lmt);
       //System.out.println(pstmt);
       
       rs = pstmt.executeQuery();
       //System.out.println(pstmt);
 %>
     <div id="list02" data-role="page" data-theme="c">
     <%@ include file="include/header.jsp" %>
        <div data-role="content">
           <div id="brand">
              <h1><span>맛집</span> <span>검색</span></h1>
              <h3>종류: <%=param %>, 지역: <%=param2 %> [<%=allColumn %>개의 상점/<%=totalPages%> page]</h3>
           </div>
           <div class="choice_list">
               <h2><span class="number">
                  <i class="ri-number-3"></i></span>음식점을 선택하세요.</h2>
               <!-- listview -->
               <ul id="restaurant_v" data-role="listview" data-inset="true">
 
 <%       
       while(rs.next()) {
        String city = rs.getString("sigundu");
        String enCity = URLEncoder.encode(city);
        
        //별표
        sql3 = "select avg(star) from review where rnum = ? ";
        pstmt2 = conn.prepareStatement(sql3);
        pstmt2.setInt(1, rs.getInt("num"));
        rs2 = pstmt2.executeQuery();
        
        String[] tstar = {"ri-star-fill", "ri-star-half-line", "ri-star-line"};
        double star=0.0, starD=0.0;
        int starInt=0;
        String stars;
        if(rs2.next()){
        	star = rs2.getFloat("avg(star)");
        	starInt = (int) star;
        	starD = star - (int) star;
        }
        if(starD > 0 && starD < 0.4){
        	stars = tstar[2];
        }else if (0.4 <= starD && starD <0.6){
        	stars = tstar[1];
        }else{
        	stars = tstar[0];
        }
        
%>
<!-- <%=star %> -->
        <input type="hidden" class="lat" name="lat" value="<%=rs.getFloat("lat")%>">
        <input type="hidden" class="lon" name="lon" value="<%=rs.getFloat("lon")%>">
                  <li>
                     <a href="detail.jsp?num=<%=rs.getInt("num")%>" data-transition="slidedown">
                       <div class="roadView"></div>
                       <div class="context-box">
                           <h3><%=rs.getString("title") %></h3>
                           <p>
                           <%
                           if(starInt ==0) {
                        	   out.print("<i>리뷰가 없습니다.</i>");
                           }else{
                           		for(int i = 0; i<starInt; i++){
                           			if((starInt - 1) == i){
                           				out.print("<i class=\""+stars+"\"></i>");
                           			}else{
                           				out.print("<i class=\"ri-star-fill\"></i>");
                           			}
                           		}
                           	}
                           %>
                           <!-- 
                              <i class="ri-star-fill"></i>
                              <i class="ri-star-fill"></i>
                              <i class="ri-star-fill"></i>
                              <i class="ri-star-half-line"></i>
                              <i class="ri-star-line"></i>
                            -->
                           </p>
                       </div>
                     </a>
                  </li>
<%
       } 
    }catch(Exception e){
       e.printStackTrace();
    }finally{
      if(rs != null) try{ rs.close(); } catch(SQLException e){}
      if(pstmt != null) try{ pstmt.close(); } catch(SQLException e){}
      if(conn != null) try{ conn.close(); } catch(SQLException e){}
    }    

%>
              </ul>
              
              <div class="text-right">
                <% if(pg > 1){ %>
                   <a href="?sectordetail=<%=param %>&city=<%=param2 %>&cpage=<%=pg-1 %>" data-role="button"  data-icon="arrow-l" data-inline="true">이전</a>
                <% } %> 
                <% if(pg < totalPages) { %>                 
                   <a href="?sectordetail=<%=param %>&city=<%=param2 %>&cpage=<%=pg+1 %>" data-role="button"  data-icon="arrow-r" data-inline="true">다음</a>
                <% } %>
              </div>
              
              
           </div>
        </div>
  
<%@ include file="include/footer.jsp" %>
 </div>