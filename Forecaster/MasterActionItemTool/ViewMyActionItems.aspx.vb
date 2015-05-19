﻿Imports System.Data.SqlClient

Public Class ViewMyActionItems
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Dim queryString As String = "SELECT * FROM tblMasterActionItemTool LEFT JOIN tblTeamMembership ON tblMasterActionItemTool.TeamID = tblTeamMembership.TeamID WHERE (tblTeamMembership.MemberName = '" + Session("Username") + "' OR tblMasterActionItemTool.Responsable = '" + Session("Username") + "') AND tblMasterActionItemTool.Visible = 1"
        'Dim queryString As String = "SELECT * FROM tblMasterActionItemTool WHERE tblMasterActionItemTool.Responsable = '" + Session("Username") + "'"
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

    Protected Sub mastInsert_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        'Check if the notes text box is empty
        If CType(mastInsert.FindControl("NewNoteTextbox"), TextBox).Text IsNot "" Then
            'if they wrote something in the notes box then insert it into tblNotes
            Dim query As String = "INSERT INTO [tblNotes] ([MAST_ID], [Note], [DatePosted]) VALUES (@MAST_ID, @Note, getDate())"
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
        Me.mastEdit.DataBind()
    End Sub

    Protected Sub HiddenItemStatusTextbox_DataBinding(sender As Object, e As EventArgs)
        CType(mastInsert.FindControl("ItemStatusDropDown"), DropDownList).SelectedValue = CType(mastInsert.FindControl("HiddenItemStatusTextbox"), TextBox).Text
    End Sub

    Protected Sub gvNotes_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

    End Sub
End Class