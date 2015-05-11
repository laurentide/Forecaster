Imports System.Data.SqlClient

Public Class MasterActionItemTool
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

    Protected Sub mastInsert_DataBound(sender As Object, e As EventArgs)
        Dim teamDropDown As DropDownList
        teamDropDown = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList)
        Dim queryString As String = "SELECT * FROM tblTeams JOIN tblTeamMembership ON tblTeams.TeamID = tblTeamMembership.TeamID JOIN tblMembers ON tblTeamMembership.MemberName = tblMembers.MemberName WHERE tblTeamMembership.MemberName = '" + Session("Username") + "'"
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("MASTConnectionString").ConnectionString
        'Dim ds As New DataSet()
        'Try
        '    ' Connect to the database and run the query.
        '    Dim connection As New SqlConnection(connectionString)
        '    Dim adapter As New SqlDataAdapter(queryString, connection)
        '    ' Fill the DataSet.
        '    adapter.Fill(ds)
        'Catch ex As Exception
        'End Try
        'teamDropDown.DataSource = ds
        sdsTeams.SelectCommand = queryString
        teamDropDown.DataValueField = "TeamID"
        teamDropDown.DataTextField = "TeamName"
        teamDropDown.DataBind()
    End Sub

    Protected Sub TeamsDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        CType(mastInsert.FindControl("HiddenTeamNameTextbox"), TextBox).Text = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedItem.Text
        CType(mastInsert.FindControl("HiddenTeamIDTextbox"), TextBox).Text = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedValue
    End Sub
End Class