Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class Building
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()
    End Sub

    Protected Sub gvBuidingRequests_SelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        Try
            If frmInsert.CurrentMode = FormViewMode.Insert Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=Safety;Trusted_Connection=true"

                Dim SqlConnection As New SqlConnection(connectionString)
                Dim sc As New SqlCommand("select givenname + ' ' + sn as IssuedBy,mail as Email from vwEmployees where 'LCLMTL\' + sAMAccountName = '" & Session("Username") & "'", SqlConnection)
                SqlConnection.Open()

                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Session("IssuedBy") = reader.GetString(0)
                Session("Email") = reader.GetString(1)
                reader.Close()

                CType(frmInsert.FindControl("IssuedByTextbox"), TextBox).Text = Session("IssuedBy")
                CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text = Session("Email")
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
       Try
            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Additional Info: " & CType(frmInsert.FindControl("AdditionalInfoTextBox"), TextBox).Text & vbCrLf & _
                                 "Office: " & CType(frmInsert.FindControl("OfficeDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/Building/BuildingManager.aspx to see it!"
            Dim mm As New MailMessage("Concierge@Laurentide.com", "Concierge@laurentide.com", IIf(CType(frmInsert.FindControl("UrgentCheckbox"), CheckBox).Checked, "Urgent: ", "") & "New Building request issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            mm.CC.Add(mailaddress)
            Dim smtp As New SmtpClient("lcl-exc")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewreq();", True)

            'update gridview
             Me.gvBuidingRequests.DataBind
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        Try
            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Additional Info: " & CType(frmInsert.FindControl("AdditionalInfoTextBox"), TextBox).Text & vbCrLf & _
                                 "Office: " & CType(frmInsert.FindControl("OfficeDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/Building/BuildingManager.aspx to see it!"
            Dim mm As New MailMessage("Concierge@Laurentide.com", "Concierge@laurentide.com", IIf(CType(frmInsert.FindControl("UrgentCheckbox"), CheckBox).Checked, "Urgent: ", "") & "Updated building request issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            mm.CC.Add(mailaddress)
            Dim smtp As New SmtpClient("lcl-exc")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewreq();", True)

            'update gridview
            Me.gvBuidingRequests.DataBind()
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)

    End Sub
End Class