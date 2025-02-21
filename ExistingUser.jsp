<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

			
	
<%
try {
    String driver = application.getInitParameter("Driver");
    Class.forName(driver);
    System.out.println("Driver Loaded");

    String url = "jdbc:sqlserver://DESKTOP-9V6RT8O;encrypt=false;databaseName=Study;integratedSecurity=true";
    Connection conn = DriverManager.getConnection(url);
    out.println("Connection Done");	

    // Get the username and password from the request
    String inputUsername = request.getParameter("username");
    String inputPassword = request.getParameter("password");
    session.setAttribute("username", inputUsername);

    // Query to check if the username and password are present in the database
    String query = "SELECT username, password FROM Credentials WHERE username = ? AND password = ?";
    boolean validUser = false;

    PreparedStatement ps = conn.prepareStatement(query);
    ps.setString(1, inputUsername);
    ps.setString(2, inputPassword);
    ResultSet rs = ps.executeQuery();

    // Check if there is a matching record
    if (rs.next()) 
    {
        validUser = true;
    }

    rs.close();
    ps.close();

    // Redirect based on the presence of the username and password in the database
    if (validUser) 
    {
    	
        response.sendRedirect("AlreadyPresent.jsp");
    } 
    else 
    {
        // Assuming that you want to insert a new record if the user does not exist
        String n1 = request.getParameter("name");
        String u1 = request.getParameter("username");
        String p1 = request.getParameter("password");
		session.setAttribute("username", u1);
        // Check if parameters are not null
        if (n1 != null && u1 != null && p1 != null) 
        {
            // Prepare SQL statement
            PreparedStatement psp = conn.prepareStatement("INSERT INTO Credentials (name, username, password) VALUES (?, ?, ?)");

            // Set parameters
            psp.setString(1, n1);
            psp.setString(2, u1);
            psp.setString(3, p1);

            // Execute update
            int result = psp.executeUpdate();
            if (result > 0) 
            {
                out.print("Inserted Successfully");
            } 
            else 
            {
                out.print("Failed to insert");
            }
            psp.close();
        } 
        else 
        {
            out.print("Failed to insert: One or more parameters are null");
        }
        
        
        response.sendRedirect("DataAdded.jsp");
    }
    conn.close();
} 
catch (ClassNotFoundException | SQLException e) 
{
    e.printStackTrace();
} 
catch (Exception e) 
{
    e.printStackTrace();
}
%>
	
	

</body>
</html>