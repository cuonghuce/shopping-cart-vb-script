<!-- #include file="connect.asp" -->
<%
    id = Request.QueryString("id")

    if (isnull(id) OR trim(id)="" OR isnull(Session("Email")) OR trim(Session("Email"))="") then
        Response.redirect("login.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM tbl_NhaCC WHERE MaNCC=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("MaNCC",3,1, ,id)

    cmdPrep.execute
    connDB.Close()

    Session("Success") = "Xóa Thành Công!"


    Response.Redirect("nhacungcap.asp")
%>