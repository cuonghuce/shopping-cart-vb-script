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
            cmdPrep.CommandText = "SELECT * FROM tbl_KhachHang WHERE MAKH=?"
           
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                name = Result("TenKH")
                dates = Result("NgaySinh")
                taikhoan = Result("TaiKhoan")
                matkhau = Result("MatKhau")
                gender = Result("GioiTinh")
                phone = Result("SDT")
                address = Result("DiaChi")
            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        name = Request.form("name")
        dates = Request.form("dates")
        taikhoan = Request.form("taikhoan")
        matkhau = Request.form("matkhau")
        gender = Request.form("gender")
        phone = Request.form("phone")
        address = Request.form("address")

        if (isnull (id) OR trim(id) = "") then id=0 end if

        
            if (NOT isnull(name) and name<>"" and NOT isnull(dates) and dates<>"" and NOT isnull(taikhoan) and taikhoan<>"" and NOT isnull(matkhau) and matkhau<>"" and NOT isnull(gender) and gender<>"" and NOT isnull(phone) and phone<>"" and NOT isnull(address) and address<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE tbl_KhachHang SET TenKH=?,NgaySinh=?,TaiKhoan=?,MatKhau=?,GioiTinh=?,SDT=?,DiaChi=? WHERE MaKH=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("dates",202,1,255,dates)
                cmdPrep.parameters.Append cmdPrep.createParameter("taikhoan",202,1,255,taikhoan)
                cmdPrep.parameters.Append cmdPrep.createParameter("matkhau",202,1,255,matkhau)
                cmdPrep.parameters.Append cmdPrep.createParameter("gender",202,1,255,gender)
                cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
                cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
                cmdPrep.parameters.Append cmdPrep.createParameter("MaKH",3,1, ,id)

                cmdPrep.execute
                Session("Success") = "Sửa Khách Hàng Thành Công"
                Response.redirect("admin.asp") 
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
    <style>
        #messageCheck{
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
                    <label for="name" class="form-label">Tên Khách</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
                </div>
                <div class="mb-3">
                    <label for="dates" class="form-label">Ngày Sinh</label>
                    <input type="date" class="form-control" id="dates" name="dates" value="<%=dates%>">
                </div>
                <div class="mb-3">
                    <label for="taikhoan" class="form-label">Tài Khoản</label>
                    <input type="text" class="form-control" id="taikhoan" name="taikhoan" value="<%=taikhoan%>">
                </div>
                 <div class="mb-3">
                    <label for="matkhau" class="form-label">Mật Khẩu</label>
                    <input type="password" class="form-control" id="matkhau" name="matkhau" value="<%=matkhau%>">
                </div>
                <div class="mb-3">
                    <label for="gender" class="form-label">Giới Tính</label>
                    <input type="text" class="form-control" id="gender" name="gender" value="<%=gender%>">
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số Điện Thoại</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="<%=phone%>">
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Địa Chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" value="<%=address%>">
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">
                        Edit
                    </button>
                    <a href="admin.asp" class="btn btn-info">Cancel</a>
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
        name = document.getElementById("name").value;
        dates = document.getElementById("dates").value;
        gender = document.getElementById("gender").value;
        phone = document.getElementById("phone").value;
        address = document.getElementById("address").value;

        
        if (name.trim() == "" || dates.trim() == "" || gender.trim() == "" || phone.trim() == "" || address.trim() == ""){
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