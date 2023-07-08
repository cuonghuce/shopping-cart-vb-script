<%
Function createPagination(pages, page,currentUrl)
    Dim str, i
    str = "<ul class='pagination'>"
    ' Kiểm tra nút "Previous"
    If page > 1 Then
        str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=" & page - 1 & "'>Previous</a></li>"
    End If
    ' Hiển thị các trang
    If pages < 6 Then
        For i = 1 To pages
            str = str & "<li" 
            if(i = Clng(page)) Then
              str=str &" class='active page-item'"
            else
              str= str &" class='page-item'"
            end if 
            str=str & "><a class='page-link' href='"&currentUrl&"page=" & i & "'>" & i & "</a></li>"
        Next
    Else
        Dim startPage, endPage, gap
        startPage = page - 2
        endPage = page + 2
        If startPage < 1 Then
            startPage = 1
            endPage = 5
        ElseIf endPage > pages Then
            endPage = pages
            startPage = pages - 4
        End If
        gap = startPage - 1
        If gap >= 1 Then
            str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=1'>1</a></li>"
            If gap >= 2 Then
                str = str & "<li class='page-item'><span class='page-link'>...</span></li>"
            End If
        End If
        For i = startPage To endPage
            str = str & "<li" 
            If(i = Clng(page)) Then
            str=str &" class='active page-item'"
            else
              str =str &" class='page-item'"
            end if
              str=str & "><a class='page-link' href='"&currentUrl&"page=" & i & "'>" & i & "</a></li>"
        Next
        gap = pages - endPage
        If gap >= 1 Then
            If gap >= 2 Then
                str = str & "<li class='page-item'><span class='page-link'>...</span></li>"
            End If
            str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=" & pages & "'>" & pages & "</a></li>"
        End If
    End If
    ' Kiểm tra nút "Next"
    If Clng(page) < Clng(pages) Then
        str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=" & page + 1 & "'>Next</a></li>"
    End If
    str = str & "</ul>"
    createPagination = str
End Function


if(trim(page) = "") or (isnull(page)) then
page = 1
end if
' Gọi hàm tạo chuỗi HTML cho thanh phân trang
pagination = createPagination(pages, page,currentUrl)

' In chuỗi HTML
Response.Write pagination

%>

