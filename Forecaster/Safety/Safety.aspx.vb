Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class Safety
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()
    End Sub

    ' Date: 5/16/2013
    ' Author: Duc Duy Nguyen
    ' Sub to send email to safety team (sst@laurentide.com)
    '
    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        Try
            'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Safety;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim managerEmail As String = reader.GetString(0)
            reader.Close()

            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Circumstances: " & CType(frmInsert.FindControl("CircumstancesTextBox"), TextBox).Text & vbCrLf & _
                                 "Victim: " & CType(frmInsert.FindControl("VictimTextBox"), TextBox).Text & vbCrLf & _
                                 "Witness: " & CType(frmInsert.FindControl("WitnessTextBox"), TextBox).Text & vbCrLf & _
                                 "Suspected Root Cause: " & CType(frmInsert.FindControl("SuspectedRootCauseTextbox"), TextBox).Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/Safety/SafetyMgmt.aspx to see it!"
            Dim mm As New MailMessage("Safety@Laurentide.com", "Safety@laurentide.com", IIf(CType(frmInsert.FindControl("UrgentCheckbox"), CheckBox).Checked, "Urgent: ", "") & "New Safety case issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            'If CType(frmInsert.FindControl("NotificationTextBox"), TextBox).Text <> "" Then
            '    Dim notifyaswell As New MailAddress(CType(frmInsert.FindControl("NotificationTextBox"), TextBox).Text)
            '    mm.CC.Add(notifyaswell)
            'End If
            mm.CC.Add(managerEmail)
            mm.CC.Add(mailaddress)
            mm.CC.Add("salt@laurentide.com")
            Dim smtp As New SmtpClient("lcl-exc")
            'smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewcase();", True)
            'update gridview
            Me.gvSafetyCases.DataBind()
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
    End Sub
    Protected Sub gvSafetyCases_SelectedIndexChanged1(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Safety;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim managerEmail As String = reader.GetString(0)
            reader.Close()

            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Circumstances: " & CType(frmInsert.FindControl("CircumstancesTextBox"), TextBox).Text & vbCrLf & _
                                 "Victim: " & CType(frmInsert.FindControl("VictimTextBox"), TextBox).Text & vbCrLf & _
                                 "Witness: " & CType(frmInsert.FindControl("WitnessTextBox"), TextBox).Text & vbCrLf & _
                                 "Suspected Root Cause: " & CType(frmInsert.FindControl("SuspectedRootCauseTextbox"), TextBox).Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/Safety/SafetyMgmt.aspx to see it!"
            Dim mm As New MailMessage(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text, "SafetyCommittee@laurentide.com", IIf(CType(frmInsert.FindControl("UrgentCheckbox"), CheckBox).Checked, "Urgent: ", "") & "New Safety case issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            'Dim strNotify As String
            'strNotify = CType(frmInsert.FindControl("NotificationTextBox"), TextBox).Text
            'If strNotify <> "" Then
            '    Dim notifyaswell As New MailAddress(CType(frmInsert.FindControl("NotificationTextBox"), TextBox).Text)
            '    mm.CC.Add(notifyaswell)
            'End If
            mm.CC.Add(managerEmail)
            mm.CC.Add(mailaddress)

            Dim smtp As New SmtpClient("lcl-exc")
            'smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
            'update gridview
            Me.gvSafetyCases.DataBind()
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
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

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub
End Class