<!--#include file="connect.asp"-->
<%
    connDB.Open()
    
    MaHoaDB =  Request.QueryString("id")
    Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = connDB
        cmd.CommandType = 1
        cmd.Prepared = True
        cmd.CommandText = "Select * from tbl_ChiTietHDB where MaHoaDB=?"
        cmd.parameters.Append cmd.createParameter("MaHoaDB",3,1, ,MaHoaDB)
        set Curr = cmd.execute
    
    
%>

<html lang="en">

<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
	<title>Admin Web</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/all.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="css/custom.css">

	<!----css3---->
	
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
        
        <!-- #include file="./layouts/header.asp" -->
       
       
		

		
			<div id="content">

				<!------top-header-start----------->
				
				<!--#include file="./layouts/sidebar.asp"-->
			
				
				
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
					<div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrapper">
                                    <div class="table-title mt-4">
                                        <div class="row">
                                            <div class="col-sm-8 d-flex">
                                                <form method="post" id="form-pageSize" action="" name="form-pageSize"> 
                                                        <div class=" col-sm-8 mb-4 d-flex">
                                                        <label for="pageSize" class="p-2">Chọn </label>
                                                        
                                                        <input type="number" style="width:50px;height:38px" class="form-control " id="pageSize" name="pageSize" value="<%=pageSize%>" min="1">
                                                        
                                                        </div>
                                                </form>
                                                <div class="d-flex col-sm-8 p-0 flex justify-content-lg-start justify-content-center" style="margin-left:30px;margin-bottom:28px">
                                                
                                                    <form  method="get" class="form-inline " action="" style="justify-content: flex-end;">
                                                        <input class="form-control mr-sm-2" name="input-search"type="search" placeholder="Search" aria-label="Search" style="min-width: 260px;">
                                                        
                                                        <button class="btn btn-success my-2 my-sm-0 col-0" type="submit">Search</button>
                                                    </form> 
                                                </div>
                                            </div>
                                           
                                        </div>
                                    </div>

                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col-0" >ID</th>
                                                <th scope="col-4" >Mã Sản Phẩm</th>
                                                <th scope="col-3">Mã Hóa Đơn bán</th>
                                                <th scope="col-2">Số Lượng sản phẩm</th>
                                                <th scope="col-2">Giá sản phẩm</th>

                                                
                                            </tr>
                                        </thead>

                                        <tbody>
                                        
                                            <%
                                            do while not Curr.EOF
                                            %>
                                            <tr>
                                                <td><%=Curr("MaCT")%></td>
                                                <td><%=Curr("MaSP")%></td>
                                                <td><%=Curr("MaHoaDB")%></td>
                                                <td><%=Curr("SoLuongSP")%></td>
                                                <td><%=Curr("GiaSP")%></td>

                                               
                                                
                                            </tr>
                                            <%
                                                Curr.MoveNext
                                                loop
                                            %>

                                        </tbody>


                                    </table>
                                    

                                    
                                </div>
                                
                            </div>


                            
                        </div>
                    </div>
						
						<!----delete-modal start--------->
						<div class="modal" tabindex="-1" id="confirm-delete">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">Xóa Hóa Đơn Bán</h5>
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