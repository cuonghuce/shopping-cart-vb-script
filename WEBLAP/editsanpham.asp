<!-- #include file="connect.asp" -->
<%
    If (isnull(Session("Email")) OR TRIM(Session("Email")) = "") Then
        Response.redirect("login.asp")
    End If
   connDB.Open()
   Set categoryResult = connDB.execute("Select * from tbl_NhaCC")
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        If (isnull(id) OR trim(id) = "") then 
            id=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
         
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM tbl_SanPham WHERE MaSP=?"
           
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                tensp = Result("TenSP")
               
                mancc = Result("MaNCC")
                mota = Result("MoTa")
                gianhap = Result("GiaNhap")
                giaban = Result("GiaBan")
                soluong = Result("SoLuong")
                trangthai = Result("TrangThai")

            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        tensp = Request.form("tensp")
        mancc = Request.form("mancc")
      
        mota = Request.form("mota")
        gianhap = Request.form("gianhap")
        giaban = Request.form("giaban")
        soluong = Request.form("soluong")
        trangthai = Request.form("trangthai")



        if (isnull (id) OR trim(id) = "") then id=0 end if

        
            if (NOT isnull(tensp) and tensp<>"" and NOT isnull(tenncc) and tenncc<>"" and NOT isnull(mota) and mota<>"" and NOT isnull(gianhap) and gianhap<>"" and NOT isnull(giaban) and giaban<>"" and NOT isnull(soluong) and soluong<>"" and NOT isnull(trangthai) and trangthai<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE tbl_SanPham SET TenSP=?,MaNCC=?,MoTa=?,GiaNhap=?,GiaBan=?,SoLuong=?,TrangThai=?  WHERE MaSP=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("tensp",202,1,255,tensp)
                cmdPrep.parameters.Append cmdPrep.createParameter("mancc",202,1,255,mancc)
                cmdPrep.parameters.Append cmdPrep.createParameter("mota",202,1,255,mota)
                cmdPrep.parameters.Append cmdPrep.createParameter("gianhap",202,1,255,gianhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("giaban",202,1,255,giaban)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong",202,1,255,soluong)
                cmdPrep.parameters.Append cmdPrep.createParameter("trangthai",202,1,255,trangthai)

                cmdPrep.parameters.Append cmdPrep.createParameter("MaSP",3,1, ,id)

                cmdPrep.execute
                Session("Success") = "Sửa San Pham Thành Công"
                Response.redirect("sanpham.asp") 
            else
                Session("Error") = "Sửa không thành công"
            end if
        
    End If 
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
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">

	<!----css3---->
	<link rel="stylesheet" href="css/custom.css">
    
	<!--google fonts -->
    
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">


	<!--google material icon-->
	<link href="https://fonts.googleapis.com/css2?family=Material+Icons" rel="stylesheet">
</head>
<body>
		

    
    <div class="content">
    <!-- #include file="./layouts/header.asp" -->
    
        <div class="container">
            <form class="form" method="post" onsubmit="return check_add_news()" >
                <div class="mb-3">
                    <label for="tensp" class="form-label">Tên Sản Phẩm</label>
                    <input type="text" class="form-control" id="tensp" name="tensp" value="<%=tensp%>">
                </div>
                <div class="mb-3">
                    <label for="tenncc" class="form-label">Tên Nhà Cung Cấp</label><br>
                    
                    <select id="mancc" name="mancc" class="form-control"  >
                        <%
                            if(id=0) then
                        %>
                            <option selected value="">---Chọn nhà cung cấp---</option> 
                        <%
                            else
                            ' Set temp = Server.CreateObject("ADODB.Command")
                            ' temp.ActiveConnection = connDB
                            ' temp.CommandType = 1
                            ' temp.Prepared = True
                            ' temp.CommandText="Select * from Category where CategoryID=?"
                            ' temp.parameters(0)=1
                            Set temp = connDB.execute("Select * from tbl_NhaCC where MaNCC='"&mancc&"'")
                            
                        %>
                            <option selected value="<%=temp("MaNCC")%>"><%=temp("TenNCC")%></option> 
                        <%
                            end if
                        %>
                        <%
                        Do while not categoryResult.EOF
                        %>
                        <option value="<%=categoryResult("MaNCC")%>"><%=categoryResult("TenNCC")%></option>
                        <%
                            categoryResult.MoveNext
                        Loop
                        %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="mota" class="form-label">Mô Tả Sản Phẩm</label>
                    <input type="text" class="form-control" id="mota" name="mota" value="<%=mota%>">
                </div>
                    
                <div class="mb-3">
                    <label for="gianhap" class="form-label">Giá Nhập</label>
                    <input type="text" class="form-control" id="gianhap" name="gianhap" value="<%=gianhap%>">
                </div>
                <div class="mb-3">
                    <label for="giaban" class="form-label">Giá Bán</label>
                    <input type="text" class="form-control" id="giaban" name="giaban" value="<%=giaban%>">
                </div>
                <div class="mb-3">
                    <label for="soluong" class="form-label">Số Lượng</label>
                    <input type="text" class="form-control" id="soluong" name="soluong" value="<%=soluong%>">
                </div>
                <div class="mb-3">
                    <label for="trangthai" class="form-label">Trạng Thái</label><br>
                   
                    <select id="trangthai" name="trangthai" class="form-control" aria-label="Default select example">
                        <option value="Còn">Còn</option>
                        <option value="Hết">Hết</option>
                    </select>
                </div>
                 <div class="mb-3">
                    <button type="submit" class="btn btn-primary">
                    Edit
                    </button>   
                   <%
                        connDB.Close()
                    %>
                    <a href="sanpham.asp" class="btn btn-info">Cancel</a>
                </div>
                
            </form>
        </div>
    </div>



    <!-- #include file="./layouts/footer.asp" -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script>
document.getElementById("year").innerHTML = new Date().getFullYear();
</script>


</body>
</html>