<%@ page import="medical.Customer" %>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    String message = (String) session.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review and Submit</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f8fc;
            padding: 40px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        .message {
            text-align: center;
            color: green;
            margin-bottom: 20px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="tel"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            border-radius: 5px;
        }

        input[readonly] {
            background-color: #f1f1f1;
            color: #555;
        }

        .btn-group {
            text-align: center;
            margin-top: 30px;
        }

        input[type="submit"],
        .edit-btn {
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            margin: 0 10px;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
        }

        .edit-btn {
            background-color: #007bff;
            color: white;
            text-decoration: none;
        }

        .edit-btn:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>

<div class="container">
    <h2>Review Your Form</h2>

    <% if (message != null) { %>
        <div class="message"><%= message %></div>
    <% } %>

    <form action="MedicalServlet" method="post">
        <div class="form-section">
            <label>Name:</label>
            <input type="text" name="name" value="<%= customer.getName() %>" readonly>
        </div>

        <div class="form-section">
            <label>Phone:</label>
            <input type="tel" name="phone" value="<%= customer.getPhone() %>" readonly>
        </div>

        <div class="form-section">
            <label>District:</label>
            <input type="text" name="district" value="<%= customer.getDistrict() %>" readonly>
        </div>

        <div class="form-section">
            <label>Gender:</label>
            <input type="text" name="gender" value="<%= customer.getGender() %>" readonly>
        </div>

        <div class="form-section">
            <label>Date of Purchase:</label>
            <input type="text" name="buy_date" value="<%= customer.getBuyDate() %>" readonly>
        </div>

        <div class="form-section">
            <label>Medicine:</label>
            <input type="text" name="medicine" value="<%= customer.getMedicine() %>" readonly>
        </div>

        <div class="btn-group">
            <input type="submit" name="action" value="Submit">
            <a href="index.jsp" class="edit-btn">Edit</a>
        </div>
    </form>
</div>

</body>
</html>
