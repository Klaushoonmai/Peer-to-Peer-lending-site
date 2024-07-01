<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="config.DbHelper"%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid p-2">
	<div class="card shadow" style="min-height: 90vh">
		<div class="card-body">
			<jsp:include page="msg.jsp"></jsp:include>
			<h4 class="p-2" style="border-bottom: 2px solid green;">Users</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>ID</th>
						<th>User Name</th>
						<th>Email Id</th>
						<th>Gender</th>
						<th>Password</th>
						<th>Project</th>
						<th>Role</th>
						<th>Designation</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="modal fade" id="adduser">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="adduser"
			enctype="multipart/form-data">
			<div class="modal-header">
				<h5>Add User</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">User Name</label>
					<div class="col-sm-8">
						<input type="text" name="uname" required
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
					<label class="col-sm-4">Role</label>
					<div class="col-sm-8">
						<select name="role" required class="form-control form-control-sm">
							<option value="">--- Select Role ---</option>
							<option value="M">Manager</option>
							<option value="E">Employee</option>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Project</label>
					<div class="col-sm-8">
						<select name="pid" required
							class="form-control form-control-sm">
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Password</label>
					<div class="col-sm-8">
						<input type="password" required name="pwd"
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Repeat Password</label>
					<div class="col-sm-8">
						<input type="password" required name="cpwd"
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Photo</label>
					<div class="col-sm-8">
						<input type="file" name="photo"
							class="form-control-sm form-control-file">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save User"
					class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>