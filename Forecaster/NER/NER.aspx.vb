Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class NER
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()
    End Sub

    Protected Sub gvNewEmployeeRequests_OnSelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        Try
            'If frmInsert.CurrentMode = FormViewMode.Insert Then
            'Dim connectionString As String
            'connectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"

            'Dim SqlConnection As New SqlConnection(connectionString)
            'Dim sc As New SqlCommand("select givenname + ' ' + sn as IssuedBy,mail as Email from vwEmployees where 'LCLMTL\' + sAMAccountName = '" & Session("Username") & "'", SqlConnection)
            'SqlConnection.Open()

            'Dim reader As SqlDataReader = sc.ExecuteReader()
            'reader.Read()
            'Session("IssuedBy") = reader.GetString(0)
            'Session("Email") = reader.GetString(1)
            'reader.Close()

            'CType(frmInsert.FindControl("IssuedByTextbox"), TextBox).Text = Session("IssuedBy")
            'CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text = Session("Email")
            'End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
            Dim SqlConnection As New SqlConnection(connectionString)
            SqlConnection.Open()

            Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim managerEmail As String = reader.GetString(0)
            reader.Close()

            'Copy the files
            Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\NewEmployeeRequest\Ner" & Session("ID") & "\"
            System.IO.Directory.CreateDirectory(savePath)

            If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
                CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
                Dim updatecommand As New SqlCommand("update tblNewEmployeeRequest set AttachmentSheetLink = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where NERID = " & Session("ID"), SqlConnection)
                updatecommand.ExecuteNonQuery()
            End If

            Dim body As String = "Manager: " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Name: " & CType(frmInsert.FindControl("NameTextBox"), TextBox).Text & vbCrLf & _
                                 "Employee Type: " & CType(frmInsert.FindControl("EmployeeTypeDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Date Needed:" & CType(frmInsert.FindControl("DateNeededTextBox"), TextBox).Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/NER/NERManager.aspx to see it!"
            Dim mm As New MailMessage("NER@Laurentide.com", "NER@laurentide.com", "New Employee request: " & Session("ID") & " issued by " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text, body)
            Dim mailaddress As New MailAddress(managerEmail)
            mm.CC.Add(mailaddress)
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            'smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewreq();", True)

            'update gridview
            Me.gvNewEmployeeRequests.DataBind()
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
            Dim SqlConnection As New SqlConnection(connectionString)
            SqlConnection.Open()

            Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim managerEmail As String = reader.GetString(0)
            reader.Close()

            Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\NewEmployeeRequest\Ner" & Session("ID") & "\"
            System.IO.Directory.CreateDirectory(savePath)

            If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
                CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
                Dim updatecommand As New SqlCommand("update tblNewEmployeeRequest set AttachmentSheetLink = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where NERID = " & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text, SqlConnection)
                updatecommand.ExecuteNonQuery()
            End If

            Dim body As String = "Manager: " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Name: " & CType(frmInsert.FindControl("NameTextBox"), TextBox).Text & vbCrLf & _
                                 "Employee Type: " & CType(frmInsert.FindControl("EmployeeTypeDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Date Needed:" & CType(frmInsert.FindControl("DateNeededTextBox"), TextBox).Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/NER/NERManager.aspx to see it!"
            Dim mm As New MailMessage("NER@Laurentide.com", "NER@laurentide.com", "Updated NER: " & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text & " issued by " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text, body)
            Dim mailaddress As New MailAddress(managerEmail)
            mm.CC.Add(mailaddress)
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            'smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewreq();", True)

            'update gridview
            Me.gvNewEmployeeRequests.DataBind()
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub
End Class