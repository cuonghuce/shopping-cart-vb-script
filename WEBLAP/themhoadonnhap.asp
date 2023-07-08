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
            cmdPrep.CommandText = "SELECT * FROM tbl_HoaDonNhap WHERE MaHoaDN=?"
            
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                mancc = Result("MaNCC")
                masp = Result("MaSP")
                tensp = Result("TenSP")
                dongianhap = Result("DonGiaNhap")
                soluongnhap = Result("SoLuongNhap")
                ngaynhap = Result("NgayNhap")
            End If 
            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        mancc = Request.form("MaNCC")
        masp= Request.form("MaSP")
        tensp = Request.form("TenSP")
        dongianhap = Request.form("DonGiaNhap")
        soluongnhap = Request.form("SoLuongNhap")
        ngaynhap = Request.form("NgayNhap")
        

        if (isnull (id) OR trim(id) = "") then id=0 end if

            if (NOT isnull(mancc) and mancc<>"" and NOT isnull(masp) and masp<>"" and NOT isnull(tensp) and tensp<>"" and NOT isnull(dongianhap) and dongianhap<>"" and NOT isnull(soluongnhap) and soluongnhap<>"" and NOT isnull(ngaynhap) and ngaynhap<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO tbl_HoaDonNhap (MaNCC,MaSP,TenSP,DonGiaNhap,SoLuongNhap,NgayNhap) VALUES(?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("mancc",202,1,255,MaNCC)
                cmdPrep.parameters.Append cmdPrep.createParameter("masp",202,1,255,MaSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("tensp",202,1,255,TenSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("dongianhap",202,1,255,DonGiaNhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluongnhap",202,1,255,SoLuongNhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("ngaynhap",202,1,255,NgayNhap)

                cmdPrep.execute
                Session("Success") = "Thêm hóa đơn thành công"
                Response.redirect("hoadonnhap.asp")
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
                    <label for="mancc" class="form-label">Mã nhà cung cấp</label><br>
                    
                    <select id="mancc" name="mancc" class="form-control"  >
                        <option >---Chọn---</option>               
                        <%
                            Dim sqlString, rs
                            sqlString = "Select * from tbl_NhaCC"
                            connDB.Open()
                            set rs = connDB.execute(sqlString)                    
                        %>
                        <% 
                            Do While NOT rs.Eof
                        %>

                            <option value="<%=rs("MaNCC")%>"><%=rs("MaNCC")%></option>
                        <%  
                            rs.movenext
                            loop
                            rs.close()
                            set rs = nothing
                        %>
                    </select>
                    
                </div>
                <div class="mb-3">
                    <label for="masp" class="form-label">Mã sản phẩm</label><br>
                    
                    <input type="text" class="form-control" id="masp" name="masp" value="<%=masp%>">
                    
                </div>
                <div class="mb-3">
                    <label for="tensp" class="form-label">Tên Sản Phẩm</label><br>
                    <input type="text" class="form-control" id="tensp" name="tensp" value="<%=tensp%>">
                    
                    
                </div>
                <div class="mb-3">
                    <label for="dongianhap" class="form-label">Đơn Giá Nhập</label>
                    <input type="text" class="form-control" id="dongianhap" name="dongianhap" value="<%=dongianhap%>">
                </div>
                
                <div class="mb-3">
                    <label for="soluongnhap" class="form-label">Số Lượng</label>
                    <input type="text" class="form-control" id="soluongnhap" name="soluongnhap" value="<%=soluongnhap%>">
                </div>
                <div class="mb-3">
                    <label for="ngaynhap" class="form-label">Ngày Nhập</label><br>
                    <input type="date" class="form-control" id="ngaynhap" name="ngaynhap" value="<%=ngaynhap%>">
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">
                    Add
                    </button>
                    <a href="hoadonnhap.asp" class="btn btn-info">Cancel</a>
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
        dongia = document.getElementById("dongia").value;
        soluong = document.getElementById("soluong").value;
        ngaynhap = document.getElementById("ngaynhap").value;
        
       

        if (dongia.trim() == "" || soluong.trim() == "" ||  ngaynhap.trim() == "" ){
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