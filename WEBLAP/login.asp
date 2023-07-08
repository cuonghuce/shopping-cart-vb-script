<!-- #include  file ="connect.asp" -->

<%
Dim Email , Password
Email = Request.Form("Email")
Password = Request.Form("Password")

If (NOT isnull(Email) AND NOT isnull(Password) AND TRIM(Email)<>"" AND TRIM(Password)<>"" ) Then
'true
    Dim sql
    sql = "select * from tbl_TaiKhoan where Email = ? and Password = ? "
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=Email
    cmdPrep.Parameters(1)=Password
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("Email")=result("Email")
        Session("Success")="Đăng Nhập Thành Công"
        Response.redirect("admin.asp")
    Else
        ' dang nhap ko thanh cong
        Response.Write("<script>alert('Tên đăng nhập hoặc mật khẩu không chính xác!');</script>")
    End if
    result.Close()
    
    connDB.Close()
Else
' false
    Session("check_login")="Vui lòng nhập email và password."
End if
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf8">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
            <center>
                <div class="section"></div>
                <h5 class="indigo-text">ĐĂNG NHẬP Admin</h5>
                <div class="section"></div>

                <div class="container">
                    <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
                        <form class="col s12" method="post" action="login.asp" onsubmit="return check_login()">
                            <div class='row'>
                                <div class='col s12'>
                                </div>
                            </div>
                            <div class='row'>
                                <div class='input-field col s12'>
                                    <input class='validate' type='email' name='Email' id='Email'/>
                                    <label for='email'>Enter your username  </label>
                                </div>
                            </div>

                            <div class='row'>
                                <div class='input-field col s12'>
                                    <input class='validate' type='password' name='Password' id='Password' />
                                    <label for='password'>Enter your password </label>
                                </div>
                                <label style='float: right;'>
                                    <a class='pink-text' href='#!' style="font-size:14px"><b>Forgot Password?</b></a>
                                </label>
                            </div>
                            <br/>
                            <center>
                                <div class='row'>
                                    <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect indigo'>Login</button>
                                </div>
                                <div class="alert alert-danger" role="alert" id="messageLogin" style="display:<%If Session("check_login") = -1 Then Response.Write("block") end if %>">
                                    <% 
                                        If Session("check_login") = -1 Then 
                                            Response.Write(session("message_login")) 
                                            Session("check_login") = 0
                                        end if
                                    %>
                                </div>
                            </center>
                        </form>
                    </div>
                </div>
                
            </center>
            <div class="section"></div>
            <div class="section"></div>
        </main>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
        <script type="text/javascript">
            function check_login(){
                let user = document.getElementById("Email").value;
                let pass = document.getElementById("Password").value;
                if (user.trim() === "" || pass.trim() === ""){
                    document.getElementById("messageLogin").innerHTML = "Vui lòng điền đầy đủ thông tin đăng nhập.";
                    document.getElementById("messageLogin").style.display = "block";
                    return false;
                }else {
                    return true;
                }
            }
        </script>
    </body>
</html>