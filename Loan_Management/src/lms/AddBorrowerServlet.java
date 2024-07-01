package lms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/addborrower")
public class AddBorrowerServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String fname=req.getParameter("fname");
		String lname=req.getParameter("lname");
		String gender=req.getParameter("gender");
		String email=req.getParameter("email");
		String phone=req.getParameter("phone");
		String address=req.getParameter("address");
		String pan=req.getParameter("pan");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("insert into borrowers(fname,lname,gender,email,phone,address,pan) values(?,?,?,?,?,?,?)", 
					fname,lname,gender,email,phone,address,pan);
			
			session.setAttribute("msg", "Borrower added successfully");
			
			resp.sendRedirect("borrowers.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
