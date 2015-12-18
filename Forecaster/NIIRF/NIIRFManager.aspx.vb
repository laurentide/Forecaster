Imports System.Data.SqlClient

Public Class NIIRFManager
    Inherits System.Web.UI.Page
    Public cmd As New SqlCommand()
    Public da As New SqlDataAdapter(cmd)
    Public conn As New SqlConnection("Data Source=lcl-sql2k5-s;Initial Catalog=MasterActionItemTool;Integrated Security=True")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub

    Protected Sub StockInvestmentList_SelectedIndexChanged(sender As Object, e As EventArgs)
        If (CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList).SelectedValue = 1) Then
            CType(niirfInsert.FindControl("NoExplainTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("NoExplainLabel"), Label).Visible = True
        Else
            CType(niirfInsert.FindControl("NoExplainTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("NoExplainLabel"), Label).Visible = False
        End If
    End Sub

    Protected Sub ReorderList_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Reset StockInvestmentList
        Dim StockInvestmentList As RadioButtonList = CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList)
        StockInvestmentList.SelectedIndex = -1
        'If No
        If (CType(niirfInsert.FindControl("ReorderList"), RadioButtonList).SelectedValue = 1) Then
            CType(niirfInsert.FindControl("JustificationTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("OriginalOrderTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("OriginalPOTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("OriginalOrderLabel"), Label).Visible = True
            CType(niirfInsert.FindControl("JustificationLabel"), Label).Visible = True
            CType(niirfInsert.FindControl("BuisnessReasonTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList).Visible = False
            CType(niirfInsert.FindControl("InitialInvestmentTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("SourcedTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("LeadTimeTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("BusinessReasonLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("StockInvestmentLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("InitialInvestmentLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("SourcedFromLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("LeadTimeLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("NoExplainLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("NoExplainTextBox"), TextBox).Visible = False
        Else 'If Yes
            CType(niirfInsert.FindControl("JustificationTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("OriginalOrderTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("OriginalPOTextBox"), TextBox).Visible = False
            CType(niirfInsert.FindControl("OriginalOrderLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("JustificationLabel"), Label).Visible = False
            CType(niirfInsert.FindControl("BuisnessReasonTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList).Visible = True
            CType(niirfInsert.FindControl("InitialInvestmentTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("SourcedTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("LeadTimeTextBox"), TextBox).Visible = True
            CType(niirfInsert.FindControl("BusinessReasonLabel"), Label).Visible = True
            CType(niirfInsert.FindControl("StockInvestmentLabel"), Label).Visible = True
            CType(niirfInsert.FindControl("InitialInvestmentLabel"), Label).Visible = True
            CType(niirfInsert.FindControl("SourcedFromLabel"), Label).Visible = True
            CType(niirfInsert.FindControl("LeadTimeLabel"), Label).Visible = True
        End If
    End Sub

    Protected Sub StateList_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub MASTGridView_SelectedIndexChanged(sender As Object, e As EventArgs)
        niirfInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub niirfInsert_DataBound(sender As Object, e As EventArgs)
        Try
            If (CType(niirfInsert.FindControl("ReorderList"), RadioButtonList).SelectedValue = 1) Then
                CType(niirfInsert.FindControl("JustificationTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("OriginalOrderTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("OriginalPOTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("OriginalOrderLabel"), Label).Visible = True
                CType(niirfInsert.FindControl("JustificationLabel"), Label).Visible = True
                CType(niirfInsert.FindControl("BuisnessReasonTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList).Visible = False
                CType(niirfInsert.FindControl("InitialInvestmentTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("SourcedTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("LeadTimeTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("BusinessReasonLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("StockInvestmentLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("InitialInvestmentLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("SourcedFromLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("LeadTimeLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("NoExplainLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("NoExplainTextBox"), TextBox).Visible = False
            Else 'If Yes
                CType(niirfInsert.FindControl("JustificationTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("OriginalOrderTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("OriginalPOTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("OriginalOrderLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("JustificationLabel"), Label).Visible = False
                CType(niirfInsert.FindControl("BuisnessReasonTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList).Visible = True
                CType(niirfInsert.FindControl("InitialInvestmentTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("SourcedTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("LeadTimeTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("BusinessReasonLabel"), Label).Visible = True
                CType(niirfInsert.FindControl("StockInvestmentLabel"), Label).Visible = True
                CType(niirfInsert.FindControl("InitialInvestmentLabel"), Label).Visible = True
                CType(niirfInsert.FindControl("SourcedFromLabel"), Label).Visible = True
                CType(niirfInsert.FindControl("LeadTimeLabel"), Label).Visible = True
            End If
            If (CType(niirfInsert.FindControl("StockInvestmentList"), RadioButtonList).SelectedValue = 1) Then
                CType(niirfInsert.FindControl("NoExplainTextBox"), TextBox).Visible = True
                CType(niirfInsert.FindControl("NoExplainLabel"), Label).Visible = True
            Else
                CType(niirfInsert.FindControl("NoExplainTextBox"), TextBox).Visible = False
                CType(niirfInsert.FindControl("NoExplainLabel"), Label).Visible = False
            End If
        Catch ex As Exception

        End Try
    End Sub
End Class