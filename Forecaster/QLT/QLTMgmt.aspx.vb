﻿Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class QLTMgmt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Dim un As String = Session("Username")
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()

        'and (@ManagerDomainUser in (select QLTMemberUserName from tblQLTMembers) or ReassignmentUsername = @ManagerDomainUser)
        'Get user's name based on their username
        Dim sqlConnection1 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
        Dim cmd As New SqlCommand
        Dim name As String
        cmd.CommandText = "SELECT QLTMemberName FROM tblQLTMembers WHERE QLTMemberUsername = '" + Session("Username") + "'"
        cmd.CommandType = CommandType.Text
        cmd.Connection = sqlConnection1
        sqlConnection1.Open()
        name = cmd.ExecuteScalar()
        sqlConnection1.Close()

        Dim sqlConnection2 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
        Dim cmd2 As New SqlCommand
        Dim memberID As String
        cmd.CommandText = "SELECT QLTMemberID FROM tblQLTMembers WHERE QLTMemberUsername = '" + Session("Username") + "'"
        cmd.CommandType = CommandType.Text
        cmd.Connection = sqlConnection1
        sqlConnection1.Open()
        memberID = cmd.ExecuteScalar()
        sqlConnection1.Close()

        Dim sqlConnection3 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
        Dim cmd3 As New SqlCommand
        Dim reassignmentName As String
        cmd3.CommandText = "SELECT Reassignment FROM tblQLT WHERE ReassignmentEmail = '" + Session("Username") + "'"
        cmd3.CommandType = CommandType.Text
        cmd3.Connection = sqlConnection3
        sqlConnection3.Open()
        reassignmentName = cmd3.ExecuteScalar()
        sqlConnection3.Close()

        Dim sqlConnection4 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
        Dim cmd4 As New SqlCommand
        Dim managerName As String
        cmd4.CommandText = "SELECT ManagerName FROM tblManagers WHERE ManagerDomainUser = '" + Session("Username") + "'"
        cmd4.CommandType = CommandType.Text
        cmd4.Connection = sqlConnection4
        sqlConnection4.Open()
        managerName = cmd4.ExecuteScalar()
        sqlConnection4.Close()

        Dim sqlConnection5 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
        Dim cmd5 As New SqlCommand
        Dim managerID As String
        cmd5.CommandText = "SELECT ManagerID FROM tblManagers WHERE ManagerDomainUser = '" + Session("Username") + "'"
        cmd5.CommandType = CommandType.Text
        cmd5.Connection = sqlConnection5
        sqlConnection5.Open()
        managerID = cmd5.ExecuteScalar()
        sqlConnection5.Close()

        If (name = "" Or memberID = "") Then
            'If (reassignmentName = "") Then
            'Response.Redirect("~/MasterActionItemTool/AccessDenied.aspx")
            If (managerName = "" Or managerID = "") Then
                Response.Redirect("~/MasterActionItemTool/AccessDenied.aspx")
            End If
            'End If
            Session("QLTMember") = False
        Else
            Session("QLTMember") = True
        End If
        If (managerName = "" Or managerID = "") Then
            Session("Manager") = False
        Else
            Session("Manager") = True
        End If

        Dim queryString As String = "SELECT *,customerid as CustomerName,vendorid as VendorName,left(description,50) as ShortDescription, case when tbltypes.type = 'Other' and tblQLT.Type is not null then tblQLT.Type else tblTypes.Type end as category FROM tblQLT LEFT JOIN tblEventTypes on  tblQLT.EventTypeID = tblEventTypes.EventTypeID LEFT JOIN tblStatus on tblQLT.StatusID = tblStatus.StatusID LEFT JOIN tblOrigins on tblQLT.OriginID = tblOrigins.OriginID LEFT JOIN tblQLTMembers on tblQLT.AssignedTo = tblQLTMembers.QLTMemberID LEFT JOIN tblManagers on tblQLT.ManagerID = tblManagers.ManagerID LEFT JOIN tblTypes on tblQLT.TypeID = tblTypes.TypeID where Visible = 1 and (tblQLT.AssignedTo = @AssignedTo or @AssignedTo = 0) and (tblQLT.StatusID = @StatusID or @StatusID = 0) and (tblQLT.DepartmentID = @DeptID or @DeptID = 0) and (tblQLT.TypeID = @TypeID or @TypeID = 0) Order by QLTID Desc"
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("QLTConnectionString").ConnectionString
        sdsQLTGrid.SelectCommand = queryString
        sdsQLTGrid.DataBind()

        'If (Not Page.User.IsInRole("LCLMTL\LCL_Manager")) Then
        '    Response.Redirect("~/MasterActionItemTool/AccessDenied.aspx")
        'End If

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

    Public Sub BindPCA()
        Dim gvPermanentCorrectiveAction As GridView = CType(frmInsert.FindControl("gvPermanentCorrectiveAction"), GridView)
        gvPermanentCorrectiveAction.DataSource = ViewState("PCA")
        gvPermanentCorrectiveAction.DataBind()
    End Sub

    Public Sub BindACA()
        Dim gvAdditionalCorrectiveAction As GridView = CType(frmInsert.FindControl("gvAdditionalCorrectiveAction"), GridView)
        gvAdditionalCorrectiveAction.DataSource = ViewState("ACA")
        gvAdditionalCorrectiveAction.DataBind()
    End Sub

    Protected Sub gvQLT_SelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        Try
            'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
            Dim SqlConnection As New SqlConnection(connectionString)
            SqlConnection.Open()

            Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\QLT\" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & "\"
            System.IO.Directory.CreateDirectory(savePath)

            If (CType(frmInsert.FindControl("CasehandlerfuDialog"), FileUpload).HasFile) Then
                CType(frmInsert.FindControl("CasehandlerfuDialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("CasehandlerfuDialog"), FileUpload).FileName)
                Dim updatecommand As New SqlCommand("update tblQLT set CasehandlerFilename = '" & CType(frmInsert.FindControl("CasehandlerfuDialog"), FileUpload).FileName & "', CasehandlerPath = '" & savePath & CType(frmInsert.FindControl("CasehandlerfuDialog"), FileUpload).FileName & "' where QLTID = " & CType(frmInsert.FindControl("IDTextbox"), Label).Text, SqlConnection)
                updatecommand.ExecuteNonQuery()
            End If
        Catch ex As Exception
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
        End Try
        'Check if the PCA text box is empty
        If CType(frmInsert.FindControl("PermanentCorrectiveActionTextBox"), TextBox).Text IsNot "" Then
            'if they wrote then insert it into the table
            Dim PCAquery As String = "INSERT INTO [tblPermanentCorrectiveAction] ([QLTID], [PermanentCorrectiveAction], [Timestamp], [Visible], [PostedBy]) VALUES (@QLTID, @PermanentCorrectiveAction, getDate(), 1, @PostedBy)"
            Using PCAconn As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Using PCAcomm As New SqlCommand()
                    With PCAcomm
                        .Connection = PCAconn
                        .CommandType = CommandType.Text
                        .CommandText = PCAquery
                        .Parameters.AddWithValue("@QLTID", CType(frmInsert.FindControl("IDTextbox"), Label).Text)
                        .Parameters.AddWithValue("@PermanentCorrectiveAction", CType(frmInsert.FindControl("PermanentCorrectiveActionTextBox"), TextBox).Text)
                        .Parameters.AddWithValue("@PostedBy", Me.User.Identity.Name.ToString())
                    End With
                    PCAconn.Open()
                    PCAcomm.ExecuteNonQuery()
                End Using
            End Using
        End If

        'Check if the ACA text box is empty
        If CType(frmInsert.FindControl("AdditionalCorrectiveActionTextBox"), TextBox).Text IsNot "" Then
            'if they wrote then insert it into the table
            Dim query As String = "INSERT INTO [tblAdditionalCorrectiveAction] ([QLTID], [AdditionalCorrectiveAction], [Timestamp], [Visible], [PostedBy]) VALUES (@QLTID, @AdditionalCorrectiveAction, getDate(), 1, @PostedBy)"
            Using conn As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Using comm As New SqlCommand()
                    With comm
                        .Connection = conn
                        .CommandType = CommandType.Text
                        .CommandText = query
                        .Parameters.AddWithValue("@QLTID", CType(frmInsert.FindControl("IDTextbox"), Label).Text)
                        .Parameters.AddWithValue("@AdditionalCorrectiveAction", CType(frmInsert.FindControl("AdditionalCorrectiveActionTextBox"), TextBox).Text)
                        .Parameters.AddWithValue("@PostedBy", Me.User.Identity.Name.ToString())
                    End With
                    conn.Open()
                    comm.ExecuteNonQuery()
                End Using
            End Using
        End If

        'update gridview
        Me.gvQLT.DataBind()

        If CType(frmInsert.FindControl("SendEmailCheckbox"), CheckBox).Checked And CType(frmInsert.FindControl("SendEmailOriginatorCheckbox"), CheckBox).Checked Then
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

                Dim QLTMemberID As String = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedValue.ToString
                Dim sqlConnection1 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Dim cmd As New SqlCommand
                Dim AssignedToEmail As String
                cmd.CommandText = "SELECT QLTMemberEmail FROM tblQLTMembers WHERE QLTMemberID = " + QLTMemberID + ""
                cmd.CommandType = CommandType.Text
                cmd.Connection = sqlConnection1
                sqlConnection1.Open()
                AssignedToEmail = cmd.ExecuteScalar()
                sqlConnection1.Close()

                Dim AssignedToName As String
                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    AssignedToName = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString
                Else
                    AssignedToName = "Not yet assigned"
                End If

                Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                     "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                     "Assigned To: " & AssignedToName & vbCrLf & _
                                     "Feedback To Issuer: " + CType(frmInsert.FindControl("FeedbackToIssuerTextBox"), TextBox).Text & vbCrLf & _
                                     "Please go to this address: http://lcl-sql2k5-s:81/QLT/QLT.aspx to see it!" & vbCrLf & _
                                     "QLT Team link: http://lcl-sql2k5-s:81/QLT/QLTMgmt.aspx to see it!"
                Dim mm As New MailMessage("QLT@Laurentide.com", "QLT@laurentide.com", "Updated Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
                Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
                mm.CC.Add(managerEmail)
                mm.CC.Add(mailaddress)

                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    mm.CC.Add(AssignedToEmail)
                End If

                Dim smtp As New SmtpClient("lcl-mail.adc.laurentidecontrols.com")
                smtp.Send(mm)
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)

                'update gridview
                Me.gvQLT.DataBind()
            Catch ex As Exception
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
            End Try
        ElseIf CType(frmInsert.FindControl("SendEmailCheckbox"), CheckBox).Checked Then
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

                Dim QLTMemberID As String = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedValue.ToString
                Dim sqlConnection1 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Dim cmd As New SqlCommand
                Dim AssignedToEmail As String
                cmd.CommandText = "SELECT QLTMemberEmail FROM tblQLTMembers WHERE QLTMemberID = " + QLTMemberID + ""
                cmd.CommandType = CommandType.Text
                cmd.Connection = sqlConnection1
                sqlConnection1.Open()
                AssignedToEmail = cmd.ExecuteScalar()
                sqlConnection1.Close()

                Dim AssignedToName As String
                If Not String.IsNullOrEmpty(CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text) Then
                    AssignedToName = CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text
                ElseIf Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    AssignedToName = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString
                Else
                    AssignedToName = "Not yet assigned"
                End If

                Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                     "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                     "Assigned To: " & AssignedToName & vbCrLf & _
                                     "Feedback To Issuer: " + CType(frmInsert.FindControl("FeedbackToIssuerTextBox"), TextBox).Text & vbCrLf & _
                                     "Please go to this address: http://lcl-sql2k5-s:81/QLT/QLT.aspx to see it!" & vbCrLf & _
                                     "QLT Team link: http://lcl-sql2k5-s:81/QLT/QLTMgmt.aspx to see it!"
                Dim mm As New MailMessage("QLT@Laurentide.com", "QLT@laurentide.com", "Updated Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)
                'Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
                mm.CC.Add(managerEmail)
                'mm.CC.Add(mailaddress)

                If Not String.IsNullOrEmpty(CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text) Then
                    mm.CC.Add(CType(frmInsert.FindControl("ReassignmentEmailTextbox"), TextBox).Text)
                ElseIf Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    mm.CC.Add(AssignedToEmail)
                End If
                'mm.CC.Add("QLT@laurentide.com")
                Dim smtp As New SmtpClient("lcl-mail.adc.laurentidecontrols.com")
                smtp.Send(mm)
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)
                'update gridview
                Me.gvQLT.DataBind()
            Catch ex As Exception
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alerterror();", True)
            End Try
        ElseIf CType(frmInsert.FindControl("SendEmailOriginatorCheckbox"), CheckBox).Checked Then
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

                Dim QLTMemberID As String = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedValue.ToString
                Dim sqlConnection1 As New SqlConnection("Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true")
                Dim cmd As New SqlCommand
                Dim AssignedToEmail As String
                cmd.CommandText = "SELECT QLTMemberEmail FROM tblQLTMembers WHERE QLTMemberID = " + QLTMemberID + ""
                cmd.CommandType = CommandType.Text
                cmd.Connection = sqlConnection1
                sqlConnection1.Open()
                AssignedToEmail = cmd.ExecuteScalar()
                sqlConnection1.Close()

                Dim AssignedToName As String
                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    AssignedToName = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString
                Else
                    AssignedToName = "Not yet assigned"
                End If

                Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text)
                Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                     "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                     "Assigned To: " & AssignedToName & vbCrLf & _
                                     "Feedback To Issuer: " + CType(frmInsert.FindControl("FeedbackToIssuerTextBox"), TextBox).Text & vbCrLf & _
                                     "Please go to this address: http://lcl-sql2k5-s:81/QLT/QLT.aspx to see it!" & vbCrLf & _
                                     "QLT Team link: http://lcl-sql2k5-s:81/QLT/QLTMgmt.aspx to see it!"
                Dim mm As New MailMessage("QLT@Laurentide.com", mailaddress.ToString, "Updated Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body)

                mm.CC.Add(managerEmail)

                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    mm.CC.Add(AssignedToEmail)
                End If

                Dim smtp As New SmtpClient("lcl-mail.adc.laurentidecontrols.com")
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
                Dim PCAsc As New SqlCommand("select * from tblPermanentCorrectiveAction where Visible = 1 AND QLTID = " & CType(frmInsert.FindControl("IDTextbox"), Label).Text, PCASqlConnection)
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
                Dim ACAsc As New SqlCommand("select * from tblAdditionalCorrectiveAction where Visible = 1 AND QLTID = " & CType(frmInsert.FindControl("IDTextbox"), Label).Text, ACASqlConnection)
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
                If CType(frmInsert.FindControl("LearningOpportunityCheckbox"), CheckBox).Checked = True Then
                    CType(frmInsert.FindControl("LearningOpportunityPanel"), Panel).Visible = True
                End If
            End If
            Session("Assigned") = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString

            If (Session("Manager") = True) Then
                If (Session("QLTMember") = False) Then
                    CType(frmInsert.FindControl("UpdateButton"), Button).Enabled = False
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

    Protected Sub StatusDropDown_DataBound(sender As Object, e As EventArgs)
        Dim un As String = Session("Username")
        If Not un.Equals("LCLMTL\pruvo") And Not un.Equals("LCLMTL\MichaelD") And Not un.Equals("LCLMTL\mignoto") Then
            CType(frmInsert.FindControl("StatusDropDown"), DropDownList).Items.FindByValue("6").Attributes.Add("disabled", "true")
        End If
    End Sub

    Protected Sub PSSFilterButton_Click(sender As Object, e As EventArgs)
        Dim MainContent As ContentPlaceHolder = Page.Master.FindControl("MainContent")
        Dim gvDS As SqlDataSource = CType(MainContent.FindControl("sdsQLTGrid"), SqlDataSource)
        gvDS.FilterExpression = "DepartmentID = 17 OR DepartmentID = 20 OR DepartmentID = 21"
        gvDS.DataBind()
        gvQLT.DataBind()
    End Sub

    Protected Sub ResetPSSFilterButton_Click(sender As Object, e As EventArgs)
        Dim MainContent As ContentPlaceHolder = Page.Master.FindControl("MainContent")
        Dim gvDS As SqlDataSource = CType(MainContent.FindControl("sdsQLTGrid"), SqlDataSource)
        gvDS.FilterExpression = ""
        gvDS.DataBind()
        DeptFilterDropDownList.SelectedValue = ""
        AssigneeDropDownList.SelectedValue = ""
        StatusDropDownList.SelectedValue = ""
        gvQLT.DataBind()
    End Sub

    Protected Sub DeptFilterDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim MainContent As ContentPlaceHolder = Page.Master.FindControl("MainContent")
        'Dim gvDS As SqlDataSource = CType(MainContent.FindControl("sdsQLTGrid"), SqlDataSource)
        'Dim DeptID As String = CType(MainContent.FindControl("DeptFilterDropDownList"), DropDownList).SelectedValue
        'If (DeptID IsNot String.Empty) Then
        '    gvDS.FilterExpression = gvDS.FilterExpression & " DepartmentID = " & DeptID
        '    gvDS.DataBind()
        '    gvQLT.DataBind()
        'Else
        '    gvDS.FilterExpression = ""
        '    gvDS.DataBind()
        '    gvQLT.DataBind()
        'End If
        gvQLT.DataBind()
    End Sub

    Protected Sub TypeDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        gvQLT.DataBind()
    End Sub

    Protected Sub AssigneeDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim MainContent As ContentPlaceHolder = Page.Master.FindControl("MainContent")
        'Dim gvDS As SqlDataSource = CType(MainContent.FindControl("sdsQLTGrid"), SqlDataSource)
        'Dim AssignedTo As String = CType(MainContent.FindControl("AssigneeDropDownList"), DropDownList).SelectedValue
        'If (AssignedTo IsNot String.Empty) Then
        '    gvDS.FilterExpression = gvDS.FilterExpression & " AssignedTo = " & AssignedTo
        '    gvDS.DataBind()
        '    gvQLT.DataBind()
        'Else
        '    gvDS.FilterExpression = ""
        '    gvDS.DataBind()
        '    gvQLT.DataBind()
        'End If
        gvQLT.DataBind()


    End Sub

    Protected Sub StatusDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim MainContent As ContentPlaceHolder = Page.Master.FindControl("MainContent")
        'Dim gvDS As SqlDataSource = CType(MainContent.FindControl("sdsQLTGrid"), SqlDataSource)
        'Dim StatusID As String = CType(MainContent.FindControl("StatusDropDownList"), DropDownList).SelectedValue
        'If (StatusID IsNot String.Empty) Then
        '    gvDS.FilterExpression = gvDS.FilterExpression & " StatusID = " & StatusID
        '    gvDS.DataBind()
        '    gvQLT.DataBind()
        'Else
        '    gvDS.FilterExpression = ""
        '    gvDS.DataBind()
        '    gvQLT.DataBind()
        'End If

        gvQLT.DataBind()


    End Sub

    Protected Sub frmInsert_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)
        Try
            Dim statusID As String = CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedValue 'store what the status is at the time the update begins
            If statusID = "6" Then 'If status is Resolved, send an email to ticket originator and manager 

                'Get Manager email from database
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                SqlConnection.Open()

                Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Dim managerEmail As String = reader.GetString(0)
                reader.Close()

                Dim AssignedToName As String
                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    AssignedToName = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString
                Else
                    AssignedToName = "Not yet assigned"
                End If

                Dim AssignedToEmail As String = ""
                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    Dim QLTMemberID As String = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedValue.ToString
                    Dim cmd As New SqlCommand
                    cmd.CommandText = "SELECT QLTMemberEmail FROM tblQLTMembers WHERE QLTMemberID = " + QLTMemberID + ""
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = SqlConnection
                    AssignedToEmail = cmd.ExecuteScalar()
                    SqlConnection.Close()
                End If

                Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("IssuedByEmailTextBox"), TextBox).Text) 'Get Originator email from form 
                Dim body As String = "Issued By: " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & vbCrLf & _
                                     "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                     "Assigned To: " & AssignedToName & vbCrLf & _
                                     "Quality Case #" + CType(frmInsert.FindControl("IDTextbox"), Label).Text + " has been resolved!" & vbCrLf & vbCrLf & _
                                     "Feedback To Issuer: " + CType(frmInsert.FindControl("FeedbackToIssuerTextBox"), TextBox).Text
                Dim mm As New MailMessage("QLT@Laurentide.com", mailaddress.ToString, "Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text & "has been resolved", body)

                mm.CC.Add(managerEmail)

                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    mm.CC.Add(AssignedToEmail)
                End If

                Dim smtp As New SmtpClient("lcl-mail.adc.laurentidecontrols.com")
                smtp.Send(mm)
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)
            End If
            If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString.Equals(Session("Assigned")) Then

                Dim AssignedToName As String
                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    AssignedToName = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString
                Else
                    AssignedToName = "Not yet assigned"
                End If

                Dim AssignedToEmail As String = ""

                If Not CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedItem.Text.ToString = "(Assign a QLT Member)" Then
                    Dim connectionString As String
                    connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
                    Dim SqlConnection As New SqlConnection(connectionString)
                    SqlConnection.Open()
                    Dim QLTMemberID As String = CType(frmInsert.FindControl("QLTMembersDropDown"), DropDownList).SelectedValue.ToString
                    Dim cmd As New SqlCommand
                    cmd.CommandText = "SELECT QLTMemberEmail FROM tblQLTMembers WHERE QLTMemberID = " + QLTMemberID + ""
                    cmd.CommandType = CommandType.Text
                    cmd.Connection = SqlConnection
                    AssignedToEmail = cmd.ExecuteScalar()
                    SqlConnection.Close()
                End If

                Dim body As String = "You have been assigned to Quality Case #" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & vbCrLf & _
                                     "Click here to view it: http://lcl-sql2k5-s:81/QLT/QLT.aspx"
                Dim mm As New MailMessage("QLT@Laurentide.com", AssignedToEmail.ToString, "Quality case #:" & CType(frmInsert.FindControl("IDTextbox"), Label).Text & " issued by " & CType(frmInsert.FindControl("IssuedByTextBox"), TextBox).Text, body & " has been assigned to you.")
                Dim smtp As New SmtpClient("lcl-mail.adc.laurentidecontrols.com")
                smtp.Send(mm)
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemailnewQLTcase();", True)
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub gvPermanentCorrectiveAction_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim gvPermanentCorrectiveAction As GridView = CType(frmInsert.FindControl("gvPermanentCorrectiveAction"), GridView)
        Dim dt As DataTable = ViewState("PCA")
        Dim row = gvPermanentCorrectiveAction.Rows(e.RowIndex)
        dt.Rows.RemoveAt(e.RowIndex)
        Dim idLabel As Label = CType(row.Cells(2).FindControl("PCALabel"), Label)
        Dim PCAID As String = idLabel.Text.ToString

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()
        Dim cmd As New SqlCommand
        cmd.CommandText = "UPDATE tblPermanentCorrectiveAction SET Visible = '0' WHERE PCAID = '" + PCAID + "'"
        cmd.CommandType = CommandType.Text
        cmd.Connection = SqlConnection
        cmd.ExecuteScalar()
        SqlConnection.Close()

        BindPCA()
    End Sub

    Protected Sub gvPermanentCorrectiveAction_RowEditing(sender As Object, e As GridViewEditEventArgs)
        sender.EditIndex = e.NewEditIndex
        BindPCA()
    End Sub

    Protected Sub gvPermanentCorrectiveAction_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim dt As DataTable = ViewState("PCA")

        Dim gvPermanentCorrectiveAction As GridView = CType(frmInsert.FindControl("gvPermanentCorrectiveAction"), GridView)
        Dim row = gvPermanentCorrectiveAction.Rows(e.RowIndex)

        dt.Rows(row.DataItemIndex)("PermanentCorrectiveAction") = (CType((row.Cells(3).Controls(0)), TextBox)).Text

        gvPermanentCorrectiveAction.EditIndex = -1

        BindPCA()
    End Sub

    Protected Sub gvPermanentCorrectiveAction_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        Dim gvPermanentCorrectiveAction As GridView = CType(frmInsert.FindControl("gvPermanentCorrectiveAction"), GridView)
        gvPermanentCorrectiveAction.EditIndex = -1
        BindPCA()
    End Sub

    Protected Sub gvQLT_DataBound(sender As Object, e As EventArgs)
        'Set the count at the top of the page (work in progress)
        Dim MainContent As ContentPlaceHolder = Page.Master.FindControl("MainContent")
        Dim IssuedLabel As Label = CType(MainContent.FindControl("IssuedCount"), Label)
        Dim AssignedLabel As Label = CType(MainContent.FindControl("AssignedCount"), Label)
        Dim QLTReviewLabel As Label = CType(MainContent.FindControl("QLTReviewCount"), Label)
        Dim Resolvedlabel As Label = CType(MainContent.FindControl("ResolvedCount"), Label)
        Dim QTReviewLabel As Label = CType(MainContent.FindControl("QTReviewCount"), Label)

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        Dim scIssuedCount As New SqlCommand("SELECT COUNT(QLTID) FROM tblQLT WHERE StatusID = 1 AND Visible = 1", SqlConnection)
        Dim reader As SqlDataReader = scIssuedCount.ExecuteReader()
        reader.Read()
        Dim IssuedCount As Int32 = reader.GetInt32(0)
        reader.Close()

        Dim scAssignedCount As New SqlCommand("SELECT COUNT(QLTID) FROM tblQLT WHERE StatusID = 2 AND Visible = 1", SqlConnection)
        reader = scAssignedCount.ExecuteReader()
        reader.Read()
        Dim AssignedCount As Int32 = reader.GetInt32(0)
        reader.Close()

        Dim scQLTReviewCount As New SqlCommand("SELECT COUNT(QLTID) FROM tblQLT WHERE StatusID = 4 AND Visible = 1", SqlConnection)
        reader = scQLTReviewCount.ExecuteReader()
        reader.Read()
        Dim QLTReviewCount As Int32 = reader.GetInt32(0)
        reader.Close()

        Dim scResolvedCount As New SqlCommand("SELECT COUNT(QLTID) FROM tblQLT WHERE StatusID = 6 AND Visible = 1", SqlConnection)
        reader = scResolvedCount.ExecuteReader()
        reader.Read()
        Dim ResolvedCount As Int32 = reader.GetInt32(0)
        reader.Close()

        Dim scQTReviewCount As New SqlCommand("SELECT COUNT(QLTID) FROM tblQLT WHERE StatusID = 9 AND Visible = 1", SqlConnection)
        reader = scQTReviewCount.ExecuteReader()
        reader.Read()
        Dim QTReviewCount As Int32 = reader.GetInt32(0)
        reader.Close()

        SqlConnection.Close()

        IssuedLabel.Text = IssuedCount
        AssignedLabel.Text = AssignedCount
        QLTReviewLabel.Text = QLTReviewCount
        Resolvedlabel.Text = ResolvedCount
        QTReviewLabel.Text = QTReviewCount
    End Sub

    Protected Sub gvAdditionalCorrectiveAction_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim gvAdditionalCorrectiveAction As GridView = CType(frmInsert.FindControl("gvAdditionalCorrectiveAction"), GridView)
        Dim dt As DataTable = ViewState("ACA")
        Dim row = gvAdditionalCorrectiveAction.Rows(e.RowIndex)
        dt.Rows.RemoveAt(e.RowIndex)
        Dim idLabel As Label = CType(row.Cells(2).FindControl("ACALabel"), Label)
        Dim ACAID As String = idLabel.Text.ToString

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=QLT;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()
        Dim cmd As New SqlCommand
        cmd.CommandText = "UPDATE tblAdditionalCorrectiveAction SET Visible = '0' WHERE ACAID = '" + ACAID + "'"
        cmd.CommandType = CommandType.Text
        cmd.Connection = SqlConnection
        cmd.ExecuteScalar()
        SqlConnection.Close()

        BindACA()
    End Sub
End Class
