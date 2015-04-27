Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class QLT
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()
    End Sub

    Protected Sub gvQLT_SelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub



    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        Try
            'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
            'Dim connectionString As String
            'connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
            'Dim SqlConnection As New SqlConnection(connectionString)
            'SqlConnection.Open()

            'Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
            'Dim reader As SqlDataReader = sc.ExecuteReader()
            'reader.Read()
            'Dim managerEmail As String = reader.GetString(0)
            'reader.Close()

            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/QLT/QLT.aspx to see it!" & vbCrLf & _
                                 "QLT Team link: http://lcl-sql2k5-s:81/QLT/QLTMgmt.aspx to see it!"
            Dim mm As New MailMessage("QLT@Laurentide.com", "QLT@laurentide.com", "New Quality case #:" & Session("ID") & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            'mm.CC.Add(managerEmail)
            mm.CC.Add(mailaddress)
            mm.CC.Add("QLT@laurentide.com")
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)
            'update gridview
            Me.gvQLT.DataBind()
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        Try
            'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
            'Dim connectionString As String
            'connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
            'Dim SqlConnection As New SqlConnection(connectionString)
            'SqlConnection.Open()

            'Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
            'Dim reader As SqlDataReader = sc.ExecuteReader()
            'reader.Read()
            'Dim managerEmail As String = reader.GetString(0)
            'reader.Close()

            Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                 "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Please go to this address: http://lcl-sql2k5-s:81/QLT/QLT.aspx to see it!" & vbCrLf & _
                                 "QLT Team link: http://lcl-sql2k5-s:81/QLT/QLTMgmt.aspx to see it!"
            Dim mm As New MailMessage("QLT@Laurentide.com", "QLT@laurentide.com", "Updated Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
            Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
            'mm.CC.Add(managerEmail)
            mm.CC.Add(mailaddress)
            mm.CC.Add("QLT@laurentide.com")
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)
            'update gridview
            Me.gvQLT.DataBind()
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
            Else
                If CType(frmInsert.FindControl("CorrectiveActionDropDown"), DropDownList).SelectedValue = 2 Then
                    CType(frmInsert.FindControl("CorrectiveActionTakenTextBox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("CorrectiveActionLabel"), Label).Visible = True
                Else
                    CType(frmInsert.FindControl("CorrectiveActionTakenTextBox"), TextBox).Visible = False
                    CType(frmInsert.FindControl("CorrectiveActionLabel"), Label).Visible = False
                End If
                If CType(frmInsert.FindControl("TypeDropDown"), DropDownList).SelectedValue = 8 Then
                    CType(frmInsert.FindControl("TypeTextBox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("TypeLabel"), Label).Visible = True
                Else
                    CType(frmInsert.FindControl("TypeTextBox"), TextBox).Visible = False
                    CType(frmInsert.FindControl("TypeLabel"), Label).Visible = False

                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    <System.Web.Script.Services.ScriptMethod(), _
    System.Web.Services.WebMethod()> _
    Public Shared Function GetCompletionList(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        Dim sc As New SqlCommand("select rtrim(cacstx) + ' - ' + rtrim(convert(varchar,cazxnb)) as cacstx from Nomis.S1018252.NOMDBF95.CUSPHY01 where cacstx like '%" & prefixText & "%' and cafesu = 'A' and caaqnb = '1'", SqlConnection)
        Dim reader As SqlDataReader = sc.ExecuteReader()
        Dim customers As List(Of String) = New List(Of String)
        While reader.Read
            customers.Add(reader("cacstx").ToString)
        End While
        SqlConnection.Close()
        Return customers
    End Function

    <System.Web.Script.Services.ScriptMethod(), _
System.Web.Services.WebMethod()> _
    Public Shared Function GetCompletionList_Vendor(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        Dim sc As New SqlCommand("select rtrim(lrrktx) + ' - ' + rtrim(lrrccd) as lrrktx from Nomis.S1018252.NOMDBF95.VENPHY01 where lrrktx like '%" & prefixText & "%' and lrfesu = 'A'", SqlConnection)
        Dim reader As SqlDataReader = sc.ExecuteReader()
        Dim customers As List(Of String) = New List(Of String)
        While reader.Read
            customers.Add(reader("lrrktx").ToString)
        End While
        SqlConnection.Close()
        Return customers
    End Function

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        'Dim ID As Integer = e.Command.Parameters("@ID").Value
        'Session("ID") = ID
    End Sub

    Protected Sub CorrectiveActionDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("CorrectiveActionDropDown"), DropDownList).SelectedValue = "2" Then
            CType(frmInsert.FindControl("CorrectiveActionTakenTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("CorrectiveActionLabel"), Label).Visible = True
        Else
            CType(frmInsert.FindControl("CorrectiveActionTakenTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("CorrectiveActionLabel"), Label).Visible = False
        End If
    End Sub

    Protected Sub TypeDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("TypeDropDown"), DropDownList).SelectedValue = "8"  Then
            CType(frmInsert.FindControl("TypeTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("TypeLabel"), Label).Visible = True
        Else
            CType(frmInsert.FindControl("TypeTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("TypeLabel"), Label).Visible = False
        End If
    End Sub
End Class