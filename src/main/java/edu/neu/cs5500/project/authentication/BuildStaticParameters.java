package edu.neu.cs5500.project.authentication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class BuildStaticParameters {
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/teenviolence";
	static final String USER = "root";
	static final String PASS = "msd1234";
	public static Connection conn = null;
	public static Statement stmt =null;

	public static void buildConnectionWithSQL() {
		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			 stmt=BuildStaticParameters.conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
