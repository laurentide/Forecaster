Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit

Public Class Admin
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        '    Dim trigger As New AsyncPostBackTrigger
        '    trigger.ControlID = "ddlProductCodeFamily"
        '    trigger.EventName = "SelectedIndexChanged"
        '    Me.UpdatePanel1.Triggers.Add(trigger)
    End Sub

    'Public Sub btnClear_onClick(ByVal sender As Object, ByVal e As EventArgs)
    '    Me.txtSearch.Text = ""
    '    'Me.cblDogs.ClearSelection()
    '    Me.ddlProductCodeFamily.SelectedIndex = -1
    '    Me.ddlProductCode.SelectedIndex = -1
    '    'Session("dogs") = "nothing"
    '    GridView1.Visible = False
    'End Sub

    'Public Sub btnFilter_onClick(ByVal sender As Object, ByVal e As EventArgs)
    '    GridView1.Visible = True
    '    Dim str As String
    '    str = ""
    '    'For Each itm In Me.cblDogs.Items()
    '    'lbitem = CType(itm, ListItem)
    '    'If lbitem.Selected Then
    '    '    str = str & lbitem.Value & ","
    '    'End If
    '    'Next
    '    str = str.TrimEnd(",")
    '    'Session("dogs") = IIf(str = "", "nothing", str)
    '    GridView1.DataBind()
    'End Sub

    'Protected Sub ddlProductCodeFamily_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlProductCodeFamily.SelectedIndexChanged
    '    'Me.ddlProductCode.Visible = True
    '    'Me.UpdatePanel1.Update()
    'End Sub
End Class