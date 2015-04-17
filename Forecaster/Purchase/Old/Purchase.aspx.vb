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
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        'Copy the files
        Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\Puchase Request Tool\" & Session("ID") & "\"
        System.IO.Directory.CreateDirectory(savePath)

        If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
            CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
            Dim updatecommand As New SqlCommand("update tblPurchaseRequests set Filename = '" & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "', Path = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where PurchaseRequestID = " & Session("ID"), SqlConnection)
            updatecommand.ExecuteNonQuery()
        End If
        Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
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
                             "Please go to this address: http://lcl-sql2k5-s:81/Purchase/PurchaseManager.aspx to approve it!"
        Dim mm As New MailMessage(CType(frmInsert.FindControl("RequesterEmailTextbox"), TextBox).Text, managerEmail, "New Purchase Request by " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text, body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text)
        mm.CC.Add(mailaddress)
        Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
        smtp.Send(mm)
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
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
        'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        'Copy the files
        Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\Puchase Request Tool\" & CType(frmInsert.FindControl("IDLabel"), Label).Text & "\"
        System.IO.Directory.CreateDirectory(savePath)

        If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
            CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
            Dim updatecommand As New SqlCommand("update tblPurchaseRequests set Filename = '" & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "', Path = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where PurchaseRequestID = " & CType(frmInsert.FindControl("IDLabel"), Label).Text, SqlConnection)
            updatecommand.ExecuteNonQuery()
        End If

        Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
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
                             "Please go to this address: http://lcl-sql2k5-s:81/Purchase/PurchaseManager.aspx to review it!"
        Dim mm As New MailMessage(CType(frmInsert.FindControl("RequesterEmailTextbox"), TextBox).Text, managerEmail, "Purchase Request updated by " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text, body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text)
        mm.CC.Add(mailaddress)
        Try
            If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
                mm.Attachments.Add(New Attachment(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName))
            Else
                mm.Attachments.Add(New Attachment(CType(frmInsert.FindControl("PathTextbox"), HyperLink).Text))
            End If
        Catch ex As Exception
        End Try
        Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
        smtp.Send(mm)
        'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        'update gridview
        gvPurchaseRequests.DataBind()
    End Sub


    Sub ManagerDropDown_CustomValidation(source As Object, args As ServerValidateEventArgs)
        If CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text = CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text Then
            args.IsValid = False
        Else
            args.IsValid = True
        End If
    End Sub


    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        Try
            If frmInsert.CurrentMode = FormViewMode.Insert Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

                Dim SqlConnection As New SqlConnection(connectionString)
                Dim sc As New SqlCommand("select givenname + ' ' + sn as IssuedBy,mail as Email from vwEmployees where 'LCLMTL\' + sAMAccountName = '" & Session("Username") & "'", SqlConnection)
                SqlConnection.Open()

                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Session("IssuedBy") = reader.GetString(0)
                Session("Email") = reader.GetString(1)
                reader.Close()

                CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text = Session("IssuedBy")
                CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text = Session("Email")
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub
End Class