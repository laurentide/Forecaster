Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class SafetyMgmt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()

    End Sub


    Protected Sub gvSafetyCases_SelectedIndexChanged1(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)

    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=Safety;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\Safety Cases\" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & "\"
        System.IO.Directory.CreateDirectory(savePath)

        If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
            CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
            Dim updatecommand As New SqlCommand("update tblSafetyCases set Filename = '" & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "', Path = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where SafetyCaseID = " & CType(frmInsert.FindControl("IDTextbox"), Label).Text, SqlConnection)
            updatecommand.ExecuteNonQuery()
        End If

        Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
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
                             "Status: " & CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                             "Assigned to: " & CType(frmInsert.FindControl("SaLtMemberDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                             "To review your safety case, please go to this address: http://lcl-sql2k5-s:81/Safety/Safety.aspx" & vbCrLf & _
                             "If you are a member of the Safety Committee/SALT, please go to this address: http://lcl-sql2k5-s:81/Safety/SafetyMgmt.aspx"
        Dim mm As New MailMessage("Safety@laurentide.com", "Safety@laurentide.com", "The safety case #" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " was updated!", body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
        mm.CC.Add(managerEmail)
        mm.CC.Add(mailaddress)
        Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
        smtp.Send(mm)
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        'update gridview
        Me.gvSafetyCases.DataBind()
    End Sub

    Protected Sub RootCauseRequiredCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        Dim frm = CType(frmInsert, FormView)
        CType(frm.FindControl("RootCause"), HtmlGenericControl).Visible = IIf(CType(frm.FindControl("RootCauseRequiredCheckbox"), CheckBox).Checked, True, False)
    End Sub

    Protected Sub SaLtMemberDropDown_DataBinding(sender As Object, e As EventArgs)
        Try
            Dim SaLtMemberDropDown As DropDownList
            SaLtMemberDropDown = CType(frmInsert.FindControl("SaLtMemberDropDown"), DropDownList)
            If IsNothing(SaLtMemberDropDown.Items.FindByText(gvSafetyCases.SelectedRow.Cells(12).Text)) Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=Safety;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                SqlConnection.Open()
                Dim sc As New SqlCommand("select saltmemberid from tblsaltmembers where saltmember = '" & gvSafetyCases.SelectedRow.Cells(12).Text & "'", SqlConnection)
                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Dim ID As String = reader.GetInt32(0)
                reader.Close()
                Dim ListItem As ListItem
                ListItem = New ListItem(gvSafetyCases.SelectedRow.Cells(12).Text, ID)
                SaLtMemberDropDown.Items.Add(ListItem)
            End If
        Catch ex As Exception
            Debug.Print(ex.ToString)
        End Try
    End Sub
    Protected Sub btnFilter_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        lbStatus.ClearSelection()
    End Sub
End Class