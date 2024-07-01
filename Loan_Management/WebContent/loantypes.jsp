<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="config.DbHelper"%>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            
            <div class="row">
            	<div class="col-sm-8">
            	<h5 class="p-2" style="border-bottom: 2px solid green;">Loan Types</h5>
            		<table class="table table-bordered">
            			<thead>
            				<tr>
            					<th>Id</th>
            					<th>Type Name</th>
            					<th>Description</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%
            			final String sql="SELECT * FROM loan_types WHERE 1=?";
            			List<Map<String,String>> data=DbHelper.executeDQL(sql,"1");
            			for(Map<String,String> map : data) {
            			%>
            			<tr>
            			<td><%= map.get("id") %></td>
            			<td><%= map.get("type_name") %></td>
            			<td><%= map.get("description") %></td>
            			</tr>
            			<% } %>
            			</tbody>
            		</table>
            	</div>
            	<div class="col-sm-4">
            		<h5 class="p-2" style="border-bottom: 2px solid green;">Add Loan Types</h5>
            		<form method="post" action="addtype">
           				<div class="form-group">
           					<label>Type Name</label>
           					<input type="text" name="typename" class="form-control">
           				</div>
           				
           				<div class="form-group">
           					<label>Description</label>
           					<input type="text" name="description" class="form-control">
           				</div>
           				
           				<button class="btn btn-primary float-right">Save Type</button>
            		</form>
            		
            	</div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>