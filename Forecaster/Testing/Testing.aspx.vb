Public Class Testing
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub testEdit_SelectedIndexChanged(sender As Object, e As EventArgs)
        testInsert.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub testInsert_DataBound(sender As Object, e As EventArgs)
        CType(testInsert.FindControl("TestTextBox"), TextBox).Text = Me.User.Identity.Name.ToString
    End Sub
End Class