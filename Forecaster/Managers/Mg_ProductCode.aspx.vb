Imports System.Data
Imports System.Data.SqlClient

Public Class Mg_ProductCode
    Inherits System.Web.UI.Page

    ' Class-scope, running total variables...
    Dim Two_Year_Ago_Actual As Decimal
    Dim Last_Year_Actual As Decimal
    Dim Last_year_Budget As Decimal
    Dim Current_Year_Budget As Decimal
    Dim Current_Year_Actual As Decimal
    Dim ManagerBudget As Decimal


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session("User") = Me.User.Identity.Name.ToString
        Session("Current_Year") = "2012"
    End Sub

    Protected Sub lvForecasts_OnItemDataBound(ByVal sender As Object, ByVal e As ListViewItemEventArgs) Handles ListView1.ItemDataBound
        Dim dr As System.Data.DataRowView
        dr = CType(e.Item.DataItem, System.Data.DataRowView)
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
End Class

