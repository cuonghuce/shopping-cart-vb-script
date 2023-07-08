<!--#include file="../../connect.asp"-->
<%
    tk= Session("TaiKhoan")
    connDB.Open()
    sqltk= "Select * from tbl_KhachHang where TaiKhoan='"&tk&"'"
    resulttk=connDB.execute(sqltk)
    MaKH=resulttk("MaKH")

    Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = connDB
        cmd.CommandType = 1
        cmd.Prepared = True
        cmd.CommandText = "Select * from tbl_HoaDonBan where MaKH=?"
        cmd.parameters.Append cmd.createParameter("MaKH",3,1, ,MaKH)
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
	<link rel="stylesheet" href="../../css/bootstrap.min.css">
	<link rel="stylesheet" href="../../css/all.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

	<!----css3---->
	
	<!--google fonts -->
    
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">


	<!--google material icon-->
	<link href="https://fonts.googleapis.com/css2?family=Material+Icons" rel="stylesheet">
	
	<script src="../../js/all.js"></script>

</head>

<body>


		
		<div class="body-overlay"></div>
        <header class="p-3 bg-dark text-white">
            <div class="container">
                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                    <a href="#" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                                            
                        <h5 style="margin-top:11px;" class="nav-link px-2 text-white"><img width="40" height="32" src="../../img/logo.png" class="bi me-2" /><span>Shopping</span></h5>
                        
                    </a>

                    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                        <li><a href="index.asp" class="nav-link px-2 text-secondary btn-hover">Trang Chủ</a></li>
                        <li><a href="#" class="nav-link px-2 text-white btn-hover">Sản Phẩm</a></li>
                        <li><a href="#" class="nav-link px-2 text-white btn-hover">Giới Thiệu</a></li>
                        <li><a href="#" class="nav-link px-2 text-white btn-hover">Hỗ Trợ Online</a></li>
                    </ul>

                   

                    <div class="text-end" style="display:flex;">

                        <a href="shoppingcart.asp" type="button" class="btn btn-info"><i class="fa-sharp fa-cart-shopping"></i> Giỏ Hàng</a>

                        <div class="user_link" style="font-size:30px;margin-left:10px;">
                            <a href="logoutUser.asp" class=""><i class="fa fa-user"></i> </a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
       
       
		

		
			<div id="content">

				<!------top-header-start----------->
				
			
				
				
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
                                            
                                           
                                        </div>
                                    </div>

                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col-0" >ID</th>
                                                <th scope="col-4" >Tên KH</th>
                                                <th scope="col-3">Số Lượng</th>
                                                <th scope="col-2">Tổng Tiền</th>
                                                <th scope="col-3">Actions</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                        
                                            <%
                                            do while not Curr.EOF
                                            %>
                                            <tr>
                                                <td><%=Curr("MaHoaDB")%></td>
                                                <td><%=resulttk("TenKH")%></td>
                                                <td><%=Curr("SoLuong")%></td>
                                                <td><%=Curr("TongTien")%></td>
                                                <td style="display:flex;">
                                                    
                                                    <a style="width: 40px;height: 40px;" href="chitiet.asp?id=<%=Curr("MaHoaDB")%>" class="btn btn-primary mr-2 "><i style="color: #fff;margin-top:8px;" class="fa-solid fa-eye"></i></a>

                                                </td>
                                                
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

            window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
	</script>

</body>
</html>