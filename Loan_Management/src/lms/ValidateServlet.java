package lms;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/validate")
public class ValidateServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String userid=req.getParameter("userid");
		String pwd=req.getParameter("pwd");
		try {
			String sql="SELECT * FROM users WHERE userid=? and pwd=? limit 1";
			Map<String,String> result=DbHelper.executeDQLReturnSingle(sql, userid,pwd);
			System.out.println(result);
			if(result==null) {
				session.setAttribute("error", "Invalid username or password");
				resp.sendRedirect("index.jsp");
			}else {
				session.setAttribute("uname", result.get("name"));
				String role=result.get("role");
				session.setAttribute("role", role);				
				session.setAttribute("id", result.get("userid"));
				if(role.equals("Admin")) {				
					resp.sendRedirect("dashboard.jsp");
				} else if(role.equals("Manager")) {
					resp.sendRedirect("dashboard.jsp");
				} else if(role.equals("Staff")) {
					resp.sendRedirect("dashboard.jsp");
				}
				else if(role.equals("Customer")) {
					resp.sendRedirect("dashboard.jsp");
				}
			}
		}
		catch(Exception ex) {
			System.err.println("Error "+ex.getMessage());
		}
		//resp.sendRedirect("dashboard.jsp");
	}
}