<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /* Reset body and html margins and padding */
        html, body {
            margin: 0;
            padding: 0;
            height: 100%; /* Ensure html and body take full height */
        }
        
        /* Style for the background image container */
        .background-image {
            background-image: url('./OPlaced.png'); /* Path to your image */
            background-size: cover; /* Cover the entire element */
            background-position: center; /* Center the image */
            background-repeat: no-repeat; /* Do not repeat the image */
            height: 100vh; /* Full viewport height */
            width: 100vw; /* Full viewport width */
            overflow: hidden; /* Hide any overflow to prevent scrollbars */
            display: flex;
            
            
        }
        .button-container 
        {
        	color : white;
        	margin-left : 48%;
        	margin-top : 21%;
    		display: flex;
    		justify-content: center;
    		align-items: center;
    		position: relative; /* For absolute positioning of the button */
    		font-size : 24px;
    		text-decoration : none ;
		}
    </style>
</head>
<body>
    <div class="background-image">
        	<a href="login.html" class="button-container">Go To Login</a>
    </div>
</body>
</html>
