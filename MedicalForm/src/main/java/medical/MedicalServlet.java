package medical;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/MedicalServlet")

public class MedicalServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String district = req.getParameter("district");
        String gender = req.getParameter("gender");
        String buyDate = req.getParameter("buy_date");
        String medicine = req.getParameter("medicine");

        Customer customer = new Customer(name, phone, district, gender, buyDate, medicine);
        session.setAttribute("customer", customer);

     // After saving
        if ("Save".equals(action)) {
            try (Connection con = DBCon.getConnection()) {

                
                PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM customers WHERE phone = ?");
                checkStmt.setString(1, phone);
                ResultSet rs = checkStmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    session.setAttribute("message", "Phone number already exists! Please use a different number.");
                    res.sendRedirect("index.jsp");
                } else{
                    
                    PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO customers (name, phone, district, gender, buy_date, medicine) VALUES (?, ?, ?, ?, ?, ?)");
                    ps.setString(1, name);
                    ps.setString(2, phone);
                    ps.setString(3, district);
                    ps.setString(4, gender);
                    ps.setString(5, buyDate);
                    ps.setString(6, medicine);
                    ps.executeUpdate();

                    session.setAttribute("message", "Data saved successfully! Check once before submit.");
                    res.sendRedirect("edit.jsp");
                }
                

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "Error saving data.");
                res.sendRedirect("index.jsp");
            }
        }else if("Submit".equals(action)) {
            try (Connection con = DBCon.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE customers SET phone=?, district=?, gender=?, buy_date=?, medicine=? WHERE name=?");
                ps.setString(1, phone);
                ps.setString(2, district);
                ps.setString(3, gender);
                ps.setString(4, buyDate);
                ps.setString(5, medicine);
                ps.setString(6, name);
                ps.executeUpdate();
                res.sendRedirect("final.jsp");
            } 
            catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "Error during final submission.");
                res.sendRedirect("edit.jsp");
            }
        }


    }
}
