
<%
    If (isnull(Session("Email")) OR TRIM(Session("Email")) = "") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN        
        id = Request.QueryString("id")
        tenncc = Request.form("TenNCC")
        sdt = Request.form("SDT")
        email = Request.form("Email")
        diachi = Request.form("DiaChi")
   
        if (NOT isnull(tenncc) and tenncc<>"" and NOT isnull(sdt) and sdt<>"" and NOT isnull(email) and email<>"" and NOT isnull(diachi) and diachi<>"") then
            Set connDB = Server.CreateObject("ADODB.Connection")
            connDB.Open "Provider=SQLOLEDB.1;Data Source=CUONG-IT;Database=Doan_2023;User Id=sa;Password=123456"
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT COUNT(*) FROM tbl_NhaCC WHERE TenNCC = ? or Email= ?"
            cmdPrep.Parameters.Append cmdPrep.CreateParameter("TenNCC", 202, 1, 255, tenncc)
            cmdPrep.Parameters.Append cmdPrep.CreateParameter("Email", 202, 1, 255, email)

            Set result = cmdPrep.Execute()

            if result(0) > 0 Then
                Session("Error") = "Tên nhà cung cấp hoac email đã tồn tại trong csdl"
                Response.redirect("nhacungcap.asp")

            else
                if (NOT isnull(tenncc) and tenncc<>"" and NOT isnull(sdt) and sdt<>"" and NOT isnull(email) and email<>"" and NOT isnull(diachi) and diachi<>"") then
                    Set connDB = Server.CreateObject("ADODB.Connection")
                    connDB.Open "Provider=SQLOLEDB.1;Data Source=CUONG-IT;Database=Doan_2023;User Id=sa;Password=123456"
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                    
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType = 1
                    cmdPrep.Prepared = True
                    cmdPrep.CommandText = "INSERT INTO tbl_NhaCC(TenNCC,SDT,Email,DiaChi) VALUES(?,?,?,?)"
                    cmdPrep.parameters.Append cmdPrep.createParameter("tenncc",202,1,255,TenNCC)
                    cmdPrep.parameters.Append cmdPrep.createParameter("sdt",202,1,255,SDT)
                    cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,255,Email)
                    cmdPrep.parameters.Append cmdPrep.createParameter("diachi",202,1,255,DiaChi)
                    
                    cmdPrep.execute

                    Session("Success") = "Thêm nhà cung cấp thành công"
                    
                    Response.redirect("nhacungcap.asp")
                end if
            End If
                connDB.Close
                Set connDB = Nothing    
        Else   
            Session("Error") = "Các trường dữ liệu không được để trống!"
         
        End If 
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
	<!--toastr-->
	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    
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
            <form class="form" method="post" onsubmit="return check_add_news()">
                <div class="mb-3">
                    <label for="tenncc" class="form-label">Tên Nhà Cung Cấp</label>
                    <input type="text" class="form-control" id="tenncc" name="tenncc" value="<%=tenncc%>">
                </div>
                <div class="mb-3">
                    <label for="sdt" class="form-label">Số Điện Thoại</label>
                    <input type="text" class="form-control" id="sdt" name="sdt" value="<%=sdt%>">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%=email%>">
                </div>
                <div class="mb-3">
                    <label for="diachi" class="form-label">Địa Chỉ</label>
                    <input type="text" class="form-control" id="diachi" name="diachi" value="<%=diachi%>">
                </div>
                
                
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">
                        Add
                    </button>
                    <a href="nhacungcap.asp" class="btn btn-info">Cancel</a>
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
        tenncc = document.getElementById("tenncc").value;
        sdt = document.getElementById("sdt").value;
        email = document.getElementById("email").value;
        diachi = document.getElementById("diachi").value;
        
        if (tenncc.trim() == "" || sdt.trim() == "" || email.trim() == "" || diachi.trim() == "" ){
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