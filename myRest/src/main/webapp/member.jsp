<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.net.*, java.time.*, java.time.format.DateTimeFormatter , myRest.SQLConnection"
%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql = "";
	int rows = 0;
%>

<jsp:useBean id="mem" class="myRest.MemberDTO" />
<jsp:setProperty name="mem" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//아이피 주소 받기
		try{
			local = InetAddress.getLocalHost();
		}catch (UnknownHostException e){
			
		}
	
		if(local != null){
			ip = local.getHostAddress();
		}
		//out.println(ip);
		
		//현재 날짜 받기 LocalDateTime 을 이용해 년월일시분초를 받은후 datetimeformatter를 이용해 yyyy-mm-dd hh:mm:ss 형식으로 출력
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyy-MM-dd HH:mm:ss");
		String writeday = now.format(formatter);
		
		//out.print(Writeday);
		
		//배열로 받은 값을 하나로 합침
		String[] hobby = mem.getHobby();
		out.print(mem.getHobby());
		String strHobby = "";
		for(String h : hobby){
			strHobby += h + " ";
		}
		sql = "insert into members (";
		sql += " username, userid, userpass, gender, postcode, address, detailAddress, job, hobby, leftright, writeday, writeip";
		sql += ") values (?,?,?,?,?,?,?,?,?,?,?,?)";
		
		//접속
		conn = SQLConnection.initConnection();
		
		try{
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mem.getUsername());
			pstmt.setString(2, mem.getUserid());
			pstmt.setString(3, mem.getUserpass());
			pstmt.setString(4, mem.getGender());
			pstmt.setInt(5, mem.getPostcode());
			pstmt.setString(6, mem.getAddress());
			pstmt.setString(7, mem.getDetailAddress());
			pstmt.setString(8, mem.getJob());
			pstmt.setString(9, strHobby);
			pstmt.setString(10, mem.getLeftright());
			pstmt.setString(11, writeday);
			pstmt.setString(12, ip);
			
						
			System.out.println(pstmt);
			rows = pstmt.executeUpdate();
			
			if(rows > 0 ){
				out.print("정보를 입력 했습니다.");
				
				
			}
			pstmt.close();
			
			
		}catch(SQLException e){
			
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(SQLException e){
					
				}
			}
		}
	%>
</body>
</html>