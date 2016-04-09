package edu.neu.cs5500.project.registration;

import authentication.*;
import edu.neu.cs5500.project.authentication.BuildStaticParameters;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Register
 * for getting the data from the android application
 * and store it into the database
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json");
		
		String uname = request.getParameter("uname");
		String pwd = request.getParameter("password");
		String age = request.getParameter("ethnicity");
		String ethnicity = request.getParameter("ethnicity");
		String gender = request.getParameter("gender");
		String disability = request.getParameter("disability");
		String education = request.getParameter("education");
		String mobileExp = request.getParameter("mobileExperience");
		String psychoMed = request.getParameter("psychoMedi");
		String colorBlindness = request.getParameter("colorblindness");
		
		try {
			response.setCharacterEncoding("UTF-8");
			if (BuildStaticParameters.conn == null) {
				BuildStaticParameters.buildConnectionWithSQL();
			}
			String sql = "select ulUserName from userLogin where "
					+ "ulUserName ='" + uname + "'";
			ResultSet rs = BuildStaticParameters.stmt.executeQuery(sql);
			String result;
			
			if(!rs.next()){
				PreparedStatement updateUserLogin = BuildStaticParameters.conn.prepareStatement
					      ("insert into userLogin values(?,?)");
				updateUserLogin.setString(1,uname);
				updateUserLogin.setString(2,pwd);
				updateUserLogin.executeUpdate();
				
				PreparedStatement updateUser = BuildStaticParameters.conn.prepareStatement(
						"insert into user values(?,?,?,?,?,?,?,?)");
				updateUser.setString(1, age);
				updateUser.setString(2, gender);
				updateUser.setString(3, ethnicity);
				updateUser.setString(4, disability);
				updateUser.setString(5, education);
				updateUser.setString(6, mobileExp);
				updateUser.setString(7, psychoMed);
				updateUser.setString(8, colorBlindness);
				updateUser.executeUpdate();
				
				result =  "{\"register\":successful}";
			} else {
				result = "{\"register\":unsuccessful}";
			}
			response.getWriter().write(result);
			
		} catch(SQLException se) {
			se.getStackTrace();;
		} catch(Exception e) {
			e.getStackTrace();;
		}
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
