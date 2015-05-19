Imports System.Data.SqlClient

Public Class MASTManager
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not User.Identity.Name.ToString = "LCLMTL\SteveD" And Not User.Identity.Name.ToString = "LCLMTL\mignoto" Then
            Response.Redirect("~/MasterActionItemTool/AccessDenied.aspx")
        End If
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
        Me.MASTGridView.DataBind()
    End Sub

    Protected Sub gvNotes_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

    End Sub
End Class