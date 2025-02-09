<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<html>
<head>
    <title>Display Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }
        h2 {
            text-align: center;
            font-size: 24px;
            color: #4CAF50;
            margin-top: 20px;
        }
        table {
            width: 70%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: center;
            font-size: 16px;
        }
        th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
        .add-to-cart {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .add-to-cart:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Product List</h2>
    <table>
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Product Price</th>
            <th>Purchase</th>
        </tr>
        
        <%
            out.write("<br><br><h2 style='font-size:24px;'>Welcome " + request.getParameter("username") + "</h2>");
        
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try 
            {
                // Load the JDBC driver
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                
                // Establish the connection
                String dbURL = "jdbc:sqlserver://DESKTOP-9V6RT8O;encrypt=false;databaseName=Study;integratedSecurity=true";
                conn = DriverManager.getConnection(dbURL);

                // Create a statement
                stmt = conn.createStatement();

                // Execute a query
                String sql = "SELECT pid, pname, pprice FROM Product_List";
                rs = stmt.executeQuery(sql);

                // Iterate through the result set and display the data
                while(rs.next()) 
                {
                    int pid = rs.getInt("pid");
                    String pname = rs.getString("pname");
                    int pprice = rs.getInt("pprice");

                    // Display the data in the table rows
                    %>
                    <tr>
                        <td><%= pid %></td>
                        <td><%= pname %></td>
                        <td><%= pprice %></td>
                        <td><button class="add-to-cart">Add To Cart</button></td>
                    </tr>
                    <%
                }
            }
            catch(Exception e) 
            {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
