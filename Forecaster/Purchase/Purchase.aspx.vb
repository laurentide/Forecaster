Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Data.SqlTypes

Public Class Purchase
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
        Session("DateRequested") = Now()

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

    ' Date: 2/18/2013
    ' Author: Duc Duy Nguyen
    ' Sub to send email to managers
    '
    Protected Sub frmInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        Dim row As DataRow
        'add the projected roi details
        'get the datatable underlying the gridview
        Dim dt As New DataTable
        dt = CType(ViewState("PROIDatatable"), DataTable)

        'populate the expensereportid from the newly added expense report to the details
        For Each row In dt.Rows
            row("PurchaseRequestID") = Session("ID")
        Next

        Console.WriteLine(Session("id"))

        Dim connectionstringproi As String
        connectionstringproi = "server=lcl-sql2k5-s;database=PurchaseRequest;trusted_connection=true"

        Using destinationconnection As SqlConnection = New SqlConnection(connectionstringproi)
            destinationconnection.Open()

            Using bulkcopy As SqlBulkCopy = _
              New SqlBulkCopy(destinationconnection)
                bulkcopy.DestinationTableName = _
                "dbo.tblprojectedroi"

                Try
                    ' write from the source to the destination.
                    bulkcopy.WriteToServer(dt)

                Catch ex As Exception
                    Debug.Print(ex.Message)
                End Try
            End Using
            destinationconnection.Close()
        End Using
        'gvexpensereports.databind()
        dt.Clear()
        ViewState("PROIDatatable") = dt

        Dim pcrow As DataRow
        'add the program cost 
        'get the datatable underlying the gridview
        Dim pcdt As New DataTable
        pcdt = CType(ViewState("PCDatatable"), DataTable)

        'populate the expensereportid from the newly added expense report to the details
        For Each pcrow In pcdt.Rows
            pcrow("PurchaseRequestID") = Session("ID")
        Next

        Console.WriteLine(Session("id"))

        Dim pcconnectionstring As String
        pcconnectionstring = "server=lcl-sql2k5-s;database=PurchaseRequest;trusted_connection=true"

        Using pcdestinationconnection As SqlConnection = New SqlConnection(pcconnectionstring)
            pcdestinationconnection.Open()

            Using pcbulkcopy As SqlBulkCopy = _
              New SqlBulkCopy(pcdestinationconnection)
                pcbulkcopy.DestinationTableName = _
                "dbo.tblprogramcost"

                Try
                    ' write from the source to the destination.
                    pcbulkcopy.WriteToServer(pcdt)

                Catch ex As Exception
                    Debug.Print(ex.Message)
                End Try
            End Using
            pcdestinationconnection.Close()
        End Using
        'gvexpensereports.databind()
        pcdt.Clear()
        ViewState("PCDatatable") = pcdt

        Dim scrow As DataRow
        'add the successcriteria
        'get the datatable underlying the gridview
        Dim scdt As New DataTable
        scdt = CType(ViewState("SCDatatable"), DataTable)

        'populate the nerid from the newly added expense report to the details
        For Each scrow In scdt.Rows
            scrow("PurchaseRequestID") = Session("ID")
        Next

        Console.WriteLine(Session("ID"))

        Dim scconnectionstring As String
        scconnectionstring = "server=lcl-sql2k5-s;database=PurchaseRequest;trusted_connection=true"

        Using scdestinationconnection As SqlConnection = New SqlConnection(scconnectionstring)
            scdestinationconnection.Open()

            Using scbulkcopy As SqlBulkCopy = _
              New SqlBulkCopy(scdestinationconnection)
                scbulkcopy.DestinationTableName = _
                "dbo.tblsuccesscriteria"

                Try
                    ' write from the source to the destination.
                    scbulkcopy.WriteToServer(scdt)

                Catch ex As Exception
                    Debug.Print(ex.Message)
                End Try
            End Using
            scdestinationconnection.Close()
        End Using
        'gvexpensereports.databind()
        scdt.Clear()
        ViewState("SCDatatable") = scdt

        Dim fuprow As DataRow
        'add the implementation/follow-up plan
        'get the datatable underlying the gridview
        Dim fupdt As New DataTable
        fupdt = CType(ViewState("FUPDatatable"), DataTable)

        'populate the nerid from the newly added expense report to the details
        For Each fuprow In fupdt.Rows
            fuprow("PurchaseRequestID") = Session("ID")
        Next

        Console.WriteLine(Session("ID"))

        Dim fupconnectionstring As String
        fupconnectionstring = "server=lcl-sql2k5-s;database=PurchaseRequest;trusted_connection=true"

        Using fupdestinationconnection As SqlConnection = New SqlConnection(fupconnectionstring)
            fupdestinationconnection.Open()

            Using fupbulkcopy As SqlBulkCopy = _
              New SqlBulkCopy(fupdestinationconnection)
                fupbulkcopy.DestinationTableName = _
                "dbo.tblfup"

                Try
                    ' write from the source to the destination.
                    fupbulkcopy.WriteToServer(fupdt)

                Catch ex As Exception
                    Debug.Print(ex.Message)
                End Try
            End Using
            fupdestinationconnection.Close()
        End Using
        'gvexpensereports.databind()
        fupdt.Clear()
        ViewState("FUPDatatable") = fupdt

        Dim ISconnectionString As String
        ISconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim ISSqlConnection As New SqlConnection(ISconnectionString)
        ISSqlConnection.Open()
        Dim InvestmentOwner As String = CType(frmInsert.FindControl("InvestmentOwnerID"), TextBox).Text
        Dim InvestmentStartDate As String = CType(frmInsert.FindControl("ISD_TextBox"), TextBox).Text
        Dim InvestmentDefinition As String = CType(frmInsert.FindControl("DOF_ID"), TextBox).Text
        Dim InvestmentLaurentideBenefit As String = CType(frmInsert.FindControl("BenefitTextBox"), TextBox).Text
        Dim ContingencyPlan As String = CType(frmInsert.FindControl("ContingencyPlanTextbox"), TextBox).Text
        Dim ISupdate As New SqlCommand("update tblPurchaseRequests set InvestmentOwner = '" & InvestmentOwner & "', InvestmentStartDate = '" & InvestmentStartDate & "', InvestmentDefinition = '" & InvestmentDefinition & "', InvestmentLaurentideBenefit = '" & InvestmentLaurentideBenefit & "', ContingencyPlan = '" & ContingencyPlan & "' where PurchaseRequestID = " & Session("ID") & "", ISSqlConnection)
        ISupdate.ExecuteNonQuery()
        ISSqlConnection.Close()

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        'Copy the files
        Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\Puchase Request Tool\" & Session("ID") & "\"
        System.IO.Directory.CreateDirectory(savePath)

        If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
            CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
            Dim updatecommand As New SqlCommand("update tblPurchaseRequests set Filename = '" & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "', Path = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where PurchaseRequestID = " & Session("ID"), SqlConnection)
            updatecommand.ExecuteNonQuery()
        End If
        Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
        Dim reader As SqlDataReader = sc.ExecuteReader()
        reader.Read()
        Dim managerEmail As String = reader.GetString(0)
        reader.Close()

        Dim body As String = "Requested By: " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text & vbCrLf & _
                             "Item: " & CType(frmInsert.FindControl("ItemNameTextbox"), TextBox).Text & vbCrLf & _
                             "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                             "Reason: " & CType(frmInsert.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                             "Quantity: " & CType(frmInsert.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                             "Cost not to exceed: " & CType(frmInsert.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                             "Date Required: " & CType(frmInsert.FindControl("DateRequiredTextBox"), TextBox).Text & vbCrLf & _
                             "Please go to this address: http://lcl-sql2k5-s:81/Purchase/PurchaseManager.aspx to approve it!"
        Dim mm As New MailMessage(CType(frmInsert.FindControl("RequesterEmailTextbox"), TextBox).Text, managerEmail, "New Purchase Request by " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text, body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text)
        mm.CC.Add(mailaddress)
        Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
        smtp.Send(mm)
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        'update gridview
        gvPurchaseRequests.DataBind()
    End Sub


    Protected Sub gvPurchaseRequests_SelectedIndexChanged1(sender As Object, e As EventArgs)
        'When selecting in gridview, put formview to edit
        frmInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub frmInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        Dim dt As New DataTable
        dt = CType(ViewState("PROIDatatable"), DataTable)

        Dim PROIconnectionString As String
        PROIconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

        Using destinationConnection As SqlConnection = New SqlConnection(PROIconnectionString)
            destinationConnection.Open()
            Try

                Dim sqlcommand As New SqlCommand("Delete from tblProjectedROI where PurchaseRequestID = " & CType(Me.frmInsert.FindControl("IDLabel"), Label).Text)
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
        gvPurchaseRequests.DataBind()
        dt.Clear()
        ViewState("PROIDatatable") = dt

        Dim PCdt As New DataTable
        PCdt = CType(ViewState("PCDatatable"), DataTable)

        Dim PCconnectionString As String
        PCconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

        Using PCdestinationConnection As SqlConnection = New SqlConnection(PCconnectionString)
            PCdestinationConnection.Open()
            Try

                Dim PCsqlcommand As New SqlCommand("Delete from tblProgramCost where PurchaseRequestID = " & CType(Me.frmInsert.FindControl("IDLabel"), Label).Text)
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
        gvPurchaseRequests.DataBind()
        PCdt.Clear()
        ViewState("PCDatatable") = PCdt

        Dim SCdt As New DataTable
        SCdt = CType(ViewState("SCDatatable"), DataTable)

        Dim SCconnectionString As String
        SCconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

        Using SCdestinationConnection As SqlConnection = New SqlConnection(SCconnectionString)
            SCdestinationConnection.Open()
            Try

                Dim SCsqlcommand As New SqlCommand("Delete from tblSuccessCriteria where PurchaseRequestID = " & CType(Me.frmInsert.FindControl("IDLabel"), Label).Text)
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
        gvPurchaseRequests.DataBind()
        SCdt.Clear()
        ViewState("SCDatatable") = SCdt

        Dim FUPdt As New DataTable
        FUPdt = CType(ViewState("FUPDatatable"), DataTable)

        Dim FUPconnectionString As String
        FUPconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

        Using FUPdestinationConnection As SqlConnection = New SqlConnection(FUPconnectionString)
            FUPdestinationConnection.Open()
            Try

                Dim FUPsqlcommand As New SqlCommand("Delete from tblFUP where PurchaseRequestID = " & CType(Me.frmInsert.FindControl("IDLabel"), Label).Text)
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
        gvPurchaseRequests.DataBind()
        FUPdt.Clear()
        ViewState("FUPDatatable") = FUPdt
        Dim ISconnectionString As String
        ISconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim ISSqlConnection As New SqlConnection(ISconnectionString)
        ISSqlConnection.Open()
        Dim InvestmentOwner As String = CType(frmInsert.FindControl("InvestmentOwnerID"), TextBox).Text
        Dim InvestmentStartDate As String = CType(frmInsert.FindControl("ISD_TextBox"), TextBox).Text
        Dim InvestmentDefinition As String = CType(frmInsert.FindControl("DOF_ID"), TextBox).Text
        Dim InvestmentLaurentideBenefit As String = CType(frmInsert.FindControl("BenefitTextBox"), TextBox).Text
        Dim ContingencyPlan As String = CType(frmInsert.FindControl("ContingencyPlanTextbox"), TextBox).Text
        Dim ISupdate As New SqlCommand("update tblPurchaseRequests set InvestmentOwner = '" & InvestmentOwner & "', InvestmentStartDate = '" & InvestmentStartDate & "', InvestmentDefinition = '" & InvestmentDefinition & "', InvestmentLaurentideBenefit = '" & InvestmentLaurentideBenefit & "', ContingencyPlan = '" & ContingencyPlan & "' where PurchaseRequestID = " & CType(Me.frmInsert.FindControl("IDLabel"), Label).Text & "", ISSqlConnection)
        ISupdate.ExecuteNonQuery()
        ISSqlConnection.Close()



        'Sub to send an email to the manager with the requester in CC to alert the manager that he needs to approve something.
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        'Copy the files
        Dim savePath As String = "\\lcl-fil1\directory_2000\Administration\LCL\Corporate\Puchase Request Tool\" & CType(frmInsert.FindControl("IDLabel"), Label).Text & "\"
        System.IO.Directory.CreateDirectory(savePath)

        If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
            CType(frmInsert.FindControl("fudialog"), FileUpload).SaveAs(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName)
            Dim updatecommand As New SqlCommand("update tblPurchaseRequests set Filename = '" & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "', Path = '" & savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName & "' where PurchaseRequestID = " & CType(frmInsert.FindControl("IDLabel"), Label).Text, SqlConnection)
            updatecommand.ExecuteNonQuery()
        End If

        Dim sc As New SqlCommand("select managerEmail from tblManagers where managerid = " & CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedValue.ToString, SqlConnection)
        Dim reader As SqlDataReader = sc.ExecuteReader()
        reader.Read()
        Dim managerEmail As String = reader.GetString(0)
        reader.Close()

        Dim body As String = "Requested By: " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text & vbCrLf & _
                             "Item: " & CType(frmInsert.FindControl("ItemNameTextbox"), TextBox).Text & vbCrLf & _
                             "Description: " & CType(frmInsert.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                             "Reason: " & CType(frmInsert.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                             "Quantity: " & CType(frmInsert.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                             "Cost not to exceed: " & CType(frmInsert.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                             "Date Required: " & CType(frmInsert.FindControl("DateRequiredTextBox"), TextBox).Text & vbCrLf & _
                             "Please go to this address: http://lcl-sql2k5-s:81/Purchase/PurchaseManager.aspx to review it!"
        Dim mm As New MailMessage(CType(frmInsert.FindControl("RequesterEmailTextbox"), TextBox).Text, managerEmail, "Purchase Request updated by " & CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text, body)
        Dim mailaddress As New MailAddress(CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text)
        mm.CC.Add(mailaddress)
        Try
            If (CType(frmInsert.FindControl("fudialog"), FileUpload).HasFile) Then
                mm.Attachments.Add(New Attachment(savePath & CType(frmInsert.FindControl("fudialog"), FileUpload).FileName))
            Else
                mm.Attachments.Add(New Attachment(CType(frmInsert.FindControl("PathTextbox"), HyperLink).Text))
            End If
        Catch ex As Exception
        End Try
        Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
        smtp.Send(mm)
        'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        'update gridview
        gvPurchaseRequests.DataBind()
    End Sub


    Sub ManagerDropDown_CustomValidation(source As Object, args As ServerValidateEventArgs)
        Dim managerName As String
        managerName = CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
        Dim SqlConnection As New SqlConnection(connectionString)
        SqlConnection.Open()

        Dim sc As New SqlCommand("select approvallimit from tblManagers where managerName = '" & managerName & "'", SqlConnection)
        Dim reader As SqlDataReader = sc.ExecuteReader()
        reader.Read()
        Dim approvalLimit As Double
        approvalLimit = 0.1 * reader.GetDouble(0)

        If CType(frmInsert.FindControl("ManagerDropDown"), DropDownList).SelectedItem.Text = CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text And approvalLimit <
            CType(frmInsert.FindControl("TotalPriceTextBox"), TextBox).Text Then
            args.IsValid = False
        Else
            args.IsValid = True
        End If
    End Sub


    Protected Sub frmInsert_DataBound(sender As Object, e As EventArgs)
        Try
            If frmInsert.CurrentMode = FormViewMode.Insert Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

                Dim SqlConnection As New SqlConnection(connectionString)
                Dim sc As New SqlCommand("select givenname + ' ' + sn as IssuedBy,mail as Email from vwEmployees where 'LCLMTL\' + sAMAccountName = '" & Session("Username") & "'", SqlConnection)
                SqlConnection.Open()

                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Session("IssuedBy") = reader.GetString(0)
                Session("Email") = reader.GetString(1)
                reader.Close()

                CType(frmInsert.FindControl("RequesterNameTextBox"), TextBox).Text = Session("IssuedBy")
                CType(frmInsert.FindControl("RequesterEmailTextBox"), TextBox).Text = Session("Email")
            End If
            If frmInsert.CurrentMode = FormViewMode.Edit Then
                'Fill PROI gridview
                Dim dt As New DataTable
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                Dim neridstr As String = CType(frmInsert.FindControl("IDLabel"), Label).Text
                Dim sc As New SqlCommand("select * from tblProjectedROI where PurchaseRequestID = " & neridstr, SqlConnection)
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
                PCconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim PCSqlConnection As New SqlConnection(PCconnectionString)
                Dim PCsc As New SqlCommand("select * from tblProgramCost where PurchaseRequestID = " & CType(frmInsert.FindControl("IDLabel"), Label).Text, PCSqlConnection)
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
                SCconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim SCSqlConnection As New SqlConnection(SCconnectionString)
                Dim SCsc As New SqlCommand("select * from tblSuccessCriteria where PurchaseRequestID = " & CType(frmInsert.FindControl("IDLabel"), Label).Text, SCSqlConnection)
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
                FUPconnectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"
                Dim FUPSqlConnection As New SqlConnection(FUPconnectionString)
                Dim FUPsc As New SqlCommand("select * from tblFUP where PurchaseRequestID = " & CType(frmInsert.FindControl("IDLabel"), Label).Text, FUPSqlConnection)
                FUPSqlConnection.Open()
                Dim FUPda As New SqlDataAdapter(FUPsc)
                FUPda.Fill(FUPdt)
                ViewState("FUPDatatable") = FUPdt
                Dim gvImplementation As GridView
                gvImplementation = CType(frmInsert.FindControl("gvImplementation"), GridView)
                gvImplementation.DataSource = FUPdt
                gvImplementation.DataBind()

                If (CType(frmInsert.FindControl("InvestmentCheckedLabel"), Label).Text = "True") Then
                    CType(frmInsert.FindControl("EditInvestmentSheetPanel"), Panel).Visible = True
                Else
                    CType(frmInsert.FindControl("EditInvestmentSheetPanel"), Panel).Visible = False
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
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

        'PROIYear0Total += Convert.ToDecimal(CType(frm.FindControl("Year0"), TextBox).Text)
        'PROIYear1Total += Convert.ToDecimal(CType(frm.FindControl("Year1"), TextBox).Text)
        'PROIYear2Total += Convert.ToDecimal(CType(frm.FindControl("Year2"), TextBox).Text)
        'PROIYear3Total += Convert.ToDecimal(CType(frm.FindControl("Year3"), TextBox).Text)
        'PROIYear4Total += Convert.ToDecimal(CType(frm.FindControl("Year4"), TextBox).Text)
        UpdateNetCashFlow()

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

    Protected Sub gvPROIDetails_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim panelPROI As Panel = CType(frmInsert.FindControl("proi_panel"), Panel)
        Dim fvPROI As FormView = CType(frmInsert.FindControl("proiDetails"), FormView)
        Dim dtPROI As DataTable = New DataTable
        dtPROI = ViewState("PROIDatatable")
        Dim gvPROI As GridView = CType(frmInsert.FindControl("gvPROIDetails"), GridView)

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
        Dim panelPC As Panel = CType(frmInsert.FindControl("ProgramCostsPanel"), Panel)
        Dim fvPC As FormView = CType(frmInsert.FindControl("frmProgramCosts"), FormView)
        Dim dtPC As DataTable = New DataTable
        dtPC = ViewState("PCDatatable")
        Dim gvPC As GridView = CType(frmInsert.FindControl("gvProgramCostsDetails"), GridView)

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
        Dim panelSC As Panel = CType(frmInsert.FindControl("SuccessCriteriaPanel"), Panel)
        Dim fvSC As FormView = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
        Dim dtSC As DataTable = New DataTable
        dtSC = ViewState("SCDatatable")
        Dim gvSC As GridView = CType(frmInsert.FindControl("gvSuccessCriteria"), GridView)

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
        Dim panelFUP As Panel = CType(frmInsert.FindControl("ImplementationPanel"), Panel)
        Dim fvFUP As FormView = CType(frmInsert.FindControl("frmImplementation"), FormView)
        Dim dtFUP As DataTable = New DataTable
        dtFUP = ViewState("FUPDatatable")
        Dim gvFUP As GridView = CType(frmInsert.FindControl("gvImplementation"), GridView)

        Dim dtRow As DataRow = dtFUP.Rows(gvFUP.SelectedRow.RowIndex)

        panelFUP.Visible = True
        CType(fvFUP.FindControl("EventTextbox"), TextBox).Text = dtRow("Event")
        CType(fvFUP.FindControl("WhenID"), TextBox).Text = dtRow("FUPWhen")
        CType(fvFUP.FindControl("ComplID"), TextBox).Text = dtRow("Compl")
        CType(fvFUP.FindControl("RespID"), TextBox).Text = dtRow("Resp")
        CType(fvFUP.FindControl("NotesID"), TextBox).Text = dtRow("Notes")
    End Sub

    'Protected Sub ProductCodeDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    Dim fvPC As FormView = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
    '    Dim ProductCodeDropDown As DropDownList = CType(fvPC.FindControl("ProductCodeDropDownList"), DropDownList)
    '    Dim query = "SELECT AQC6AA FROM Nomis.NOMDBF95.PCDPHY01 WHERE AQC5AA = '" & ProductCodeDropDown.SelectedValue.ToString & "'"
    '    'Dim myconn As New SqlConnection(ConfigurationManager.ConnectionStrings("NomisConnectionString").ConnectionString)
    '    Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("NomisConnectionString").ConnectionString)
    '        Dim command As New SqlCommand(query, connection)
    '        connection.Open()

    '        Dim reader As SqlDataReader = command.ExecuteReader()

    '        ' Call Read before accessing data. 
    '        While reader.Read()
    '            ReadSingleRow(CType(reader, IDataRecord))
    '        End While

    '        ' Call Close when done reading.
    '        reader.Close()
    '    End Using
    'End Sub
    'Private Sub ReadSingleRow(ByVal record As IDataRecord)
    '    Dim fvPC As FormView = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
    '    Dim ProductCodeDescriptionLabel As Label = CType(fvPC.FindControl("ProductCodeDescriptionLabel"), Label)
    '    ProductCodeDescriptionLabel.Text = " " & record(0).ToString
    'End Sub

    Protected Sub PeriodDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim fvSC As FormView = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
        Dim periodDropDown As DropDownList = CType(fvSC.FindControl("PeriodDropDownList"), DropDownList)
        Dim selectedPeriod As String = periodDropDown.SelectedValue.ToString

        Dim fvPC As FormView = CType(frmInsert.FindControl("frmProgramCosts"), FormView)
        Dim PCperiodDropDown As DropDownList = CType(fvPC.FindControl("PCPeriodDropDownList"), DropDownList)
        Dim PCselectedPeriod As String = PCperiodDropDown.SelectedValue.ToString

        Dim fvPROI As FormView = CType(frmInsert.FindControl("proiDetails"), FormView)
        Dim PROIperiodDropDown As DropDownList = CType(fvPROI.FindControl("PROIPeriodDropDownList"), DropDownList)
        Dim PROIselectedPeriod As String = PROIperiodDropDown.SelectedValue.ToString

        If selectedPeriod = "Quarterly" Then
            CType(fvSC.FindControl("LabelQ1"), Label).Text = "Q1:"
            CType(fvSC.FindControl("LabelQ2"), Label).Text = "Q2:"
            CType(fvSC.FindControl("LabelQ3"), Label).Text = "Q3:"
            CType(fvSC.FindControl("LabelQ4"), Label).Text = "Q4:"
            CType(fvSC.FindControl("LabelQ5"), Label).Text = "Q5:"
            CType(fvSC.FindControl("LabelQ6"), Label).Text = "Q6:"
            PCperiodDropDown.Items.FindByValue("Yearly").Selected = False
            PCperiodDropDown.Items.FindByValue("Quarterly").Selected = True
            CType(fvPC.FindControl("PC_P1"), Label).Text = "Q1:"
            CType(fvPC.FindControl("PC_P2"), Label).Text = "Q2"
            CType(fvPC.FindControl("PC_P3"), Label).Text = "Q3:"
            CType(fvPC.FindControl("PC_P4"), Label).Text = "Q4:"
            CType(fvPC.FindControl("PC_P5"), Label).Text = "Q5:"
            PROIperiodDropDown.Items.FindByValue("Yearly").Selected = False
            PROIperiodDropDown.Items.FindByValue("Quarterly").Selected = True
            CType(fvPROI.FindControl("PROI_P1"), Label).Text = "Q1:"
            CType(fvPROI.FindControl("PROI_P2"), Label).Text = "Q2:"
            CType(fvPROI.FindControl("PROI_P3"), Label).Text = "Q3:"
            CType(fvPROI.FindControl("PROI_P4"), Label).Text = "Q4:"
            CType(fvPROI.FindControl("PROI_P5"), Label).Text = "Q5:"
        Else
            CType(fvSC.FindControl("LabelQ1"), Label).Text = "Year 1:"
            CType(fvSC.FindControl("LabelQ2"), Label).Text = "Year 2:"
            CType(fvSC.FindControl("LabelQ3"), Label).Text = "Year 3:"
            CType(fvSC.FindControl("LabelQ4"), Label).Text = "Year 4:"
            CType(fvSC.FindControl("LabelQ5"), Label).Text = "Year 5:"
            CType(fvSC.FindControl("LabelQ6"), Label).Text = "Year 6:"
            PCperiodDropDown.Items.FindByValue("Quarterly").Selected = False
            PCperiodDropDown.Items.FindByValue("Yearly").Selected = True
            CType(fvPC.FindControl("PC_P1"), Label).Text = "Year 1:"
            CType(fvPC.FindControl("PC_P2"), Label).Text = "Year 2:"
            CType(fvPC.FindControl("PC_P3"), Label).Text = "Year 3:"
            CType(fvPC.FindControl("PC_P4"), Label).Text = "Year 4:"
            CType(fvPC.FindControl("PC_P5"), Label).Text = "Year 5:"
            PROIperiodDropDown.Items.FindByValue("Quarterly").Selected = False
            PROIperiodDropDown.Items.FindByValue("Yearly").Selected = True
            CType(fvPROI.FindControl("PROI_P1"), Label).Text = "Year 1:"
            CType(fvPROI.FindControl("PROI_P2"), Label).Text = "Year 2:"
            CType(fvPROI.FindControl("PROI_P3"), Label).Text = "Year 3:"
            CType(fvPROI.FindControl("PROI_P4"), Label).Text = "Year 4:"
            CType(fvPROI.FindControl("PROI_P5"), Label).Text = "Year 5:"
        End If
    End Sub

    Protected Sub InvestmentSheetCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        Dim InvestmentCheckbox As CheckBox = CType(frmInsert.FindControl("InvestmentSheetCheckbox"), CheckBox)
        Dim InvestmentPanel As Panel = CType(frmInsert.FindControl("InvestmentSheetPanel"), Panel)

        If InvestmentCheckbox.Checked = True Then
            InvestmentPanel.Visible = True
        Else
            InvestmentPanel.Visible = False
        End If
    End Sub

    Protected Sub PCPeriodDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim fvSC As FormView = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
        Dim periodDropDown As DropDownList = CType(fvSC.FindControl("PeriodDropDownList"), DropDownList)
        Dim selectedPeriod As String = periodDropDown.SelectedValue.ToString

        Dim fvPC As FormView = CType(frmInsert.FindControl("frmProgramCosts"), FormView)
        Dim PCperiodDropDown As DropDownList = CType(fvPC.FindControl("PCPeriodDropDownList"), DropDownList)
        Dim PCselectedPeriod As String = PCperiodDropDown.SelectedValue.ToString

        Dim fvPROI As FormView = CType(frmInsert.FindControl("proiDetails"), FormView)
        Dim PROIperiodDropDown As DropDownList = CType(fvPROI.FindControl("PROIPeriodDropDownList"), DropDownList)
        Dim PROIselectedPeriod As String = PROIperiodDropDown.SelectedValue.ToString

        If PCselectedPeriod = "Quarterly" Then
            periodDropDown.Items.FindByValue("Yearly").Selected = False
            periodDropDown.Items.FindByValue("Quarterly").Selected = True
            CType(fvSC.FindControl("LabelQ1"), Label).Text = "Q1:"
            CType(fvSC.FindControl("LabelQ2"), Label).Text = "Q2:"
            CType(fvSC.FindControl("LabelQ3"), Label).Text = "Q3:"
            CType(fvSC.FindControl("LabelQ4"), Label).Text = "Q4:"
            CType(fvSC.FindControl("LabelQ5"), Label).Text = "Q5:"
            CType(fvSC.FindControl("LabelQ6"), Label).Text = "Q6:"
            CType(fvPC.FindControl("PC_P1"), Label).Text = "Q1:"
            CType(fvPC.FindControl("PC_P2"), Label).Text = "Q2"
            CType(fvPC.FindControl("PC_P3"), Label).Text = "Q3:"
            CType(fvPC.FindControl("PC_P4"), Label).Text = "Q4:"
            CType(fvPC.FindControl("PC_P5"), Label).Text = "Q5:"
            PROIperiodDropDown.Items.FindByValue("Yearly").Selected = False
            PROIperiodDropDown.Items.FindByValue("Quarterly").Selected = True
            CType(fvPROI.FindControl("PROI_P1"), Label).Text = "Q1:"
            CType(fvPROI.FindControl("PROI_P2"), Label).Text = "Q2:"
            CType(fvPROI.FindControl("PROI_P3"), Label).Text = "Q3:"
            CType(fvPROI.FindControl("PROI_P4"), Label).Text = "Q4:"
            CType(fvPROI.FindControl("PROI_P5"), Label).Text = "Q5:"
        Else
            periodDropDown.Items.FindByValue("Quarterly").Selected = False
            periodDropDown.Items.FindByValue("Yearly").Selected = True
            CType(fvSC.FindControl("LabelQ1"), Label).Text = "Year 1:"
            CType(fvSC.FindControl("LabelQ2"), Label).Text = "Year 2:"
            CType(fvSC.FindControl("LabelQ3"), Label).Text = "Year 3:"
            CType(fvSC.FindControl("LabelQ4"), Label).Text = "Year 4:"
            CType(fvSC.FindControl("LabelQ5"), Label).Text = "Year 5:"
            CType(fvSC.FindControl("LabelQ6"), Label).Text = "Year 6:"
            CType(fvPC.FindControl("PC_P1"), Label).Text = "Year 1:"
            CType(fvPC.FindControl("PC_P2"), Label).Text = "Year 2:"
            CType(fvPC.FindControl("PC_P3"), Label).Text = "Year 3:"
            CType(fvPC.FindControl("PC_P4"), Label).Text = "Year 4:"
            CType(fvPC.FindControl("PC_P5"), Label).Text = "Year 5:"
            PROIperiodDropDown.Items.FindByValue("Quarterly").Selected = False
            PROIperiodDropDown.Items.FindByValue("Yearly").Selected = True
            CType(fvPROI.FindControl("PROI_P1"), Label).Text = "Year 1:"
            CType(fvPROI.FindControl("PROI_P2"), Label).Text = "Year 2:"
            CType(fvPROI.FindControl("PROI_P3"), Label).Text = "Year 3:"
            CType(fvPROI.FindControl("PROI_P4"), Label).Text = "Year 4:"
            CType(fvPROI.FindControl("PROI_P5"), Label).Text = "Year 5:"
        End If
    End Sub

    Protected Sub PROIPeriodDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim fvSC As FormView = CType(frmInsert.FindControl("frmSuccessCriteria"), FormView)
        Dim periodDropDown As DropDownList = CType(fvSC.FindControl("PeriodDropDownList"), DropDownList)
        Dim selectedPeriod As String = periodDropDown.SelectedValue.ToString

        Dim fvPC As FormView = CType(frmInsert.FindControl("frmProgramCosts"), FormView)
        Dim PCperiodDropDown As DropDownList = CType(fvPC.FindControl("PCPeriodDropDownList"), DropDownList)
        Dim PCselectedPeriod As String = PCperiodDropDown.SelectedValue.ToString

        Dim fvPROI As FormView = CType(frmInsert.FindControl("proiDetails"), FormView)
        Dim PROIperiodDropDown As DropDownList = CType(fvPROI.FindControl("PROIPeriodDropDownList"), DropDownList)
        Dim PROIselectedPeriod As String = PROIperiodDropDown.SelectedValue.ToString

        If PROIselectedPeriod = "Quarterly" Then
            periodDropDown.Items.FindByValue("Yearly").Selected = False
            periodDropDown.Items.FindByValue("Quarterly").Selected = True
            CType(fvSC.FindControl("LabelQ1"), Label).Text = "Q1:"
            CType(fvSC.FindControl("LabelQ2"), Label).Text = "Q2:"
            CType(fvSC.FindControl("LabelQ3"), Label).Text = "Q3:"
            CType(fvSC.FindControl("LabelQ4"), Label).Text = "Q4:"
            CType(fvSC.FindControl("LabelQ5"), Label).Text = "Q5:"
            CType(fvSC.FindControl("LabelQ6"), Label).Text = "Q6:"
            PCperiodDropDown.Items.FindByValue("Yearly").Selected = False
            PCperiodDropDown.Items.FindByValue("Quarterly").Selected = True
            CType(fvPC.FindControl("PC_P1"), Label).Text = "Q1:"
            CType(fvPC.FindControl("PC_P2"), Label).Text = "Q2"
            CType(fvPC.FindControl("PC_P3"), Label).Text = "Q3:"
            CType(fvPC.FindControl("PC_P4"), Label).Text = "Q4:"
            CType(fvPC.FindControl("PC_P5"), Label).Text = "Q5:"
            CType(fvPROI.FindControl("PROI_P1"), Label).Text = "Q1:"
            CType(fvPROI.FindControl("PROI_P2"), Label).Text = "Q2:"
            CType(fvPROI.FindControl("PROI_P3"), Label).Text = "Q3:"
            CType(fvPROI.FindControl("PROI_P4"), Label).Text = "Q4:"
            CType(fvPROI.FindControl("PROI_P5"), Label).Text = "Q5:"
        Else
            periodDropDown.Items.FindByValue("Quarterly").Selected = False
            periodDropDown.Items.FindByValue("Yearly").Selected = True
            CType(fvSC.FindControl("LabelQ1"), Label).Text = "Year 1:"
            CType(fvSC.FindControl("LabelQ2"), Label).Text = "Year 2:"
            CType(fvSC.FindControl("LabelQ3"), Label).Text = "Year 3:"
            CType(fvSC.FindControl("LabelQ4"), Label).Text = "Year 4:"
            CType(fvSC.FindControl("LabelQ5"), Label).Text = "Year 5:"
            CType(fvSC.FindControl("LabelQ6"), Label).Text = "Year 6:"
            PCperiodDropDown.Items.FindByValue("Quarterly").Selected = False
            PCperiodDropDown.Items.FindByValue("Yearly").Selected = True
            CType(fvPC.FindControl("PC_P1"), Label).Text = "Year 1:"
            CType(fvPC.FindControl("PC_P2"), Label).Text = "Year 2:"
            CType(fvPC.FindControl("PC_P3"), Label).Text = "Year 3:"
            CType(fvPC.FindControl("PC_P4"), Label).Text = "Year 4:"
            CType(fvPC.FindControl("PC_P5"), Label).Text = "Year 5:"
            CType(fvPROI.FindControl("PROI_P1"), Label).Text = "Year 1:"
            CType(fvPROI.FindControl("PROI_P2"), Label).Text = "Year 2:"
            CType(fvPROI.FindControl("PROI_P3"), Label).Text = "Year 3:"
            CType(fvPROI.FindControl("PROI_P4"), Label).Text = "Year 4:"
            CType(fvPROI.FindControl("PROI_P5"), Label).Text = "Year 5:"
        End If
    End Sub
End Class