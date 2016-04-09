package edu.neu.cs5500.project.imageData;

import java.io.IOException;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
//import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class ImageDataServlet
 */
@WebServlet("/ImageDataServlet")
public class ImageDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
    static final String DB_URL = "jdbc:mysql://localhost:3306/teenviolence";
    static final String USER = "root";
    static final String PASS = "msd1234";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageDataServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
			 
			 String correctness;
			 
			 String responseTime = request.getParameter("responsetime");
			 //String responseTime = "0.12";
			 
			 String expectedResult = request.getParameter("expected");
			 //String expectedResult = "0";
			 
			 String actualResult = request.getParameter("actual");
			 //String actualResult = "1";
			 
			 if(expectedResult.equals(actualResult))
				 correctness = "right";
			 else
				 correctness ="wrong";
				 
			 String userid = request.getParameter("userid");
			 //String userid = "1";
			 
			 String imageid = request.getParameter("image");
			 //String imageid = "2";
			 
			 Class.forName("com.mysql.jdbc.Driver");
			 // Pwd frm the db to be stored into this variable
			
			 
			 //out.println("Connecting to database... <br>");
			 Connection conn = DriverManager.getConnection(DB_URL,USER,PASS);
			 
			 //out.println("Creating statement...<br>");
			 Statement stmt = conn.createStatement();
			 String sql;
			 sql = "insert into response (respCorrectness,respTimeTaken,expectedResult,actualResult,user,image)values ('"
			 + correctness + "', '"  + responseTime +"','"+ expectedResult +"','" + actualResult + "','" + userid + "','" + imageid +"' ) ";
			 
			 stmt.executeUpdate(sql);
		
			 //String json_res = new Gson().toJson("true");
			 
			 response.setContentType("application/json");
			 response.setCharacterEncoding("UTF-8");
			 
			 
			 //out.println(username + " " + pwd + " " + success + "<br>");
			 
			 //out.println("</body></html>");
			 
			 response.getWriter().write("{\"result\":true");
			 stmt.close();
			 conn.close();
		 } catch(SQLException se){
	         //Handle errors for JDBC
	         se.printStackTrace();
	      }catch(Exception e){
	         //Handle errors for Class.forName
	         e.printStackTrace();
	      }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
