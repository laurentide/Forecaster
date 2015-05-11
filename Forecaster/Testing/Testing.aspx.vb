Public Class Testing
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub testEdit_SelectedIndexChanged(sender As Object, e As EventArgs)
        testInsert.ChangeMode(FormViewMode.Edit)
    End Sub
End Class