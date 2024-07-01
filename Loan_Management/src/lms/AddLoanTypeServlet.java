package lms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/addtype")
public class AddLoanTypeServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String type=req.getParameter("typename");
		String descr=req.getParameter("description");
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("insert into loan_types(type_name,description) values(?,?)",type,descr);			
			session.setAttribute("msg", "Master added successfully");
			resp.sendRedirect("loantypes.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
