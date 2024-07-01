<%@page import="java.util.Map"%>
<%@page import="config.DbHelper"%>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <h5 class="p-2" style="border-bottom: 2px solid green;">Payments</h5>
            
            <form class="form-inline">
            	<label class="mr-2">Enter Loan Id</label>
            	<input type="text" name="loan_id" value="${param.loan_id }" class="form-control mr-2">
            	<button class="btn btn-primary">Search</button>
            </form>
            
            <%
            if(request.getParameter("loan_id")!=null)
            {
            	String loanid=request.getParameter("loan_id");
            	Map<String,String> loan=DbHelper.executeDQLReturnSingle("SELECT l.*,b.*,p.*,s.iamount,s.penalty as spenal,s.withpenalty FROM loan_list l join borrowers b on l.borrower_id=b.id join loan_plan p on p.id=l.plan_id join loan_schedules s on s.loan_id=l.loan_id WHERE l.loan_id=? limit 1", loanid);
            	
            	if(loan!=null ){
            %>
            	<table class="table mt-3">
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
				<tr>
					<th>Penalty</th>
					<th>&#8377; <%= loan.get("spenal") %></th>
					<th>With Penalty Amount</th>
					<th>&#8377; <%= loan.get("withpenalty") %></th>
				</tr>
			</table>
			
			<form method="post" class="mt-3" action="payemi">
			<input type="hidden" name="loan_id" value="<%= loanid %>">
				<div class="form-row form-group">
					<label class="col-sm-2">Enter Amount</label>
					<div class="col-sm-3">
						<input type="number" name="emi" min="0" value="<%= loan.get("iamount") %>" class="form-control"> 
					</div>
					<label class="col-sm-2">Penalty</label>
					<div class="col-sm-3">
						<input type="number" name="penalty" min="0" value="0" class="form-control"> 
					</div>
					<button class="btn btn-primary col-sm-2">Save Payment</button>
				</div>
			</form>
           <% 
            	}
            	else{%>
            		<h4 class="p-2 text-center text-danger">Invalid loan id given</h4>
            	<%}
            }
           %>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>