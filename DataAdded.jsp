<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Success</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    
    .container {
        background-color: #fff;
        padding: 20px 40px;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    
    h2 {
        color: #333;
        font-size: 24px;
        margin-bottom: 20px;
    }
    
    a {
        text-decoration: none;
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    
    a:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <div class="container">
        <%
            String user = (String) session.getAttribute("username");
            out.write("<h2>The user " + user + " has registered successfully</h2>");
        %>
        <br>
        <a href="login.html">Go To Login</a>
    </div>
</body>
</html>
