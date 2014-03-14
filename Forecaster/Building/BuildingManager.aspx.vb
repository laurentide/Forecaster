Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class BuildingManager
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()
    End Sub

    Protected Sub gvBuidingRequests_SelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub


    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'Todo: Fill in assign to username and email
        Try
            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Additional Info: " & CType(frmInsert.FindControl("AdditionalInfoTextBox"), TextBox).Text & vbCrLf & _
                                 "Office: " & CType(frmInsert.FindControl("OfficeDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Status: " & CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Corrective Action: " & CType(frmInsert.FindControl("CorrectiveActionTextbox"), TextBox).Text & vbCrLf & _
                                 "Assigned To: " & CType(frmInsert.FindControl("ddlAssignments"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/Building/BuildingManager.aspx to see it!"
            Dim mm As New MailMessage("Concierge@Laurentide.com", "Concierge@laurentide.com", IIf(CType(frmInsert.FindControl("UrgentCheckbox"), CheckBox).Checked, "Urgent: ", "") & "Updated building request issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            Dim assignedaddress As New MailAddress(CType(frmInsert.FindControl("AssignToEmailTextbox"), TextBox).Text)
            mm.CC.Add(mailaddress)
            mm.CC.Add(assignedaddress)
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

    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)

    End Sub

    Protected Sub ddlAssignments_SelectedIndexChanged(sender As Object, e As EventArgs)
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Building;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select mail as Email,sAMAccountName from vwAllADUsers where fullname = '" & CType(frmInsert.FindControl("ddlAssignments"), DropDownList).SelectedItem.Text & "'", SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            CType(frmInsert.FindControl("AssignToEmailTextbox"), TextBox).Text = reader.GetString(0)
            CType(frmInsert.FindControl("AssignToUsernameTextbox"), TextBox).Text = "LCLMTL\" & reader.GetString(1)
            reader.Close()
        Catch ex As Exception

        End Try
    End Sub
End Class