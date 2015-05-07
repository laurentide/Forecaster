Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class NERManager
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()

        If Not User.IsInRole("LCLMTL\LCL_Manager") And Not User.Identity.Name = "LCLMTL\Duc-DuyN" And Not User.Identity.Name = "LCLMTL\mignoto" And Not User.Identity.Name = "LCLMTL\mcarr" Then
            'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertaccess();", True)
            Response.Redirect("~/NER/AccessDenied.aspx")
        End If
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
            If frmInsert.CurrentMode = FormViewMode.Edit Then
                If CType(frmInsert.FindControl("chkReplacement"), CheckBox).Checked = True Then
                    CType(frmInsert.FindControl("ReplacementTextBox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("lblReplacement"), Label).Visible = True
                Else
                    CType(frmInsert.FindControl("ReplacementTextBox"), TextBox).Visible = False
                    CType(frmInsert.FindControl("lblReplacement"), Label).Visible = False
                End If

                If CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Denied" Then
                    CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Text = "Reason: "
                ElseIf CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Closed" Then
                    CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Text = "Employee Name: "
                Else
                    CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = False
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = False
                End If         
                If CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 1 Then
                    CType(frmInsert.FindControl("SORDetailLabel"), Label).Text = "Internal Referal Name:"
                    CType(frmInsert.FindControl("SORDetailPanel"), Panel).Visible = True
                ElseIf CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 2 Then
                    CType(frmInsert.FindControl("SORDetailLabel"), Label).Text = "Agency Name:"
                    CType(frmInsert.FindControl("SORDetailPanel"), Panel).Visible = True
                ElseIf CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 6 Then
                    CType(frmInsert.FindControl("SORDetailLabel"), Label).Text = "Other (details):"
                    CType(frmInsert.FindControl("SORDetailPanel"), Panel).Visible = True
                ElseIf CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 7 And
                    CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedItem.Value = 7 Then
                    CType(frmInsert.FindControl("SchoolDetailLabel"), Label).Text = "School Name:"
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True
                    CType(frmInsert.FindControl("OtherSchoolLabel"), Label).Text = "School Name (other):"
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True
                ElseIf CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 8 And
                    CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedItem.Value = 7 Then
                    CType(frmInsert.FindControl("SchoolDetailLabel"), Label).Text = "School Name:"
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True
                    CType(frmInsert.FindControl("OtherSchoolLabel"), Label).Text = "School Name (other):"
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True
                ElseIf CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 7 Then
                    CType(frmInsert.FindControl("SchoolDetailLabel"), Label).Text = "School Name:"
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True
                ElseIf CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList).SelectedItem.Value = 8 Then
                    CType(frmInsert.FindControl("SchoolDetailLabel"), Label).Text = "School Name:"
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True

                End If
                UpdatePanel1.Update()
            End If
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
            Dim savePath As String = "\\lcl-fil1\directory_2000\Managers\New Employee Requests\Ner" & Session("ID") & "\"
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
                                 "Please go to this address: http://lcl-sql2k5-s:81/NER/NER.aspx to see it!" & vbCrLf
            Dim mm As New MailMessage("NER@Laurentide.com", "NER@laurentide.com", "New Employee request: " & Session("ID") & " issued by " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text, body)
            Dim mailaddress As New MailAddress(managerEmail)
            mm.CC.Add(mailaddress)
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)

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

            Dim savePath As String = "\\lcl-fil1\directory_2000\Managers\New Employee Requests\Ner" & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text & "\"
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
                                 "Please go to this address: http://lcl-sql2k5-s:81/NER/NER.aspx to see it!"
            Dim mm As New MailMessage("NER@Laurentide.com", "NER@laurentide.com", "Updated NER: " & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text & " issued by " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text, body)
            Dim mailaddress As New MailAddress(managerEmail)
            mm.CC.Add(mailaddress)
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)

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
    Protected Sub chkReplacement_CheckedChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("chkReplacement"), CheckBox).Checked = True Then
            CType(frmInsert.FindControl("ReplacementTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("lblReplacement"), Label).Visible = True
        Else
            CType(frmInsert.FindControl("ReplacementTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("lblReplacement"), Label).Visible = False
        End If
    End Sub

    Protected Sub StatusDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Denied" Then
            CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = True
            CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = True
            CType(frmInsert.FindControl("StatusReasonLabel"), Label).Text = "Reason: "
        ElseIf CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Closed" Then
            CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = True
            CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = True
            CType(frmInsert.FindControl("StatusReasonLabel"), Label).Text = "Employee Name: "
        Else
            CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = False
            CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = False
        End If
    End Sub

    Protected Sub RecruitmentDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panel As Panel
        Dim recruitmentSource As DropDownList
        Dim label As Label

        panel = CType(frmInsert.FindControl("SORDetailPanel"), Panel)
        recruitmentSource = CType(frmInsert.FindControl("RecruitmentDropDown"), DropDownList)
        label = CType(panel.FindControl("SORDetailLabel"), Label)

        Select Case recruitmentSource.SelectedValue
            Case 1
                CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                If CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = False
                    CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedValue = ""
                End If
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = False
                End If
                label.Text = "Internal Referal Name:"
                panel.Visible = True
            Case 2
                CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                If CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = False
                    CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedValue = ""
                End If
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = False
                End If
                label.Text = "Agency Name:"
                panel.Visible = True
            Case 6
                CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                If CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = False
                End If
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = False
                End If
                label.Text = "Other (details):"
                panel.Visible = True
            Case 7
                CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                If panel.Visible = True Then
                    panel.Visible = False
                End If
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True And Not CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedValue = 7 Then
                    CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = False
                End If
                CType(frmInsert.FindControl("SchoolDetailLabel"), Label).Text = "School Name:"
                CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True
            Case 8
                CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                If panel.Visible = True Then
                    panel.Visible = False
                End If
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True And Not CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedValue = 7 Then
                    CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = False
                End If
                CType(frmInsert.FindControl("SchoolDetailLabel"), Label).Text = "School Name:"
                CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True
            Case Else
                CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                    CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = False
                End If
                If CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = True Then
                    CType(frmInsert.FindControl("SchoolDetailPanel"), Panel).Visible = False
                    CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedValue = ""
                ElseIf panel.Visible = True Then
                    panel.Visible = False
                    CType(frmInsert.FindControl("SORDetailTextbox"), TextBox).Text = ""
                End If
        End Select
    End Sub

    Protected Sub SchoolDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panel As Panel
        Dim schools As DropDownList
        Dim label As Label

        panel = CType(frmInsert.FindControl("OtherSchoolPanel"), Panel)
        schools = CType(frmInsert.FindControl("SchoolDropDown"), DropDownList)
        label = CType(panel.FindControl("OtherSchoolLabel"), Label)

        Select Case schools.SelectedValue
            Case 7
                CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                label.Text = "School Name (other):"
                panel.Visible = True
            Case Else
                CType(frmInsert.FindControl("OtherSchoolTextBox"), TextBox).Text = ""
                panel.Visible = False
        End Select
    End Sub
End Class