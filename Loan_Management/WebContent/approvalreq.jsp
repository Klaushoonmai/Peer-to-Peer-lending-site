<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="msg.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <h5 class="p-2" style="border-bottom: 2px solid green;">Approval Requests</h5>
            <table class="table table-bordered">
            			<thead>
            				<tr>
            					<th>#</th>
            					<th>Borrower Details</th>
            					<th>Loan Details</th>
            					<th>Status</th>
            					<th>Action</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%
            			final String sql="SELECT * FROM loan_list WHERE status=? order by id desc";
            			List<Map<String,String>> data=DbHelper.executeDQL(sql,"Unapproved");
            			for(Map<String,String> map : data) {
            				String sql2="SELECT * FROM borrowers WHERE id=?";
            				Map<String,String> user=DbHelper.executeDQLReturnSingle(sql2, map.get("borrower_id"));
            				sql2="SELECT * FROM loan_plan WHERE id=?";
            				Map<String,String> plan=DbHelper.executeDQLReturnSingle(sql2, map.get("plan_id"));
            				sql2="SELECT * FROM loan_types WHERE id=?";
            				Map<String,String> type=DbHelper.executeDQLReturnSingle(sql2, map.get("type_id"));
            			%>
            			<tr>
            			<td><%= map.get("id") %></td>
            			<td>
            			Name <span class="font-weight-bold"><%= user.get("fname") %> <%= user.get("lname") %></span><br>
            			Phone <span class="font-weight-bold"><%= user.get("phone") %></span><br>
            			Address <span class="font-weight-bold"><%= user.get("address") %></span><br>
            			</td>
            			<td>
            			Loan Type : <span class="font-weight-bold"><%= type.get("type_name") %></span><br>
            			Plan : <span class="font-weight-bold"><%= plan.get("months") %> months (<%= plan.get("perc") %>%)</span><br>
            			Purpose : <span class="font-weight-bold"><%= map.get("purpose") %></span><br>
            			Amount : <span class="font-weight-bold">&#8377; <%= map.get("amount") %></span><br>
            			</td>
            			<td><%= map.get("status") %></td>
            			<td>
            			<a onclick="return confirm('Are you sure to approve this loan ?')" href="loanstatus?id=<%= map.get("id") %>&status=A" class="btn btn-success btn-sm">Approve</a>
            			<a onclick="return confirm('Are you sure to reject this loan ?')" href="loanstatus?id=<%= map.get("id") %>&status=R" class="btn btn-danger btn-sm">Reject</a>
            			</td>
            			</tr>
            			<% } %>
            			</tbody>
            		</table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>