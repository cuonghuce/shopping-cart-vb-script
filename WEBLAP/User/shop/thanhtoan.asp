<!--#include file="../../connect.asp"-->
<%
    Dim address,paymentMethod,customerID,payments
    Set mycarts = Session("mycarts")
    tk= Session("TaiKhoan")
    connDB.Open()
    sqltk= "Select * from tbl_KhachHang where TaiKhoan='"&tk&"'"
    resulttk=connDB.execute(sqltk)
    MaKH=resulttk("MaKH")
    Response.write(MaKH)
    Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs
If (NOT IsEmpty(Session("mycarts"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct =mycarts.Count    
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
    
    Set priceDetails = Server.CreateObject("Scripting.Dictionary")
    For Each key In mycarts.Keys
        Do While Not rs.EOF
            fieldValue1=rs("MaSP")
            fieldValue2=rs("GiaBan")
            if Clng(key) = clng(fieldValue1) Then
            priceDetails.Add key,fieldValue2
            End if
        rs.MoveNext
        Loop
        rs.MoveFirst
    Next
    
        On Error Resume Next '*** Error Resume ***'
        '*** Transaction Start ***'
        connDB.BeginTrans

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "INSERT INTO tbl_HoaDonBan (MaKH, SoLuong, TongTien) VALUES ("&MaKH&","&totalProduct&","&subtotal&")"
        

        cmdPrep.Execute

        Dim rsid
        Dim HDBID
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "SELECT @@IDENTITY AS ID"
        Set rsid = cmdPrep.Execute
        If Not rsid.EOF Then
            HDBID = cint(rsid("ID"))
        End If
        if(orderID<>0) then
        Response.write(HDBID)
        else
        Response.write("errror")
        end if
        rsid.Close

        

        'Thực hiện thêm chi tiết hóa đơn
        If HDBID<>0 Then
            For Each key In mycarts.Keys
                Response.write(key)
                Response.write("<br>")
                Response.write(mycarts.Item(key))
                Response.write("<br>")
                 For Each priceDetailkey In priceDetails.Keys
                    if Clng(key) = clng(priceDetailkey) Then
                    Set cmdDetail = Server.CreateObject("ADODB.Command")
                    cmdDetail.ActiveConnection = connDB
                    cmdDetail.CommandType = 1
                    cmdDetail.Prepared = True
                    cmdDetail.CommandText = "INSERT INTO tbl_ChiTietHDB (MaHoaDB,MaSP,SoLuongSP,GiaSP) VALUES (?,? ,? , ?)"
                    cmdDetail.parameters.Append cmdDetail.createParameter("MaHoaDB",3,1,,HDBID)
                    cmdDetail.parameters.Append cmdDetail.createParameter("MaSP",3,1,,key)
                    cmdDetail.parameters.Append cmdDetail.createParameter("SoLuongSP",3,1,,mycarts.Item(key))
                    cmdDetail.parameters.Append cmdDetail.createParameter("GiaSP",3,1,,priceDetails.Item(priceDetailkey))
                    cmdDetail.Execute
                    end if
                next
            Next
        End If
        If Err.Number = 0 Then
            Session("Success") = "Order was added!"
            ' Hoàn thành giao dịch
            connDB.CommitTrans
            Response.Redirect("nguoidung.asp")
        Else
            connDB.RollbackTrans
            Response.Write("Error Save (" & Err.Description & ")")
        End If

    connDB.Close
    Set connDB = Nothing

%>