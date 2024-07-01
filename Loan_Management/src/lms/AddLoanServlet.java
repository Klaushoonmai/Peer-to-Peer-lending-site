package lms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/addloan")
public class AddLoanServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String bid=req.getParameter("bid");
		String typeid=req.getParameter("type_id");
		String planid=req.getParameter("plan_id");
		String amount=req.getParameter("amount");
		String purpose=req.getParameter("purpose");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("insert into loan_list(type_id,plan_id,borrower_id,purpose,amount) values(?,?,?,?,?)", 
					typeid,planid,bid,purpose,amount);
			
			session.setAttribute("msg", "Loan saved successfully");
			
			resp.sendRedirect("applications.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
