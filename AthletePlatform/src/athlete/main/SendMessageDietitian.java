package athlete.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SendMessageDietitian extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
       
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement psCoach = null;
        ResultSet rsCoach = null;
        
        try {
            int receiverID = Integer.parseInt(request.getParameter("ID"));
            String message = request.getParameter("message");
            
            
            int senderID = GetterSetter.getId();
            String senderName = GetterSetter.getName();
            System.out.println(senderName);
            
           
            String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            

            con = ConnectDB.dbCon();
            
            psCoach = con.prepareStatement("SELECT Name FROM dietitian WHERE DietitianID = ?");
            psCoach.setInt(1, receiverID);
            rsCoach = psCoach.executeQuery();
            
            String receiverName = "";
            if(rsCoach.next()) {
                receiverName = rsCoach.getString("Name");
            }
            
            ps = con.prepareStatement("INSERT INTO request  VALUES (?, ?, ?, ?, ?, ?, ?,?) ");
            ps.setInt(1, 0);
            ps.setInt(2, senderID);
            ps.setString(3, senderName);
            ps.setInt(4, receiverID);
            ps.setString(5, receiverName);
            ps.setString(6, message);
            ps.setString(7, "pending");
            ps.setString(8, timestamp);
            
            int rowsAffected = ps.executeUpdate();
            
            if(rowsAffected > 0) {
                response.sendRedirect("viewCoaches.jsp");
            } else {
                response.sendRedirect("error.html");
            }
            
        } catch(Exception e) {
            e.printStackTrace();

        
        }
    }
}