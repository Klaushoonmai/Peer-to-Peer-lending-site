<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="msg.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
        <a href="" class="btn btn-success btn-sm float-right"
				data-target="#adduser" data-toggle="modal"><i class="fa fa-plus"></i>
				New Loan Application</a>
            <h5 class="p-2" style="border-bottom: 2px solid green;">Loan Applications</h5>
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
            			final String sql="SELECT * FROM loan_list WHERE 1=? order by id desc";
            			List<Map<String,String>> data=DbHelper.executeDQL(sql,"1");
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
            			<a href="" class="btn btn-primary btn-sm">Edit</a>
            			</td>
            			</tr>
            			<% } %>
            			</tbody>
            		</table>
        </div>
    </div>
</div>
<div class="modal fade" id="adduser">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="AddloanServlet.java"
			>
			<div class="modal-header">
				<h5>New Loan Application</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">Select Borrower</label>
					<div class="col-sm-8">
						<select name="bid" required
							class="form-control form-control-sm">
							<option value="">Select Borrower</option>
							<%
							List<Map<String,String>> brs=DbHelper.executeDQL("SELECT * FROM borrowers where 1=?","1");
							for(Map<String,String> mm : brs){ %>
								<option value="<%= mm.get("id") %>"><%= mm.get("fname") %> <%= mm.get("lname") %> | <%= mm.get("pan") %></option>
							<%}
							%>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Select Type</label>
					<div class="col-sm-8">
						<select name="type_id" class="form-control form-control-sm">
						<option value="">Select Type</option>
							<%
							List<Map<String,String>> types=DbHelper.executeDQL("SELECT * FROM loan_types where 1=?","1");
							for(Map<String,String> mm : types){ %>
								<option value="<%= mm.get("id") %>"><%= mm.get("type_name") %></option>
							<%}
							%>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Select Plan</label>
					<div class="col-sm-8">
						<select name="plan_id" class="form-control form-control-sm">
						<option value="">Select Plan</option>
							<%
							List<Map<String,String>> plans=DbHelper.executeDQL("SELECT * FROM loan_plan where 1=?","1");
							for(Map<String,String> mm : plans){ %>
								<option value="<%= mm.get("id") %>"><%= mm.get("months") %> months | Rate <%= mm.get("perc") %>% | Penalty <%= mm.get("penalty") %>% |</option>
							<%}
							%>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Amount</label>
					<div class="col-sm-8">
						<input type="number" name="amount" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Purpose</label>
					<div class="col-sm-8">
						<textarea required name="purpose" rows="3" class="form-control form-control-sm"></textarea>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Application"
					class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>