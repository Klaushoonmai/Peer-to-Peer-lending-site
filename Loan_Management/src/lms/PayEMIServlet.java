package lms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/payemi")
public class PayEMIServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String loanid=req.getParameter("loan_id");
		String amount=req.getParameter("emi");
		String penalty=req.getParameter("penalty");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("insert into payments(loan_id,amount,penalty) values(?,?,?)", 
					loanid,amount,penalty);
			
			session.setAttribute("msg", "EMI saved successfully");
			
			resp.sendRedirect("payments.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
