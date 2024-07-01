<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="msg.jsp"></jsp:include>
<%
String loanid=request.getParameter("id");
Map<String,String> loan=DbHelper.executeDQLReturnSingle("SELECT l.*,b.*,p.*,s.iamount FROM loan_list l join borrowers b on l.borrower_id=b.id join loan_plan p on p.id=l.plan_id join loan_schedules s on s.loan_id=l.loan_id WHERE l.loan_id=? limit 1", loanid);
%>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <h5 class="p-2" style="border-bottom: 2px solid green;">Loan Details for Loan Id: <%= loan.get("loan_id") %></h5>
			<table class="table">
				<tr>
					<th>Borrower Name</th>
					<th><%= loan.get("fname") %> <%= loan.get("lname") %></th>
					<th>Duration</th>
					<th><%= loan.get("months") %> months</th>
				</tr>
				<tr>
					<th>Rate</th>
					<th><%= loan.get("perc") %>%</th>
					<th>Loan Amount</th>
					<th>&#8377; <%= loan.get("amount") %></th>
				</tr>
				<tr>
					<th>Loan Date</th>
					<th><%= loan.get("date_released") %></th>
					<th>EMI Amount</th>
					<th>&#8377; <%= loan.get("iamount") %></th>
				</tr>
			</table>
			
			<h5 class="p-2 text-center" style="border-bottom: 2px solid green;">Loan EMI Details</h5>
			
			<table class="table table-sm table-bordered mt-2">
				<thead>
				<tr>
					<th>Id</th>
					<th>EMI Amount</th>
					<th>Penalty Amount</th>
					<th>Payment Date</th>
				</tr>				
				</thead>
				<tbody>
				<%
				List<Map<String,String>> pmts=DbHelper.executeDQL("SELECT * FROM payments WHERE loan_id=?", loanid);
				for(Map<String,String> pmt : pmts){
				%>
				<tr>
				<td><%= pmt.get("id") %></td>
				<td>&#8377; <%= pmt.get("amount") %></td>
				<td>&#8377; <%= pmt.get("penalty") %></td>
				<td><%= pmt.get("date_created") %></td>
				</tr>
				<%} %>
				</tbody>
			</table>
        </div>
    </div>
</div>