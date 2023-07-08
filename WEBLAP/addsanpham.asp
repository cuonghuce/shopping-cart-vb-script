<!-- #include file="connect.asp" -->
<%
    If (isnull(Session("Email")) OR TRIM(Session("Email")) = "") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        If (isnull(id) OR trim(id) = "") then 
            id=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM tbl_SanPham WHERE MaSP=?"
            
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                tensp = Result("TenSP")
                mota = Result("MoTa")
                mancc = Result("MaNCC")
                gianhap = Result("GiaNhap")
                giaban = Result("GiaBan")
                soluong = Result("SoLuong")
                trangthai = Result("TrangThai")
            End If 
            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        tensp = Request.form("TenSP")
        mota = Request.form("MoTa")
        mancc = Request.form("MaNCC")
        gianhap = Request.form("GiaNhap")
        giaban = Request.form("GiaBan")
        soluong = Request.form("SoLuong")
        trangthai = Request.form("TrangThai")

        if (isnull (id) OR trim(id) = "") then id=0 end if

            if (NOT isnull(tensp) and tensp<>"" and NOT isnull(mota) and mota<>"" and NOT isnull(mancc) and mancc<>"" and NOT isnull(gianhap) and gianhap<>"" and NOT isnull(giaban) and giaban<>"" and NOT isnull(soluong) and soluong<>"" and NOT isnull(trangthai) and trangthai<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO tbl_SanPham (TenSP,MoTa,MaNCC,GiaNhap,GiaBan,SoLuong,TrangThai) VALUES(?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("tensp",202,1,255,TenSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("mota",202,1,255,MoTa)
                cmdPrep.parameters.Append cmdPrep.createParameter("mancc",202,1,255,MaNCC)
                cmdPrep.parameters.Append cmdPrep.createParameter("gianhap",202,1,255,GiaNhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("giaban",202,1,255,GiaBan)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong",202,1,255,SoLuong)
                cmdPrep.parameters.Append cmdPrep.createParameter("trangthai",202,1,255,TrangThai)

                cmdPrep.execute
                Session("Success") = "Thêm sản phẩm thành công"
                Response.redirect("sanpham.asp")
            else
                Session("Error") = "Thêm không thành công"                
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
    <style>
        #messageCheck {
            display:none;
            }
    </style>
</head>
<body>
		

    
    <div class="content">
    <!-- #include file="./layouts/header.asp" -->

        <div class="container">
            <form method="post" class="form" onsubmit="return check_add_news()">
                <div class="mb-3">
                    <label for="tensp" class="form-label">Tên Sản Phẩm</label>
                    <input type="text" class="form-control" id="tensp" name="tensp" value="<%=tensp%>">
                </div>
                <div class="mb-3">
                    <label for="mota" class="form-label">Mô Tả Sản Phẩm</label>
                    <input type="text" class="form-control" id="mota" name="mota" value="<%=mota%>">
                </div>
                <div class="mb-3">
                    <label for="tenncc" class="form-label">Tên Nhà Cung Cấp</label><br>
                    
                    <select id="mancc" name="mancc" class="form-control"  >
                        <option >---Chọn nhà cung cấp---</option>               
                        <%
                            Dim sqlString, rs
                            sqlString = "Select * from tbl_NhaCC"
                            connDB.Open()
                            set rs = connDB.execute(sqlString)                    
                        %>
                        <% 
                            Do While NOT rs.Eof
                        %>

                            <option value="<%=rs("MaNCC")%>"><%=rs("TenNCC")%></option>
                        <%  
                            rs.movenext
                            loop
                            rs.close()
                            set rs = nothing
                        %>
                    </select>
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
                    Add
                    </button>
                    <a href="sanpham.asp" class="btn btn-info">Cancel</a>
                </div>


                <div class="alert alert-danger" role="alert" id="messageCheck"></div>
                
            </form>
        </div>
    </div>



    <!-- #include file="./layouts/footer.asp" -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>


<script type="text/javascript">
    function check_add_news(){
        tensp = document.getElementById("tensp").value;
        mota = document.getElementById("mota").value;
        gianhap = document.getElementById("gianhap").value;
        giaban = document.getElementById("giaban").value;
        soluong = document.getElementById("soluong").value;
       

        if (tensp.trim() == "" || mota.trim() == "" ||  gianhap.trim() == "" || giaban.trim() == "" || soluong.trim() == ""){
            document.getElementById("messageCheck").innerHTML = "Vui lòng điền đầy đủ thông tin.";
            document.getElementById("messageCheck").style.display = "block";
            return false;
        }else {
            return true;
        }
    }

    document.getElementById("year").innerHTML = new Date().getFullYear();

    window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
</script>

</body>
</html>