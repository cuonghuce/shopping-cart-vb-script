<!-- #include file="connect.asp" -->
<!--#include file="./pure/upload.lib.asp"-->
<% Response.Charset = "ISO-8859-1"

Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execu��o de c�digo, o upload deve acontecer dentro deste tempo ou ent�o ocorre erro de limite de tempo.
Const MaxFileSize = 10240000 ' Bytes. Aqui est� configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conte�dos dos formul�rios).
If Form.State = 0 Then

	' For each Key in Form.Texts.Keys
	' 	Response.Write "Elemento: " & Key & " = " & Form.Texts.Item(Key) & "<br />"
	' Next

	For each Field in Form.Files.Items
		' # Field.Filename : Nome do Arquivo que chegou.
		' # Field.ByteArray : Dados bin�rios do arquivo, �til para subir em blobstore (MySQL).
		Field.SaveAs Server.MapPath(".") & "\upload\" & Field.FileName
        Dim filename
        filename =Field.FileName
		' Response.Write "File name: " & Field.FileName & " uploaded. <br />"
	Next
End If
%>
<%
 
    connDB.Open()
    Set categoryResult = connDB.execute("Select * from Category")
    If (isnull(Session("admin")) OR TRIM(Session("admin")) = "") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        idproduct = Request.QueryString("idproduct")
        If (isnull(idproduct) OR trim(idproduct) = "") then 
            idproduct=0 
        End if
        If (cint(idproduct)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Products WHERE ProductID=?"
            cmdPrep.Parameters(0)=idproduct
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                name = Result("ProductName")
                description = Result("Description")
                price = Result("Price")
                brand = Result("Brand")
                statuspd = Result("Status")
                category = Result("CategoryID")
                specification=Result("Specification")
                ' image = Result("image")
            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
        idproduct = Request.QueryString("idproduct")
        name = Form.Texts.Item("name")
        description = Form.Texts.Item("description")
        category = Form.Texts.Item("category")
        price = Form.Texts.Item("price")
        brand = Form.Texts.Item("brand")
        specification=Form.Texts.Item("Specification")
        statuspd = "Enable"
        
        imagesrc = "/upload/" & filename
        ' Response.write(imagesrc)
        if (isnull (idproduct) OR trim(idproduct) = "") then idproduct=0 end if

        if (cint(idproduct)=0) then
            if (NOT isnull(specification) and specification<>"" and NOT isnull(name) and name<>"" and NOT isnull(description) and description<>"" and NOT isnull(price) and price<>"" and NOT isnull(brand) and brand<>"" and NOT isnull(category) and category<>""  and NOT isnull(statuspd) and statuspd<>""and NOT isnull(filename) and filename<>"") then
                sqlcheck = "Select Count(ProductID) as countcheck from Products Where ProductName='"&name&"'"
                set resultcheck = connDB.execute(sqlcheck)
                If resultcheck("countcheck") > 0 Then 
                    Session("Error")= "product already exists. Please choose another product"
                Else
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO Products(ProductName,CategoryID,Description,Price,Image,Brand,Status,Specification) VALUES(?,?,?,?,?,?,?,?)"
                cmdPrep.parameters(0)=name
                cmdPrep.parameters(1)=category
                cmdPrep.parameters(2)=description
                cmdPrep.parameters(3)=price
                cmdPrep.parameters(4)=imagesrc
                cmdPrep.parameters(5)=brand
                cmdPrep.parameters(6)=statuspd
                cmdPrep.parameters(7)=specification

                cmdPrep.execute
                Session("Success") = "New product was added!"
                Response.redirect("productManagement.asp") 
                End if
            else
                Session("Error") = "You have to input enough info"
            end if
        else
            if (NOT isnull(specification) and specification<>"" and NOT isnull(name) and name<>"" and NOT isnull(description) and description<>"" and NOT isnull(price) and price<>"" and NOT isnull(brand) and brand<>"" and NOT isnull(category) and category<>"" and NOT isnull(statuspd) and statuspd<>"" and NOT isnull(filename) and filename<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Products SET CategoryID=?,ProductName=?,Description=?,Price=?,Image=?,Brand=?,Specification=? WHERE ProductID=?"
                cmdPrep.parameters(0)=category
                cmdPrep.parameters(1)=name
                cmdPrep.parameters(2)=description
                cmdPrep.parameters(3)=price
                cmdPrep.parameters(4)=imagesrc
                cmdPrep.parameters(5)=brand
                cmdPrep.parameters(6)=specification
                cmdPrep.parameters(7)=idproduct

                cmdPrep.execute
                Session("Success") = "The product was edited!"
                Response.redirect("productManagement.asp") 
            else
                Session("Error") = "You have to input enough info"
            end if
        end if
    End If    
%>
<!-- #include file="./layout/header.asp" -->

        <div class="container mt-4">
            <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <%
                                if (idproduct=0) then
                            %>
                                <div class="col-sm-6">
                                    <h1><%=Response.write("Add")%> Product</h1>
                                </div>
                                <div class="col-sm-6">
                                    <ol class="breadcrumb float-sm-right">
                                        <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                                        <li class="breadcrumb-item active"><%=Response.write("Add")%>Product</li>
                                    </ol>
                                </div>
                            <%   
                                else 
                            %>
                                <div class="col-sm-6">
                                    <h1><%=Response.write("Edit")%> Product</h1>
                                </div>
                                <div class="col-sm-6">
                                    <ol class="breadcrumb float-sm-right">
                                        <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                                        <li class="breadcrumb-item active"><%=Response.write("Edit")%> Product</li>
                                    </ol>
                                </div>
                            <% 
                                end if 
                            %>
                        </div>
                    </div>
                </section>
        </div>
        <div class="container mb-5">
            <form method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="name" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
                </div>
                <div class="input-group mb-3">
                    <label for="category" class="form-label">Category Name</label>
                    <select class="form-control" id="categoryname" name="category" style="width:100%">
                        <%
                            if(idproduct=0) then
                        %>
                            <option selected value="">Choose...</option> 
                        <%
                            else
                            ' Set temp = Server.CreateObject("ADODB.Command")
                            ' temp.ActiveConnection = connDB
                            ' temp.CommandType = 1
                            ' temp.Prepared = True
                            ' temp.CommandText="Select * from Category where CategoryID=?"
                            ' temp.parameters(0)=1
                            Set temp = connDB.execute("Select * from Category where CategoryID="&category&"")
                            
                        %>
                            <option selected value="<%=temp("CategoryID")%>"><%=temp("CategoryName")%></option> 
                        <%
                            end if
                        %>
                        <%
                        Do while not categoryResult.EOF
                        %>
                        <option value="<%=categoryResult("CategoryID")%>"><%=categoryResult("CategoryName")%></option>
                        <%
                            categoryResult.MoveNext
                        Loop
                        %>

                    </select>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <input type="text" class="form-control" id="description" name="description" value="<%=description%>">
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="text" class="form-control" id="price" name="price"value="<%=price%>" >
                </div>
                <div class="mb-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand"value="<%=brand%>">
                </div> 
                <div class="mb-3">
                    <label for="MoTa">Specification</label>
                    <textarea name="Specification" id="Specification" rows="10" cols="80">
                    <%=specification%>
                    </textarea>
                    <script>
                        CKEDITOR.replace( 'Specification' );
                    </script>
                </div> 
                <div class="mb-3">
                    <label for="brand" class="form-label">Image</label>
                    <div style="display:flex">
                        <input type="file" name="arquivo" multiple />
                    </div>
                </div>
                <button tyepe="submit" id="submitbutton" class="btn btn-primary">
                    <%
                        if (idproduct=0) then
                            Response.write("Add")
                        else
                            Response.write("Edit")
                        end if
                    %>
                </button>
                    <%
                        connDB.Close()
                    %>
                <a href="index.asp" class="btn btn-info">Cancel</a>           
            </form>
        </div>
      <!-- #include file="./layout/footer.asp" -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    </body>
</html>