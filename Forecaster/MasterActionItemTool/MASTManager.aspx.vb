Imports System.Data.SqlClient

Public Class MASTManager
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        If Not User.Identity.Name.ToString = "LCLMTL\SteveD" And Not User.Identity.Name.ToString = "LCLMTL\mignoto" And Not User.Identity.Name.ToString = "LCLMTL\mcarr" Then
            Response.Redirect("~/MasterActionItemTool/AccessDenied.aspx")
        End If
    End Sub

    Protected Sub mastInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'Check if the notes text box is empty
        If CType(mastInsert.FindControl("NewNoteTextbox"), TextBox).Text IsNot "" Then
            'if they wrote something in the notes box then insert it into tblNotes
            Dim query As String = "INSERT INTO [tblNotes] ([MAST_ID], [Note], [DatePosted], [Visible]) VALUES (@MAST_ID, @Note, getDate(), 1)"
            Using conn As New SqlConnection("Server=lcl-sql2k5-s;Database=MasterActionItemTool;Trusted_Connection=true")
                Using comm As New SqlCommand()
                    With comm
                        .Connection = conn
                        .CommandType = CommandType.Text
                        .CommandText = query
                        .Parameters.AddWithValue("@MAST_ID", CType(mastInsert.FindControl("MASTIDLabel"), Label).Text)
                        .Parameters.AddWithValue("@Note", CType(mastInsert.FindControl("NewNoteTextbox"), TextBox).Text)
                    End With
                    conn.Open()
                    comm.ExecuteNonQuery()
                End Using
            End Using
        End If
        'update gridview
        Me.MASTGridView.DataBind()
    End Sub

    Protected Sub gvNotes_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

    End Sub

    Protected Sub TeamsDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        CType(mastInsert.FindControl("HiddenTeamNameTextbox"), TextBox).Text = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedItem.Text
        CType(mastInsert.FindControl("HiddenTeamIDTextbox"), TextBox).Text = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedValue
    End Sub

    Protected Sub mastInsert_DataBound(sender As Object, e As EventArgs)
        If mastInsert.CurrentMode = FormViewMode.Edit Then

            'Dim teamDropDown As DropDownList = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList)
            'Dim queryString As String = "SELECT * FROM tblTeams JOIN tblTeamMembership ON tblTeams.TeamID = tblTeamMembership.TeamID JOIN tblMembers ON tblTeamMembership.MemberName = tblMembers.MemberUserName WHERE tblTeamMembership.MemberName = '" & Session("Username") & "'"
            'Dim connectionString As String = ConfigurationManager.ConnectionStrings("MASTConnectionString").ConnectionString
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
            ''sdsTeams.SelectCommand = queryString
            'teamDropDown.DataValueField = "TeamID"
            'teamDropDown.DataTextField = "TeamName"
            'teamDropDown.DataBind()
        End If
    End Sub

    Protected Sub MASTGridView_SelectedIndexChanged(sender As Object, e As EventArgs)
        mastInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub TeamFilterDropdown_Load(sender As Object, e As EventArgs)
        If Not IsPostBack() Then
            Dim queryTeam As String = "SELECT * FROM tblTeams JOIN tblTeamMembership ON tblTeams.TeamID = tblTeamMembership.TeamID JOIN tblMembers ON tblTeamMembership.MemberName = tblMembers.MemberUserName WHERE tblTeamMembership.MemberName = '" + Session("Username") + "'"
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
            sdsTeamFilter.SelectCommand = queryTeam
            sender.DataValueField = "TeamID"
            sender.DataTextField = "TeamName"
            sdsTeamFilter.DataBind()
        End If
    End Sub
End Class