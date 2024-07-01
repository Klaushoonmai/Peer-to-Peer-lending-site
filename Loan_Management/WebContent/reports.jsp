<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="config.DbHelper"%>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <h5 class="p-2" style="border-bottom: 2px solid green;">Reports</h5>
            <table class="table table-sm table-bordered mt-2">
				<thead>
				<tr>
					<th>Id</th>
					<th>Loan Id</th>
					<th>Penalty</th>
					<th>Paid Amount</th>
					<th>Payment Date</th>
				</tr>				
				</thead>
				<tbody>
				<%
				List<Map<String,String>> pmts=DbHelper.executeDQL("SELECT * FROM payments WHERE 1=? order by id desc", "1");
				for(Map<String,String> pmt : pmts){
				%>
				<tr>
				<td><%= pmt.get("id") %></td>
				<td><%= pmt.get("loan_id") %></td>
				<td><%= pmt.get("amount") %></td>
				<td><%= pmt.get("penalty") %></td>
				<td><%= pmt.get("date_created") %></td>
				</tr>
				<%} %>
				</tbody>
			</table>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>