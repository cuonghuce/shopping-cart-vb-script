<!--#include file="../../connect.asp"-->
<%
If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) = "") Then
        Response.redirect("loginUser.asp")
End If
'lay ve danh sach product theo id trong my cart
Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs
If (NOT IsEmpty(Session("mycarts"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from tbl_SanPham where MaSP IN (" & idList &")"
	connDB.Open()
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)

  Else
    'Session empty
    statusViews = "d-block"
    statusButtons = "d-none"
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("MaSP")))) * CDbl(CStr(rs("GiaBan")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Items")
    Else
      Response.Write(" Item")
    End If
  End Sub
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carts</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

</head>
<body>
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

				<form style="margin-top:8px;" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
					<input style="height:29px;" type="search" class="form-control form-control-dark" placeholder="Search..." aria-label="Search">
				</form>

				
			</div>
		</div>
  </header>
<section class="h-100 h-custom" style="background-color: #eee;">
  <div class="container py-2 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-5">
                  <div class="d-flex justify-content-between align-items-center mb-5">
                    <h1 class="fw-bold mb-0 text-black">Giỏ Hàng</h1>
                    <h6 class="mb-0 text-muted"><%= totalProduct %> <%call defineItems(totalProduct) %></h6>
                  </div>
                  <form action="removecart.asp" method=post>
                  <hr class="my-4">
                  <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">Bạn không có sản phẩm nào được thêm vào giỏ hàng của bạn.</h5>
<%
                If (totalProduct<>0) Then
                do while not rs.EOF
                %>
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                      <img
                        src="themes/images/products/4.jpg"
                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 style="color:#0D6EFD!important;" class="text-muted"><%= rs("TenSP")%></h6>
                      <h6 class="text-black mb-0"><%= rs("MoTa")%></h6>
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                        <i class="fas fa-minus"></i>
                      </button>

                      <input id="form1" min="0" name="quantity" value="<%
                                    Dim id
                                    id  = CStr(rs("MaSP"))
                                    Response.Write(mycarts.Item(id))                                     
                                    %>" type="number"
                        class="form-control form-control-sm" />

                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                        <i class="fas fa-plus"></i>
                      </button>
                    </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0">$ <%= rs("GiaBan")%></h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                    
                      <a href="removecart.asp?id=<%= rs("MaSP")%>" class="text-muted"><i class="fas fa-times"></i></a>
                    </div>
                  </div>

                  <hr class="my-4">
<%
                rs.MoveNext
                loop
                'phuc vu cho viec update subtotal
                rs.MoveFirst
                End If
                %> 
                
                  <div class="row pt-2">
                    <h6  class="mb-0 col-lg-10 pt-3 fw-bold"><a style="color:#0D6EFD!important;" href="index.asp" class="text-body"><i
                          class="fas fa-long-arrow-alt-left me-2"></i>Quay lại cửa hàng</a></h6>
                          <input type="submit" name="update" value="Cập Nhập" class="btn btn-warning btn-block btn-lg text-white col-lg-2 <%= statusButtons %>"
                    data-mdb-ripple-color="dark"/>
                  </div>
                </form>
                </div>
              </div>
              
              <div class="col-lg-4 bg-secondary-subtle <%= statusButtons %>">
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1">Thanh Toán</h3>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-4">
                    <h5 class="text-uppercase"><%= totalProduct %> <%call defineItems(totalProduct) %></h5>
                    <h5>$ <%= subtotal%></h5>
                  </div>
                  <%
                    Dim sql,rstk
                    TaiKhoan = Session("TaiKhoan")
                    sql = "select * from tbl_KhachHang Where TaiKhoan='"&TaiKhoan&"'"
                    set rstk = connDB.execute(sql)

                  %>

                  <form class="mb-5">

                      <div class="form-outline mb-5">
                      
                          <input type="text" id="typeText" class="form-control form-control-lg"
                              siez="17" value="<%=rstk("TenKH")%>" minlength="19" maxlength="19" />
                          <label class="form-label" for="typeText">Tên Khách Hàng</label>
                      </div>

                      <div class="form-outline mb-5">
                          <input type="text" id="typeName" class="form-control form-control-lg"
                              siez="17" value="<%=rstk("NgaySinh")%>" />
                          <label class="form-label" for="typeName">Ngày Sinh</label>
                      </div>

                      <div class="row">
                          <div class="col-md-6 mb-5">
                              <div class="form-outline">
                                  <input type="text" value="<%=rstk("DiaChi")%>" id="typeExp" class="form-control form-control-lg"
                                       size="7" id="exp" minlength="7" maxlength="7" />
                                  <label class="form-label" for="typeExp">Địa Chỉ</label>
                              </div>
                          </div>
                          <div class="col-md-6 mb-5">
                              <div class="form-outline">
                                  <input type="text" id="typeText" value="<%=rstk("SDT")%>"
                                      class="form-control form-control-lg"
                                        />
                                  <label class="form-label" for="typeText">Số Điện Thoại</label>
                              </div>
                          </div>
                      </div>

                     

                     
                      <hr class="my-4">

                      <div style="background-color: #e1f5fe;" class="d-flex justify-content-between mb-5">
                        <h5 class="text-uppercase">Tổng Giá</h5>
                        <h5>$ <%= subtotal %></h5>
                      </div>
                      <div class="row">
                        <a href="thanhtoan.asp" type="button" class="btn btn-primary btn-lg"
                          data-mdb-ripple-color="dark">Tiếp Tục</a>
                      </div>
                     

                  </form>

                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" 
crossorigin="anonymous">
</script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>

</html>
