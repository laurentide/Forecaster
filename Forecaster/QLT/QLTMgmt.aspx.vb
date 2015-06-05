﻿Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class QLTMgmt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()

        If ViewState("PCA") Is Nothing Then
            Dim PCAdt As DataTable = New DataTable
            PCAdt.Columns.Add("PCAID", GetType(Integer))
            PCAdt.Columns.Add("QLTID", GetType(Integer))
            PCAdt.Columns.Add("PermanentCorrectiveAction", GetType(String))
            PCAdt.Columns.Add("Timestamp", GetType(DateTime))
        End If

        If ViewState("ACA") Is Nothing Then
            Dim ACAdt As DataTable = New DataTable
            ACAdt.Columns.Add("ACAID", GetType(Integer))
            ACAdt.Columns.Add("QLTID", GetType(Integer))
            ACAdt.Columns.Add("AdditionalCorrectiveAction", GetType(String))
            ACAdt.Columns.Add("Timestamp", GetType(DateTime))
        End If

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

    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)

    End Sub

    Protected Sub gvQLT_SelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'Check if the PCA text box is empty
        If CType(frmInsert.FindControl("PermanentCorrectiveActionTextBox"), TextBox).Text IsNot "" Then
            'if they wrote then insert it into the table
            Dim PCAquery As String = "INSERT INTO [tblPermanentCorrectiveAction] ([QLTID], [PermanentCorrectiveAction], [Timestamp]) VALUES (@QLTID, @PermanentCorrectiveAction, getDate())"
            Using PCAconn As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Using PCAcomm As New SqlCommand()
                    With PCAcomm
                        .Connection = PCAconn
                        .CommandType = CommandType.Text
                        .CommandText = PCAquery
                        .Parameters.AddWithValue("@QLTID", CType(frmInsert.FindControl("IDTextbox"), Label).Text)
                        .Parameters.AddWithValue("@PermanentCorrectiveAction", CType(frmInsert.FindControl("PermanentCorrectiveActionTextBox"), TextBox).Text)
                    End With
                    PCAconn.Open()
                    PCAcomm.ExecuteNonQuery()
                End Using
            End Using
        End If

        'Check if the ACA text box is empty
        If CType(frmInsert.FindControl("AdditionalCorrectiveActionTextBox"), TextBox).Text IsNot "" Then
            'if they wrote then insert it into the table
            Dim query As String = "INSERT INTO [tblAdditionalCorrectiveAction] ([QLTID], [AdditionalCorrectiveAction], [Timestamp]) VALUES (@QLTID, @AdditionalCorrectiveAction, getDate())"
            Using conn As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Using comm As New SqlCommand()
                    With comm
                        .Connection = conn
                        .CommandType = CommandType.Text
                        .CommandText = query
                        .Parameters.AddWithValue("@QLTID", CType(frmInsert.FindControl("IDTextbox"), Label).Text)
                        .Parameters.AddWithValue("@AdditionalCorrectiveAction", CType(frmInsert.FindControl("AdditionalCorrectiveActionTextBox"), TextBox).Text)
                    End With
                    conn.Open()
                    comm.ExecuteNonQuery()
                End Using
            End Using
        End If

        'update gridview
        Me.gvQLT.DataBind()

        If CType(frmInsert.FindControl("SendEmailCheckbox"), CheckBox).Checked Then
            Try
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                SqlConnection.Open()

                Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Dim managerEmail As String = reader.GetString(0)
                reader.Close()

                Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                     "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                     "Please go to this address: http://lcl-sql2k5-s:81/QLT/QLT.aspx to see it!" & vbCrLf & _
                                     "QLT Team link: http://lcl-sql2k5-s:81/QLT/QLTMgmt.aspx to see it!"
                Dim mm As New MailMessage("QLT@Laurentide.com", "QLT@laurentide.com", "Updated Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
                Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
                mm.CC.Add(managerEmail)
                mm.CC.Add(mailaddress)
                If Not String.IsNullOrEmpty(CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text) Then
                    mm.CC.Add(CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text)
                End If
                'mm.CC.Add("QLT@laurentide.com")
                Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
                smtp.Send(mm)
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)
                'update gridview
                Me.gvQLT.DataBind()
            Catch ex As Exception
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
            End Try
        End If
    End Sub

    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        Try
            If frmInsert.CurrentMode = FormViewMode.Insert Then
                'Dim connectionString As String
                'connectionString = "Server=lcl-sql2k5-s;Database=Safety;Trusted_Connection=true"

                'Dim SqlConnection As New SqlConnection(connectionString)
                'Dim sc As New SqlCommand("select givenname + ' ' + sn as IssuedBy,mail as Email from vwEmployees where 'LCLMTL\' + sAMAccountName = '" & Session("Username") & "'", SqlConnection)
                'SqlConnection.Open()

                'Dim reader As SqlDataReader = sc.ExecuteReader()
                'reader.Read()
                ''Session("IssuedBy") = reader.GetString(0)
                ''Session("Email") = reader.GetString(1)
                'reader.Close()

            Else
                'CType(frmInsert.FindControl("IssuedByTextbox"), TextBox).Text = Session("IssuedBy")
                'CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text = Session("Email")

                'Fill PCA GridView
                Dim PCAdt As New DataTable
                Dim PCAconnectionString As String
                PCAconnectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
                Dim PCASqlConnection As New SqlConnection(PCAconnectionString)
                Dim PCAsc As New SqlCommand("select * from tblPermanentCorrectiveAction where QLTID = " & CType(frmInsert.FindControl("IDTextbox"), Label).Text, PCASqlConnection)
                PCASqlConnection.Open()
                Dim PCAda As New SqlDataAdapter(PCAsc)
                PCAda.Fill(PCAdt)
                ViewState("PCA") = PCAdt
                Dim gvPermanentCorrectiveAction As GridView
                gvPermanentCorrectiveAction = CType(frmInsert.FindControl("gvPermanentCorrectiveAction"), GridView)
                gvPermanentCorrectiveAction.DataSource = PCAdt
                gvPermanentCorrectiveAction.DataBind()

                Dim ACAdt As New DataTable
                Dim ACAconnectionString As String
                ACAconnectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
                Dim ACASqlConnection As New SqlConnection(ACAconnectionString)
                Dim ACAsc As New SqlCommand("select * from tblAdditionalCorrectiveAction where QLTID = " & CType(frmInsert.FindControl("IDTextbox"), Label).Text, ACASqlConnection)
                ACASqlConnection.Open()
                Dim ACAda As New SqlDataAdapter(ACAsc)
                ACAda.Fill(ACAdt)
                ViewState("ACA") = ACAdt
                Dim gvAdditionalCorrectiveAction As GridView
                gvAdditionalCorrectiveAction = CType(frmInsert.FindControl("gvAdditionalCorrectiveAction"), GridView)
                gvAdditionalCorrectiveAction.DataSource = ACAdt
                gvAdditionalCorrectiveAction.DataBind()

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
                If CType(frmInsert.FindControl("ImmediateActionRequiredCheckbox"), CheckBox).Checked = True Then
                    CType(frmInsert.FindControl("ImmediateActionRequiredPanel"), Panel).Visible = True
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
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
        If CType(frmInsert.FindControl("TypeDropDown"), DropDownList).SelectedValue = "8" Then
            CType(frmInsert.FindControl("TypeTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("TypeLabel"), Label).Visible = True
        Else
            CType(frmInsert.FindControl("TypeTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("TypeLabel"), Label).Visible = False
        End If
    End Sub

    Protected Sub ReassignmentDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("ReassignmentDropDown"), DropDownList).SelectedValue IsNot "" Then
            Dim selectedUser As String
            selectedUser = CType(frmInsert.FindControl("ReassignmentDropDown"), DropDownList).SelectedValue
            Dim dv As DataView = CType(sdsActiveUsers.Select(DataSourceSelectArguments.Empty), DataView)
            dv.Sort = "FullName"
            Dim rowIndex As Integer = dv.Find(selectedUser)
            CType(frmInsert.FindControl("ReassignmentUsernameTextbox"), TextBox).Text = dv(rowIndex)("mail").ToString()
            CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text = "LCLMTL\" & dv(rowIndex)("sAMAccountName").ToString()
        Else
            CType(frmInsert.FindControl("ReassignmentUsernameTextbox"), TextBox).Text = ""
            CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text = ""
        End If
    End Sub

    Protected Sub StatusDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedValue IsNot "" Then
            If CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedValue = 5 Then
                CType(frmInsert.FindControl("FollowUpDatePanel"), Panel).Visible = True
            Else
                CType(frmInsert.FindControl("FollowUpDateTextbox"), TextBox).Text = ""
                CType(frmInsert.FindControl("FollowUpDatePanel"), Panel).Visible = False
            End If
        End If
    End Sub

    Protected Sub ImmediateActionRequiredCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("ImmediateActionRequiredCheckbox"), CheckBox).Checked = True Then
            CType(frmInsert.FindControl("ImmediateActionRequiredPanel"), Panel).Visible = True
        Else
            CType(frmInsert.FindControl("ImmediateActionTextbox"), TextBox).Text = ""
            CType(frmInsert.FindControl("ImmediateActionRequiredPanel"), Panel).Visible = False
        End If
    End Sub

    Protected Sub LearningOpportunityCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        If CType(frmInsert.FindControl("LearningOpportunityCheckbox"), CheckBox).Checked = True Then
            CType(frmInsert.FindControl("LearningOpportunityPanel"), Panel).Visible = True
        Else
            CType(frmInsert.FindControl("LearningOpportunityTextbox"), TextBox).Text = ""
            CType(frmInsert.FindControl("LearningOpportunityPanel"), Panel).Visible = False
        End If
    End Sub
End Class
