Imports System.Data
Imports System.Data.SqlClient

Public Class Forecasts
    Inherits System.Web.UI.Page

    ' Class-scope, running total variables...
    Dim Two_Year_Ago_Actual As Decimal
    Dim Last_Year_Actual As Decimal
    Dim Last_year_Budget As Decimal
    Dim Current_Year_Budget As Decimal
    Dim Current_Year_Actual As Decimal
    Dim ManagerBudget As Decimal
    Dim Two_Year_Ago_Actual_Details As Decimal
    Dim Last_Year_Actual_Details As Decimal
    Dim Last_Year_Budget_Details As Decimal
    Dim Budget_Details As Decimal
    Dim ManagerBudget_Details As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("User") = Me.User.Identity.Name.ToString
        Session("Current_Year") = "2012"
    End Sub

    Dim lastteamNameValue As String = Nothing
    Dim lastApprovedValue As String = Nothing
    Protected Function AddGroupingRowIfTeamHasChanged() As String
        'Get the data field value of interest for this row
        Dim currentteamNameValue As String = Eval("TeamName").ToString()
        Dim currentApprovedValue As String = IIf(Eval("Approved").ToString(), "Approved", "Not Approved")

        'Specify name to display if dataFieldValue is a database NULL
        If currentteamNameValue.Length = 0 Then
            currentteamNameValue = "Unknown"
        End If

        'See if there's been a change in value
        If lastteamNameValue <> currentteamNameValue Or lastApprovedValue <> currentApprovedValue Then
            'There's been a change! Record the change and emit the table row
            lastteamNameValue = currentteamNameValue
            lastApprovedValue = currentApprovedValue

            Return String.Format("<tr class=""group""><td colspan=""11"">Team: {0} - Budget Status: {1} </td></tr>", currentteamNameValue, currentApprovedValue)
        Else
            'No change, return an empty string
            Return String.Empty
        End If
    End Function

    Protected Function TestForEnterpriseNull(ByVal enterprise As Object, ByVal customer As Object) As String
        'inital hidden
        If IsDBNull(customer) Then
            Return "<tr class=""ent"">"
        End If
        Return "<tr class=""cust hidden"">"
    End Function

    Protected Function SegmentLabel(ByVal Enterprise As Object) As String
        If IsDBNull(Enterprise) Then
            'If no enterprise, it is the segment summary, put plus sign
            Return "<img src=""../_assets/img/plus.png"" alt='<%# Eval(""TerritoryCode"")%>' onclick=""toggleGroup(this);"" />"
        Else
            'Enterprise present
            Return Nothing
        End If
    End Function

    Protected Function EnterpriseLabel(ByVal Enterprise As Object, ByVal Customer As Object) As String
        If Not IsDBNull(Enterprise) And IsDBNull(Customer) Then
            'If no customer, enterprise summary, put plus sign
            Return "<img src=""../_assets/img/plus.png"" alt='<%# Eval(""EnterpriseName"")%>' onclick=""toggleGroupCust(this);"" />"
        Else
            'Customer line (No plus)
            Return Nothing
        End If
    End Function

    Protected Function EditButton(ByVal CustomerName As Object) As String
        If IsDBNull(CustomerName) Then
            Return "<td>"
        Else
            Return "<td style=""visibility:hidden;"">"
        End If
    End Function

    Protected Function MngrButton(ByVal CustomerName As Object) As String
        If IsDBNull(CustomerName) Then
            Return "<td>"
        Else
            Return "<td style=""visibility:hidden;"">"
        End If
    End Function

    Sub CommandButton_OnSelect(ByVal sender As Object, ByVal e As CommandEventArgs)
        Session("EnterpriseID") = e.CommandArgument
        modalpopupextender1.Show()
    End Sub

    Protected Function CheckIfEnterpriseExists(ByVal strval As String) As String
        Dim Enterprise As String = ViewState("Enterprise")
        If Enterprise = strval Then
            Return String.Empty
        Else
            Enterprise = strval
            ViewState("Enterprise") = Enterprise
            Return "<br><b>" & Enterprise & "</b><br>"
        End If
    End Function

    Protected Function BudgetCol(ByVal CustomerName As Object) As String
        If IsDBNull(CustomerName) Then
            Return "<td class=""budgetCol"">"
        Else
            Return "<td class=""budgetCol"" style=""visibility:hidden;"">"
        End If
    End Function

    Protected Function MngCol(ByVal CustomerName As Object) As String
        If IsDBNull(CustomerName) Then
            Return "<td class=""managerCol"">"
        Else
            Return "<td class=""managerCol"" style=""visibility:hidden;"">"
        End If
    End Function

    Protected Sub lvForecasts_OnItemDataBound(ByVal sender As Object, ByVal e As ListViewItemEventArgs)
        Dim dr As System.Data.DataRowView
        dr = CType(e.Item.DataItem, System.Data.DataRowView)
        If IsDBNull(dr.Row("CustomerName")) Then
            If Not IsDBNull(dr.Row("Two_Year_Ago_Actual")) Then
                Two_Year_Ago_Actual += dr.Row("Two_Year_Ago_Actual")
            End If
            If Not IsDBNull(dr.Row("Last_Year_Actual")) Then
                Last_Year_Actual += dr.Row("Last_Year_Actual")
            End If
            If Not IsDBNull(dr.Row("Last_Year_Budget")) Then
                Last_year_Budget += dr.Row("Last_Year_Budget")
            End If
            If Not IsDBNull(dr.Row("Budgeted")) Then
                Current_Year_Budget += dr.Row("Budgeted")
            End If
            If Not IsDBNull(dr.Row("Current_Year_Actual")) Then
                Current_Year_Actual += dr.Row("Current_Year_Actual")
            End If
            If Not IsDBNull(dr.Row("ManagerBudget")) Then
                managerBudget += dr.Row("ManagerBudget")
            End If
        End If
        Dim lit As Literal
        lit = lvForecasts.FindControl("Two_Year_Ago_Actual")
        lit.Text = String.Format("{0:c0}", Two_Year_Ago_Actual)
        lit = lvForecasts.FindControl("Last_year_Actual")
        lit.Text = String.Format("{0:c0}", Last_Year_Actual)
        lit = lvForecasts.FindControl("Last_year_Budget")
        lit.Text = String.Format("{0:c0}", Last_year_Budget)
        lit = lvForecasts.FindControl("Current_Year_Budget")
        lit.Text = String.Format("{0:c0}", Current_Year_Budget)
        lit = lvForecasts.FindControl("Current_Year_Actual")
        lit.Text = String.Format("{0:c0}", Current_Year_Actual)
        lit = lvForecasts.FindControl("ManagerBudget")
        lit.Text = String.Format("{0:c0}", managerBudget)
    End Sub

    Protected Sub EnterpriseDetails_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType <> 0 And e.Row.RowType <> 1 Then
            If e.Row.Cells(3).Text <> "" Then
                Two_Year_Ago_Actual_Details += CDec(e.Row.Cells(3).Text)
            End If
            If e.Row.Cells(4).Text <> "" Then
                Last_Year_Actual_Details += CDec(e.Row.Cells(4).Text)
            End If
            If e.Row.Cells(5).Text <> "" Then
                Last_Year_Budget_Details += CDec(e.Row.Cells(5).Text)
            End If
            If CType(e.Row.FindControl("txtBudgeted"), TextBox).Text <> "" Then
                Budget_Details += CDec(CType(e.Row.FindControl("txtBudgeted"), TextBox).Text)
            End If
            If e.Row.Cells(7).Text <> "" Then
                ManagerBudget_Details += CDec(e.Row.Cells(7).Text)
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = "Total:"
            e.Row.Cells(3).Text = String.Format("{0:c0}", Two_Year_Ago_Actual_Details)
            e.Row.Cells(4).Text = String.Format("{0:c0}", Last_Year_Actual_Details)
            e.Row.Cells(5).Text = String.Format("{0:c0}", Last_Year_Budget_Details)
            e.Row.Cells(6).Text = String.Format("{0:c0}", Budget_Details)
            e.Row.Cells(7).Text = String.Format("{0:c0}", ManagerBudget_Details)
        End If
    End Sub

    Public Sub refreshListView(ByVal sender As Object, ByVal e As EventArgs)
        modalpopupextender1.Hide()
        lvForecasts.DataBind()
    End Sub

    Public Sub Update(ByVal sender As Object, ByVal e As EventArgs)
        Dim sb As StringBuilder = New StringBuilder
        'build the query
        For Each row In EnterpriseDetails.Rows
            sb.Append("UPDATE tblforecastdetails SET budgeted = ")
            Dim tb As TextBox = DirectCast(row.findcontrol("txtBudgeted"), TextBox)
            sb.Append(tb.Text)
            sb.Append(" WHERE forecastdetailid = ")
            sb.Append(EnterpriseDetails.DataKeys(row.rowindex).Value.ToString)
            sb.Append(" ")
        Next

        Dim connectionString As String
        connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

        Dim SqlConnection As SqlConnection = New SqlConnection
        SqlConnection.ConnectionString = connectionString

        Dim SqlCommand As SqlCommand = New SqlCommand
        SqlCommand.CommandText = sb.ToString
        SqlCommand.Connection = SqlConnection

        SqlConnection.Open()
        SqlCommand.ExecuteNonQuery()
        SqlConnection.Close()

        'modalpopupextender1.Hide()
        lblnotification.text = "Updated " & Now.ToString
        'lvForecasts.DataBind()
        EnterpriseDetails.DataBind()
    End Sub
End Class