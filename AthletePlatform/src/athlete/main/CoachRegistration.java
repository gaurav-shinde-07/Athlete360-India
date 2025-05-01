package athlete.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CoachRegistration extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form parameters with basic validation
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String sport = request.getParameter("sport");
        String experienceStr = request.getParameter("experience");
        String password = request.getParameter("password");
        
        // Validate required fields
        if (name == null || phone == null || email == null || 
            sport == null || experienceStr == null || password == null) {
            response.sendRedirect("error.html?message=Missing+required+fields");
            return;
        }
        
        int experience;
        try {
            experience = Integer.parseInt(experienceStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.html?message=Invalid+experience+format");
            return;
        }
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = ConnectDB.dbCon();
            
            // Hash the password before storing

            
            // Use proper column names and let database auto-generate ID
            String sql = "INSERT INTO coach (name, phone, email, sport, experience, password) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, sport);
            ps.setInt(5, experience);
            ps.setString(6, password);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("coachLogin.html");
            } else {
                response.sendRedirect("error.html?message=Registration+failed");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle specific SQL errors (like duplicate email)
            if (e.getMessage().contains("Duplicate entry") && e.getMessage().contains("email")) {
                response.sendRedirect("error.html?message=Email+already+exists");
            } else {
                response.sendRedirect("error.html?message=Database+error");
            }
        } finally {
            // Proper resource cleanup
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}