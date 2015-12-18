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

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub

    Protected Sub StockInvestmentList_SelectedIndexChanged(sender As Object, e As EventArgs)
        If (CType(frmInsert.FindControl("StockInvestmentList"), RadioButtonList).SelectedValue = 1) Then
            CType(frmInsert.FindControl("NoExplainTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("NoExplainLabel"), Label).Visible = True
        Else
            CType(frmInsert.FindControl("NoExplainTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("NoExplainLabel"), Label).Visible = False
        End If
    End Sub

    Protected Sub ReorderList_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Reset StockInvestmentList
        Dim StockInvestmentList As RadioButtonList = CType(frmInsert.FindControl("StockInvestmentList"), RadioButtonList)
        StockInvestmentList.SelectedIndex = -1
        'If No
        If (CType(frmInsert.FindControl("ReorderList"), RadioButtonList).SelectedValue = 1) Then
            CType(frmInsert.FindControl("JustificationTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("OriginalOrderTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("OriginalPOTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("OriginalOrderLabel"), Label).Visible = True
            CType(frmInsert.FindControl("JustificationLabel"), Label).Visible = True
            CType(frmInsert.FindControl("BuisnessReasonTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("StockInvestmentList"), RadioButtonList).Visible = False
            CType(frmInsert.FindControl("InitialInvestmentTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("SourcedTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("LeadTimeTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("BusinessReasonLabel"), Label).Visible = False
            CType(frmInsert.FindControl("StockInvestmentLabel"), Label).Visible = False
            CType(frmInsert.FindControl("InitialInvestmentLabel"), Label).Visible = False
            CType(frmInsert.FindControl("SourcedFromLabel"), Label).Visible = False
            CType(frmInsert.FindControl("LeadTimeLabel"), Label).Visible = False
            CType(frmInsert.FindControl("NoExplainLabel"), Label).Visible = False
            CType(frmInsert.FindControl("NoExplainTextBox"), TextBox).Visible = False
        Else 'If Yes
            CType(frmInsert.FindControl("JustificationTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("OriginalOrderTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("OriginalPOTextBox"), TextBox).Visible = False
            CType(frmInsert.FindControl("OriginalOrderLabel"), Label).Visible = False
            CType(frmInsert.FindControl("JustificationLabel"), Label).Visible = False
            CType(frmInsert.FindControl("BuisnessReasonTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("StockInvestmentList"), RadioButtonList).Visible = True
            CType(frmInsert.FindControl("InitialInvestmentTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("SourcedTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("LeadTimeTextBox"), TextBox).Visible = True
            CType(frmInsert.FindControl("BusinessReasonLabel"), Label).Visible = True
            CType(frmInsert.FindControl("StockInvestmentLabel"), Label).Visible = True
            CType(frmInsert.FindControl("InitialInvestmentLabel"), Label).Visible = True
            CType(frmInsert.FindControl("SourcedFromLabel"), Label).Visible = True
            CType(frmInsert.FindControl("LeadTimeLabel"), Label).Visible = True
        End If
    End Sub

    Protected Sub StateList_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub
End Class