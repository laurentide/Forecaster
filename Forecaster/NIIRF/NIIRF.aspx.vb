Imports System.Data.SqlClient

Public Class NIIRF
    Inherits System.Web.UI.Page
    Public cmd As New SqlCommand()
    Public da As New SqlDataAdapter(cmd)
    Public conn As New SqlConnection("Data Source=lcl-sql2k5-s;Initial Catalog=MasterActionItemTool;Integrated Security=True")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString

        'sdsTeams.SelectCommand = queryString
        'place username in the Name text box
        'CType(mastInsert.FindControl("NameTextBox"), TextBox).Text = Session("Username")
    End Sub

 
    Protected Sub ReorderYes_CheckedChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub StateNew_CheckedChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub StockInvestmentYes_CheckedChanged(sender As Object, e As EventArgs)

    End Sub
End Class