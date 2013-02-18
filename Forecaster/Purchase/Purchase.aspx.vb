Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class Purchase
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("DateRequested") = Now()
    End Sub

    ' Date: 2/18/2013
    ' Author: Duc Duy Nguyen
    ' Sub to send email to managers
    '
    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

        Dim SqlConnection As New SqlConnection(connectionString)
        Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
        SqlConnection.Open()

        Dim reader As SqlDataReader = sc.ExecuteReader()
        reader.Read()
        Dim managerEmail As String = reader.GetString(0)
        reader.Close()

        Dim body As String = "Requested By: " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text & vbCrLf & _
                             "Item: " & CType(frmInsert.FindControl("ItemNameTextbox"), TextBox).Text & vbCrLf & _
                             "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                             "Reason: " & CType(frmInsert.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                             "Quantity: " & CType(frmInsert.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                             "Cost not to exceed: " & CType(frmInsert.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                             "Date Required: " & CType(frmInsert.FindControl("DateRequiredTextBox"), TextBox).Text & vbCrLf & _
                             "Please go to this address: http://lcl-sql2k5-s:81/Managers/PurchaseManager.aspx to approve it!"
        Dim mm As New MailMessage("ddnguyen@laurentide.com", managerEmail, "New Purchase Request by " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text, body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text)
        mm.CC.Add(mailaddress)
        Dim smtp As New SmtpClient("lcl-exc")
        smtp.Send(mm)

        'update gridview
        gvPurchaseRequests.DataBind()
    End Sub
    '
    'When selecting in gridview, put formview to edit
    '
    Protected Sub gvPurchaseRequests_SelectedIndexChanged1(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'update gridview
        gvPurchaseRequests.DataBind()
    End Sub
End Class