Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Data.SqlTypes

Public Class PurchaseManager
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
        Session("DateApproved") = Now()

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
            PROIdt.Columns.Add("PurchaseRequestID", GetType(Integer))
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
            PCdt.Columns.Add("PurchaseRequestID", GetType(Integer))
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
            SCdt.Columns.Add("PurchaseRequestID", GetType(Integer))
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
            FUPdt.Columns.Add("PurchaseRequestID", GetType(Integer))
            FUPdt.Columns.Add("Event", GetType(String))
            FUPdt.Columns.Add("FUPWhen", GetType(String))
            FUPdt.Columns.Add("Compl", GetType(String))
            FUPdt.Columns.Add("Resp", GetType(String))
            FUPdt.Columns.Add("Notes", GetType(String))
            FUPdt.Columns.Add("Visible", GetType(SqlBoolean))
            ViewState("FUPDatatable") = FUPdt
        End If
    End Sub

    Protected Sub frmView_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'Find manager email
        Dim connectionString As String
        Dim managerEmail As String

        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

        Dim SqlConnection As New SqlConnection(connectionString)
        Dim sc As New SqlCommand("select managerEmail from tblManagers where managername = '" & CType(frmView.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text & "'", SqlConnection)
        SqlConnection.Open()

        Dim reader As SqlDataReader = sc.ExecuteReader()
        reader.Read()
        managerEmail = reader.GetString(0)
        reader.Close()

        If CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Approved" Then
            '-----------------------------------------------------------------
            'Send Email back to user telling him that his request was approved
            '-----------------------------------------------------------------
            Dim body As String = "This Email was automatically generated by the purchase request tool!" & vbCrLf & _
                                 "Item: " & CType(frmView.FindControl("ItemNameTextbox"), Label).Text & vbCrLf & _
                                 "Description: " & CType(frmView.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Reason: " & CType(frmView.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                                 "Quantity: " & CType(frmView.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                                 "Cost not to exceed: " & CType(frmView.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                                 "Date Required: " & CType(frmView.FindControl("DateRequiredTextBox"), Label).Text & vbCrLf & _
                                 "Requested by: " & CType(frmView.FindControl("RequesterNameTextBox"), Label).Text & vbCrLf & _
                                 "Approved by: " & CType(frmView.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text & vbCrLf & _
                                 "Approved on: " & Session("DateApproved")
            '"Purchasing Agent" & CType(frmView.FindControl("PurchaseAgentLabel"), Label).Text & vbCrLf & _
            '"Message to purchase agent: " & CType(frmView.FindControl("ITMessageTextBox"), TextBox).Text & vbCrLf & _
            '"Bolt Sponsor" & CType(frmView.FindControl("BoltSponsorLabel"), Label).Text

            Dim mm As New MailMessage(managerEmail, CType(frmView.FindControl("RequesterEmailTextBox"), Label).Text, "Request Approved (ID: " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text & ")", body)
            If CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue = 1 Or CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue = 2 Then
                'CC IT if IT review was checked
                mm.CC.Add("support@laurentide.com")
            End If
            Dim smtp As New SmtpClient("lcl-exc")
            smtp.Send(mm)

            '---------------------------------------------------------------
            'send email to buyer to warn them about new action to execute on
            '---------------------------------------------------------------
            'Get Buyer's Email
            sc.CommandText = "select buyeremail from tblbuyers where buyerid = " & CType(frmView.FindControl("BuyerDropDown"), DropDownList).SelectedValue.ToString
            reader = sc.ExecuteReader()
            reader.Read()
            Dim BuyerEmail As String = reader.GetString(0)
            reader.Close()

            'Send Email to buyer
            mm.To.RemoveAt(0)
            mm.To.Add(BuyerEmail)
            If mm.CC.Count > 0 Then
                mm.CC.RemoveAt(0)
            End If
            mm.Body = body & vbCrLf & "Please go to this address: http://lcl-sql2k5-s:81/Purchase/PurchaseEntry.aspx to continue."
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        ElseIf CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Denied" Then
            '-----------------------------------------------------------------
            'Send Email back to user telling him that his request was denied
            '-----------------------------------------------------------------
            Dim body As String = "This Email was automatically generated by the purchase request tool!" & vbCrLf & _
                                 "Item: " & CType(frmView.FindControl("ItemNameTextbox"), Label).Text & vbCrLf & _
                                 "Description: " & CType(frmView.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Reason: " & CType(frmView.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                                 "Quantity: " & CType(frmView.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                                 "Cost not to exceed: " & CType(frmView.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                                 "Your request was denied! Please see with your manager for more information."
            Dim mm As New MailMessage(managerEmail, CType(frmView.FindControl("RequesterEmailTextBox"), Label).Text, "Request Denied (ID: " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text & ")", body)
            Dim smtp As New SmtpClient("lcl-exc")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        ElseIf CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Transferred to another approver" Then
            '-----------------------------------------------------------------------------------------
            'Send Email back to user telling him that his request was transferred to another approver
            '-----------------------------------------------------------------------------------------
            Dim body As String = "This Email was automatically generated by the purchase request tool!" & vbCrLf & _
                                 "Item: " & CType(frmView.FindControl("ItemNameTextbox"), Label).Text & vbCrLf & _
                                 "Description: " & CType(frmView.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Reason: " & CType(frmView.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                                 "Quantity: " & CType(frmView.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                                 "Cost not to exceed: " & CType(frmView.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                                 "This request was redirected to another manager!"
            Dim mm As New MailMessage(managerEmail, CType(frmView.FindControl("RequesterEmailTextBox"), Label).Text, "Request transferred (ID: " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text & ")", body)
            mm.CC.Add(managerEmail)
            Dim smtp As New SmtpClient("lcl-exc")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        Else
            'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertnotsent();", True)
        End If
        'Refresh Gridview
        gvPurchaseRequests.DataBind()
    End Sub

    '************
    'Note: This sub is not used anymore 10-22-2013
    '************
    Protected Sub ITReviewCheckBox_CheckedChanged(sender As Object, e As EventArgs)
        Dim BuyerDropDown As DropDownList
        BuyerDropDown = CType(frmView.FindControl("BuyerDropDown"), DropDownList)
        Dim ITReviewCheckBox As CheckBox = CType(frmView.FindControl("ITReviewCheckBox"), CheckBox)
        If ITReviewCheckBox.Checked Then
            BuyerDropDown.SelectedValue = 38
            BuyerDropDown.Enabled = False
        Else
            BuyerDropDown.Enabled = True
        End If
    End Sub

    Protected Sub frmView_DataBound(sender As Object, e As EventArgs)
        Try
            If frmView.CurrentMode = FormViewMode.Edit Then
                'Fill PROI gridview
                Dim dt As New DataTable
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                Dim neridstr As String = CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text
                Dim sc As New SqlCommand("select * from tblProjectedROI where PurchaseRequestID = " & neridstr, SqlConnection)
                SqlConnection.Open()
                Dim da As New SqlDataAdapter(sc)
                da.Fill(dt)
                ViewState("PROIDatatable") = dt
                Dim gvPROIDetails As GridView
                gvPROIDetails = CType(frmView.FindControl("gvPROIDetails"), GridView)
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
                PCconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim PCSqlConnection As New SqlConnection(PCconnectionString)
                Dim PCsc As New SqlCommand("select * from tblProgramCost where PurchaseRequestID = " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text, PCSqlConnection)
                PCSqlConnection.Open()
                Dim PCda As New SqlDataAdapter(PCsc)
                PCda.Fill(PCdt)
                ViewState("PCDatatable") = PCdt
                Dim gvProgramCostsDetails As GridView
                gvProgramCostsDetails = CType(frmView.FindControl("gvProgramCostsDetails"), GridView)
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
                SCconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim SCSqlConnection As New SqlConnection(SCconnectionString)
                Dim SCsc As New SqlCommand("select * from tblSuccessCriteria where PurchaseRequestID = " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text, SCSqlConnection)
                SCSqlConnection.Open()
                Dim SCda As New SqlDataAdapter(SCsc)
                SCda.Fill(SCdt)
                ViewState("SCDatatable") = SCdt
                Dim gvSuccessCriteria As GridView
                gvSuccessCriteria = CType(frmView.FindControl("gvSuccessCriteria"), GridView)
                gvSuccessCriteria.DataSource = SCdt
                gvSuccessCriteria.DataBind()

                'Fill FUP gridview
                Dim FUPdt As New DataTable
                Dim FUPconnectionString As String
                FUPconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim FUPSqlConnection As New SqlConnection(FUPconnectionString)
                Dim FUPsc As New SqlCommand("select * from tblFUP where PurchaseRequestID = " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text, FUPSqlConnection)
                FUPSqlConnection.Open()
                Dim FUPda As New SqlDataAdapter(FUPsc)
                FUPda.Fill(FUPdt)
                ViewState("FUPDatatable") = FUPdt
                Dim gvImplementation As GridView
                gvImplementation = CType(frmView.FindControl("gvImplementation"), GridView)
                gvImplementation.DataSource = FUPdt
                gvImplementation.DataBind()

                Dim sqlConnection1 As New SqlConnection("Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true")
                Dim cmd As New SqlCommand
                Dim returnValue As String
                cmd.CommandText = "SELECT InvestmentChecked FROM tblPurchaseRequests WHERE PurchaseRequestID = " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text
                cmd.CommandType = CommandType.Text
                cmd.Connection = sqlConnection1
                sqlConnection1.Open()
                returnValue = cmd.ExecuteScalar
                sqlConnection1.Close()
                If (returnValue = True) Then
                    CType(frmView.FindControl("InvestmentSheetPanel"), Panel).Visible = True
                Else
                    CType(frmView.FindControl("InvestmentSheetPanel"), Panel).Visible = False
                End If
            End If
        Catch ex As Exception

        End Try


        'Dim BuyerDropDown As DropDownList
        'BuyerDropDown = CType(frmView.FindControl("BuyerDropDown"), DropDownList)
        'Dim ITReviewCheckBox As CheckBox = CType(frmView.FindControl("ITReviewCheckBox"), CheckBox)
        'If Not ITReviewCheckBox Is Nothing Then
        '    If ITReviewCheckBox.Checked Then
        '        BuyerDropDown.SelectedValue = 38
        '        BuyerDropDown.Enabled = False
        '    Else
        '        BuyerDropDown.Enabled = True
        '    End If
        'End If
        'Dim ITReviewCheckBox As CheckBox = CType(frmView.FindControl("ITReviewCheckBox"), CheckBox)
        Dim PurchaseCategoryDropdown As DropDownList
        PurchaseCategoryDropdown = CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList)
        If Not PurchaseCategoryDropdown Is Nothing Then
            Call PurchaseCategoryDropDown_SelectedIndexChanged(Nothing, Nothing)
        End If
    End Sub

    Protected Sub PurchaseCategoryDropDown_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue <> "" Then
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
            Dim SqlConnection As New SqlConnection(connectionString)

            SqlConnection.Open()
            'Dim reader As SqlDataReader

            ''Purchasing Agent
            'Dim sc As New SqlCommand("select tblPurchasingAgents.purchasingAgent from tblPurchasingAgents inner join tblpurchasecategories on tblpurchasecategories.PurchasingAgentid = tblPurchasingAgents.PurchasingAgentID where purchasecategoryid =  " & CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue, SqlConnection)
            'Dim reader As SqlDataReader = sc.ExecuteReader()
            'reader.Read()
            'CType(frmView.FindControl("PurchaseAgentLabel"), Label).Text = reader.GetString(0)
            'reader.Close()

            ''Bolt sponsor
            'sc.CommandText = "Select tblBoltSponsors.Boltsponsor from tblBoltSponsors inner join  tblpurchasecategories on tblpurchasecategories.boltsponsorid = tblboltsponsors.boltsponsorid where purchasecategoryid =  " & CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue
            'reader = sc.ExecuteReader
            'reader.Read()
            'CType(frmView.FindControl("boltsponsorlabel"), Label).Text = reader.GetString(0)
            'reader.Close()

            'Buyer
            Dim BuyerDropDown As DropDownList
            BuyerDropDown = CType(frmView.FindControl("BuyerDropDown"), DropDownList)
            Dim sc As New SqlCommand("Select tblbuyers.buyerid from tblbuyers inner join  tblpurchasecategories on tblpurchasecategories.AdminOE = tblbuyers.buyerid where purchasecategoryid =  " & CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue, SqlConnection)
            Dim reader As SqlDataReader = sc.ExecuteReader
            reader.Read()
            BuyerDropDown.SelectedValue = reader.GetInt32(0)
            reader.Close()

            'Backup Buyer
            Dim BackupBuyerDropDown As DropDownList
            BackupBuyerDropDown = CType(frmView.FindControl("BackupBuyerDropDown"), DropDownList)
            sc.CommandText = "Select tblbuyers.buyerid from tblbuyers inner join  tblpurchasecategories on tblpurchasecategories.BackupOE = tblbuyers.buyerid where purchasecategoryid =  " & CType(frmView.FindControl("PurchaseCategoryDropDown"), DropDownList).SelectedValue
            reader = sc.ExecuteReader
            reader.Read()
            BackupBuyerDropDown.SelectedValue = reader.GetInt32(0)
            reader.Close()
            SqlConnection.Close()
        End If
    End Sub

    Protected Sub ManagerDropDownCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        Dim sc As New SqlCommand("select ApprovalLimit from tblmanagers  where managerid = " & CType(frmView.FindControl("ManagerDropDown"), DropDownList).SelectedValue, SqlConnection)
        Dim reader As SqlDataReader = sc.ExecuteReader()
        reader.Read()
        If reader.GetDouble(0) < CDbl(CType(frmView.FindControl("TotalPriceTextBox"), TextBox).Text) And _
            Not CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Denied" Then
            CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedValue = 4
            args.IsValid = False
        Else
            args.IsValid = True
        End If
        reader.Close()
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

        CType(frmView.FindControl("NCFYear0"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear0)
        CType(frmView.FindControl("NCFYear1"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear1)
        CType(frmView.FindControl("NCFYear2"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear2)
        CType(frmView.FindControl("NCFYear3"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear3)
        CType(frmView.FindControl("NCFYear4"), Label).Text = String.Format("{0:$#,##0.00}", NCFYear4)

        CType(frmView.FindControl("DNCFYear0"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear0)
        CType(frmView.FindControl("DNCFYear1"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear1)
        CType(frmView.FindControl("DNCFYear2"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear2)
        CType(frmView.FindControl("DNCFYear3"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear3)
        CType(frmView.FindControl("DNCFYear4"), Label).Text = String.Format("{0:$#,##0.00}", DNCFYear4)

        CType(frmView.FindControl("NPVLabel"), Label).Text = String.Format("{0:$#,##0.00}", NPV)
    End Sub

    Protected Sub AddPROIButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmView.FindControl("proi_panel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub proiDetails_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("PROIDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmView.FindControl("proiDetails"), FormView)
        Dim srow As GridViewRow = CType(frmView.FindControl("gvPROIDetails"), GridView).SelectedRow 'Current selected row if any
        Dim gvPROIDetails As GridView = CType(frmView.FindControl("gvPROIDetails"), GridView) 'The Details grid

        If (CType(frmView.FindControl("gvPROIDetails"), GridView).SelectedIndex = -1) Then
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

        'PROIYear0Total += Convert.ToDecimal(CType(frm.FindControl("Year0"), TextBox).Text)
        'PROIYear1Total += Convert.ToDecimal(CType(frm.FindControl("Year1"), TextBox).Text)
        'PROIYear2Total += Convert.ToDecimal(CType(frm.FindControl("Year2"), TextBox).Text)
        'PROIYear3Total += Convert.ToDecimal(CType(frm.FindControl("Year3"), TextBox).Text)
        'PROIYear4Total += Convert.ToDecimal(CType(frm.FindControl("Year4"), TextBox).Text)
        UpdateNetCashFlow()

        If frmView.CurrentMode = FormViewMode.Edit Then
            drow("PurchaseRequestID") = CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text
        End If

        If (CType(frmView.FindControl("gvPROIDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmView.FindControl("gvPROIDetails"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("PROIDatatable") = dt
        CType(frmView.FindControl("gvPROIDetails"), GridView).DataSource = dt
        CType(frmView.FindControl("gvPROIDetails"), GridView).DataBind()
        CType(frmView.FindControl("proi_panel"), Panel).Visible = False
    End Sub
    Protected Sub CancelPROIButton_Click(sender As Object, e As EventArgs)
        CType(frmView.FindControl("proi_panel"), Panel).Visible = False
        Dim frm = CType(frmView.FindControl("proiDetails"), FormView)
        CType(frm.FindControl("BenefitsTextBox"), TextBox).Text = ""
        CType(frm.FindControl("year0"), TextBox).Text = ""
        CType(frm.FindControl("year1"), TextBox).Text = ""
        CType(frm.FindControl("year2"), TextBox).Text = ""
        CType(frm.FindControl("year3"), TextBox).Text = ""
        CType(frm.FindControl("year4"), TextBox).Text = ""
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

    Protected Sub AddProgramCostButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmView.FindControl("ProgramCostsPanel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub frmProgramCosts_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("PCDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmView.FindControl("frmProgramCosts"), FormView)
        Dim srow As GridViewRow = CType(frmView.FindControl("gvProgramCostsDetails"), GridView).SelectedRow 'Current selected row if any
        Dim gvProgramCostsDetails As GridView = CType(frmView.FindControl("gvProgramCostsDetails"), GridView) 'The Details grid

        If (CType(frmView.FindControl("gvProgramCostsDetails"), GridView).SelectedIndex = -1) Then
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


        If frmView.CurrentMode = FormViewMode.Edit Then
            drow("PurchaseRequestID") = CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text
        End If

        If (CType(frmView.FindControl("gvProgramCostsDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmView.FindControl("gvProgramCostsDetails"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("PCDatatable") = dt
        CType(frmView.FindControl("gvProgramCostsDetails"), GridView).DataSource = dt
        CType(frmView.FindControl("gvProgramCostsDetails"), GridView).DataBind()
        CType(frmView.FindControl("ProgramCostsPanel"), Panel).Visible = False
    End Sub

    Protected Sub CancelProgramCostButton_Click(sender As Object, e As EventArgs)
        CType(frmView.FindControl("ProgramCostsPanel"), Panel).Visible = False
        Dim frm = CType(frmView.FindControl("frmProgramCosts"), FormView)
        CType(frm.FindControl("ProgramCostTextBox"), TextBox).Text = ""
        CType(frm.FindControl("PCYear0"), TextBox).Text = ""
        CType(frm.FindControl("PCYear1"), TextBox).Text = ""
        CType(frm.FindControl("PCYear2"), TextBox).Text = ""
        CType(frm.FindControl("PCYear3"), TextBox).Text = ""
        CType(frm.FindControl("PCYear4"), TextBox).Text = ""
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

    Protected Sub CancelSuccessCriteriaButton_Click(sender As Object, e As EventArgs)
        CType(frmView.FindControl("SuccessCriteriaPanel"), Panel).Visible = False
        Dim frm = CType(frmView.FindControl("frmSuccessCriteria"), FormView)
        CType(frm.FindControl("SuccessCriteriaTextbox"), TextBox).Text = ""
        CType(frm.FindControl("BaselineID"), TextBox).Text = ""
        CType(frm.FindControl("Q1"), TextBox).Text = ""
        CType(frm.FindControl("Q2"), TextBox).Text = ""
        CType(frm.FindControl("Q3"), TextBox).Text = ""
        CType(frm.FindControl("Q4"), TextBox).Text = ""
        CType(frm.FindControl("Q5"), TextBox).Text = ""
        CType(frm.FindControl("Q6"), TextBox).Text = ""
    End Sub

    Protected Sub SuccessCriteriaButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmView.FindControl("SuccessCriteriaPanel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub frmSuccessCriteria_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("SCDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmView.FindControl("frmSuccessCriteria"), FormView)
        Dim srow As GridViewRow = CType(frmView.FindControl("gvSuccessCriteria"), GridView).SelectedRow 'Current selected row if any
        Dim gvSuccessCriteria As GridView = CType(frmView.FindControl("gvSuccessCriteria"), GridView) 'The Details grid

        If (CType(frmView.FindControl("gvSuccessCriteria"), GridView).SelectedIndex = -1) Then
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

        If frmView.CurrentMode = FormViewMode.Edit Then
            drow("PurchaseRequestID") = CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text
        End If

        If (CType(frmView.FindControl("gvSuccessCriteria"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmView.FindControl("gvSuccessCriteria"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("SCDatatable") = dt
        CType(frmView.FindControl("gvSuccessCriteria"), GridView).DataSource = dt
        CType(frmView.FindControl("gvSuccessCriteria"), GridView).DataBind()
        CType(frmView.FindControl("SuccessCriteriaPanel"), Panel).Visible = False

    End Sub

    Protected Sub AddImplementationButton_Click(sender As Object, e As EventArgs)
        Dim panel As Panel = CType(frmView.FindControl("ImplementationPanel"), Panel)
        If panel.Visible = False Then
            panel.Visible = True
        End If
    End Sub

    Protected Sub frmImplementation_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("FUPDatatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmView.FindControl("frmImplementation"), FormView)
        Dim srow As GridViewRow = CType(frmView.FindControl("gvImplementation"), GridView).SelectedRow 'Current selected row if any
        Dim gvProgramCostsDetails As GridView = CType(frmView.FindControl("gvImplementation"), GridView) 'The Details grid

        If (CType(frmView.FindControl("gvImplementation"), GridView).SelectedIndex = -1) Then
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

        If frmView.CurrentMode = FormViewMode.Edit Then
            drow("PurchaseRequestID") = CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text
        End If

        If (CType(frmView.FindControl("gvImplementation"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmView.FindControl("gvImplementation"), GridView).SelectedIndex = -1 'Remove the Selection
        End If

        ViewState("FUPDatatable") = dt
        CType(frmView.FindControl("gvImplementation"), GridView).DataSource = dt
        CType(frmView.FindControl("gvImplementation"), GridView).DataBind()
        CType(frmView.FindControl("ImplementationPanel"), Panel).Visible = False
    End Sub

    Protected Sub CancelImplementationButton_Click(sender As Object, e As EventArgs)
        CType(frmView.FindControl("ImplementationPanel"), Panel).Visible = False
        Dim frm = CType(frmView.FindControl("frmImplementation"), FormView)
        CType(frm.FindControl("EventTextbox"), TextBox).Text = ""
        CType(frm.FindControl("WhenID"), TextBox).Text = ""
        CType(frm.FindControl("ComplID"), TextBox).Text = ""
        CType(frm.FindControl("RespID"), TextBox).Text = ""
        CType(frm.FindControl("NotesID"), TextBox).Text = ""
    End Sub

    Protected Sub gvPROIDetails_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panelPROI As Panel = CType(frmView.FindControl("proi_panel"), Panel)
        Dim fvPROI As FormView = CType(frmView.FindControl("proiDetails"), FormView)
        Dim dtPROI As DataTable = New DataTable
        dtPROI = ViewState("PROIDatatable")
        Dim gvPROI As GridView = CType(frmView.FindControl("gvPROIDetails"), GridView)

        Dim dtRow As DataRow = dtPROI.Rows(gvPROI.SelectedRow.RowIndex)

        panelPROI.Visible = True
        CType(fvPROI.FindControl("BenefitsTextBox"), TextBox).Text = dtRow("Benefit")
        CType(fvPROI.FindControl("year0"), TextBox).Text = dtRow("PROI_Year0")
        CType(fvPROI.FindControl("year1"), TextBox).Text = dtRow("PROI_Year1")
        CType(fvPROI.FindControl("year2"), TextBox).Text = dtRow("PROI_Year2")
        CType(fvPROI.FindControl("year3"), TextBox).Text = dtRow("PROI_Year3")
        CType(fvPROI.FindControl("year4"), TextBox).Text = dtRow("PROI_Year4")
    End Sub

    Protected Sub gvProgramCostsDetails_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panelPC As Panel = CType(frmView.FindControl("ProgramCostsPanel"), Panel)
        Dim fvPC As FormView = CType(frmView.FindControl("frmProgramCosts"), FormView)
        Dim dtPC As DataTable = New DataTable
        dtPC = ViewState("PCDatatable")
        Dim gvPC As GridView = CType(frmView.FindControl("gvProgramCostsDetails"), GridView)

        Dim dtRow As DataRow = dtPC.Rows(gvPC.SelectedRow.RowIndex)

        panelPC.Visible = True
        CType(fvPC.FindControl("ProgramCostTextBox"), TextBox).Text = dtRow("ProgramCostDetail")
        CType(fvPC.FindControl("PCYear0"), TextBox).Text = dtRow("PC_Year0")
        CType(fvPC.FindControl("PCYear1"), TextBox).Text = dtRow("PC_Year1")
        CType(fvPC.FindControl("PCYear2"), TextBox).Text = dtRow("PC_Year2")
        CType(fvPC.FindControl("PCYear3"), TextBox).Text = dtRow("PC_Year3")
        CType(fvPC.FindControl("PCYear4"), TextBox).Text = dtRow("PC_Year4")
    End Sub

    Protected Sub gvSuccessCriteria_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panelSC As Panel = CType(frmView.FindControl("SuccessCriteriaPanel"), Panel)
        Dim fvSC As FormView = CType(frmView.FindControl("frmSuccessCriteria"), FormView)
        Dim dtSC As DataTable = New DataTable
        dtSC = ViewState("SCDatatable")
        Dim gvSC As GridView = CType(frmView.FindControl("gvSuccessCriteria"), GridView)

        Dim dtRow As DataRow = dtSC.Rows(gvSC.SelectedRow.RowIndex)

        panelSC.Visible = True
        CType(fvSC.FindControl("SuccessCriteriaTextbox"), TextBox).Text = dtRow("SuccessCriteriaDetail")
        CType(fvSC.FindControl("BaselineID"), TextBox).Text = dtRow("Baseline")
        CType(fvSC.FindControl("Q1"), TextBox).Text = dtRow("Q1")
        CType(fvSC.FindControl("Q2"), TextBox).Text = dtRow("Q2")
        CType(fvSC.FindControl("Q3"), TextBox).Text = dtRow("Q3")
        CType(fvSC.FindControl("Q4"), TextBox).Text = dtRow("Q4")
        CType(fvSC.FindControl("Q5"), TextBox).Text = dtRow("Q5")
        CType(fvSC.FindControl("Q6"), TextBox).Text = dtRow("Q6")
    End Sub

    Protected Sub gvImplementation_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panelFUP As Panel = CType(frmView.FindControl("ImplementationPanel"), Panel)
        Dim fvFUP As FormView = CType(frmView.FindControl("frmImplementation"), FormView)
        Dim dtFUP As DataTable = New DataTable
        dtFUP = ViewState("FUPDatatable")
        Dim gvFUP As GridView = CType(frmView.FindControl("gvImplementation"), GridView)

        Dim dtRow As DataRow = dtFUP.Rows(gvFUP.SelectedRow.RowIndex)

        panelFUP.Visible = True
        CType(fvFUP.FindControl("EventTextbox"), TextBox).Text = dtRow("Event")
        CType(fvFUP.FindControl("WhenID"), TextBox).Text = dtRow("FUPWhen")
        CType(fvFUP.FindControl("ComplID"), TextBox).Text = dtRow("Compl")
        CType(fvFUP.FindControl("RespID"), TextBox).Text = dtRow("Resp")
        CType(fvFUP.FindControl("NotesID"), TextBox).Text = dtRow("Notes")
    End Sub
End Class