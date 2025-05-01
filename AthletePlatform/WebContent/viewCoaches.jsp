<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, athlete.main.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Coaches List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Reuse athlete dashboard styles */
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
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Dashboard Specific Styles */
        .dashboard-header {
            background: var(--secondary);
            color: white;
            padding: 100px 0 40px;
            margin-bottom: 40px;
        }

        .athlete-profile {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid var(--accent);
        }

        .athlete-info h1 {
            font-size: 2rem;
            margin-bottom: 5px;
        }

        .athlete-meta {
            display: flex;
            gap: 20px;
            color: #ccc;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .dashboard-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 1.3rem;
            color: var(--secondary);
        }

        .metric-badge {
            background: var(--light);
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
        }

        .metric-value {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .metric-label {
            color: var(--gray);
        }

        .session-list {
            list-style: none;
        }

        .session-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .session-type {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .session-icon {
            color: var(--accent);
            font-size: 1.2rem;
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
            margin-top: 20px;
        }

        .calendar-day {
            aspect-ratio: 1;
            background: var(--light);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .calendar-day:hover {
            background: var(--primary);
            color: white;
        }

        /* Reuse existing button styles */
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .athlete-profile {
                flex-direction: column;
                text-align: center;
            }

            .athlete-meta {
                flex-direction: column;
                gap: 5px;
            }
        }
        
        
         .option-card {
        text-align: center;
        padding: 20px;
        border-radius: 8px;
        transition: all 0.3s ease;
        cursor: pointer;
        border: 2px solid var(--light);
    }

    .option-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        border-color: var(--primary);
    }

    .option-card i {
        font-size: 2rem;
        color: var(--primary);
        margin-bottom: 15px;
        transition: color 0.3s ease;
    }

    .option-card h4 {
        color: var(--secondary);
        margin-bottom: 8px;
    }

    .option-card p {
        color: var(--gray);
        font-size: 0.9rem;
    }

    @media (max-width: 768px) {
        .dashboard-grid {
            gap: 15px;
        }
        
        .option-card {
            padding: 15px;
        }
    }
    </style>
    
    
    
    
</head>
<body>
    <%
        Connection con = null;
        PreparedStatement ps = null, ps1 = null;
        ResultSet rs = null, rs1 = null;
        
        try {
            int id = GetterSetter.getId();
            con = ConnectDB.dbCon();
            
            // Get athlete details
            ps1 = con.prepareStatement("SELECT * FROM athlete WHERE AthleteID = ?"); 
            ps1.setInt(1, id);
            rs1 = ps1.executeQuery();
            
            // Get coaches list
            ps = con.prepareStatement("SELECT * FROM coach");
            rs = ps.executeQuery();
            
            // Process athlete result set
            if(!rs1.next()) {
                throw new SQLException("Athlete not found");
            }
    %>
    
    <header class="dashboard-header">
        <div class="container">
            <nav class="navbar">
                <!-- Navigation code -->
            </nav>
            
            <div class="athlete-profile">
                <img src="https://images.unsplash.com/photo-1565992441121-4367c2967103?ixlib=rb-1.2.1&auto=format&fit=crop&w=1352&q=80" 
                     alt="Athlete" 
                     class="profile-img">
                <div class="athlete-info">
                    <h1><%= rs1.getString("name") %></h1>
                    <div class="athlete-meta">
                        <span></span>
                        <span> </span>
                        <span></span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Rest of the code remains same -->

    <main class="container">
    <!-- Options Card -->
    <div class="dashboard-card" style="margin-top: 30px;">
        <div class="card-header">
            <h3 class="card-title">Quick Access</h3>
            <i class="fas fa-th-large" style="color: var(--accent);"></i>
        </div>
        
        <div class="dashboard-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));">
            <div class="option-card">
                <a href="viewCoaches.jsp">
                    <i class="fas fa-users"></i>
                    <h4>View Coaches</h4>
                    <p>Access your coaching team</p>
                </a>
            </div>
            
            <div class="option-card">
                <i class="fas fa-user-md"></i>
                <h4>View Dietitian</h4>
                <p>Connect with nutrition experts</p>
            </div>
            
            <div class="option-card">
                <i class="fas fa-calendar-alt"></i>
                <h4>View Events</h4>
                <p>Check your schedule</p>
            </div>
            
            <div class="option-card">
                <i class="fas fa-utensils"></i>
                <h4>My Diet</h4>
                <p>View meal plans</p>
            </div>
        </div>
    </div>

    <!-- Coaches Table Card -->
    <div class="dashboard-card">
        <div class="card-header">
            <h3 class="card-title">Available Coaches</h3>
            <i class="fas fa-users" style="color: var(--accent);"></i>
        </div>
        
        <table class="coach-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Sport</th>
                    <th>Experience</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% while(rs.next()) { %>
                    <tr>
                        <td><%= rs.getInt("CoachID") %></td>
                        <td><%= rs.getString("Name") %></td>
                        <td><%= rs.getString("phone") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("sport") %></td>
                        <td><%= rs.getInt("experience") %> years</td>
                        <td>
                            <button class="btn btn-primary">
                                <i class="fas fa-envelope"></i> Contact
                            </button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

<% 
    } catch(Exception e) {
        e.printStackTrace();
    } 
%>
</body>
</html>