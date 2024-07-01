<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="config.DbHelper"%>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="msg.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <div class="row">
            	<div class="col-sm-8">
            	<h5 class="p-2" style="border-bottom: 2px solid green;">Plans</h5>
            		<table class="table table-bordered">
            			<thead>
            				<tr>
            					<th>#</th>
            					<th>Plan</th>
            					<th>Action</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%
            			final String sql="SELECT * FROM loan_plan WHERE 1=?";
            			List<Map<String,String>> data=DbHelper.executeDQL(sql,"1");
            			for(Map<String,String> map : data) {
            			%>
            			<tr>
            			<td><%= map.get("id") %></td>
            			<td>
            			Duration <span class="font-weight-bold"><%= map.get("months") %> months</span><br>
            			Interest <span class="font-weight-bold"><%= map.get("perc") %>%</span><br>
            			Penalty Over Month <span class="font-weight-bold"><%= map.get("penalty") %>%</span><br>
            			</td>
            			<td>
            			<a href="" class="btn btn-primary btn-sm">Edit</a>
            			<a href="" class="btn btn-danger btn-sm">Delete</a>
            			</td>
            			</tr>
            			<% } %>
            			</tbody>
            		</table>
            	</div>
            	<div class="col-sm-4">
            		<h5 class="p-2" style="border-bottom: 2px solid green;">Add Plan</h5>
            		<form method="post" action="addplan">
           				<div class="form-group">
           					<label>Duration (months)</label>
           					<input type="number" name="months" class="form-control">
           				</div>
           				
           				<div class="form-group">
           					<label>Interest Rate (%)</label>
           					<input type="number" name="perc" class="form-control">
           				</div>
           				
           				<div class="form-group">
           					<label>Penalty Rate (%)</label>
           					<input type="number" name="penalty" class="form-control">
           				</div>
           				
           				<button class="btn btn-primary float-right">Save Plan</button>
            		</form>
            		
            	</div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>