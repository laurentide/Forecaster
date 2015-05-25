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
        Dim queryString As String = "SELECT * FROM tblTeams JOIN tblTeamMembership ON tblTeams.TeamID = tblTeamMembership.TeamID JOIN tblMembers ON tblTeamMembership.MemberName = tblMembers.MemberUserName WHERE tblTeamMembership.MemberName = '" + Session("Username") + "'"
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

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim ID As Integer = e.Command.Parameters("@ID").Value
        Session("ID") = ID
    End Sub

    Protected Sub mastInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        'Check if the notes text box is empty
        If CType(mastInsert.FindControl("NotesTextBox"), TextBox).Text IsNot "" Then
            'if they wrote something in the notes box then insert it into tblNotes
            Dim query As String = "INSERT INTO [tblNotes] ([MAST_ID], [Note], [DatePosted], [Visible]) VALUES (@MAST_ID, @Note, getDate(), 1)"
            Using conn As New SqlConnection("Server=lcl-sql2k5-s;Database=MasterActionItemTool;Trusted_Connection=true")
                Using comm As New SqlCommand()
                    With comm
                        .Connection = conn
                        .CommandType = CommandType.Text
                        .CommandText = query
                        .Parameters.AddWithValue("@MAST_ID", Session("ID"))
                        .Parameters.AddWithValue("@Note", CType(mastInsert.FindControl("NotesTextBox"), TextBox).Text)
                    End With
                    conn.Open()
                    comm.ExecuteNonQuery()
                End Using
            End Using
        End If
    End Sub
End Class