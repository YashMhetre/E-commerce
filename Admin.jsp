<!DOCTYPE html>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

/* General Page Styling */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 20px;
    color: #333;
}

h1, h2, h3 {
    font-family: 'Helvetica', sans-serif;
    color: #2c3e50;
}

form {
    margin-bottom: 20px;
}

input[type="text"], input[type="number"], button {
    padding: 10px;
    font-size: 16px;
    border-radius: 5px;
    border: 1px solid #bdc3c7;
    margin-right: 10px;
}

button {
    background-color: #3498db;
    color: #fff;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #2980b9;
}

/* Container for centering the toggle switch and labels */
.toggle-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px; /* Adjust gap between the switch and labels */
}
.toggle-label {
    font-family: 'Arial', sans-serif;
    font-size: 20px;
    color: red;
    margin: 0 10px;
    font-weight: bold;
    vertical-align: middle;
    transition: color 0.3s ease-in-out;
}

.toggle-label:hover {
    color: red;
}


/* Toggle Switch Styling */
.switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
}

.switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: orange;
    transition: .4s;
    border-radius: 34px;
}

.slider:before {
    position: absolute;
    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    transition: .4s;
    border-radius: 50%;
}

input:checked + .slider {
    background-color: orange;
}

input:checked + .slider:before {
    transform: translateX(26px);
}

/* Hide text when switch is off */
input:not(:checked) ~ #switchOn {
    display: none;
}

/* Hide text when switch is on */
input:checked ~ #switchOff {
    display: none;
}


/* Hide text when switch is off */
input:not(:checked) ~ #switchOn {
    display: none;
}

/* Hide text when switch is on */
input:checked ~ #switchOff {
    display: none;
}



/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #ecf0f1;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    overflow: hidden;
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #2980b9;
    color: white;
}

td {
    background-color: #f9f9f9;
}

tr:hover td {
    background-color: #e1f5fe;
}

/* Messages Styling */
.message, .error-message {
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
}

.message {
    background-color: #2ecc71;
    color: white;
}

.error-message {
    background-color: #e74c3c;
    color: white;
}

</style>
</head>
<body>

<%
    String formType = request.getParameter("formType");
    if (formType == null) {
        formType = "manual"; // default form type
    }
%>


	<div class="center-container">
        <form method="post" action="#">
            <div class="toggle-container">
                <span class="toggle-label" id="switchOff">Update Products</span>
                <label class="switch">
                    <input type="checkbox" name="formType" value="allAtOnce" <%= formType.equals("allAtOnce") ? "checked" : "" %> onchange="this.form.submit()">
                    <span class="slider round"></span>
                </label>
                <span class="toggle-label" id="switchOn">Add Products</span>
            </div>
            <input type="hidden" name="submitted" value="true">
        </form>
    </div>



<% if (formType.equals("manual")) { %>
    <div id="manualSaveForm" style="display: block;">
        <!-- Forms for Manual Save -->
        <form method="post" action="#">
            <input type="hidden" name="formType" value="manual">
            <input type="text" name="pname" placeholder="Product Name" required>
            <button type="submit" name="addProduct">Add to Database</button>
        </form>

        <form method="post" action="#">
            <input type="hidden" name="formType" value="manual">
            <input type="text" name="pname" placeholder="Product Name" required>
            <input type="number" name="pquantity" placeholder="Quantity to Add/Subtract" required>
            <button type="submit" name="updateQuantity">Update Quantity</button>
        </form>

        <form method="post" action="#">
            <input type="hidden" name="formType" value="manual">
            <input type="text" name="pname" placeholder="Product Name" required>
            <input type="number" name="pprice" placeholder="New Product Price" required>
            <button type="submit" name="updatePrice">Update Price</button>
        </form>

        <form method="post" action="#">
            <input type="hidden" name="formType" value="manual">
            <input type="text" name="oldPname" placeholder="Current Product Name" required>
            <input type="text" name="newPname" placeholder="New Product Name" required>
            <button type="submit" name="updateProductName">Update Product Name</button>
        </form>

        <form method="post" action="#">
            <input type="hidden" name="formType" value="manual">
            <input type="text" name="pname" placeholder="Product Name" required>
            <button type="submit" name="removeProduct">Remove Product</button>
        </form>
    </div>
<% } else { %>
    <div id="saveAllAtOnceForm" style="display: block;">
        <!-- Form for Save All at Once -->
        <form method="post" action="#">
            <input type="hidden" name="formType" value="allAtOnce">
            <input type="text" name="pname" placeholder="Product Name" required>
            <input type="number" name="pquantity" placeholder="Product Quantity" required>
            <input type="number" name="pprice" placeholder="Product Price" required>
            <button type="submit" name="saveProduct">Save</button>
        </form>
    </div>
<% } %>

<%
    String message = null;
    String errorMessage = null;
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String dbURL = "jdbc:sqlserver://DESKTOP-9V6RT8O;encrypt=false;databaseName=Study;integratedSecurity=true";
        conn = DriverManager.getConnection(dbURL);

        // Add Product (Manual)
        if (request.getParameter("addProduct") != null) {
            String pname = request.getParameter("pname");
            int pquantity = 0;  // Default quantity to 0

            String insertSQL = "INSERT INTO Product_List (pname, pquantity, pprice) VALUES (?, ?, NULL)";
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setString(1, pname);
            pstmt.setInt(2, pquantity);
            pstmt.executeUpdate();

            message = "Product added successfully!";
        }

        // Update Quantity (Manual)
        if (request.getParameter("updateQuantity") != null) {
            String pname = request.getParameter("pname");
            int pquantity = Integer.parseInt(request.getParameter("pquantity"));

            String updateSQL = "UPDATE Product_List SET pquantity = pquantity + ? WHERE pname = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setInt(1, pquantity);
            pstmt.setString(2, pname);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "Quantity updated successfully!";
            } else {
                errorMessage = "Product not found!";
            }
        }

        // Update Price (Manual)
        if (request.getParameter("updatePrice") != null) {
            String pname = request.getParameter("pname");
            int pprice = Integer.parseInt(request.getParameter("pprice"));

            String updateSQL = "UPDATE Product_List SET pprice = ? WHERE pname = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setInt(1, pprice);
            pstmt.setString(2, pname);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "Price updated successfully!";
            } else {
                errorMessage = "Product not found!";
            }
        }

        // Update Product Name (Manual)
        if (request.getParameter("updateProductName") != null) {
            String oldPname = request.getParameter("oldPname");
            String newPname = request.getParameter("newPname");

            String updateSQL = "UPDATE Product_List SET pname = ? WHERE pname = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setString(1, newPname);
            pstmt.setString(2, oldPname);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "Product name updated successfully!";
            } else {
                errorMessage = "Product not found!";
            }
        }

        // Remove Product (Manual)
        if (request.getParameter("removeProduct") != null) {
            String pname = request.getParameter("pname");

            String deleteSQL = "DELETE FROM Product_List WHERE pname = ?";
            pstmt = conn.prepareStatement(deleteSQL);
            pstmt.setString(1, pname);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "Product removed successfully!";
            } else {
                errorMessage = "Product not found!";
            }
        }

        // Save Product with Name, Quantity, and Price (All at Once)
        if (request.getParameter("saveProduct") != null) {
            String pname = request.getParameter("pname");
            int pquantity = Integer.parseInt(request.getParameter("pquantity"));
            int pprice = Integer.parseInt(request.getParameter("pprice"));

            String insertSQL = "INSERT INTO Product_List (pname, pquantity, pprice) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setString(1, pname);
            pstmt.setInt(2, pquantity);
            pstmt.setInt(3, pprice);
            pstmt.executeUpdate();

            message = "Product saved successfully!";
        }

        // Display messages
        if (message != null) {
            out.println("<div class='message'>" + message + "</div>");
        }
        if (errorMessage != null) {
            out.println("<div class='error-message'>" + errorMessage + "</div>");
        }

    } 
    catch (Exception e) 
    {
        e.printStackTrace();
    } 
    finally 
    {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!-- Display Product List -->
    <table>
        <tr>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <%
            ResultSet rs = null;
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String dbURL = "jdbc:sqlserver://DESKTOP-9V6RT8O;encrypt=false;databaseName=Study;integratedSecurity=true";
                conn = DriverManager.getConnection(dbURL);
                String selectSQL = "SELECT pname, pquantity, pprice FROM Product_List";
                pstmt = conn.prepareStatement(selectSQL);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    String pname = rs.getString("pname");
                    int pquantity = rs.getInt("pquantity");
                    int pprice = rs.getInt("pprice");
                    %>
                    <tr>
                        <td><%= pname %></td>
                        <td><%= pquantity %></td>
                        <td><%= pprice %></td>
                    </tr>
                    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>

</body>
</html>
