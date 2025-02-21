<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Already Exists</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    
    .container {
        background-color: #ffffff;
        padding: 30px 50px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    
    h2 {
        color: #ff6f61;
        font-size: 26px;
        margin-bottom: 20px;
    }
    
    a {
        text-decoration: none;
        background-color: #007bff;
        color: white;
        padding: 12px 24px;
        border-radius: 5px;
        font-size: 18px;
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
            String paser = (String) session.getAttribute("username");
            out.write("<h2>The user " + paser + " already exists</h2>");
        %>
        <a href="login.html">Go To Login</a>
    </div>
</body>
</html>
