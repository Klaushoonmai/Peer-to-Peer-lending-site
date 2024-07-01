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
				Add New</a>
            <h5 class="p-2" style="border-bottom: 2px solid green;">Borrowers</h5>
            <table class="table table-bordered">
            			<thead>
            				<tr>
            					<th>#</th>
            					<th>Borrower Name</th>
            					<th>Email</th>
            					<th>Phone</th>
            					<th>Address</th>
            					<th>PAN</th>
            					<th>Action</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%
            			final String sql="SELECT * FROM borrowers WHERE 1=?";
            			List<Map<String,String>> data=DbHelper.executeDQL(sql,"1");
            			for(Map<String,String> map : data) {
            			%>
            			<tr>
            			<td><%= map.get("id") %></td>
            			<td>
            			<span class="font-weight-bold"><%= map.get("fname") %> <%= map.get("lname") %></span></td>
            			<td><span class="font-weight-bold"><%= map.get("phone") %></span></td>
            			<td><span class="font-weight-bold"><%= map.get("address") %></span></td>
            			<td><span class="font-weight-bold"><%= map.get("email") %></span></td>
            			<td><span class="font-weight-bold"><%= map.get("pan") %></span>
            			</td>
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
		<form class="modal-content" method="post" action="addborrower"
			>
			<div class="modal-header">
				<h5>Add Borrower</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">First Name</label>
					<div class="col-sm-8">
						<input type="text" name="fname" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Last Name</label>
					<div class="col-sm-8">
						<input type="text" name="lname" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Email Id</label>
					<div class="col-sm-8">
						<input type="email" name="email" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Gender</label>
					<div class="col-sm-8">
						<select name="gender" class="form-control form-control-sm">
							<option value="M">Male</option>
							<option value="F">Female</option>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Date of Birth</label>
					<div class="col-sm-8">
						<input type="date" name="dob" class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Phone</label>
					<div class="col-sm-8">
						<input type="text" name="phone" maxlength="10" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Address</label>
					<div class="col-sm-8">
						<input type="text" name="address" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">PAN No</label>
					<div class="col-sm-8">
						<input type="text" name="pan" maxlength="10" required
							class="form-control form-control-sm">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Borrower"
					class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>