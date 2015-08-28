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
        Dim queryString As String = "SELECT * FROM tblTeams JOIN tblTeamMembership ON tblTeams.TeamID = tblTeamMembership.TeamID JOIN tblMembers ON tblTeamMembership.MemberName = tblMembers.MemberUserName WHERE tblTeamMembership.MemberName = '" + Session("Username") + "' ORDER BY TeamName"
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("MASTConnectionString").ConnectionString
        Dim ds As New DataSet()
        Try
            ' Connect to the database and run the query.
            Dim connection As New SqlConnection(connectionString)
            connection.Open()
            Dim adapter As New SqlDataAdapter(queryString, connection)
            ' Fill the DataSet.
            adapter.Fill(ds)
            connection.Close()
        Catch ex As Exception
        End Try
        teamDropDown.DataSource = ds
        teamDropDown.DataValueField = "TeamID"
        teamDropDown.DataTextField = "TeamName"
        teamDropDown.DataBind()
    End Sub

    Protected Sub TeamsDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        CType(mastInsert.FindControl("HiddenTeamNameTextbox"), TextBox).Text = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedItem.Text
        Dim TeamID As String = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedItem.Value
        Dim RespDropDown As DropDownList = CType(mastInsert.FindControl("RespDropDownList"), DropDownList)
        RespDropDown.Items.Clear() 'First need to clear the RespDropDown items and add only the returnValue to the list
        RespDropDown.Items.Add("(Select the responsable)")
        CType(mastInsert.FindControl("HiddenResponsableTextbox"), TextBox).Text = ""

        'Select the user's name in the Responsable drop down list and grey it out if Individual is selected in the Team drop down
        If (CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedItem.Text = "Individual") Then
            Dim sqlConnection1 As New SqlConnection("Server=lcl-sql2k5-s;Database=MasterActionItemTool;Trusted_Connection=true")
            Dim cmd As New SqlCommand
            Dim returnValue As String
            cmd.CommandText = "SELECT MemberName FROM tblMembers WHERE MemberUserName = '" + Session("Username") + "'"
            cmd.CommandType = CommandType.Text
            cmd.Connection = sqlConnection1
            sqlConnection1.Open()
            returnValue = cmd.ExecuteScalar()
            sqlConnection1.Close()

            RespDropDown.Items.Add(returnValue)
            RespDropDown.SelectedValue = RespDropDown.Items.FindByText(returnValue).Text
            RespDropDown.Enabled = False
            CType(mastInsert.FindControl("HiddenTeamIDTextbox"), TextBox).Text = "16" 'TeamID of "Individual" in SQL Server
            CType(mastInsert.FindControl("HiddenResponsableTextbox"), TextBox).Text = returnValue.ToString
        ElseIf CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedItem.Text = "(Choose team)" Then
            CType(mastInsert.FindControl("HiddenTeamIDTextbox"), TextBox).Text = ""
            CType(mastInsert.FindControl("HiddenTeamNameTextbox"), TextBox).Text = ""
        Else 'Otherwise, re-enable Responsable drop down and fetch the members of the selected team           
            CType(mastInsert.FindControl("HiddenTeamIDTextbox"), TextBox).Text = CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedValue
            RespDropDown.Enabled = True

            Dim connectionString As String = ConfigurationManager.ConnectionStrings("MASTConnectionString").ConnectionString
            Dim connection As SqlConnection = New SqlConnection(connectionString)
            connection.Open()
            Dim query As String = "SELECT tblMembers.MemberName, tblMembers.MemberID FROM tblMembers INNER JOIN tblTeamMembership ON tblMembers.MemberID = tblTeamMembership.MemberID WHERE tblTeamMembership.TeamID = " & CType(mastInsert.FindControl("TeamsDropDownList"), DropDownList).SelectedValue & " ORDER BY tblMembers.MemberName"
            Dim cmd As SqlCommand = New SqlCommand(query, connection)
            Dim dadapter As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dataset As DataSet = New DataSet
            dadapter.Fill(dataset)
            connection.Close()
            RespDropDown.DataSource = dataset
            RespDropDown.DataTextField = "MemberName"
            RespDropDown.DataValueField = "MemberID"
            RespDropDown.DataBind()
        End If
    End Sub

    Protected Sub sdsInsert_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Try
            Dim ID As Integer = e.Command.Parameters("@ID").Value
            Session("ID") = ID
        Catch ex As Exception
        End Try
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

    Protected Sub RespDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs)
        CType(mastInsert.FindControl("HiddenResponsableTextbox"), TextBox).Text = CType(mastInsert.FindControl("RespDropDownList"), DropDownList).SelectedItem.Text
    End Sub
End Class