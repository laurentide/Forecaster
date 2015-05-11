Public Class ViewMyActionItems
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Dim queryString As String = "SELECT MAST_ID, DateCreated, Name, TeamName, Topic, SubTopic, Action, Responsable, Notes FROM tblMasterActionItemTool JOIN tblTeamMembership ON tblMasterActionItemTool.TeamID = tblTeamMembership.TeamID WHERE tblTeamMembership.MemberName = '" + Session("Username") + "'"
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
        sdsEdit.SelectCommand = queryString
        sdsEdit.DataBind()        
    End Sub

    Protected Sub mastEdit_SelectedIndexChanged(sender As Object, e As EventArgs)
        mastInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub
End Class