<%

'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=CUONG-IT;Database=Doan_2023;User Id=sa; Password=123456"
connDB.ConnectionString = strConnection
%>

