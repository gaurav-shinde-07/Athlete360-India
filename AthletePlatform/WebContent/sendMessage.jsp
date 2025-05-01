<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, athlete.main.*, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Send Message | AthleteMonitoring</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Reuse existing styles */
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .message-container {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        .message-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background: var(--secondary);
        }
    </style>
</head>
<body>
    <%
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement psSender = null;
        PreparedStatement psReceiver = null;
        ResultSet rsSender = null;
        ResultSet rsReceiver = null;
        
        try {
            // Get form data
            int receiverID = Integer.parseInt(request.getParameter("coachId"));
            String message = request.getParameter("message");
            
            // Get sender info from session (assuming athlete is sending)
            int senderID = (Integer) session.getAttribute("athleteId");
            String senderName = (String) session.getAttribute("athleteName");
            
            // Get current timestamp
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String timestamp = sdf.format(new Date());
            
            // Get receiver (coach) info
            con = ConnectDB.dbCon();
            
            // Get sender details (if not in session)
            if(senderName == null) {
                psSender = con.prepareStatement("SELECT Name FROM athlete WHERE AthleteID = ?");
                psSender.setInt(1, senderID);
                rsSender = psSender.executeQuery();
                if(rsSender.next()) {
                    senderName = rsSender.getString("Name");
                }
            }
            
            // Get receiver details
            psReceiver = con.prepareStatement("SELECT Name FROM coach WHERE CoachID = ?");
            psReceiver.setInt(1, receiverID);
            rsReceiver = psReceiver.executeQuery();
            String receiverName = "";
            if(rsReceiver.next()) {
                receiverName = rsReceiver.getString("Name");
            }
            
            // Insert message into database
            ps = con.prepareStatement(
                "INSERT INTO request (id, senderID, SenderName, receiverID, ReceiverName, message, timestamp, status) " +
                "VALUES (NULL, ?, ?, ?, ?, ?, ?, 'Pending')");
            
            ps.setInt(1, senderID);
            ps.setString(2, senderName);
            ps.setInt(3, receiverID);
            ps.setString(4, receiverName);
            ps.setString(5, message);
            ps.setString(6, timestamp);
            
            int rowsAffected = ps.executeUpdate();
    %>
    
    <div class="message-container">
        <% if(rowsAffected > 0) { %>
            <div class="message-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h2>Message Sent Successfully!</h2>
            <p>Your message to <%= receiverName %> has been sent.</p>
            <p>You will be notified when they respond.</p>
            <a href="athleteDashboard.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i> Return to Dashboard
            </a>
        <% } else { %>
            <div class="message-icon" style="color: var(--accent);">
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <h2>Message Failed to Send</h2>
            <p>There was an error sending your message.</p>
            <a href="coachDetail.jsp?id=<%= receiverID %>" class="btn btn-primary">
                <i class="fas fa-arrow-left"></i> Try Again
            </a>
        <% } %>
    </div>

    <% 
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Failed to send message: " + e.getMessage());
        } finally {
            if (rsReceiver != null) rsReceiver.close();
            if (rsSender != null) rsSender.close();
            if (psReceiver != null) psReceiver.close();
            if (psSender != null) psSender.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>
</body>
</html>