<!-- #include file="../../connect.asp" -->
<%
    id = Request.QueryString("id")

    if (isnull(id) OR trim(id)="" OR isnull(Session("Email")) OR trim(Session("Email"))="") then
        Response.redirect("loginUser.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM tbl_ChiTietHDB WHERE MaCT=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("MaCT",3,1, ,id)

    cmdPrep.execute
    connDB.Close()

    Session("Success") = "Xóa Thành Công!"

    Response.Redirect("nguoidung.asp")
%>