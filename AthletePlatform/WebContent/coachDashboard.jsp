<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, athlete.main.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Coach Dashboard | AthleteMonitoring</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Reuse athlete dashboard styles with coach-specific accents */
        :root {
            --primary: #2c3e50;  /* Darker blue for coach */
            --secondary: #1a252f; 
            --accent: #e74c3c;   /* Red accent for coach */
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

        /* Dashboard Header */
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

        .coach-info h1 {
            font-size: 2rem;
            margin-bottom: 5px;
        }

        .coach-meta {
            display: flex;
            gap: 20px;
            color: #ccc;
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .dashboard-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-top: 30px;
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

        /* Option Cards */
        .option-card {
            text-align: center;
            padding: 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid var(--light);
            text-decoration: none;
            display: block;
            color: inherit;
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

        .option-card:hover i {
            color: var(--accent);
        }

        .option-card h4 {
            color: var(--secondary);
            margin-bottom: 8px;
        }

        .option-card p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .coach-profile {
                flex-direction: column;
                text-align: center;
            }

            .coach-meta {
                flex-direction: column;
                gap: 5px;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
        }
    </style>
</head>
<body>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
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
                        <span><i class="fas fa-users"></i> 24 Athletes</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main class="container">
        <!-- Quick Access Cards -->
        <div class="dashboard-card">
            <div class="card-header">
                <h3 class="card-title">Coach Portal</h3>
                <i class="fas fa-tachometer-alt" style="color: var(--accent);"></i>
            </div>
            
            <div class="dashboard-grid">
                <!-- View Athletes -->
                <a href="viewAthletes.jsp" class="option-card">
                    <i class="fas fa-users"></i>
                    <h4>My Clients</h4>
                    <p>Manage your athlete roster</p>
                </a>
                
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
        
        <!-- Additional dashboard sections can be added here -->
    </main>

<% 
    } catch(Exception e) {
        e.printStackTrace();
      
    } 
%>

</body>
</html>