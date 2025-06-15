<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Final Page - All Submissions</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9fdfc;
            margin: 0;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #2a6c2a;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            background-color: white;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #e0f7fa;
            color: #00695c;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
            }

            body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<h2>All Submitted Medical Store Forms</h2>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical_store", "root", "Chetu@123");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM customers");
%>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Phone</th>
        <th>District</th>
        <th>Gender</th>
        <th>Buy Date</th>
        <th>Medicine</th>
    </tr>

<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("phone") %></td>
        <td><%= rs.getString("district") %></td>
        <td><%= rs.getString("gender") %></td>
        <td><%= rs.getString("buy_date") %></td>
        <td><%= rs.getString("medicine") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        // Silent fail - don't show any message
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    }
%>
</table>

</body>
</html>
