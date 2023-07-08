<!--#include file="../../connect.asp"-->

<%   
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN        
        id = Request.QueryString("id")
        name = Request.form("name")
        dates = Request.form("dates")
        taikhoan = Request.form("taikhoan")
        password = Request.form("password")
        gender = Request.form("gender")
        phone = Request.form("phone")
        address = Request.form("address")
   
        if (NOT isnull(name) and name<>"" and NOT isnull(dates) and dates<>"" and NOT isnull(taikhoan) and taikhoan<>"" and NOT isnull(password) and password<>"") then
        
            Set connDB = Server.CreateObject("ADODB.Connection")
            connDB.Open "Provider=SQLOLEDB.1;Data Source=CUONG-IT;Database=Doan_2023;User Id=sa;Password=123456"
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT COUNT(*) FROM tbl_KhachHang WHERE TaiKhoan = ? or TenKH=?"
            cmdPrep.Parameters.Append cmdPrep.CreateParameter("TaiKhoan", 202, 1, 255, taikhoan)
            cmdPrep.Parameters.Append cmdPrep.CreateParameter("TenKH", 202, 1, 255, name)

            

            Set result = cmdPrep.Execute()

            if result(0) > 0 Then
                Session("Error") = "Tài Khoản đã tồn tại trong csdl"

            else
                if (NOT isnull(name) and name<>"" and NOT isnull(dates) and dates<>"" and NOT isnull(taikhoan) and taikhoan<>"" and NOT isnull(password) and password<>"") then
                
                    Set connDB = Server.CreateObject("ADODB.Connection")
                    connDB.Open "Provider=SQLOLEDB.1;Data Source=CUONG-IT;Database=Doan_2023;User Id=sa;Password=123456"
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                    
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType = 1
                    cmdPrep.Prepared = True
                    cmdPrep.CommandText = "INSERT INTO tbl_KhachHang (TenKH,NgaySinh,TaiKhoan,MatKhau,GioiTinh,SDT,DiaChi) VALUES(?,?,?,?,?,?,?)"
                    cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                    cmdPrep.parameters.Append cmdPrep.createParameter("dates",202,1,255,dates)
                    cmdPrep.parameters.Append cmdPrep.createParameter("taikhoan",202,1,255,taikhoan)
                    cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
                    cmdPrep.parameters.Append cmdPrep.createParameter("gender",202,1,255,gender)
                    cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
                    cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
                    
                    cmdPrep.execute

                   
                    
                    
                    Response.redirect("loginUser.asp")
                end if
            End If
                connDB.Close
                Set connDB = Nothing    
        Else   
            Session("Error") = "Các trường dữ liệu không được để trống!"
        End If 
    End If


     
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf8">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
        <style>
            body {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
            }

            main {
            flex: 1 0 auto;
            }

            body {
            background: #fff;
            }

            .input-field input[type=date]:focus + label,
            .input-field input[type=text]:focus + label,
            .input-field input[type=email]:focus + label,
            .input-field input[type=password]:focus + label {
            color: #e91e63;
            }

            .input-field input[type=date]:focus,
            .input-field input[type=text]:focus,
            .input-field input[type=email]:focus,
            .input-field input[type=password]:focus {
            border-bottom: 2px solid #e91e63;
            box-shadow: none;
            }

            #messageLogin{
                display:none;
            }
        </style>
    </head>

    <body>
        <div class="section"></div>
        <main>
            <div class="container">
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
                <section class="text-center">
            <!-- Background image -->
            <div class="p-5 bg-image" style="
                    background-image: url('https://mdbootstrap.com/img/new/textures/full/171.jpg');
                    height: 300px;
                    "></div>
            <!-- Background image -->

            <div class="card mx-4 mx-md-5 shadow-5-strong" style="
                    margin-top: -100px;
                    background: hsla(0, 0%, 100%, 0.8);
                    backdrop-filter: blur(30px);
                    ">
                <div class="card-body py-5 px-md-5">

                <div class="row d-flex justify-content-center">
                    <div class="col-lg-8">
                    <h2 class="fw-bold mb-5">Đăng Ký Tài Khoản</h2>
                    <form method="post" class="form" onsubmit="return check_add_news()">
                        
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="form-outline">
                                    <input type="text" id="name" name="name" class="form-control" />
                                    <label class="form-label" for="form3Example1">Tên Khách Hàng</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="form-outline">
                                    <input type="date" id="dates" name="dates" class="form-control" />
                                    <label  class="form-label" for="form3Example2">Ngày Sinh</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="form-outline">
                                    <select style="border:1px solid #9e9e9e; border-radius:3px!important;" id="gender" name="gender" class="form-control" >
                                        <option value="Nam">Nam</option>
                                        <option value="Nữ">Nữ</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                    <label style="margin-top:17px" for="form3Example2" class="form-label">Giới Tính</label><br>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="form-outline">
                                    <input type="number" id="phone" name="phone" class="form-control" />
                                    <label  class="form-label" for="form3Example2">Số Điện Thoại</label>
                                </div>
                            </div>
                        </div>
                        <!-- Email input -->
                        <div class="form-outline mb-4">
                        <input type="text" id="address" name="address" class="form-control" />
                        <label class="form-label" for="form3Example3">Địa Chỉ</label>
                        </div>
                        <div class="form-outline mb-4">
                        <input type="text" id="taikhoan" name="taikhoan" class="form-control" />
                        <label class="form-label" for="form3Example3">Tài Khoản</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline mb-4">
                        <input type="password" id="password" name="password" class="form-control" />
                        <label class="form-label" for="form3Example4">Mật Khẩu</label>
                        </div>

                        <!-- Checkbox -->
                        <div class="form-check d-flex justify-content-center mb-4">
                        <input class="form-check-input me-2" type="checkbox" value="" id="form2Example33" checked />
                        <label class="form-check-label" for="form2Example33">
                            Subscribe to our newsletter
                        </label>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" style="width:100%" class="form-outline btn btn-primary  mb-4">
                        Sign up
                        </button>

                    </form>
                    </div>
                </div>
                </div>
            </div>
            </section>
            </div>
            

            <div class="section"></div>
            <div class="section"></div>
        </main>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
        <script type="text/javascript">
            function check_login(){
                let user = document.getElementById("taikhoan").value;
                let pass = document.getElementById("Password").value;
                let num = document.getElementById("number").value;
                let name = document.getElementById("name").value;
                let retype = document.getElementById("retype_password").value;
                let address = document.getElementById("diachi").value;

                if (user.trim() === "" || pass.trim() === "" || num.trim() === "" || name.trim() === "" || retype.trim() === "" || address.trim() === ""){
                    document.getElementById("messageLogin").innerHTML = "Vui lòng điền đầy đủ thông tin .";
                    document.getElementById("messageLogin").style.display = "block";
                    return false;
                }else {
                    return true;
                }
            }

            
        </script>
    </body>
</html>