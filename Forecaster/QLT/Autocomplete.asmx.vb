Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class Autocomplete
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Shared Function GetCompletionList(ByVal prefixText As String, ByVal count As Integer) As String()
        ' Create array of movies
        Dim movies() As String = {"Star Wars", "Star Trek", "Superman", "Memento", "Shrek", "Shrek II"}

        ' Return matching movies
        Return (
            From m In movies
            Where m.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase)
            Select m).Take(count).ToArray()
    End Function

End Class