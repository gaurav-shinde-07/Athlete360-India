<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, athlete.main.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Coach Dashboard | AthleteMonitoring</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Your existing styles remain the same */
        :root {
            --primary: #2c3e50;
            --secondary: #1a252f; 
            --accent: #e74c3c;
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

        .dashboard-header {
            background: var(--secondary);
            color: white;
            padding: 100px 0 40px;
            margin-bottom: 40px;
        }

        .coach-profile {
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

        /* New table styles matching your design */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .data-table th, .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .data-table th {
            background-color: var(--secondary);
            color: white;
            font-weight: 500;
        }

        .data-table tr:hover {
            background-color: rgba(0,0,0,0.02);
        }

        .table-container {
            margin-top: 30px;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .table-title {
            font-size: 1.3rem;
            color: var(--secondary);
        }

        /* Your existing responsive styles */
        @media (max-width: 768px) {
            .coach-profile {
                flex-direction: column;
                text-align: center;
            }
            
            .data-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>

<%
    Connection con = null;
    PreparedStatement ps = null, psAthletes = null;
    ResultSet rs = null, rsAthletes = null;
    
    try {
        int coachId = GetterSetter.getId();
        con = ConnectDB.dbCon();
        
        // Get coach details
        ps = con.prepareStatement("SELECT * FROM coach WHERE CoachID = ?"); 
        ps.setInt(1, coachId);
        rs = ps.executeQuery();
        
        if(!rs.next()) {
            throw new SQLException("Coach not found");
        }
        
        // Get athletes assigned to this coach
        psAthletes = con.prepareStatement("SELECT * FROM athlete WHERE CoachID = ?");
        psAthletes.setInt(1, coachId);
        rsAthletes = psAthletes.executeQuery();
%>

    <header class="dashboard-header">
        <div class="container">
            <div class="coach-profile">
                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" 
                     alt="Coach" 
                     class="profile-img">
                <div class="coach-info">
                    <h1><%= rs.getString("Name") %></h1>
                    <div class="coach-meta">
                        <span><i class="fas fa-envelope"></i> <%= rs.getString("Email") %></span>
                        <span><i class="fas fa-users"></i> 
                            <%= rsAthletes.last() ? rsAthletes.getRow() : 0 %> Athletes</span>
                        <% rsAthletes.beforeFirst(); %>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main class="container">
        <!-- Athletes Table -->
        <div class="dashboard-card">
            <div class="table-header">
                <h3 class="table-title">My Athletes</h3>
                <i class="fas fa-users" style="color: var(--accent); font-size: 1.5rem;"></i>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Sport</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% while(rsAthletes.next()) { %>
                    <tr>
                        <td><%= rsAthletes.getInt("AthleteID") %></td>
                        <td><%= rsAthletes.getString("Name") %></td>
                        <td><%= rsAthletes.getString("Email") %></td>
                        <td><%= rsAthletes.getString("Phone") %></td>
                        <td><%= rsAthletes.getString("Sport") %></td>
                        <td>
                            <a href="viewAthlete.jsp?id=<%= rsAthletes.getInt("AthleteID") %>" 
                               style="color: var(--primary); text-decoration: none;">
                                <i class="fas fa-eye"></i> View
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Your existing quick access cards -->
        <div class="dashboard-card">
            <div class="card-header">
                <h3 class="card-title">Coach Portal</h3>
                <i class="fas fa-tachometer-alt" style="color: var(--accent);"></i>
            </div>
            
            <div class="dashboard-grid">
                <!-- Your existing option cards -->
                <a href="viewAthletes.jsp" class="option-card">
                    <i class="fas fa-users"></i>
                    <h4>My Clients</h4>
                    <p>Manage your athlete roster</p>
                </a>
                
                <!-- Other cards... -->
                
                 <!-- View Appointments -->
                <a href="viewAppointments.jsp" class="option-card">
                    <i class="fas fa-calendar-check"></i>
                    <h4>Appointments</h4>
                    <p>Schedule and view sessions</p>
                </a>
                
                <!-- Training Plans -->
                <a href="trainingPlans.jsp" class="option-card">
                    <i class="fas fa-clipboard-list"></i>
                    <h4>Training Plans</h4>
                    <p>Create workout programs</p>
                </a>
                
                <!-- Performance Analysis -->
                <a href="performance.jsp" class="option-card">
                    <i class="fas fa-chart-line"></i>
                    <h4>Performance</h4>
                    <p>Analyze athlete metrics</p>
                </a>
                
                <!-- Messaging -->
                <a href="messages.jsp" class="option-card">
                    <i class="fas fa-comments"></i>
                    <h4>Messages</h4>
                    <p>Communicate with athletes</p>
                </a>
                
                <!-- Reports -->
                <a href="reports.jsp" class="option-card">
                    <i class="fas fa-file-alt"></i>
                    <h4>Reports</h4>
                    <p>Generate performance reports</p>
                </a>
                
            </div>
        </div>
    </main>

<% 
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.html?message=" + e.getMessage());
    } 
%>

</body>
</html>