<!-- #include file="connect.asp"-->
<%
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
    
	pageSize = Request.Form("pageSize")
	If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Lấy giá trị mới của pageSize từ form
        Dim newPageSize
        newPageSize = Request.Form("pageSize")

        ' Kiểm tra nếu pageSize không rỗng
        If Not IsEmpty(newPageSize) Then
            ' Lưu giá trị mới của pageSize vào biến Session
            Session("pageSize") = newPageSize
        End If
    End If
    Dim pageSize
    pageSize = Session("pageSize")
    
    If IsEmpty(pageSize) Then
        pageSize = 5 ' Giá trị mặc định của pageSize
    End If
	inputsearch=Request.QueryString("input-search")
   
    strSQL = "SELECT COUNT(MaHoaDN) AS count FROM tbl_HoaDonNhap where TenSP  Like '%"&inputsearch&"%' "
 
 
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
	' lay ve tong so trang
    pages = Ceil(totalRows/pageSize)

    if (trim(page) = "") or (isnull(page) or page < 1) then
        page = 1
    end if
    offset = (Clng(page) * Clng(pageSize)) - Clng(pageSize)
 
	currentUrl = "hoadonnhap.asp?input-search="&inputsearch&"&"
%>

<html lang="en">

<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
	<title>Admin Web</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/all.min.css">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">

	<!----css3---->
	<link rel="stylesheet" href="css/custom.css">
	<!--google fonts -->
    
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">


	<!--google material icon-->
	<link href="https://fonts.googleapis.com/css2?family=Material+Icons" rel="stylesheet">
	
	<script src="./js/all.js"></script>

</head>

<body>


		
		<div class="body-overlay"></div>
		<!-- #include file="./layouts/sidebar.asp" -->

		
			<div id="content">

				<!------top-header-start----------->
				<!--#include file="./layouts/header.asp"-->
				
				
				<!------main-content-start----------->

				<div class="main-content">
					<div class="container">
						<%
							If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
						%>
								<div class="alert alert-success mt-2" role="alert">
									<%=Session("Success")%>
								</div>
						<%
								Session.Contents.Remove("Success")
							End If
						%>
						<%
							If (NOT IsEmpty(Session("Error")) AND NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
						%>
								<div class="alert alert-danger mt-2" role="alert">
									<%=Session("Error")%>
								</div>
						<%
								Session.Contents.Remove("Error")
							End If
						%>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="table-wrapper">
								<div class="table-title">
									<div class="row">
										<div class="col-sm-8 d-flex">
											<form method="post" id="form-pageSize" action="" name="form-pageSize"> 
													<div class="row mb-3">
													<label for="pageSize" class="p-2">Chọn :</label>
													
													<input type="number" style="width:70px;height:38px" class="form-control " id="pageSize" name="pageSize" value="<%=pageSize%>" min="1">
													
													</div>
											</form>
											<div class="d-flex col-sm-8 p-0 flex justify-content-lg-start justify-content-center" style="margin-left:30px;margin-bottom:28px">
											
												<form  method="get" class="form-inline " action="" style="justify-content: flex-end;">
													<input class="form-control mr-sm-2" name="input-search"type="search" placeholder="Search" aria-label="Search" style="min-width: 260px;">
													
													<button class="btn btn-success my-2 my-sm-0 col-0" type="submit">Search</button>
												</form> 
											</div>
										</div>
										<div class="col-sm-4 p-0 flex justify-content-lg-end justify-content-center">
											<a href="themhoadonnhap.asp" class="btn btn-success" >											
												<span>Thêm Hóa Đơn</span>
											</a>
											
										</div>
									</div>
								</div>

								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th scope="col" >ID</th>
											<th scope="col" >Mã NCC</th>
											<th scope="col">Tên SP</th>
											<th scope="col">Đơn Giá Nhập</th>
											<th scope="col">Số Lượng</th>
											<th scope="col">Ngày Nhập</th>									
											<th scope="col">Actions</th>
										</tr>
									</thead>

									<tbody>
									
										<%
											Set cmdPrep = Server.CreateObject("ADODB.Command")
											cmdPrep.ActiveConnection = connDB
											cmdPrep.CommandType = 1
											cmdPrep.Prepared = True
											cmdPrep.CommandText = "SELECT * FROM tbl_HoaDonNhap where TenSP Like '%"&inputsearch&"%' ORDER BY MaHoaDN OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
											cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
											cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , pageSize)

											Set Result = cmdPrep.execute
											do while not Result.EOF
										%>
										<tr>
											<td><%=Result("MaHoaDN")%></td>
											<td><%=Result("MaNCC")%></td>
											<td><%=Result("TenSP")%></td>
											<td><%=Result("DonGiaNhap")%></td>
											<td><%=Result("SoLuongNhap")%></td>
											<td><%=Result("NgayNhap")%></td>
											
											<td style="display:flex;">
												<a style="cursor: pointer;" data-href="deletehoadon.asp?id=<%=Result("MaHoaDN")%>" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete"><i style="color:#fff;margin-top:8px;" class="fa-solid fa-trash"></i></a>
											</td>
											
										</tr>
									<%
											Result.MoveNext
										loop
									%>

									</tbody>


								</table>
								<div class="container mt-4">
									<div class="row align-items-center">
									
									<%
										if(page=(pages-1) OR page=1) then 
									%>
										<div class="col-ms-12 col-md-5 " >Hiện Thị <%=offset+1%> Từ <%=pageSize%> / <%=totalRows%></div>
									<%
										Else
									%>
										<div class="col-ms-12 col-md-5" >Hiện Thị <%=offset+1%> Từ <%=totalRows%> / <%=totalRows%></div>
									<%
										end if
									%>
									<div class="col-ms-12 col-md-5" >
										<nav aria-label="Page navigation example">
											<div id="pagination" style="justify-content: flex-end" class="pull-right">
												<!-- #include file="pagination.asp" -->	
											</div>
										</nav>  
									</div>
								</div>

								
							</div>
							
						</div>


						
					</div>
						
						<!----delete-modal start--------->
						<div class="modal" tabindex="-1" id="confirm-delete">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">Xóa Hóa Đơn Nhập</h5>
										<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										
									</div>
									<div class="modal-body">
										<p>Bạn Chắc Chưa?</p>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
										<a class="btn btn-danger btn-delete">Delete</a>
									</div>
								</div>
							</div>
						</div>

						<!----edit-modal end--------->



<!--#include file="./layouts/footer.asp"-->
					</div>
				</div>
							
				<!------main-content-end----------->

				<!----footer-design------------->

				
			
		    </div>
	
    
	<!-------complete html----------->

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/jquery-3.3.1.slim.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>


	<script type="text/javascript">
		$(document).ready(function () {
			$(".xp-menubar").on('click', function () {
				$("#sidebar").toggleClass('active');
				$("#content").toggleClass('active');
			});

			$('.xp-menubar,.body-overlay').on('click', function () {
				$("#sidebar,.body-overlay").toggleClass('show-nav');
			});

		});
		document.getElementById("year").innerHTML = new Date().getFullYear();

		 $(function()
            {
                $('#confirm-delete').on('show.bs.modal', function(e){
                    $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
                });
            });
	</script>

</body>
</html>