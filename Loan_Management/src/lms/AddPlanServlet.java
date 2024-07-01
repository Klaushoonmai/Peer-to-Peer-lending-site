package lms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/addplan")
public class AddPlanServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String months=req.getParameter("months");
		String perc=req.getParameter("perc");
		String penalty=req.getParameter("penalty");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("insert into loan_plan(months,perc,penalty) values(?,?,?)", 
					months,perc,penalty);
			
			session.setAttribute("msg", "Plan added successfully");
			
			resp.sendRedirect("plans.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
