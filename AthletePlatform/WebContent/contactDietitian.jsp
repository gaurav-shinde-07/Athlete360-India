<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, athlete.main.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Coach Details | AthleteMonitoring</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Reuse existing styles from previous pages */
        :root {
            --primary: #0056b3;
            --secondary: #003366;
            --accent: #ff6b00;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .options-menu {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 15px;
        }

        .dashboard-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-top: 30px;
        }

        .coach-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .coach-table th, .coach-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .coach-table th {
            background: var(--secondary);
            color: white;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background: var(--secondary);
        }

        .message-form {
            margin-top: 30px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--secondary);
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
    </style>
</head>
<body>
    <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
           
            int dietitianId = Integer.parseInt(request.getParameter("id"));
            con = ConnectDB.dbCon();
            
            // Get coach details
            ps = con.prepareStatement("SELECT * FROM dietitian WHERE DietitianID = ?");
            ps.setInt(1, dietitianId);
            rs = ps.executeQuery();
            
            if(!rs.next()) {
                throw new SQLException("dietitian not found");
            }
    %>
    
    <div class="container">
        <!-- Back button -->
        <a href="viewCoaches.jsp" class="btn btn-primary" style="margin-bottom: 20px;">
            <i class="fas fa-arrow-left"></i> Back to Coaches
        </a>
        
        <!-- Coach Table Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <h3 class="card-title">Coach Details</h3>
                <i class="fas fa-user-tie" style="color: var(--accent);"></i>
            </div>
            
            <table class="coach-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        
                        <th>Experience</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs.getInt("DietitianID") %></td>
                        <td><%= rs.getString("Name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("phone") %></td>
                       
                        <td><%= rs.getInt("experience") %> years</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <!-- Message Form Card -->
        <div class="message-form">
            <h3 style="margin-bottom: 20px; color: var(--secondary);">Send Message to Coach</h3>
            
            <form action="SendMessageDietitian" method="post">
                <input type="hidden" name="ID" value="<%= dietitianId %>">
                
                <div class="form-group">
                    <label for="message">Your Message:</label>
                    <textarea id="message" name="message" class="form-control" required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane"></i> Send Message
                </button>
            </form>
        </div>
    </div>

    <% 
        } catch(Exception e) {
            e.printStackTrace();

        }
    %>
</body>
</html>