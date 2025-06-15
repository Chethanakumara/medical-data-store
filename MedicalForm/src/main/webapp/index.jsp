<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="medical.Customer" %>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    String name = "", phone = "", district = "", taluk = "", gender = "", buyDate = "", medicine = "";
    if (customer != null) {
        name = customer.getName();
        phone = customer.getPhone();
        district = customer.getDistrict();
        gender = customer.getGender();
        buyDate = customer.getBuyDate();
        medicine = customer.getMedicine();
        // Add taluk if it's stored in customer object
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Medical Store Form</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #e0f7fa;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            background: #fff;
            margin: 50px auto;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #00796b;
            margin-bottom: 30px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        label {
            font-weight: 600;
            display: inline-block;
            margin-bottom: 8px;
            color: #333;
        }

        select, input, textarea {
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        select:focus, input:focus, textarea:focus {
            border-color: #26a69a;
            outline: none;
        }

        textarea {
            resize: vertical;
            width: 100%;
        }

        .dropdown-row {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        #taluk-container {
            display: none;
        }

        .btn-group {
            text-align: center;
            margin-top: 30px;
        }

        input[type="submit"],
        input[type="reset"],
        .view-btn {
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            margin: 0 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"] { background-color: #4caf50; color: #fff; }
        input[type="reset"] { background-color: #ffca28; color: #000; }
        .view-btn { background-color: #039be5; color: white; }

        input[type="submit"]:hover { background-color: #388e3c; }
        input[type="reset"]:hover { background-color: #fbc02d; }
        .view-btn:hover { background-color: #0288d1; }
    </style>

    <script>
        function updateTaluks() {
            var district = document.getElementById("district").value;
            var talukContainer = document.getElementById("taluk-container");
            var taluk = document.getElementById("taluk");

            taluk.innerHTML = "";

            var options = {
                "Bangalore": ["North", "South", "East", "West"],
                "Mysuru": ["Mysuru", "Nanjangud", "T. Narasipura"],
                "Shivamogga": ["Bhadravathi", "Sagar", "Shikaripur"],
                "Hubli": ["Hubli Urban", "Hubli Rural"],
                "Mangaluru": ["Mangaluru North", "Mangaluru South"]
            };

            if (options[district]) {
                talukContainer.style.display = "inline-block";
                options[district].forEach(function(t) {
                    var opt = document.createElement("option");
                    opt.value = t;
                    opt.text = t;
                    taluk.appendChild(opt);
                });
            } else {
                talukContainer.style.display = "none";
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Medical Store</h2>
    <form action="MedicalServlet" method="post">

        <div class="form-section">
            <label>Name:</label>
            <input type="text" name="name" value="<%= name %>" required style="width: 100%;">
        </div>

        <div class="form-section">
            <label>Phone:</label>
            <input type="tel" name="phone" pattern="[0-9]{10}" maxlength="10" value="<%= phone %>" required style="width: 100%;">
        </div>

        <div class="form-section dropdown-row">
            <label>District:</label>
            <select name="district" id="district" onchange="updateTaluks()" required>
                <option value="">--Select District--</option>
                <option value="Bangalore" <%= "Bangalore".equals(district) ? "selected" : "" %>>Bangalore</option>
                <option value="Mysuru" <%= "Mysuru".equals(district) ? "selected" : "" %>>Mysuru</option>
                <option value="Shivamogga" <%= "Shivamogga".equals(district) ? "selected" : "" %>>Shivamogga</option>
                <option value="Hubli" <%= "Hubli".equals(district) ? "selected" : "" %>>Hubli</option>
                <option value="Mangaluru" <%= "Mangaluru".equals(district) ? "selected" : "" %>>Mangaluru</option>
            </select>

            <div id="taluk-container">
                <label style="margin-left:10px;">Taluk:</label>
                <select id="taluk" name="taluk"></select>
            </div>
        </div>

        <div class="form-section">
            <label>Gender:</label>
            <input type="radio" name="gender" value="Male" <%= "Male".equals(gender) ? "checked" : "" %>> Male
            <input type="radio" name="gender" value="Female" <%= "Female".equals(gender) ? "checked" : "" %>> Female
        </div>

        <div class="form-section">
            <label>Date of Purchase:</label>
            <input type="date" name="buy_date" value="<%= buyDate %>" required style="width: 100%;">
        </div>

        <div class="form-section">
            <label>Medicine:</label>
            <textarea name="medicine" rows="4" placeholder="Write here..." required><%= medicine %></textarea>
        </div>

        <div class="form-section">
            <h3>Common Diseases:</h3>
            <label><input type="checkbox" name="dis" value="bp"> BP</label>
            <label><input type="checkbox" name="dis" value="sug"> Sugar</label>
            <label><input type="checkbox" name="dis" value="as"> Asthma</label>
            <label><input type="checkbox" name="dis" value="hea"> Heart</label>
        </div>

        <div class="form-section">
            <label for="photo">Upload Bill Photo:</label>
            <input type="file" id="photo" name="photo">
        </div>

        <div class="btn-group">
            <input type="submit" name="action" value="Save">
            <input type="reset" value="Reset">
            <a href="final.jsp"><button type="button" class="view-btn">View</button></a>
        </div>
    </form>
</div>

<script>
    // If district already selected from session, show taluk dropdown
    window.onload = function() {
        updateTaluks();
    };
</script>
</body>
</html>
