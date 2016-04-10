package edu.neu.cs5500.project.questionnaire;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.neu.cs5500.project.authentication.BuildStaticParameters;

/**
 * Servlet implementation class Questionnaire
 */
@WebServlet("/Questionnaire")
public class Questionnaire extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Questionnaire() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqType = request.getParameter("requestType");
		String sessionQuestion = request.getParameter("questionSession");
		String result = "";
				
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			if (BuildStaticParameters.conn == null) {
				BuildStaticParameters.buildConnectionWithSQL();
			}
			
			if (reqType.equalsIgnoreCase("request")) {
				String sqlRequest = "";
				if (sessionQuestion.equals("1")){ 
					sqlRequest = "select questionText from questionnaire where questionnaireType = 'B'";
				} else if (sessionQuestion.equals("2")){
					sqlRequest = "select questionText from questionnaire where questionnaireType = 'E'";
				}
				ResultSet rs = BuildStaticParameters.stmt.executeQuery(sqlRequest);
				ArrayList<String> questions = new ArrayList<String>();
				while(rs.next()) {
					questions.add(rs.getString(0));
				}
				result = getQuestionJSON(questions);
			} else if (reqType.equalsIgnoreCase("save")) {
				String[] questions = request.getParameterValues("questions");
				String[] answers = request.getParameterValues("answers");
				String userID = request.getParameter("userId");
				String sessionID = request.getParameter("sessionId");
				String sessionDate = request.getParameter("sessionDate");
				
				String questionType = sessionQuestion.equals("1")? "Start" : "End";
				
				String sql = "insert into questAns (qaSessionId, qaSessionDate, qaUserId, qaQestion, qaAnswer, qestionType) values (?,?,?,?,?,?)";
				PreparedStatement updateAnswers = BuildStaticParameters.conn.prepareStatement(sql);
				for (int i = 0; i < 12; i++) {
					updateAnswers.setString(1, sessionID);
					updateAnswers.setString(2, sessionDate);
					updateAnswers.setString(3, userID);
					updateAnswers.setString(4, questions[i]);
					updateAnswers.setString(5, answers[i]);
					updateAnswers.setString(6, questionType);
					updateAnswers.executeUpdate();
				}
				result = "{\"save\":successful}";
			}
			response.getWriter().write(result);
			BuildStaticParameters.stmt.close();
			BuildStaticParameters.conn.close();
		} catch (SQLException se) {
			se.getStackTrace();
			response.getWriter().write("{\"save\":unsuccessful}");
		} catch (Exception e) {
			e.getStackTrace();
			response.getWriter().write("{\"save\":unsuccessful}");
		}
	}

	private String getQuestionJSON(ArrayList<String> questions) {
		String jsonString = "{questions: [";
		int i = 1;
		for (String s:questions) {
			if (i+1 > 12)
				jsonString = jsonString + "{\"question\":" + s + "}";
			else
				jsonString =  jsonString + "\"question\":" + s + "},";
			i++;
		}
		jsonString = jsonString + "]}";
		return jsonString;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
