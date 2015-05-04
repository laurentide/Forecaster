Imports System.Data.SqlClient
Imports Microsoft.Reporting.WebForms

Public Class Expense
    Inherits System.Web.UI.Page
    Private total As Double 'Expense Details total in the footer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("Current_Date") = Now()

        If Not Me.IsPostBack Then
            'Get Default Exchange Rate
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"
            Dim SqlConnection As New SqlConnection(connectionString)
            SqlConnection.Open()
            Dim sc As New SqlCommand("select exchangerate from tblDefaultExchangeRAte", SqlConnection)
            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim exchangeRate As Double = reader.GetDouble(0)
            reader.Close()
            SqlConnection.Close()
            CType(frmExpense.FindControl("ExchangeRateTextBox"), TextBox).Text = exchangeRate.ToString
        End If

        'Create datable that is like the ExpenseDetails table for temporary storage until the user commits the whole expense
        If ViewState("datatable") Is Nothing Then
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("ExpenseDetailID", GetType(Integer))
            dt.Columns.Add("ExpenseReportID", GetType(Integer))
            dt.Columns.Add("CategoryID", GetType(Integer))
            dt.Columns.Add("ExpenseTypeID", GetType(String))
            dt.Columns.Add("ExpenseItemAmount", GetType(Double))
            dt.Columns.Add("ExpenseItemDescription", GetType(String))
            dt.Columns.Add("ExpenseDate", GetType(DateTime))
            dt.Columns.Add("Tip", GetType(Double))
            dt.Columns.Add("Lodging_Taxes", GetType(Double))
            dt.Columns.Add("NonTaxableExtras", GetType(Double))
            dt.Columns.Add("ProvinceID", GetType(Integer))
            dt.Columns.Add("TaxCategory", GetType(String))
            dt.Columns.Add("Transaction", GetType(String))
            dt.Columns.Add("Currency", GetType(String))
            dt.Columns.Add("AGST", GetType(Double))
            dt.Columns.Add("AQST", GetType(Double))
            dt.Columns.Add("Km", GetType(Double))
            dt.Columns.Add("Km_Rate", GetType(Double))
            dt.Columns.Add("DepartmentID", GetType(Integer))
            dt.Columns.Add("Guests", GetType(String))
            ViewState("datatable") = dt
        End If

    End Sub

    Protected Sub ddlExpenseCategories_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlExpenseTypes As DropDownList
        Dim ddlExpenseCategories As DropDownList
        Dim panStd As Panel
        Dim frmStdExpenseDetails As FormView
        Dim descriptionLabel As Label

        'Remove row selected from the gridview to put the formview in "Add Mode"
        CType(frmExpense.FindControl("gvExpenseDetails"), GridView).SelectedIndex = -1
        CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("InsertButton"), Button).Text = "Add expense line"

        ddlExpenseTypes = CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("ddlExpenseTypes"), DropDownList)
        ddlExpenseCategories = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList)
        panStd = CType(frmExpense.FindControl("panStd"), Panel)
        frmStdExpenseDetails = CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView)
        descriptionLabel = CType(frmStdExpenseDetails.FindControl("descriptionLabel"), Label)

        If CType(frmExpense.FindControl("DepartmentDropdown"), DropDownList).SelectedValue = "" Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "PopupScript", "alert('Please choose a department first');", True)
            ddlExpenseCategories.SelectedValue = ""
        Else

            'Default date in expense details
            If CType(frmExpense.FindControl("ExpenseDateTextBox"), TextBox).Text <> "" And CType(frmStdExpenseDetails.FindControl("ExpenseDateTextBox2"), TextBox).Text = "" Then
                CType(frmStdExpenseDetails.FindControl("ExpenseDateTextBox2"), TextBox).Text = CType(frmExpense.FindControl("ExpenseDateTextBox"), TextBox).Text
            End If

            'Default Province
            If CType(frmStdExpenseDetails.FindControl("ProvinceDropdown"), DropDownList).SelectedItem.Text = "(Select your province)" Then
                CType(frmStdExpenseDetails.FindControl("ProvinceDropdown"), DropDownList).SelectedValue = 9
            End If

            'Default Department
            If CType(frmStdExpenseDetails.FindControl("DepartmentDropdown"), DropDownList).SelectedItem.Text = "(Select your department)" Then
                CType(frmStdExpenseDetails.FindControl("DepartmentDropdown"), DropDownList).SelectedValue = CType(frmExpense.FindControl("DepartmentDropDown"), DropDownList).SelectedValue
            End If

            'Reset testbox
            CType(frmStdExpenseDetails.FindControl("TipTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("ExpenseItemAmountTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("ExpenseItemDescriptionTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("Lodging_TaxesTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("AGSTTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("AQSTTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("KmTextBox"), TextBox).Text = ""
            CType(frmStdExpenseDetails.FindControl("Km_RateTextBox"), TextBox).Text = ""

            If ddlExpenseCategories.SelectedItem.Text = "" Then
                panStd.Visible = False
            Else
                panStd.Visible = True
                'ddlExpenseTypes = CType(frmExpense.FindControl("ddlExpenseTypes"), DropDownList)
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

                Dim SqlConnection As New SqlConnection(connectionString)
                Dim sc As New SqlCommand("select * from tblExpenseTypes where CategoryID = " & ddlExpenseCategories.SelectedValue, SqlConnection)
                SqlConnection.Open()

                Dim dtExpenseTypes As New DataTable
                Dim da As SqlDataAdapter = New SqlDataAdapter
                da.SelectCommand = sc
                da.Fill(dtExpenseTypes)

                ddlExpenseTypes.DataSource = dtExpenseTypes
                ddlExpenseTypes.DataTextField = "ExpenseType"
                ddlExpenseTypes.DataValueField = "ExpenseTypeID"
                ddlExpenseTypes.DataBind()
                SqlConnection.Close()

                CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = False
                CType(frmStdExpenseDetails.FindControl("panGuests"), Panel).Visible = False
                CType(frmStdExpenseDetails.FindControl("panLodging"), Panel).Visible = False
                CType(frmStdExpenseDetails.FindControl("panExtras"), Panel).Visible = False
                CType(frmStdExpenseDetails.FindControl("panAir"), Panel).Visible = False
                CType(frmStdExpenseDetails.FindControl("panKM"), Panel).Visible = False
                descriptionLabel.Text = "Description"
                Select Case ddlExpenseCategories.SelectedValue
                    Case 2 'Hotel
                        CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = True
                        CType(frmStdExpenseDetails.FindControl("panLodging"), Panel).Visible = True
                    Case 11 'Meals and entertainment
                        CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = True
                        CType(frmStdExpenseDetails.FindControl("panGuests"), Panel).Visible = True
                        descriptionLabel.Text = "Restaurant/Payee"
                    Case 1 'Meals Employee
                        CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = True
                        CType(frmStdExpenseDetails.FindControl("panGuests"), Panel).Visible = True
                        descriptionLabel.Text = "Restaurant/Payee"
                    Case 7, 16 'Subscription Membership & Telephone and Cell
                        CType(frmStdExpenseDetails.FindControl("panExtras"), Panel).Visible = True
                    Case 4 'Air Fare
                        CType(frmStdExpenseDetails.FindControl("panAir"), Panel).Visible = True
                        descriptionLabel.Text = "Airline Company"
                    Case 3 'car expenses
                        CType(frmStdExpenseDetails.FindControl("panKM"), Panel).Visible = True
                    Case 5
                        descriptionLabel.Text = "Car Rental Company"
                End Select
            End If
        End If
    End Sub

    Protected Sub frmExpense_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        Dim row As DataRow
        'Add the expense report details
        'Get the datatable underlying the gridview
        Dim dt As New DataTable
        dt = CType(ViewState("datatable"), DataTable)

        'Populate the expensereportid from the newly added expense report to the details
        For Each row In dt.Rows
            row("ExpenseReportID") = Session("ID")
        Next

        Console.WriteLine(Session("ID"))

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

        Using destinationConnection As SqlConnection = New SqlConnection(connectionString)
            destinationConnection.Open()

            Using bulkCopy As SqlBulkCopy = _
              New SqlBulkCopy(destinationConnection)
                bulkCopy.DestinationTableName = _
                "dbo.tblExpenseDetails"

                Try
                    ' Write from the source to the destination.
                    bulkCopy.WriteToServer(dt)

                Catch ex As Exception
                    Debug.Print(ex.Message)
                End Try
            End Using
            destinationConnection.Close()
        End Using
        gvExpenseReports.DataBind()
        dt.Clear()
        ViewState("datatable") = dt
    End Sub

    Protected Sub frmStdExpenseDetails_ItemInserting(sender As Object, e As FormViewInsertEventArgs)

        Dim dt As New DataTable 
        dt = CType(ViewState("datatable"), DataTable)
        Dim drow As DataRow
        Dim frm = CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView)
        Dim srow As GridViewRow = CType(frmExpense.FindControl("gvExpensedetails"), GridView).SelectedRow 'Current selected row if any
        Dim gvExpensedetails As GridView = CType(frmExpense.FindControl("gvExpensedetails"), GridView) 'The Details grid

        If (CType(frmExpense.FindControl("gvExpenseDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            drow = dt.NewRow() 'New row to add
            drow("CategoryID") = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList).SelectedValue
        Else
            'if edit mode, delete existing line but get value from the datatable beforehand for the categoryid from the datatable.
            drow = dt.Rows(srow.RowIndex)
            drow("CategoryID") = dt.Rows(srow.RowIndex).Item(2).ToString
            'dt.Rows(srow.RowIndex).Delete()

        End If

        drow("ExpenseDate") = CType(frm.FindControl("ExpenseDateTextBox2"), TextBox).Text
        drow("ExpenseTypeID") = CType(frm.FindControl("ddlExpenseTypes"), DropDownList).SelectedValue
        drow("ExpenseItemAmount") = IIf(CType(frm.FindControl("ExpenseItemAmountTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("ExpenseItemAmountTextBox"), TextBox).Text)
        drow("ExpenseItemDescription") = CType(frm.FindControl("ExpenseItemDescriptionTextBox"), TextBox).Text
        drow("ProvinceID") = CType(frm.FindControl("ProvinceDropDown"), DropDownList).SelectedValue
        drow("Currency") = CType(frm.FindControl("CurrencyDropDown"), DropDownList).SelectedValue
        drow("Transaction") = ""
        drow("DepartmentID") = CType(frm.FindControl("DepartmentDropdown"), DropDownList).SelectedValue
        drow("Guests") = CType(frm.FindControl("GuestsTextbox"), TextBox).Text

        'Meals and Entertainment & Hotel only
        drow("Tip") = IIf(CType(frm.FindControl("TipTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("TipTextBox"), TextBox).Text)

        'Hotels only
        drow("Lodging_Taxes") = IIf(CType(frm.FindControl("Lodging_TaxesTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("Lodging_TaxesTextBox"), TextBox).Text)

        'Subscription Membership & Telephone and Cell
        drow("NonTaxableExtras") = IIf(CType(frm.FindControl("Non_TaxableExtrasTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("Non_TaxableExtrasTextBox"), TextBox).Text)

        'drow("TaxCategory") = CType(frm.FindControl("TransactionTextbox"), TextBox).Text

        'Air Fare only
        drow("AGST") = IIf(CType(frm.FindControl("AGSTTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("AGSTTextBox"), TextBox).Text)
        drow("AQST") = IIf(CType(frm.FindControl("AQSTTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("AQSTTextBox"), TextBox).Text)

        'Car Expenses
        drow("Km") = IIf(CType(frm.FindControl("KmTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("KmTextBox"), TextBox).Text)
        drow("Km_Rate") = IIf(CType(frm.FindControl("Km_RateTextBox"), TextBox).Text = "", 0, CType(frm.FindControl("Km_RateTextBox"), TextBox).Text)



        If frmExpense.CurrentMode = FormViewMode.Edit Then
            drow("ExpenseReportID") = CType(frmExpense.FindControl("ExpenseReportIDLabel"), Label).Text
        End If

        If (CType(frmExpense.FindControl("gvExpenseDetails"), GridView).SelectedIndex = -1) Then
            'Add mode
            dt.Rows.Add(drow)
        Else
            'Edit Mode
            CType(frmExpense.FindControl("gvExpenseDetails"), GridView).SelectedIndex = -1 'Remove the Selectio
        End If
        dt.DefaultView.Sort = "ExpenseDate asc"
        ViewState("datatable") = dt
        CType(frmExpense.FindControl("gvExpenseDetails"), GridView).DataSource = dt
        CType(frmExpense.FindControl("gvExpenseDetails"), GridView).DataBind()
        CType(frmExpense.FindControl("panStd"), Panel).Visible = False
        'Reset drop down
        CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList).SelectedIndex = -1
    End Sub

    Protected Sub frmExpense_DataBound(sender As Object, e As EventArgs)
        Try
            If frmExpense.CurrentMode = FormViewMode.Insert Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

                Dim SqlConnection As New SqlConnection(connectionString)
                Dim sc As New SqlCommand("select sn + ' ' + givenname as EmployeeName,mail as Email from vwEmployees where 'LCLMTL\' + sAMAccountName = '" & Session("Username") & "'", SqlConnection)
                SqlConnection.Open()

                Dim reader As SqlDataReader = sc.ExecuteReader()
                reader.Read()
                Session("EmployeeName") = reader.GetString(0)
                Session("Email") = reader.GetString(1)
                reader.Close()
                SqlConnection.Close()

                'Insert Defaults here
                CType(frmExpense.FindControl("EmployeeNameTextBox"), TextBox).Text = Session("EmployeeName")
                CType(frmExpense.FindControl("EmployeeEmailTextBox"), TextBox).Text = Session("Email")
                CType(frmExpense.FindControl("AdvanceAmountTextBox"), TextBox).Text = 0
                CType(frmExpense.FindControl("ExpenseDateTextbox"), TextBox).Text = Today()
            ElseIf frmExpense.CurrentMode = FormViewMode.Edit Then
                Dim dt As New DataTable
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"
                Dim SqlConnection As New SqlConnection(connectionString)
                Dim sc As New SqlCommand("select * from tblexpensedetails where expensereportid = " & CType(frmExpense.FindControl("ExpenseReportIDLabel"), Label).Text, SqlConnection)
                SqlConnection.Open()

                Dim da As New SqlDataAdapter(sc)
                da.Fill(dt)
                ViewState("datatable") = dt
                Dim gvExpenseDetails As GridView
                gvExpenseDetails = CType(frmExpense.FindControl("gvExpenseDetails"), GridView)
                gvExpenseDetails.DataSource = dt
                gvExpenseDetails.DataBind()
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub gvExpenseDetails_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                total += CType(CType(e.Row.FindControl("AmountTextbox"), Label).Text, Double)
            End If
            If (e.Row.RowType = DataControlRowType.Footer) Then
                Dim AmountTotal As Literal = CType(e.Row.FindControl("AmountTotal"), Literal)
                AmountTotal.Text = String.Format("{0:C2}", total)
            End If
        Catch ex As Exception
        End Try
    End Sub

    Function findCategory(categoryid As Object) As String
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select category from  dbo.tblExpenseCategories where categoryid =" & categoryid, SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            findCategory = reader.GetString(0)
            reader.Close()
            SqlConnection.Close()
        Catch ex As Exception
            Return ""
        End Try

    End Function
    Function findProvince(provinceID As Object) As String
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select Province from  dbo.tblProvinceRates where provinceID =" & provinceID, SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            findProvince = reader.GetString(0)
            reader.Close()
            SqlConnection.Close()
        Catch ex As Exception
            Return ""
        End Try
    End Function
    Function findType(ExpenseTypeID As Object) As String
        Try
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select ExpenseType from  dbo.tblExpenseTypes where ExpenseTypeID =" & ExpenseTypeID, SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            findType = reader.GetString(0)
            reader.Close()
            SqlConnection.Close()
        Catch ex As Exception
            Return ""
        End Try
    End Function

    Protected Sub sdsForm_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Try
            Dim ID As Integer = e.Command.Parameters("@ID").Value
            Session("ID") = ID
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub gvExpenseReports_SelectedIndexChanged(sender As Object, e As EventArgs)
        frmExpense.ChangeMode(FormViewMode.Edit)
    End Sub

    'Deletes the specified row from the ViewState("datatable") (Expenses List)
    Protected Sub gvExpenseDetails_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim dt As DataTable 'create empty DataTable object dt
        dt = CType(ViewState("datatable"), DataTable) 'store the current ViewState("datatable") into dt
        dt.Rows(e.RowIndex).Delete() 'delete the row that was clicked on by the user (taken from the row's index)
        ViewState("datatable") = dt 'store the changes made to dt into ViewState("datatable")
        CType(sender, GridView).DataSource = dt 'set dt as the DataSource for the GridView
        CType(sender, GridView).DataBind() 'binds the data source to the GridView control
    End Sub

    Protected Sub frmExpense_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)

        Dim dt As New DataTable
        dt = CType(ViewState("datatable"), DataTable)

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

        Using destinationConnection As SqlConnection = New SqlConnection(connectionString)
            destinationConnection.Open()
            Try

                Dim sqlcommand As New SqlCommand("Delete from tblExpenseDetails where expenseReportid = " & CType(Me.frmExpense.FindControl("ExpenseReportIDLabel"), Label).Text)
                sqlcommand.Connection = destinationConnection
                sqlcommand.ExecuteNonQuery()
                Using bulkCopy As SqlBulkCopy = _
                  New SqlBulkCopy(destinationConnection)
                    bulkCopy.DestinationTableName = _
                    "dbo.tblExpenseDetails"
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
        gvExpenseReports.DataBind()
        dt.Clear()
        ViewState("datatable") = dt
    End Sub

    Protected Sub frmExpense_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim dt As DataTable = CType(ViewState("datatable"), DataTable)
        If dt.Rows.Count = 0 Then
            e.Cancel = True
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertMessage('No expense entered yet!');", True)
        End If
    End Sub

    Protected Sub frmExpense_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)
        Dim dt As DataTable = CType(ViewState("datatable"), DataTable)
        If dt.Rows.Count = 0 Then
            e.Cancel = True
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertMessage('No expense entered yet!');", True)
        End If
    End Sub

    Protected Sub btnCalculate_Click(sender As Object, e As EventArgs)
        Try
            CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("ExpenseItemAmountTextBox"), TextBox).Text = _
            CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("KmTextBox"), TextBox).Text * _
            CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("Km_RateTextBox"), TextBox).Text
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub ddlExpenseTypes_SelectedIndexChanged(sender As Object, e As EventArgs)
        If CType(sender, DropDownList).SelectedItem.Text <> "Kilometers" Then
            'Remove KM and KM rate if not kilometers
            CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("panKM"), Panel).Visible = False
        Else
            CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("panKM"), Panel).Visible = True
        End If
    End Sub

    Protected Sub gvExpenseReports_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Try
            If e.CommandName = "ShowReport" Then
                Response.Redirect("http://lcl-sql2k5-s/reportserver?%2fExpenseReports%2fExpenseReport&ExpenseReportID=" & e.CommandArgument & "&rs%3aParameterLanguage=en-US")
            End If
        Catch ex As Exception
            Debug.Print(ex.ToString)
        End Try
    End Sub

    Protected Sub gvExpenseReports_SelectedIndexChanging(sender As Object, e As GridViewSelectEventArgs)
        Dim row As GridViewRow = gvExpenseReports.Rows(e.NewSelectedIndex)
        If row.Cells(11).Text <> "&nbsp;" Then
            e.Cancel = True
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "PopupScript", "alert('Can not modify a expense report scheduled to be paid or already paid');", True)
        End If
    End Sub

    Protected Sub gvExpenseDetails_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Vars
        Dim ddlExpenseTypes As DropDownList
        Dim ddlExpenseCategories As DropDownList
        Dim panStd As Panel
        Dim frmStdExpenseDetails As FormView
        Dim descriptionLabel As Label

        'Need to extract the line data, go throught the dropbox selecting, and reinput the information
        'Put the button text to "edit"
        CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("InsertButton"), Button).Text = "Update expense line"

        'Download the current viewstate into a datatable
        Dim dt As DataTable = New DataTable
        dt = ViewState("datatable")

        'Get the index that was clicked by the user
        Dim dtrow As DataRow = dt.Rows(CType(frmExpense.FindControl("gvExpenseDetails"), GridView).SelectedRow.RowIndex)
        ddlExpenseTypes = CType(CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView).FindControl("ddlExpenseTypes"), DropDownList)
        ddlExpenseCategories = CType(frmExpense.FindControl("ddlExpenseCategories"), DropDownList)
        panStd = CType(frmExpense.FindControl("panStd"), Panel)
        frmStdExpenseDetails = CType(frmExpense.FindControl("frmStdExpenseDetails"), FormView)
        descriptionLabel = CType(frmStdExpenseDetails.FindControl("descriptionLabel"), Label)


        'Populate from datarow
        CType(frmStdExpenseDetails.FindControl("ExpenseDateTextBox2"), TextBox).Text = dtrow("ExpenseDate")
        CType(frmStdExpenseDetails.FindControl("ProvinceDropdown"), DropDownList).SelectedValue = dtrow("ProvinceID")
        CType(frmStdExpenseDetails.FindControl("DepartmentDropdown"), DropDownList).SelectedValue = dtrow("DepartmentID")
        CType(frmStdExpenseDetails.FindControl("GuestsTextbox"), TextBox).Text = dtrow("Guests")
        CType(frmStdExpenseDetails.FindControl("TipTextBox"), TextBox).Text = Format(dtrow("Tip"), "f")
        CType(frmStdExpenseDetails.FindControl("ExpenseItemAmountTextBox"), TextBox).Text = Format(dtrow("ExpenseItemAmount"), "f")
        CType(frmStdExpenseDetails.FindControl("ExpenseItemDescriptionTextBox"), TextBox).Text = dtrow("ExpenseItemDescription")
        CType(frmStdExpenseDetails.FindControl("Lodging_TaxesTextBox"), TextBox).Text = Format(dtrow("Lodging_Taxes"), "f")
        CType(frmStdExpenseDetails.FindControl("Non_TaxableExtrasTextBox"), TextBox).Text = Format(dtrow("NonTaxableExtras"), "f")
        CType(frmStdExpenseDetails.FindControl("AGSTTextBox"), TextBox).Text = Format(dtrow("AGST"), "f")
        CType(frmStdExpenseDetails.FindControl("AQSTTextBox"), TextBox).Text = Format(dtrow("AQST"), "f")
        CType(frmStdExpenseDetails.FindControl("KmTextBox"), TextBox).Text = dtrow("Km")
        CType(frmStdExpenseDetails.FindControl("Km_RateTextBox"), TextBox).Text = Format(dtrow("Km_Rate"), "f")

        panStd.Visible = True
        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=ExpenseReport;Trusted_Connection=true"

        Dim SqlConnection As New SqlConnection(connectionString)
        Dim sc As New SqlCommand("select * from tblExpenseTypes where CategoryID = " & dtrow("CategoryID"), SqlConnection)
        SqlConnection.Open()

        Dim dtExpenseTypes As New DataTable
        Dim da As SqlDataAdapter = New SqlDataAdapter
        da.SelectCommand = sc
        da.Fill(dtExpenseTypes)

        ddlExpenseTypes.DataSource = dtExpenseTypes
        ddlExpenseTypes.DataTextField = "ExpenseType"
        ddlExpenseTypes.DataValueField = "ExpenseTypeID"
        ddlExpenseTypes.DataBind()

        ddlExpenseTypes.SelectedValue = dtrow("ExpenseTypeID")

        CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = False
        CType(frmStdExpenseDetails.FindControl("panGuests"), Panel).Visible = False
        CType(frmStdExpenseDetails.FindControl("panLodging"), Panel).Visible = False
        CType(frmStdExpenseDetails.FindControl("panExtras"), Panel).Visible = False
        CType(frmStdExpenseDetails.FindControl("panAir"), Panel).Visible = False
        CType(frmStdExpenseDetails.FindControl("panKM"), Panel).Visible = False
        descriptionLabel.Text = "Description"
        Select Case dtrow("CategoryID")
            Case 2 'Hotel
                CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = True
                CType(frmStdExpenseDetails.FindControl("panLodging"), Panel).Visible = True
            Case 11 'Meals and entertainment
                CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = True
                descriptionLabel.Text = "Restaurant/Payee"
                CType(frmStdExpenseDetails.FindControl("panGuests"), Panel).Visible = True
            Case 1 'Meals Employee
                CType(frmStdExpenseDetails.FindControl("pantip"), Panel).Visible = True
                CType(frmStdExpenseDetails.FindControl("panGuests"), Panel).Visible = True
                descriptionLabel.Text = "Restaurant/Payee"
            Case 7, 16 'Subscription Membership & Telephone and Cell
                CType(frmStdExpenseDetails.FindControl("panExtras"), Panel).Visible = True
            Case 4 'Air Fare
                CType(frmStdExpenseDetails.FindControl("panAir"), Panel).Visible = True
                descriptionLabel.Text = "Airline Company"
            Case 3 'car expenses
                CType(frmStdExpenseDetails.FindControl("panKM"), Panel).Visible = True
            Case 5
                descriptionLabel.Text = "Car Rental Company"
        End Select
    End Sub
End Class