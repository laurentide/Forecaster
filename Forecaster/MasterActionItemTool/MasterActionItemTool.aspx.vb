Imports System.Data.SqlClient

Public Class MasterActionItemTool
    Inherits System.Web.UI.Page
    Public cmd As New SqlCommand()
    Public da As New SqlDataAdapter(cmd)
    Public conn As New SqlConnection("Data Source=lcl-sql2k5-s;Initial Catalog=MasterActionItemTool;Integrated Security=True")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
    End Sub

    Protected Sub mastInsert_DataBound(sender As Object, e As EventArgs)
        'place username in the Name text box
        'CType(mastInsert.FindControl("NameTextBox"), TextBox).Text = Session("Username")

        If mastInsert.CurrentMode = FormViewMode.Insert Then
            cmd.Connection = conn
            conn.Open()
            Dim ds As New DataSet
            cmd.CommandText = "SELECT * FROM tblMasterActionItemTool WHERE Name='" + Session("Username") + "'"
            da.Fill(ds)
            CType(mastInsert.FindControl("MASTGridView"), GridView).DataSource = ds.Tables(0)
            CType(mastInsert.FindControl("MASTGridView"), GridView).DataBind()
            da.FillSchema(ds, SchemaType.Mapped)
            conn.Close()
        End If
    End Sub

    Protected Sub MASTGridView_SelectedIndexChanged(sender As Object, e As EventArgs)
        mastInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub MASTGridView_RowEditing(sender As Object, e As GridViewEditEventArgs)
        mastInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub MASTGridView_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

    End Sub
End Class