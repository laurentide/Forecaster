Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class SafetyMgmt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()

    End Sub


    Protected Sub gvSafetyCases_SelectedIndexChanged1(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
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

        Dim body As String = "Status: " & CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                             "Assigned to: " & CType(frmInsert.FindControl("SaLtMemberDropDown"), DropDownList).SelectedItem.Text
        Dim mm As New MailMessage(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text, "ddnguyen@laurentide.com", "The safety case #" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " was updated!", body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
        mm.CC.Add(managerEmail)
        mm.CC.Add(mailaddress)
        Dim smtp As New SmtpClient("lcl-exc")
        smtp.Send(mm)
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        'update gridview
        Me.gvSafetyCases.DataBind()
    End Sub
End Class