Public Class Sp_ProductCode
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("User") = Me.User.Identity.Name.ToString
        'Session("User") = "lclmtl\AndreA"
    End Sub

    Dim lastcategoryNameValue As String = Nothing
    Dim lastApprovedValue As String = Nothing
    Protected Function AddGroupingRowIfcategoryHasChanged() As String
        'Get the data field value of interest for this row
        Dim currentcategoryNameValue As String = Eval("ProductCategory").ToString()
        Dim currentApprovedValue As String = IIf(Eval("Approved").ToString(), "Approved", "Not Approved")

        'Specify name to display if dataFieldValue is a database NULL
        If currentcategoryNameValue.Length = 0 Then
            currentcategoryNameValue = "Unknown"
        End If

        'See if there's been a change in value
        If lastcategoryNameValue <> currentcategoryNameValue Or lastApprovedValue <> currentApprovedValue Then
            'There's been a change! Record the change and emit the table row
            lastcategoryNameValue = currentcategoryNameValue
            lastApprovedValue = currentApprovedValue

            Return String.Format("<tr class=""group""><td colspan=""9"">Category: {0} - Budget Status: {1} </td></tr>", currentcategoryNameValue, currentApprovedValue)
        Else
            'No change, return an empty string
            Return String.Empty
        End If
    End Function

End Class