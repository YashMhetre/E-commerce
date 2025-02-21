<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calculate Total</title>
</head>
<body>

<%
    String username = request.getParameter("username"); // Get the username parameter

    int totalPrice = 0;

    if (username != null && !username.isEmpty()) {  // Ensure username is not null or empty
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String dbURL = "jdbc:sqlserver://DESKTOP-9V6RT8O;encrypt=false;databaseName=Study;integratedSecurity=true";
            Connection conn = DriverManager.getConnection(dbURL);

            String sql = "SELECT SUM(Ptotalprice) FROM Chorders WHERE username = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                totalPrice = rs.getInt(1);
            }

            session.setAttribute("totalPrice", totalPrice); // Store the total price in session

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("Products.jsp"); // If no username, redirect to Products page
    }

    // Redirect back to MyCart.jsp with the username parameter
    response.sendRedirect("MyCart.jsp?username=" + username); 
%>

</body>
</html>
