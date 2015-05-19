Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit

Public Class Funnel
    Inherits System.Web.UI.Page


    Protected WithEvents GridView1 As Global.System.Web.UI.WebControls.GridView
    Protected WithEvents GridView2 As Global.System.Web.UI.WebControls.GridView    
    Protected WithEvents txtTotal As Global.System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPercentage As Global.System.Web.UI.WebControls.TextBox
    Dim Total As Decimal
    Dim Gridview2_Total As Decimal


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Debug.Print(User.IsInRole("LCLMTL\LCL_SELT"))
    End Sub

    Private Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim pan As Panel
        If e.Row.RowType = DataControlRowType.DataRow Then
            Select Case Trim(e.Row.Cells(0).Text)
                Case "PSS"
                    pan = CType(e.Row.FindControl("panel9"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel10"), Panel)
                    pan.Visible = True
                Case "Services"
                    pan = CType(e.Row.FindControl("panel11"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel12"), Panel)
                    pan.Visible = True
                Case "Wireless"
                    pan = CType(e.Row.FindControl("panel13"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel14"), Panel)
                    pan.Visible = True
                Case "RSMT PTL"
                    pan = CType(e.Row.FindControl("panel15"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel16"), Panel)
                    pan.Visible = True
            End Select
            'CType(e.Row.FindControl("DateValidator"), RangeValidator).MinimumValue = DateTime.Today
            'CType(e.Row.FindControl("DateValidator"), RangeValidator).MaximumValue = DateTime.Today.AddYears(2)
        End If
    End Sub

    Private Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        Dim pan As Panel
        If e.Row.RowType = DataControlRowType.DataRow Then
            Select Case Trim(e.Row.Cells(0).Text)
                Case "PSS"
                    pan = CType(e.Row.FindControl("panel9"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel10"), Panel)
                    pan.Visible = True
                Case "Services"
                    pan = CType(e.Row.FindControl("panel11"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel12"), Panel)
                    pan.Visible = True
                Case "Wireless"
                    pan = CType(e.Row.FindControl("panel13"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel14"), Panel)
                    pan.Visible = True
                Case "RSMT PTL"
                    pan = CType(e.Row.FindControl("panel15"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel16"), Panel)
                    pan.Visible = True
            End Select
            'CType(e.Row.FindControl("DateValidator"), RangeValidator).MinimumValue = DateTime.Today
            'CType(e.Row.FindControl("DateValidator"), RangeValidator).MaximumValue = DateTime.Today.AddYears(2)
        End If
    End Sub

    Sub GridView4_Databound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Gridview4.DataBound
        'Dim style As New Web.UI.WebControls.Style
        'Dim row As GridViewRow = Gridview4.HeaderRow
        'style.CssClass = "vertical"
        'For Each cell As TableCell In row.Cells
        '    cell.ApplyStyle(style)
        '    cell.Font.Size = 8
        '    cell.VerticalAlign = VerticalAlign.Middle
        '    cell.HorizontalAlign = HorizontalAlign.Center
        '    cell.Wrap = False
        'Next
    End Sub

    Sub Gridview4_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim selectedRow As GridViewRow = Gridview4.Rows(index)
            Dim ID As TableCell = selectedRow.Cells(1)
            Session("OpportunityID") = ID.Text
            lblnotification.Text = ""
            frmUpdate.DataBind()
            GridView2.DataBind()
            modalpopupextender1.Show()
        End If
    End Sub

    Public Sub refreshListView(ByVal sender As Object, ByVal e As EventArgs)
        Call Update(sender, e)
        modalpopupextender1.Hide()
        Gridview4.DataBind()
    End Sub

    Public Sub Cancel(ByVal sender As Object, ByVal e As EventArgs)
        modalpopupextender1.Hide()
        Gridview4.DataBind()
    End Sub

    Public Sub Update(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim tb As TextBox
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

            Dim SqlConnection As SqlConnection = New SqlConnection
            SqlConnection.ConnectionString = connectionString

            Dim SqlCommand As SqlCommand = New SqlCommand
            SqlCommand.CommandText = "UPDATE [Forecaster].[dbo].[tblOpportunities]  " & _
                                    "   SET [Originator] = @Originator             " & _
                                    "      ,[Customer] = @Customer             " & _
                                    "      ,[CustomerLocation] = @CustomerLocation " & _
                                    "      ,[EPCConsultant] = @EPCConsultant       " & _
                                    "      ,[SalesmanID] = @SalesmanID             " & _
                                    "      ,[Name] = @Name                         " & _
                                    "      ,[CreateDate] = @CreateDate             " & _
                                    "      ,[LastModifiedDate] = @LastModifiedDate " & _
                                    "      ,[LastModifiedBy] = @LastModifiedBy " & _
                                    "      ,[ClosingDate] = @ClosingDate           " & _
                                    "      ,[FunnelPositionID] = @FunnelPositionID " & _
                                    "      ,[Percentage] = @Percentage             " & _
                                    "      ,[PATTID] = @PattID	                   " & _
                                    "      ,[Description] = @Description           " & _
                                    "      ,[LaurentideSolution] = @LaurentideSolution           " & _
                                    "      ,[Top25] = @Top25           " & _
                                    "      ,[ExecSponsorID] = @ExecSponsorID           " & _
                                    "      ,[Outage] = @Outage           " & _
                                    " WHERE Opportunityid = @OpportunityID         "

            SqlCommand.Parameters.Add("@Originator", SqlDbType.VarChar, 50).Value = CType(Me.frmUpdate.FindControl("OriginatorTextBox"), Label).Text
            'SqlCommand.Parameters.Add("@CustomerID", SqlDbType.Int).Value = CType(Me.frmUpdate.FindControl("CustomerIDDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Customer", SqlDbType.VarChar, 100).Value = CType(Me.frmUpdate.FindControl("CustomerTextBox"), TextBox).Text
            SqlCommand.Parameters.Add("@CustomerLocation", SqlDbType.VarChar, 50).Value = CType(Me.frmUpdate.FindControl("CustomerLocationTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@EPCConsultant", SqlDbType.VarChar, 100).Value = CType(Me.frmUpdate.FindControl("EPCConsultantTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@SalesmanID", SqlDbType.Int).Value = CType(Me.frmUpdate.FindControl("SalesmanIDDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Name", SqlDbType.VarChar, 150).Value = CType(Me.frmUpdate.FindControl("NameTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@CreateDate", SqlDbType.DateTime).Value = CType(Me.frmUpdate.FindControl("CreateDateTextBox"), Label).Text
            SqlCommand.Parameters.Add("@LastModifiedDate", SqlDbType.DateTime).Value = Now()
            SqlCommand.Parameters.Add("@LastModifiedBy", SqlDbType.VarChar, 50).Value = Session("Username")
            SqlCommand.Parameters.Add("@ClosingDate", SqlDbType.DateTime).Value = IIf(CType(Me.frmUpdate.FindControl("ClosingDateTextBox"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("ClosingDateTextBox"), TextBox).Text)
            'SqlCommand.Parameters.Add("@Origin", SqlDbType.Char, 1).Value = IIf(CType(Me.frmUpdate.FindControl("OriginTextBox"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("OriginTextBox"), TextBox).Text)
            SqlCommand.Parameters.Add("@FunnelPositionID", SqlDbType.Int).Value = CType(Me.frmUpdate.FindControl("FunnelPositionDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Percentage", SqlDbType.Decimal, 4).Value = IIf(CType(Me.frmUpdate.FindControl("PercentageTextbox"), TextBox).Text = "", 0, CType(Me.frmUpdate.FindControl("PercentageTextbox"), TextBox).Text)
            SqlCommand.Parameters.Add("@PATTID", SqlDbType.Int).Value = IIf(CType(Me.frmUpdate.FindControl("PATTIDTextbox"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("PATTIDTextbox"), TextBox).Text)
            'SqlCommand.Parameters.Add("@Total", SqlDbType.Decimal, 20).Value = IIf(CType(Me.frmUpdate.FindControl("TotalTextbox"), TextBox).Text = "", 0, CType(Me.frmUpdate.FindControl("TotalTextbox"), TextBox).Text)
            'SqlCommand.Parameters.Add("@FactoredTotal", SqlDbType.Decimal, 20).Value = IIf(CType(Me.frmUpdate.FindControl("FactoredTotalTextBox"), TextBox).Text = "", 0, CType(Me.frmUpdate.FindControl("FactoredTotalTextBox"), TextBox).Text)
            SqlCommand.Parameters.Add("@Description", SqlDbType.VarChar, 255).Value = CType(Me.frmUpdate.FindControl("DescriptionTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@LaurentideSolution", SqlDbType.VarChar, 255).Value = CType(Me.frmUpdate.FindControl("LaurentideSolutionTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@Top25", SqlDbType.Bit).Value = CType(Me.frmUpdate.FindControl("chkTop25"), CheckBox).Checked
            SqlCommand.Parameters.Add("@IndustryCode", SqlDbType.Int).Value = CType(Me.frmUpdate.FindControl("IndustryCodeDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@ExecSponsorID", SqlDbType.Int).Value = CType(Me.frmUpdate.FindControl("ExecSponsorDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Outage", SqlDbType.Bit).Value = CType(Me.frmUpdate.FindControl("OutageCheckbox"), CheckBox).Checked
            SqlCommand.Parameters.Add("@OpportunityID", SqlDbType.Int).Value = Session("OpportunityID")
            SqlCommand.Connection = SqlConnection

            SqlConnection.Open()
            SqlCommand.ExecuteNonQuery()

            'Update product details
            Dim sb As StringBuilder = New StringBuilder
            'build the query
            For Each row In GridView2.Rows
                sb.Append("UPDATE tblOpportunityDetails SET Total = ")
                tb = DirectCast(row.findcontrol("txtTotal"), TextBox)
                sb.Append(tb.Text & ",Percentage = ")
                tb = DirectCast(row.findcontrol("txtPercentage"), TextBox)
                sb.Append(tb.Text & ",BookingDate = " & IIf(CType(row.findcontrol("txtBookingDate"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("txtBookingDate"), TextBox).Text & "',"))
                sb.Append("ExpectedRFQDate = " & IIf(CType(row.findcontrol("ExpectedRFQDate"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("ExpectedRFQDate"), TextBox).Text & "',"))
                sb.Append("DateRecInHouse = " & IIf(CType(row.findcontrol("DateRecInHouse"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("DateRecInHouse"), TextBox).Text & "',"))
                sb.Append("DueDate = " & IIf(CType(row.findcontrol("DueDate"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("DueDate"), TextBox).Text & "',"))
                sb.Append("ProposalEngLead = '")
                tb = DirectCast(row.findcontrol("ProposalEngLead"), TextBox)
                sb.Append(tb.Text & "',ProposalCoordinator = '")
                tb = DirectCast(row.findcontrol("ProposalCoordinator"), TextBox)
                sb.Append(tb.Text & "',ExecSponsor = '")
                tb = DirectCast(row.findcontrol("ExecSponsor"), TextBox)
                sb.Append(tb.Text & "',ProductSalesLead = '")
                tb = DirectCast(row.findcontrol("ProductSalesLead"), TextBox)
                sb.Append(tb.Text & "',CompetitiveMigration = '")
                tb = DirectCast(row.findcontrol("CompetitiveMigration"), TextBox)
                sb.Append(tb.Text & "',MigrationUpgrade = '")
                tb = DirectCast(row.findcontrol("MigrationUpgrade"), TextBox)
                sb.Append(tb.Text & "',TechLead = '")
                tb = DirectCast(row.findcontrol("TechLead"), TextBox)
                sb.Append(tb.Text & "',Project = '")
                tb = DirectCast(row.findcontrol("Project"), TextBox)
                sb.Append(tb.Text & "',SARenewal = '")
                tb = DirectCast(row.findcontrol("SARenewal"), TextBox)
                sb.Append(tb.Text & "',HW = '")
                tb = DirectCast(row.findcontrol("HW"), TextBox)
                sb.Append(tb.Text & "',SW = '")
                tb = DirectCast(row.findcontrol("SW"), TextBox)
                sb.Append(tb.Text & "',Buyouts = '")
                tb = DirectCast(row.findcontrol("Buyouts"), TextBox)
                sb.Append(tb.Text & "',Automation = '")
                tb = DirectCast(row.findcontrol("Automation"), TextBox)
                sb.Append(tb.Text & "',Engineering = '")
                tb = DirectCast(row.findcontrol("Engineering"), TextBox)
                sb.Append(tb.Text & "',Instrumentation = '")
                tb = DirectCast(row.findcontrol("Instrumentation"), TextBox)
                sb.Append(tb.Text & "',Reliability = '")
                tb = DirectCast(row.findcontrol("Reliability"), TextBox)
                sb.Append(tb.Text & "',SiteServices = '")
                tb = DirectCast(row.findcontrol("SiteServices"), TextBox)
                sb.Append(tb.Text & "',New = '")
                tb = DirectCast(row.findcontrol("New"), TextBox)
                sb.Append(tb.Text & "',FillGateway = '")
                tb = DirectCast(row.findcontrol("FillGateway"), TextBox)
                sb.Append(tb.Text & "',FillPlant = '")
                tb = DirectCast(row.findcontrol("FillPlant"), TextBox)
                sb.Append(tb.Text & "',Projects = '")
                tb = DirectCast(row.findcontrol("Projects"), TextBox)
                sb.Append(tb.Text & "',SalesSupport = '")
                tb = DirectCast(row.findcontrol("SalesSupport"), TextBox)
                sb.Append(tb.Text & "',Pressure = '")
                tb = DirectCast(row.findcontrol("Pressure"), TextBox)
                sb.Append(tb.Text & "',Temperature = '")
                tb = DirectCast(row.findcontrol("Temperature"), TextBox)
                sb.Append(tb.Text & "',Level = '")
                tb = DirectCast(row.findcontrol("Level"), TextBox)
                sb.Append("' WHERE OpportunityDetailID = ")
                sb.Append(GridView2.DataKeys(row.rowindex).Value.ToString)
                sb.Append(" ")
            Next

            SqlCommand.CommandText = sb.ToString
            SqlCommand.ExecuteNonQuery()

            'Set total
            SqlCommand.CommandText = "update tblopportunities set total = (select sum(total * (percentage/100)) from tblopportunitydetails where opportunityid = " & Session("OpportunityID") & ") where opportunityid =" & Session("OpportunityID")
            SqlCommand.ExecuteNonQuery()
            SqlConnection.Close()

            lblnotification.Text = "Updated " & Now.ToString
            frmUpdate.DataBind()
            GridView2.DataBind()
        Catch ex As Exception
            'MsgBox("Error in updating your opportunity, please take a screenshot, note the opportunity # or name, and send an email to IT")
            lblnotification.Text = ex.Message.ToString
        End Try
    End Sub

    Public Sub Insert(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim tb As TextBox
            Dim intLastIdentity As Integer
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

            Dim SqlConnection As SqlConnection = New SqlConnection
            SqlConnection.ConnectionString = connectionString

            Dim SqlCommand As SqlCommand = New SqlCommand
            SqlCommand.CommandText = "INSERT INTO [Forecaster].[dbo].[tblOpportunities]  " & _
                                    "([Originator],[Customer],[CustomerLocation],[EPCConsultant],[SalesmanID],[Name],[CreateDate],[LastModifiedDate],[LastModifiedBy],[ClosingDate],[FunnelPositionID],[Percentage],[PATTID],[Description],[LaurentideSolution],[Top25],[IndustryCodeID],[Outage])" & _
                                    "   VALUES (@Originator             " & _
                                    "      ,@Customer             " & _
                                    "      ,@CustomerLocation " & _
                                    "      ,@EPCConsultant       " & _
                                    "      ,@SalesmanID             " & _
                                    "      ,@Name                         " & _
                                    "      ,@CreateDate             " & _
                                    "      ,@LastModifiedDate " & _
                                    "      ,@LastModifiedBy " & _
                                    "      ,@ClosingDate           " & _
                                    "      ,@FunnelPositionID " & _
                                    "      ,@Percentage             " & _
                                    "      ,@PattID	                   " & _
                                    "      ,@Description	                   " & _
                                    "      ,@LaurentideSolution           " & _
                                    "      ,@Top25           " & _
                                    "      ,@IndustryCode" & _
                                    "      ,@Outage)           "
            SqlCommand.Parameters.Add("@Originator", SqlDbType.VarChar, 50).Value = CType(Me.frmInsert.FindControl("OriginatorTextBox"), Label).Text
            'SqlCommand.Parameters.Add("@CustomerID", SqlDbType.Int).Value = CType(Me.frmInsert.FindControl("CustomerIDDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Customer", SqlDbType.VarChar, 100).Value = CType(Me.frmInsert.FindControl("CustomerTextBox"), TextBox).Text
            SqlCommand.Parameters.Add("@CustomerLocation", SqlDbType.VarChar, 50).Value = CType(Me.frmInsert.FindControl("CustomerLocationTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@EPCConsultant", SqlDbType.VarChar, 100).Value = CType(Me.frmInsert.FindControl("EPCConsultantTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@SalesmanID", SqlDbType.Int).Value = CType(Me.frmInsert.FindControl("SalesmanIDDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Name", SqlDbType.VarChar, 150).Value = CType(Me.frmInsert.FindControl("NameTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@CreateDate", SqlDbType.DateTime).Value = Now()
            SqlCommand.Parameters.Add("@LastModifiedDate", SqlDbType.DateTime).Value = Now()
            SqlCommand.Parameters.Add("@LastModifiedBy", SqlDbType.VarChar, 50).Value = Session("Username")
            SqlCommand.Parameters.Add("@ClosingDate", SqlDbType.DateTime).Value = IIf(CType(Me.frmInsert.FindControl("ClosingDateTextBox"), TextBox).Text = "", DBNull.Value, CType(Me.frmInsert.FindControl("ClosingDateTextBox"), TextBox).Text)
            'SqlCommand.Parameters.Add("@Origin", SqlDbType.Char, 1).Value = IIf(CType(Me.frmInsert.FindControl("OriginTextBox"), TextBox).Text = "", DBNull.Value, CType(Me.frmInsert.FindControl("OriginTextBox"), TextBox).Text)
            SqlCommand.Parameters.Add("@FunnelPositionID", SqlDbType.Int).Value = CType(Me.frmInsert.FindControl("FunnelPositionDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Percentage", SqlDbType.Decimal, 4).Value = IIf(CType(Me.frmInsert.FindControl("PercentageTextbox"), TextBox).Text = "", 0, CType(Me.frmInsert.FindControl("PercentageTextbox"), TextBox).Text)
            SqlCommand.Parameters.Add("@PATTID", SqlDbType.Int).Value = IIf(CType(Me.frmInsert.FindControl("PATTIDTextbox"), TextBox).Text = "", DBNull.Value, CType(Me.frmInsert.FindControl("PATTIDTextbox"), TextBox).Text)
            'SqlCommand.Parameters.Add("@Total", SqlDbType.Decimal, 20).Value = IIf(CType(Me.frmInsert.FindControl("TotalTextbox"), TextBox).Text = "", 0, CType(Me.frmInsert.FindControl("TotalTextbox"), TextBox).Text)
            'SqlCommand.Parameters.Add("@FactoredTotal", SqlDbType.Decimal, 20).Value = IIf(CType(Me.frmInsert.FindControl("FactoredTotalTextBox"), TextBox).Text = "", 0, CType(Me.frmInsert.FindControl("FactoredTotalTextBox"), TextBox).Text)
            SqlCommand.Parameters.Add("@Description", SqlDbType.VarChar, 255).Value = CType(Me.frmInsert.FindControl("DescriptionTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@LaurentideSolution", SqlDbType.VarChar, 255).Value = CType(Me.frmInsert.FindControl("LaurentideSolutionTextbox"), TextBox).Text
            SqlCommand.Parameters.Add("@Top25", SqlDbType.Bit).Value = CType(Me.frmInsert.FindControl("chkTop25"), CheckBox).Checked
            SqlCommand.Parameters.Add("@IndustryCode", SqlDbType.Int).Value = CType(Me.frmInsert.FindControl("IndustryCodeDropDown"), DropDownList).Text
            SqlCommand.Parameters.Add("@Outage", SqlDbType.Int).Value = CType(Me.frmInsert.FindControl("OutageCheckbox"), CheckBox).Checked
            'SqlCommand.Parameters.Add("@OpportunityID", SqlDbType.Int).Value = Session("OpportunityID")
            SqlCommand.Connection = SqlConnection

            SqlConnection.Open()
            SqlCommand.ExecuteNonQuery()

            SqlCommand.CommandText = "SELECT @@IDENTITY AS 'Identity'"
            intLastIdentity = SqlCommand.ExecuteScalar

            'Update product details
            Dim sb As StringBuilder = New StringBuilder
            'build the query
            For Each row In GridView1.Rows
                sb.Append("INSERT into tblOpportunityDetails (OpportunityID, FunnelProductID, Total, Percentage, BookingDate, ExpectedRFQDate, DateRecInHouse, ")
                sb.Append("DueDate, ProposalEngLead, ProposalCoordinator, ExecSponsor, ProductSalesLead, CompetitiveMigration, MigrationUpgrade, TechLead, Project,")
                sb.Append("SARenewal, HW, SW, Buyouts, Automation, Engineering, Instrumentation, Reliability, SiteServices, New, FillGateway, FillPlant, Projects, SalesSupport, Pressure, Temperature, Level) VALUES (")

                sb.Append(intLastIdentity & ",")

                sb.Append(row.rowindex + 1 & ",")

                tb = DirectCast(row.findcontrol("txtTotal"), TextBox)
                sb.Append(tb.Text & ",")
                tb = DirectCast(row.findcontrol("txtPercentage"), TextBox)
                sb.Append(tb.Text & ",")
                sb.Append(IIf(CType(row.findcontrol("txtBookingDate"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("txtBookingDate"), TextBox).Text & "',"))
                sb.Append(IIf(CType(row.findcontrol("ExpectedRFQDate"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("ExpectedRFQDate"), TextBox).Text & "',"))
                sb.Append(IIf(CType(row.findcontrol("DateRecInHouse"), TextBox).Text = "", "null,", "'" & CType(row.findcontrol("DateRecInHouse"), TextBox).Text & "',"))
                sb.Append(IIf(CType(row.findcontrol("DueDate"), TextBox).Text = "", "null,'", "'" & CType(row.findcontrol("DueDate"), TextBox).Text & "','"))
                tb = DirectCast(row.findcontrol("ProposalEngLead"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("ProposalCoordinator"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("ExecSponsor"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("ProductSalesLead"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("CompetitiveMigration"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("MigrationUpgrade"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("TechLead"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Project"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("SARenewal"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("HW"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("SW"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Buyouts"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Automation"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Engineering"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Instrumentation"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Reliability"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("SiteServices"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("New"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("FillGateway"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("FillPlant"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Projects"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("SalesSupport"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Pressure"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Temperature"), TextBox)
                sb.Append(tb.Text & "','")
                tb = DirectCast(row.findcontrol("Level"), TextBox)
                sb.Append("') ")
            Next

            SqlCommand.CommandText = sb.ToString
            SqlCommand.ExecuteNonQuery()

            'Set total
            SqlCommand.CommandText = "update tblopportunities set total = (select sum(total * (percentage/100)) from tblopportunitydetails where opportunityid = " & intLastIdentity & ") where opportunityid =" & intLastIdentity
            SqlCommand.ExecuteNonQuery()


            'Add other salesmen
            Dim lst As List(Of Object)
            Dim salesmanID As String = ""
            If Not CType(ViewState("List"), List(Of Object)) Is Nothing Then
                lst = CType(ViewState("List"), List(Of Object))
                For Each itm In lst
                    If itm <> 0 Then
                        SqlCommand.CommandText = "INSERT INTO [Forecaster].[dbo].[tblOpportunityAssignments]  ([OpportunityID],[SalesmanID])" & _
                                                 " VALUES (" & intLastIdentity & "," & itm & ")"
                        SqlCommand.ExecuteNonQuery()
                    End If
                Next
            End If

            SqlConnection.Close()

            Gridview4.DataBind()
            System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE=""JavaScript"">alert(""Opportunity added successfully!"")</SCRIPT>")
            Server.Transfer("Funnel.aspx")
        Catch ex As Exception
            'MsgBox("Error in creating your opportunity, please take a screenshot, note the opportunity # or name, and send an email to IT")
        End Try
    End Sub

    Protected Sub GridView1_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)

    End Sub

    Protected Sub GridView2_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType <> 0 And e.Row.RowType <> 1 Then
            If CType(e.Row.FindControl("txtTotal"), TextBox).Text <> "" And CType(e.Row.FindControl("txtPercentage"), TextBox).Text <> "" Then
                Gridview2_Total += CDec(CType(e.Row.FindControl("txtTotal"), TextBox).Text) * (CDec(CType(e.Row.FindControl("txtPercentage"), TextBox).Text) * 0.01)
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total:"
            e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Right
            e.Row.Cells(1).Text = String.Format("{0:c0}k", Gridview2_Total)
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
        End If
    End Sub

    Public Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

        Dim SqlConnection As SqlConnection = New SqlConnection
        SqlConnection.ConnectionString = connectionString

        Dim SqlCommand As SqlCommand = New SqlCommand
        SqlCommand.CommandText = "update tblopportunities set funnelpositionid = 9 where opportunityid = " & CType(frmUpdate.FindControl("OpportunityIDLabel"), Label).Text

        SqlCommand.Connection = SqlConnection
        SqlConnection.Open()
        SqlCommand.ExecuteNonQuery()

        'SqlCommand.CommandText = "Delete from tblOpportunityDetails where opportunityid = " & CType(frmUpdate.FindControl("OpportunityIDLabel"), Label).Text
        'SqlCommand.ExecuteNonQuery()

        SqlConnection.Close()

        modalpopupextender1.Hide()
        Gridview4.DataBind()
    End Sub

    Public Sub btnFilter_onClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim str As String
        Dim lbitem As ListItem
        str = ""
        For Each itm In cblFunnelPositions.Items
            lbitem = CType(itm, ListItem)
            If lbitem.Selected Then
                str = str & lbitem.Value & ","
            End If
        Next
        str = str.TrimEnd(",")
        Session("funnelpositionid") = IIf(str = "", "0", str)

        str = ""
        For Each itm In cblProducts.Items
            lbitem = CType(itm, ListItem)
            If lbitem.Selected Then
                str = str & lbitem.Value & ","
            End If
        Next
        str = str.TrimEnd(",")
        Session("funnelproductid") = IIf(str = "", "0", str)

        str = ""
        For Each itm In Me.lbIndustryCodes.Items
            lbitem = CType(itm, ListItem)
            If lbitem.Selected Then
                str = str & lbitem.Value & ","
            End If
        Next
        str = str.TrimEnd(",")
        Session("industrycodes") = IIf(str = "", "0", str)
        sdsGetOpportunities.FilterExpression = ""
    End Sub

    Public Sub btnClear_onClick(ByVal sender As Object, ByVal e As EventArgs)
        Me.ddlSalesmen.SelectedValue = 0
        Me.cblFunnelPositions.ClearSelection()
        Me.cblProducts.ClearSelection()
        Me.ClosingEndDateTextBox.Text = ""
        Me.ClosingStartDateTextBox.Text = ""
        Me.txtCustomerFilter.Text = ""
        Me.lbIndustryCodes.ClearSelection()
        Me.ddlExecSponsors.SelectedValue = 0
        Session("funnelpositionid") = 0
        Session("funnelproductid") = 0
        Session("industrycodes") = 0
        'Me.chkTop25Filter.Checked = False
        rblTop25Filter.SelectedValue = 3
        Me.CreatedEndDateTextBox.Text = ""
        Me.CreatedStartDateTextBox.Text = ""
        Gridview4.DataBind()
    End Sub

    Public Sub SalesmanIDDropDown_OnDataBound(ByVal sender As Object, ByVal e As EventArgs)
        CType(Me.frmInsert.FindControl("SalesmanIDDropDown"), DropDownList).Items.Insert(0, New ListItem(String.Empty, 0))
        CType(Me.frmInsert.FindControl("SalesmanIDDropDown"), DropDownList).SelectedIndex = 0
    End Sub

    Public Sub ibClosingDate_OnClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim strClosingDate As String
        Dim row As GridViewRow
        strClosingDate = CType(CType(CType(panEdit.FindControl("Accordion2"), Accordion).FindControl("frmUpdate"), FormView).FindControl("ClosingDateTextBox"), TextBox).Text
        If strClosingDate <> "" Then
            For Each row In Me.GridView2.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    If CType(row.FindControl("txtTotal"), TextBox).Text <> "0" Then
                        CType(row.FindControl("txtBookingDate"), TextBox).Text = strClosingDate
                    End If
                End If
            Next
        End If
    End Sub

    Public Sub ibInsertClosingDate_OnClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim strClosingDate As String
        Dim row As GridViewRow
        strClosingDate = CType(CType(CType(insertPane.FindControl("accordion3"), Accordion).FindControl("frmInsert"), FormView).FindControl("ClosingDateTextBox"), TextBox).Text
        If strClosingDate <> "" Then
            For Each row In Me.GridView1.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    If CType(row.FindControl("txtTotal"), TextBox).Text <> "0" Then
                        CType(row.FindControl("txtBookingDate"), TextBox).Text = strClosingDate
                    End If
                End If
            Next
        End If
    End Sub

    Public Sub ResetInsertForm()

    End Sub

    Protected Sub BindGridViewData(ByVal gridV As GridView)
        Try
            Dim lst As New List(Of Object)
            lst = CType(ViewState("List"), List(Of Object))
            gridV.DataSource = lst.ToList
            gridV.DataBind()
        Catch ex As Exception

        End Try

    End Sub

    ' called by the front end when a linkbutton is pushed 
    Protected Sub gvMyGrid_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        Dim lst As List(Of Object)
        Dim salesmanID As String = ""

        If (e.CommandName.Substring(0, 3) = "ADD") Then
            If CType(ViewState("List"), List(Of Object)) Is Nothing Then
                lst = New List(Of Object)
            Else
                lst = CType(ViewState("List"), List(Of Object))
            End If
            ' based on the Command name retrieve the data
            If (e.CommandName = "ADD") Then
                salesmanID = CType(sender.FooterRow.FindControl("OtherContributorsDropDown_Foot"), DropDownList).Text
            Else
                ' when the grid is empty
                salesmanID = CType(CType(sender, GridView).Controls(0).Controls(0).FindControl("NewContributor"), DropDownList).Text
            End If
            If salesmanID <> 0 Then
                lst.Add(salesmanID)
                ViewState("List") = lst
                BindGridViewData(sender)
            End If
        End If

    End Sub
    Protected Sub gvMyGrid_RowDeleting(ByVal sender As Object, ByVal e As GridViewDeleteEventArgs)
        Dim lst As List(Of Object)
        If CType(ViewState("List"), List(Of Object)) Is Nothing Then
            lst = New List(Of Object)
        Else
            lst = CType(ViewState("List"), List(Of Object))
        End If
        lst.RemoveAt(e.RowIndex)
        ViewState("List") = lst
        BindGridViewData(sender)
    End Sub

    Protected Sub gvAssignments_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        Dim salesmanID As String = ""
        If (e.CommandName.Substring(0, 3) = "ADD") Then

            ' based on the Command name retrieve the data
            If (e.CommandName = "ADD") Then
                salesmanID = CType(sender.FooterRow.FindControl("OtherContributorsDropDown_Foot"), DropDownList).Text
            Else
                ' when the grid is empty
                salesmanID = CType(CType(sender, GridView).Controls(0).Controls(0).FindControl("NewContributor"), DropDownList).Text
            End If
            If salesmanID <> 0 Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

                Dim SqlConnection As SqlConnection = New SqlConnection
                SqlConnection.ConnectionString = connectionString

                Dim SqlCommand As SqlCommand = New SqlCommand
                SqlCommand.CommandText = "insert into tblOpportunityAssignments (opportunityid,salesmanid) values (" & CType(CType(CType(sender, GridView).Parent.Parent.Parent.Parent, FormView).FindControl("OpportunityIDLabel"), Label).Text & "," & salesmanID & ")"
                SqlCommand.Connection = SqlConnection
                SqlConnection.Open()
                SqlCommand.ExecuteNonQuery()

                SqlConnection.Close()

                CType(sender, GridView).DataBind()
            End If
        End If
        modalpopupextender1.Show()
    End Sub
    Protected Sub gvAssignments_RowDeleting(ByVal sender As Object, ByVal e As GridViewDeleteEventArgs)
        'Dim OpportunityAssignmentID As String
        'Dim connectionString As String
        'connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

        'Dim SqlConnection As SqlConnection = New SqlConnection
        'SqlConnection.ConnectionString = connectionString

        'Dim SqlCommand As SqlCommand = New SqlCommand

        'OpportunityAssignmentID = ctype(CType(sender, GridView).Rows(e.RowIndex).FindControl("OpportunityAssignmentID"),Label).Text

        'SqlCommand.CommandText = "delete from tblOpportunityAssignments Where OpportunityAssignmentid = " & OpportunityAssignmentID
        'SqlCommand.Connection = SqlConnection
        'SqlConnection.Open()
        'SqlCommand.ExecuteNonQuery()

        'SqlConnection.Close()
        'CType(sender, GridView).DataBind()
        'modalpopupextender1.Show()
    End Sub

    Protected Sub gvAssignments_RowDeleted(ByVal sender As Object, ByVal e As EventArgs)
        modalpopupextender1.Show()
    End Sub

    Protected Sub frmUpdate_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Try
            CType(frmUpdate.FindControl("OriginatorTextBox"), TextBox).Text = Me.User.Identity.Name.ToString
            sdsOpportunityAssignments.SelectParameters(0).DefaultValue = CType(CType(sender, FormView).FindControl("OpportunityIDLabel"), Label).Text
            CType(CType(sender, FormView).FindControl("gvAssignments"), GridView).DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ibProductLead_Click(sender As Object, e As ImageClickEventArgs)
        Dim strSalesLead As String
        Dim row As GridViewRow
        strSalesLead = CType(CType(CType(panEdit.FindControl("Accordion2"), Accordion).FindControl("frmUpdate"), FormView).FindControl("SalesmanIDDropDown"), DropDownList).SelectedItem.Text
        If strSalesLead <> "" Then
            For Each row In Me.GridView2.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    If CType(row.FindControl("txtTotal"), TextBox).Text <> "0" Then
                        CType(row.FindControl("ProductSalesLead"), TextBox).Text = strSalesLead
                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        CType(frmInsert.FindControl("OriginatorTextBox"), TextBox).Text = Me.User.Identity.Name.ToString
    End Sub
End Class