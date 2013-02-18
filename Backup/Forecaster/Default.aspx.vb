Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("User") = Me.User.Identity.Name.ToString
        'Session("User") = "AndreA"
    End Sub

End Class