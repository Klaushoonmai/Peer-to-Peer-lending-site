package lms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/loanstatus")
public class LoanStatusUpdateServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String status=req.getParameter("status").equals("A") ? "Approved":"Rejected";
		String id=req.getParameter("id");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("update loan_list set status=? where id=?", 
					status,id);
			
			session.setAttribute("msg", "Loan status updated successfully");
			
			resp.sendRedirect("approvalreq.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
