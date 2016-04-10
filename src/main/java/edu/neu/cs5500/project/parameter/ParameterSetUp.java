package edu.neu.cs5500.project.parameter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ParameterSetUp
 */
@WebServlet(description = "To be used by the application to set up the environment for the user", urlPatterns = { "/ParameterSetUp" })
public class ParameterSetUp extends HttpServlet {
	String username;
    String password;
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
    static final String DB_URL = "jdbc:mysql://localhost:3306/teenviolence";
    static final String USER = "root";
    static final String PASS = "msd1234";
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ParameterSetUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String title = "Database Result";
	    String docType =
	        "<!doctype html public \"-//w3c//dtd html 4.0 " +
	         "transitional//en\">\n";
	    out.println(docType +
	         "<html>\n" +
	         "<head><title>" + title + "</title></head>\n" +
	         "<body bgcolor=\"#f0f0f0\">\n" +
	         "<h1 align=\"center\">" + title + "</h1>\n");
		 try {
			 
			 
			 //username = request.getParameter("username");
			 username = "chini";
			 // password = request.getParameter("pwd");
			 password = "msd1";
			 Class.forName("com.mysql.jdbc.Driver");
			 // Pwd frm the db to be stored into this variable
			 String pwd="";
			 String success = "false";
			 
			 out.println("Connecting to database... <br>");
			 Connection conn = DriverManager.getConnection(DB_URL,USER,PASS);
			 
			 out.println("Creating statement...<br>");
			 Statement stmt = conn.createStatement();
			 String sql;
			 sql = "SELECT pwd FROM user_details where userid = '" + username + "'";
			 ResultSet rs = stmt.executeQuery(sql);
			 while (rs.next()) {
				 pwd = rs.getString("pwd");
			 }
			 if (pwd.equals(password)) {
				 success = "true";
			 }
			 //String json_res = new Gson().toJson(success);
			 
			 //response.setContentType("application/json");
			 //response.setCharacterEncoding("UTF-8");
			 
			 
			 out.println(username + " " + pwd + " " + success + "<br>");
			 

			 Random r = new Random();
			 int type1 = r.nextInt(1);
			 int type2 = type1==0? 1 : 0;
			 
			 out.println(type1 + " " + type2 + "<br>");
			 
			 out.println("</body></html>");
			 
			 //response.getWriter().write(json_res);
			 rs.close();
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

}
