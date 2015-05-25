Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Data.SqlTypes

Public Class NERManager
    Inherits System.Web.UI.Page

    Public NCFYear0 As Decimal = 0
    Public NCFYear1 As Decimal = 0
    Public NCFYear2 As Decimal = 0
    Public NCFYear3 As Decimal = 0
    Public NCFYear4 As Decimal = 0

    Public DNCFYear0 As Decimal = 0
    Public DNCFYear1 As Decimal = 0
    Public DNCFYear2 As Decimal = 0
    Public DNCFYear3 As Decimal = 0
    Public DNCFYear4 As Decimal = 0

    Public NPV As Decimal = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("IssuedDate") = Now()
        Session("RevisedDate") = Now()

        If Not User.IsInRole("LCLMTL\LCL_Manager") And Not User.Identity.Name = "LCLMTL\Duc-DuyN" And Not User.Identity.Name = "LCLMTL\mignoto" And Not User.Identity.Name = "LCLMTL\mcarr" Then
            'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertaccess();", True)
            Response.Redirect("~/NER/AccessDenied.aspx")
        End If

        If Not Page.IsPostBack Then
            Session("PROIYear0Total") = 0
            Session("PROIYear1Total") = 0
            Session("PROIYear2Total") = 0
            Session("PROIYear3Total") = 0
            Session("PROIYear4Total") = 0

            Session("PCYear0Total") = 0
            Session("PCYear1Total") = 0
            Session("PCYear2Total") = 0
            Session("PCYear3Total") = 0
            Session("PCYear4Total") = 0
        End If

        If ViewState("PROIDatatable") Is Nothing Then
            Dim PROIdt As DataTable = New DataTable
            PROIdt.Columns.Add("ProjectedROI_ID", GetType(Integer))
            PROIdt.Columns.Add("NERID", GetType(Integer))
            PROIdt.Columns.Add("Benefit", GetType(String))
            PROIdt.Columns.Add("PROI_Year0", GetType(Double))
            PROIdt.Columns.Add("PROI_Year1", GetType(Double))
            PROIdt.Columns.Add("PROI_Year2", GetType(Double))
            PROIdt.Columns.Add("PROI_Year3", GetType(Double))
            PROIdt.Columns.Add("PROI_Year4", GetType(Double))
            PROIdt.Columns.Add("Visible", GetType(SqlBoolean))
            ViewState("PROIDatatable") = PROIdt
        End If

        If ViewState("PCDatatable") Is Nothing Then
            Dim PCdt As DataTable = New DataTable
            PCdt.Columns.Add("ProgramCostID", GetType(Integer))
            PCdt.Columns.Add("NERID", GetType(Integer))
            PCdt.Columns.Add("ProgramCostDetail", GetType(String))
            PCdt.Columns.Add("PC_Year0", GetType(Double))
            PCdt.Columns.Add("PC_Year1", GetType(Double))
            PCdt.Columns.Add("PC_Year2", GetType(Double))
            PCdt.Columns.Add("PC_Year3", GetType(Double))
            PCdt.Columns.Add("PC_Year4", GetType(Double))
            PCdt.Columns.Add("Visible", GetType(SqlBoolean))
            ViewState("PCDatatable") = PCdt
        End If

        If ViewState("SCDatatable") Is Nothing Then
            Dim SCdt As DataTable = New DataTable
            SCdt.Columns.Add("SuccessCriteriaID", GetType(Integer))
            SCdt.Columns.Add("NERID", GetType(Integer))
            SCdt.Columns.Add("SuccessCriteriaDetail", GetType(String))
            SCdt.Columns.Add("Baseline", GetType(String))
            SCdt.Columns.Add("Q1", GetType(String))
            SCdt.Columns.Add("Q2", GetType(String))
            SCdt.Columns.Add("Q3", GetType(String))
            SCdt.Columns.Add("Q4", GetType(String))
            SCdt.Columns.Add("Q5", GetType(String))
            SCdt.Columns.Add("Q6", GetType(String))
            SCdt.Columns.Add("Visible", GetType(SqlBoolean))
            ViewState("SCDatatable") = SCdt
        End If

        If ViewState("FUPDatatable") Is Nothing Then
            Dim FUPdt As DataTable = New DataTable
            FUPdt.Columns.Add("FUPID", GetType(Integer))
            FUPdt.Columns.Add("NERID", GetType(Integer))
            FUPdt.Columns.Add("Event", GetType(String))
            FUPdt.Columns.Add("FUPWhen", GetType(String))
            FUPdt.Columns.Add("Compl", GetType(String))
            FUPdt.Columns.Add("Resp", GetType(String))
            FUPdt.Columns.Add("Notes", GetType(String))
            FUPdt.Columns.Add("Visible", GetType(SqlBoolean))
            ViewState("FUPDatatable") = FUPdt
        End If

    End Sub

    Protected Sub gvNewEmployeeRequests_OnSelectedIndexChanged(sender As Object, e As EventArgs)
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        'Try
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
        Try
            If frmInsert.CurrentMode = FormViewMode.Edit Then
                'Fill PROI gridview
                Dim dt As New DataTable
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                Dim neridstr As String = CType(frmInsert.FindControl("NERIDLabel1"), Label).Text
                Dim sc As New SqlCommand("select * from tblProjectedROI where NERID = " & neridstr, SqlConnection)
                SqlConnection.Open()
                Dim da As New SqlDataAdapter(sc)
                da.Fill(dt)
                ViewState("PROIDatatable") = dt
                Dim gvPROIDetails As GridView
                gvPROIDetails = CType(frmInsert.FindControl("gvPROIDetails"), GridView)
                gvPROIDetails.DataSource = dt
                gvPROIDetails.DataBind()

                'Populate the footer row with the total value for each year
                'If Not IsNothing(dt) Then
                '    For Each gvr As GridViewRow In gvPROIDetails.Rows
                '        If gvr.RowType = DataControlRowType.DataRow Then
                '            PROIYear0Total += gvr.Cells(3).Text
                '            PROIYear1Total += gvr.Cells(4).Text
                '            PROIYear2Total += gvr.Cells(5).Text
                '            PROIYear3Total += gvr.Cells(6).Text
                '            PROIYear4Total += gvr.Cells(7).Text
                '        End If
                '    Next
                '    gvPROIDetails.FooterRow.Cells(2).Text = "Yearly Totals:"
                '    gvPROIDetails.FooterRow.Cells(3).Text = String.Format("{0:c}", PROIYear0Total)
                '    gvPROIDetails.FooterRow.Cells(4).Text = String.Format("{0:c}", PROIYear1Total)
                '    gvPROIDetails.FooterRow.Cells(5).Text = String.Format("{0:c}", PROIYear2Total)
                '    gvPROIDetails.FooterRow.Cells(6).Text = String.Format("{0:c}", PROIYear3Total)
                '    gvPROIDetails.FooterRow.Cells(7).Text = String.Format("{0:c}", PROIYear4Total)
                'End If


                'Fill PC gridview
                Dim PCdt As New DataTable
                Dim PCconnectionString As String
                PCconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
                Dim PCSqlConnection As New SqlConnection(PCconnectionString)
                Dim PCsc As New SqlCommand("select * from tblProgramCost where NERID = " & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text, PCSqlConnection)
                PCSqlConnection.Open()
                Dim PCda As New SqlDataAdapter(PCsc)
                PCda.Fill(PCdt)
                ViewState("PCDatatable") = PCdt
                Dim gvProgramCostsDetails As GridView
                gvProgramCostsDetails = CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView)
                gvProgramCostsDetails.DataSource = PCdt
                gvProgramCostsDetails.DataBind()

                'Populate the footer row with the total value for each year
                'If Not IsNothing(PCdt) Then
                '    For Each gvr As GridViewRow In gvProgramCostsDetails.Rows
                '        If gvr.RowType = DataControlRowType.DataRow Then
                '            PCYear0Total += gvr.Cells(3).Text
                '            PCYear1Total += gvr.Cells(4).Text
                '            PCYear2Total += gvr.Cells(5).Text
                '            PCYear3Total += gvr.Cells(6).Text
                '            PCYear4Total += gvr.Cells(7).Text
                '        End If
                '    Next
                '    gvProgramCostsDetails.FooterRow.Cells(2).Text = "Yearly Totals:"
                '    gvProgramCostsDetails.FooterRow.Cells(3).Text = String.Format("{0:c}", PCYear0Total)
                '    gvProgramCostsDetails.FooterRow.Cells(4).Text = String.Format("{0:c}", PCYear1Total)
                '    gvProgramCostsDetails.FooterRow.Cells(5).Text = String.Format("{0:c}", PCYear2Total)
                '    gvProgramCostsDetails.FooterRow.Cells(6).Text = String.Format("{0:c}", PCYear3Total)
                '    gvProgramCostsDetails.FooterRow.Cells(7).Text = String.Format("{0:c}", PCYear4Total)
                'End If

                UpdateNetCashFlow()

                'Fill SC gridview
                Dim SCdt As New DataTable
                Dim SCconnectionString As String
                SCconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
                Dim SCSqlConnection As New SqlConnection(SCconnectionString)
                Dim SCsc As New SqlCommand("select * from tblSuccessCriteria where NERID = " & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text, SCSqlConnection)
                SCSqlConnection.Open()
                Dim SCda As New SqlDataAdapter(SCsc)
                SCda.Fill(SCdt)
                ViewState("SCDatatable") = SCdt
                Dim gvSuccessCriteria As GridView
                gvSuccessCriteria = CType(frmInsert.FindControl("gvSuccessCriteria"), GridView)
                gvSuccessCriteria.DataSource = SCdt
                gvSuccessCriteria.DataBind()

                'Fill FUP gridview
                Dim FUPdt As New DataTable
                Dim FUPconnectionString As String
                FUPconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
                Dim FUPSqlConnection As New SqlConnection(FUPconnectionString)
                Dim FUPsc As New SqlCommand("select * from tblFUP where NERID = " & CType(frmInsert.FindControl("NERIDLabel1"), Label).Text, FUPSqlConnection)
                FUPSqlConnection.Open()
                Dim FUPda As New SqlDataAdapter(FUPsc)
                FUPda.Fill(FUPdt)
                ViewState("FUPDatatable") = FUPdt
                Dim gvImplementation As GridView
                gvImplementation = CType(frmInsert.FindControl("gvImplementation"), GridView)
                gvImplementation.DataSource = FUPdt
                gvImplementation.DataBind()

                If CType(frmInsert.FindControl("chkReplacement"), CheckBox).Checked = True Then
                    CType(frmInsert.FindControl("ReplacementTextBox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("lblReplacement"), Label).Visible = True
                Else
                    CType(frmInsert.FindControl("ReplacementTextBox"), TextBox).Visible = False
                    CType(frmInsert.FindControl("lblReplacement"), Label).Visible = False
                End If

                If CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Value = 3 Then
                    CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Text = "Reason: "
                ElseIf CType(frmInsert.FindControl("StatusDropDown"), DropDownList).SelectedItem.Value = 4 Then
                    CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = True
                    CType(frmInsert.FindControl("StatusReasonLabel"), Label).Text = "Employee Name:"
                    CType(frmInsert.FindControl("SORPanel"), Panel).Visible = True
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
        Dim dt As New DataTable
        dt = CType(ViewState("PROIDatatable"), DataTable)

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"

        Using destinationConnection As SqlConnection = New SqlConnection(connectionString)
            destinationConnection.Open()
            Try

                Dim sqlcommand As New SqlCommand("Delete from tblProjectedROI where NERID = " & CType(Me.frmInsert.FindControl("NERIDLabel1"), Label).Text)
                sqlcommand.Connection = destinationConnection
                sqlcommand.ExecuteNonQuery()
                Using bulkCopy As SqlBulkCopy = _
                  New SqlBulkCopy(destinationConnection)
                    bulkCopy.DestinationTableName = _
                    "dbo.tblProjectedROI"
                    ' Write from the source to the destination.
                    bulkCopy.WriteToServer(dt)
                    'Need to delete and rewrite the lines
                    'Delete first

                End Using

            Catch ex As Exception
                Debug.Print(ex.Message)


            End Try
            destinationConnection.Close()
        End Using
        gvNewEmployeeRequests.DataBind()
        dt.Clear()
        ViewState("PROIDatatable") = dt

        Dim PCdt As New DataTable
        PCdt = CType(ViewState("PCDatatable"), DataTable)

        Dim PCconnectionString As String
        PCconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"

        Using PCdestinationConnection As SqlConnection = New SqlConnection(PCconnectionString)
            PCdestinationConnection.Open()
            Try

                Dim PCsqlcommand As New SqlCommand("Delete from tblProgramCost where NERID = " & CType(Me.frmInsert.FindControl("NERIDLabel1"), Label).Text)
                PCsqlcommand.Connection = PCdestinationConnection
                PCsqlcommand.ExecuteNonQuery()
                Using PCbulkCopy As SqlBulkCopy = _
                  New SqlBulkCopy(PCdestinationConnection)
                    PCbulkCopy.DestinationTableName = _
                    "dbo.tblProgramCost"
                    ' Write from the source to the destination.
                    PCbulkCopy.WriteToServer(PCdt)
                    'Need to delete and rewrite the lines
                    'Delete first

                End Using

            Catch ex As Exception
                Debug.Print(ex.Message)


            End Try
            PCdestinationConnection.Close()
        End Using
        gvNewEmployeeRequests.DataBind()
        PCdt.Clear()
        ViewState("PCDatatable") = PCdt

        Dim SCdt As New DataTable
        SCdt = CType(ViewState("SCDatatable"), DataTable)

        Dim SCconnectionString As String
        SCconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"

        Using SCdestinationConnection As SqlConnection = New SqlConnection(SCconnectionString)
            SCdestinationConnection.Open()
            Try

                Dim SCsqlcommand As New SqlCommand("Delete from tblSuccessCriteria where NERID = " & CType(Me.frmInsert.FindControl("NERIDLabel1"), Label).Text)
                SCsqlcommand.Connection = SCdestinationConnection
                SCsqlcommand.ExecuteNonQuery()
                Using SCbulkCopy As SqlBulkCopy = _
                  New SqlBulkCopy(SCdestinationConnection)
                    SCbulkCopy.DestinationTableName = _
                    "dbo.tblSuccessCriteria"
                    ' Write from the source to the destination.
                    SCbulkCopy.WriteToServer(SCdt)
                    'Need to delete and rewrite the lines
                    'Delete first

                End Using

            Catch ex As Exception
                Debug.Print(ex.Message)


            End Try
            SCdestinationConnection.Close()
        End Using
        gvNewEmployeeRequests.DataBind()
        SCdt.Clear()
        ViewState("SCDatatable") = SCdt

        Dim FUPdt As New DataTable
        FUPdt = CType(ViewState("FUPDatatable"), DataTable)

        Dim FUPconnectionString As String
        FUPconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"

        Using FUPdestinationConnection As SqlConnection = New SqlConnection(FUPconnectionString)
            FUPdestinationConnection.Open()
            Try

                Dim FUPsqlcommand As New SqlCommand("Delete from tblFUP where NERID = " & CType(Me.frmInsert.FindControl("NERIDLabel1"), Label).Text)
                FUPsqlcommand.Connection = FUPdestinationConnection
                FUPsqlcommand.ExecuteNonQuery()
                Using FUPbulkCopy As SqlBulkCopy = _
                  New SqlBulkCopy(FUPdestinationConnection)
                    FUPbulkCopy.DestinationTableName = _
                    "dbo.tblFUP"
                    ' Write from the source to the destination.
                    FUPbulkCopy.WriteToServer(FUPdt)
                    'Need to delete and rewrite the lines
                    'Delete first

                End Using

            Catch ex As Exception
                Debug.Print(ex.Message)


            End Try
            FUPdestinationConnection.Close()
        End Using
        gvNewEmployeeRequests.DataBind()
        FUPdt.Clear()
        ViewState("FUPDatatable") = FUPdt

        Try
            Dim EconnectionString As String
            EconnectionString = "Server=lcl-sql2k5-s;Database=NewEmployeeRequest;Trusted_Connection=true"
            Dim SqlConnection As New SqlConnection(EconnectionString)
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
            CType(frmInsert.FindControl("SORPanel"), Panel).Visible = True
        Else
            CType(frmInsert.FindControl("StatusReasonTextbox"), TextBox).Visible = False
            CType(frmInsert.FindControl("StatusReasonLabel"), Label).Visible = False
            CType(frmInsert.FindControl("SORPanel"), Panel).Visible = False
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
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True And Not CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedIndex = 7 Then
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
                If CType(frmInsert.FindControl("OtherSchoolPanel"), Panel).Visible = True And Not CType(frmInsert.FindControl("SchoolDropDown"), DropDownList).SelectedIndex = 7 Then
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

    Protected Sub AddPROIButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmInsert.FindControl("proi_panel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub proiDetails_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("PROIDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmInsert.FindControl("proiDetails"), FormView)
        Dim srow As GridViewRow = CType(frmInsert.FindControl("gvPROIDetails"), GridView).SelectedRow 'Current selected row if any
        Dim gvPROIDetails As GridView = CType(frmInsert.FindControl("gvPROIDetails"), GridView) 'The Details grid

        If (CType(frmInsert.FindControl("gvPROIDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            drow = dt.NewRow() 'New row to add
            'drow("CategoryID") = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList).SelectedValue
        Else
            'if edit mode, delete existing line but get value from the datatable beforehand for the categoryid from the datatable.
            drow = dt.Rows(srow.RowIndex)
            'drow("CategoryID") = dt.Rows(srow.RowIndex).Item(2).ToString
            'dt.Rows(srow.RowIndex).Delete()
        End If

        drow("Benefit") = CType(frm.FindControl("BenefitsTextBox"), TextBox).Text
        drow("PROI_Year0") = If(CType(frm.FindControl("Year0"), TextBox).Text = "", 0, CType(frm.FindControl("Year0"), TextBox).Text)
        drow("PROI_Year1") = If(CType(frm.FindControl("Year1"), TextBox).Text = "", 0, CType(frm.FindControl("Year1"), TextBox).Text)
        drow("PROI_Year2") = If(CType(frm.FindControl("Year2"), TextBox).Text = "", 0, CType(frm.FindControl("Year2"), TextBox).Text)
        drow("PROI_Year3") = If(CType(frm.FindControl("Year3"), TextBox).Text = "", 0, CType(frm.FindControl("Year3"), TextBox).Text)
        drow("PROI_Year4") = If(CType(frm.FindControl("Year4"), TextBox).Text = "", 0, CType(frm.FindControl("Year4"), TextBox).Text)
        drow("Visible") = True

        If frmInsert.CurrentMode = FormViewMode.Edit Then
            drow("NERID") = CType(frmInsert.FindControl("NERIDLabel1"), Label).Text
        End If

        If (CType(frmInsert.FindControl("gvPROIDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmInsert.FindControl("gvPROIDetails"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("PROIDatatable") = dt
        CType(frmInsert.FindControl("gvPROIDetails"), GridView).DataSource = dt
        CType(frmInsert.FindControl("gvPROIDetails"), GridView).DataBind()
        CType(frmInsert.FindControl("proi_panel"), Panel).Visible = False
    End Sub

    Protected Sub CancelPROIButton_Click(sender As Object, e As EventArgs)
        CType(frmInsert.FindControl("proi_panel"), Panel).Visible = False
        Dim frm = CType(frmInsert.FindControl("proiDetails"), FormView)
        CType(frm.FindControl("BenefitsTextBox"), TextBox).Text = ""
        CType(frm.FindControl("year0"), TextBox).Text = ""
        CType(frm.FindControl("year1"), TextBox).Text = ""
        CType(frm.FindControl("year2"), TextBox).Text = ""
        CType(frm.FindControl("year3"), TextBox).Text = ""
        CType(frm.FindControl("year4"), TextBox).Text = ""
    End Sub

    Protected Sub AddProgramCostButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmInsert.FindControl("ProgramCostsPanel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub frmProgramCosts_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("PCDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmInsert.FindControl("frmProgramCosts"), FormView)
        Dim srow As GridViewRow = CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView).SelectedRow 'Current selected row if any
        Dim gvProgramCostsDetails As GridView = CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView) 'The Details grid

        If (CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            drow = dt.NewRow() 'New row to add
            'drow("CategoryID") = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList).SelectedValue
        Else
            'if edit mode, delete existing line but get value from the datatable beforehand for the categoryid from the datatable.
            drow = dt.Rows(srow.RowIndex)
            'drow("CategoryID") = dt.Rows(srow.RowIndex).Item(2).ToString
            'dt.Rows(srow.RowIndex).Delete()
        End If

        drow("ProgramCostDetail") = CType(frm.FindControl("ProgramCostTextBox"), TextBox).Text
        drow("PC_Year0") = If(CType(frm.FindControl("PCYear0"), TextBox).Text = "", 0, CType(frm.FindControl("PCYear0"), TextBox).Text)
        drow("PC_Year1") = If(CType(frm.FindControl("PCYear1"), TextBox).Text = "", 0, CType(frm.FindControl("PCYear1"), TextBox).Text)
        drow("PC_Year2") = If(CType(frm.FindControl("PCYear2"), TextBox).Text = "", 0, CType(frm.FindControl("PCYear2"), TextBox).Text)
        drow("PC_Year3") = If(CType(frm.FindControl("PCYear3"), TextBox).Text = "", 0, CType(frm.FindControl("PCYear3"), TextBox).Text)
        drow("PC_Year4") = If(CType(frm.FindControl("PCYear4"), TextBox).Text = "", 0, CType(frm.FindControl("PCYear4"), TextBox).Text)
        drow("Visible") = True

        'PCYear0Total += Convert.ToDecimal(CType(frm.FindControl("PCYear0"), TextBox).Text)
        'PCYear1Total += Convert.ToDecimal(CType(frm.FindControl("PCYear1"), TextBox).Text)
        'PCYear2Total += Convert.ToDecimal(CType(frm.FindControl("PCYear2"), TextBox).Text)
        'PCYear3Total += Convert.ToDecimal(CType(frm.FindControl("PCYear3"), TextBox).Text)
        'PCYear4Total += Convert.ToDecimal(CType(frm.FindControl("PCYear4"), TextBox).Text)
        UpdateNetCashFlow()

        If frmInsert.CurrentMode = FormViewMode.Edit Then
            drow("NERID") = CType(frmInsert.FindControl("NERIDLabel1"), Label).Text
        End If

        If (CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("PCDatatable") = dt
        CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView).DataSource = dt
        CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView).DataBind()
        CType(frmInsert.FindControl("ProgramCostsPanel"), Panel).Visible = False
    End Sub

    Protected Sub CancelProgramCostButton_Click(sender As Object, e As EventArgs)
        CType(frmInsert.FindControl("ProgramCostsPanel"), Panel).Visible = False
        Dim frm = CType(frmInsert.FindControl("frmProgramCosts"), FormView)
        CType(frm.FindControl("ProgramCostTextBox"), TextBox).Text = ""
        CType(frm.FindControl("PCYear0"), TextBox).Text = ""
        CType(frm.FindControl("PCYear1"), TextBox).Text = ""
        CType(frm.FindControl("PCYear2"), TextBox).Text = ""
        CType(frm.FindControl("PCYear3"), TextBox).Text = ""
        CType(frm.FindControl("PCYear4"), TextBox).Text = ""
    End Sub

    Protected Sub SuccessCriteriaButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmInsert.FindControl("SuccessCriteriaPanel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub frmSuccessCriteria_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("SCDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
        Dim srow As GridViewRow = CType(frmInsert.FindControl("gvSuccessCriteria"), GridView).SelectedRow 'Current selected row if any
        Dim gvSuccessCriteria As GridView = CType(frmInsert.FindControl("gvSuccessCriteria"), GridView) 'The Details grid

        If (CType(frmInsert.FindControl("gvSuccessCriteria"), GridView).SelectedIndex = -1) Then
            'Add mode
            drow = dt.NewRow() 'New row to add
            'drow("CategoryID") = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList).SelectedValue
        Else
            'if edit mode, delete existing line but get value from the datatable beforehand for the categoryid from the datatable.
            drow = dt.Rows(srow.RowIndex)
            'drow("CategoryID") = dt.Rows(srow.RowIndex).Item(2).ToString
            'dt.Rows(srow.RowIndex).Delete()
        End If

        drow("SuccessCriteriaDetail") = CType(frm.FindControl("SuccessCriteriaTextbox"), TextBox).Text
        drow("Baseline") = CType(frm.FindControl("BaselineID"), TextBox).Text
        drow("Q1") = CType(frm.FindControl("Q1"), TextBox).Text
        drow("Q2") = CType(frm.FindControl("Q2"), TextBox).Text
        drow("Q3") = CType(frm.FindControl("Q3"), TextBox).Text
        drow("Q4") = CType(frm.FindControl("Q4"), TextBox).Text
        drow("Q5") = CType(frm.FindControl("Q5"), TextBox).Text
        drow("Q6") = CType(frm.FindControl("Q6"), TextBox).Text
        drow("Visible") = True

        If frmInsert.CurrentMode = FormViewMode.Edit Then
            drow("NERID") = CType(frmInsert.FindControl("NERIDLabel1"), Label).Text
        End If

        If (CType(frmInsert.FindControl("gvSuccessCriteria"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmInsert.FindControl("gvSuccessCriteria"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("SCDatatable") = dt
        CType(frmInsert.FindControl("gvSuccessCriteria"), GridView).DataSource = dt
        CType(frmInsert.FindControl("gvSuccessCriteria"), GridView).DataBind()
        CType(frmInsert.FindControl("SuccessCriteriaPanel"), Panel).Visible = False
    End Sub

    Protected Sub CancelSuccessCriteriaButton_Click(sender As Object, e As EventArgs)
        CType(frmInsert.FindControl("SuccessCriteriaPanel"), Panel).Visible = False
        Dim frm = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
        CType(frm.FindControl("SuccessCriteriaTextbox"), TextBox).Text = ""
        CType(frm.FindControl("BaselineID"), TextBox).Text = ""
        CType(frm.FindControl("Q1"), TextBox).Text = ""
        CType(frm.FindControl("Q2"), TextBox).Text = ""
        CType(frm.FindControl("Q3"), TextBox).Text = ""
        CType(frm.FindControl("Q4"), TextBox).Text = ""
        CType(frm.FindControl("Q5"), TextBox).Text = ""
        CType(frm.FindControl("Q6"), TextBox).Text = ""
    End Sub

    Protected Sub AddImplementationButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmInsert.FindControl("ImplementationPanel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub frmImplementation_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("FUPDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmInsert.FindControl("frmImplementation"), FormView)
        Dim srow As GridViewRow = CType(frmInsert.FindControl("gvImplementation"), GridView).SelectedRow 'Current selected row if any
        Dim gvProgramCostsDetails As GridView = CType(frmInsert.FindControl("gvImplementation"), GridView) 'The Details grid

        If (CType(frmInsert.FindControl("gvImplementation"), GridView).SelectedIndex = -1) Then
            'Add mode
            drow = dt.NewRow() 'New row to add
            'drow("CategoryID") = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList).SelectedValue
        Else
            'if edit mode, delete existing line but get value from the datatable beforehand for the categoryid from the datatable.
            drow = dt.Rows(srow.RowIndex)
            'drow("CategoryID") = dt.Rows(srow.RowIndex).Item(2).ToString
            'dt.Rows(srow.RowIndex).Delete()
        End If

        drow("Event") = CType(frm.FindControl("EventTextbox"), TextBox).Text
        drow("FUPWhen") = CType(frm.FindControl("WhenID"), TextBox).Text
        drow("Compl") = CType(frm.FindControl("ComplID"), TextBox).Text
        drow("Resp") = CType(frm.FindControl("RespID"), TextBox).Text
        drow("Notes") = CType(frm.FindControl("NotesID"), TextBox).Text
        drow("Visible") = True

        If frmInsert.CurrentMode = FormViewMode.Edit Then
            drow("NERID") = CType(frmInsert.FindControl("NERIDLabel1"), Label).Text
        End If

        If (CType(frmInsert.FindControl("gvImplementation"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmInsert.FindControl("gvImplementation"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("FUPDatatable") = dt
        CType(frmInsert.FindControl("gvImplementation"), GridView).DataSource = dt
        CType(frmInsert.FindControl("gvImplementation"), GridView).DataBind()
        CType(frmInsert.FindControl("ImplementationPanel"), Panel).Visible = False
    End Sub

    Protected Sub CancelImplementationButton_Click(sender As Object, e As EventArgs)
        CType(frmInsert.FindControl("ImplementationPanel"), Panel).Visible = False
        Dim frm = CType(frmInsert.FindControl("frmImplementation"), FormView)
        CType(frm.FindControl("EventTextbox"), TextBox).Text = ""
        CType(frm.FindControl("WhenID"), TextBox).Text = ""
        CType(frm.FindControl("ComplID"), TextBox).Text = ""
        CType(frm.FindControl("RespID"), TextBox).Text = ""
        CType(frm.FindControl("NotesID"), TextBox).Text = ""
    End Sub

    Protected Sub gvPROIDetails_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim dt As DataTable 'create empty DataTable object dt
        dt = CType(ViewState("PROIDatatable"), DataTable) 'store the current ViewState("datatable") into dt
        dt.Rows(e.RowIndex).Delete() 'delete the row that was clicked on by the user (taken from the row's index)
        ViewState("PROIDatatable") = dt 'store the changes made to dt into ViewState("datatable")
        CType(sender, GridView).DataSource = dt 'set dt as the DataSource for the GridView
        CType(sender, GridView).DataBind() 'binds the data source to the GridView control
    End Sub

    Protected Sub gvProgramCostsDetails_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim dt As DataTable 'create empty DataTable object dt
        dt = CType(ViewState("PCDatatable"), DataTable) 'store the current ViewState("datatable") into dt
        dt.Rows(e.RowIndex).Delete() 'delete the row that was clicked on by the user (taken from the row's index)
        ViewState("PCDatatable") = dt 'store the changes made to dt into ViewState("datatable")
        CType(sender, GridView).DataSource = dt 'set dt as the DataSource for the GridView
        CType(sender, GridView).DataBind() 'binds the data source to the GridView control
    End Sub

    Protected Sub gvSuccessCriteria_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim dt As DataTable 'create empty DataTable object dt
        dt = CType(ViewState("SCDatatable"), DataTable) 'store the current ViewState("datatable") into dt
        dt.Rows(e.RowIndex).Delete() 'delete the row that was clicked on by the user (taken from the row's index)
        ViewState("SCDatatable") = dt 'store the changes made to dt into ViewState("datatable")
        CType(sender, GridView).DataSource = dt 'set dt as the DataSource for the GridView
        CType(sender, GridView).DataBind() 'binds the data source to the GridView control
    End Sub

    Protected Sub gvImplementation_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim dt As DataTable 'create empty DataTable object dt
        dt = CType(ViewState("FUPDatatable"), DataTable) 'store the current ViewState("datatable") into dt
        dt.Rows(e.RowIndex).Delete() 'delete the row that was clicked on by the user (taken from the row's index)
        ViewState("FUPDatatable") = dt 'store the changes made to dt into ViewState("datatable")
        CType(sender, GridView).DataSource = dt 'set dt as the DataSource for the GridView
        CType(sender, GridView).DataBind() 'binds the data source to the GridView control
    End Sub

    Protected Sub UpdateNetCashFlow()
        NCFYear0 = Session("PROIYear0Total") - Session("PCYear0Total")
        NCFYear1 = Session("PROIYear1Total") - Session("PCYear1Total")
        NCFYear2 = Session("PROIYear2Total") - Session("PCYear2Total")
        NCFYear3 = Session("PROIYear3Total") - Session("PCYear3Total")
        NCFYear4 = Session("PROIYear4Total") - Session("PCYear4Total")

        DNCFYear0 = NCFYear0 * 1
        DNCFYear1 = NCFYear1 * 0.91
        DNCFYear2 = NCFYear2 * 0.83
        DNCFYear3 = NCFYear3 * 0.75
        DNCFYear4 = NCFYear4 * 0.68

        NPV = DNCFYear0 + DNCFYear1 + DNCFYear2 + DNCFYear3 + DNCFYear4

        CType(frmInsert.FindControl("NCFYear0"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear0)
        CType(frmInsert.FindControl("NCFYear1"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear1)
        CType(frmInsert.FindControl("NCFYear2"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear2)
        CType(frmInsert.FindControl("NCFYear3"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear3)
        CType(frmInsert.FindControl("NCFYear4"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear4)

        CType(frmInsert.FindControl("DNCFYear0"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear0)
        CType(frmInsert.FindControl("DNCFYear1"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear1)
        CType(frmInsert.FindControl("DNCFYear2"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear2)
        CType(frmInsert.FindControl("DNCFYear3"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear3)
        CType(frmInsert.FindControl("DNCFYear4"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear4)

        CType(frmInsert.FindControl("NPVLabel"), Label).Text = String.Format("{0:$#,##0.00}", NPV)
    End Sub

    Protected Sub gvPROIDetails_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Session("PROIYear0Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PROI_Year0"))
            Session("PROIYear1Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PROI_Year1"))
            Session("PROIYear2Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PROI_Year2"))
            Session("PROIYear3Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PROI_Year3"))
            Session("PROIYear4Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PROI_Year4"))
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
        e.Row.Cells(2).Text = "Yearly Totals:"
            e.Row.Cells(3).Text = String.Format("{0:c}", Session("PROIYear0Total"))
            e.Row.Cells(4).Text = String.Format("{0:c}", Session("PROIYear1Total"))
            e.Row.Cells(5).Text = String.Format("{0:c}", Session("PROIYear2Total"))
            e.Row.Cells(6).Text = String.Format("{0:c}", Session("PROIYear3Total"))
            e.Row.Cells(7).Text = String.Format("{0:c}", Session("PROIYear4Total"))
        End If
        UpdateNetCashFlow()
    End Sub


    Protected Sub gvProgramCostsDetails_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Session("PCYear0Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PC_Year0"))
            Session("PCYear1Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PC_Year1"))
            Session("PCYear2Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PC_Year2"))
            Session("PCYear3Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PC_Year3"))
            Session("PCYear4Total") += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PC_Year4"))
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = "Yearly Totals:"
            e.Row.Cells(3).Text = String.Format("{0:c}", Session("PCYear0Total"))
            e.Row.Cells(4).Text = String.Format("{0:c}", Session("PCYear1Total"))
            e.Row.Cells(5).Text = String.Format("{0:c}", Session("PCYear2Total"))
            e.Row.Cells(6).Text = String.Format("{0:c}", Session("PCYear3Total"))
            e.Row.Cells(7).Text = String.Format("{0:c}", Session("PCYear4Total"))
        End If
        UpdateNetCashFlow()
    End Sub

    Protected Sub sdsInsert_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub

    Protected Sub gvPROIDetails_DataBinding(sender As Object, e As EventArgs)
        Session("PROIYear0Total") = 0
        Session("PROIYear1Total") = 0
        Session("PROIYear2Total") = 0
        Session("PROIYear3Total") = 0
        Session("PROIYear4Total") = 0
    End Sub

    Protected Sub gvProgramCostsDetails_DataBinding(sender As Object, e As EventArgs)
        Session("PCYear0Total") = 0
        Session("PCYear1Total") = 0
        Session("PCYear2Total") = 0
        Session("PCYear3Total") = 0
        Session("PCYear4Total") = 0
    End Sub
End Class