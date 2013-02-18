Imports System.Data
Imports System.Data.SqlClient

Public Class Mg_Segments
    Inherits System.Web.UI.Page

    ' Class-scope, running total variables...
    Dim Two_Year_Ago_Actual As Decimal
    Dim Last_Year_Actual As Decimal
    Dim Last_year_Budget As Decimal
    Dim Current_Year_Budget As Decimal
    Dim Current_Year_Actual As Decimal
    Dim ManagerBudget As Decimal
    Dim ManagerBudget_Details As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session("User") = Me.User.Identity.Name.ToString
        Session("Current_Year") = "2012"
    End Sub

    Protected Sub lvForecasts_OnItemDataBound(ByVal sender As Object, ByVal e As ListViewItemEventArgs) Handles ListView1.ItemDataBound
        Dim dr As System.Data.DataRowView
        dr = CType(e.Item.DataItem, System.Data.DataRowView)
        If IsDBNull(dr.Row("EnterpriseName")) Then
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
                ManagerBudget += dr.Row("ManagerBudget")
            End If
        End If
        Dim lit As Literal
        lit = ListView1.FindControl("Two_Year_Ago_Actual")
        lit.Text = String.Format("{0:c0}", Two_Year_Ago_Actual)
        lit = ListView1.FindControl("Last_year_Actual")
        lit.Text = String.Format("{0:c0}", Last_Year_Actual)
        lit = ListView1.FindControl("Last_year_Budget")
        lit.Text = String.Format("{0:c0}", Last_year_Budget)
        lit = ListView1.FindControl("Current_Year_Budget")
        lit.Text = String.Format("{0:c0}", Current_Year_Budget)
        lit = ListView1.FindControl("Current_Year_Actual")
        lit.Text = String.Format("{0:c0}", Current_Year_Actual)
        lit = ListView1.FindControl("ManagerBudget")
        lit.Text = String.Format("{0:c0}", ManagerBudget)
    End Sub

    Dim lastTCValue As String = Nothing
    Protected Function AddGroupingRowIfTeamHasChanged() As String
        'Get the data field value of interest for this row
        Dim currentTCNameValue As String = Eval("TerritoryCode").ToString()
        Dim SumBudgeted As Decimal
        Dim SumBudgetedMng As Decimal

        'See if there's been a change in value
        If lastTCValue <> currentTCNameValue Then
            'Calculate Sum for current team
            Dim sql As String
            sql = "SELECT sum(budgeted) as budgeted, sum(managerbudget) " & _
                   "FROM [Forecaster].[dbo].[tblForecastDetails] a       " & _
                   "inner join tblforecasts b                            " & _
                   "on a.forecastid = b.forecastid                       " & _
                   "inner join tblterritorycodes c                       " & _
                   "on a.territorycodeid = c.territorycodeid             " & _
                   "where TerritoryCode = '" & currentTCNameValue & "'"

            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("ForecasterConnectionString").ConnectionString)
            Dim command As New SqlCommand(sql, connection)
            connection.Open()

            Dim reader As SqlDataReader = command.ExecuteReader()
            While reader.Read()
                SumBudgeted = reader(0)
                SumBudgetedMng = reader(1)
            End While

            connection.Close()

            'Specify name to display if dataFieldValue is a database NULL
            If currentTCNameValue.Length = 0 Then
                currentTCNameValue = "Unknown"
            End If

            'There's been a change! Record the change and emit the table row
            lastTCValue = currentTCNameValue

            Return String.Format("<tr class=""group""><td colspan=""10"">TC: {0} - Budget Total: {1} - Manager Total: {2} </td></tr>", currentTCNameValue, FormatCurrency(SumBudgeted, 2), FormatCurrency(SumBudgetedMng, 2))
        Else
            'No change, return an empty string
            Return String.Empty
        End If
    End Function

    Protected Function SegmentLabel(ByVal Enterprise As Object) As String
        If IsDBNull(Enterprise) Then
            'If no enterprise, it is the segment summary, put plus sign
            Return "<img src=""../_assets/img/plus.png"" alt='<%# Eval(""TerritoryCode"")%>' onclick=""toggleGroupCust(this);"" />"
        Else
            'Enterprise present
            Return Nothing
        End If
    End Function

    Protected Function TestForEnterpriseNull(ByVal enterprise As Object) As String
        'inital hidden
        If IsDBNull(enterprise) Then
            Return "<tr class=""ent"">"
        End If
        Return "<tr class=""cust hidden"">"
    End Function
End Class

