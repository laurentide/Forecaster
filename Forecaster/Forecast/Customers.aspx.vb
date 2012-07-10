Imports System.Data
Imports System.Data.SqlClient

Public Class Customers
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("User") = Me.User.Identity.Name.ToString
    End Sub

    Dim lastteamNameValue As String = Nothing
    Dim lastApprovedValue As String = Nothing
    Protected Function AddGroupingRowIfTeamHasChanged() As String
        'Get the data field value of interest for this row
        Dim currentteamNameValue As String = Eval("TeamName").ToString()
        Dim currentApprovedValue As String = IIf(Eval("Approved").ToString(), "Approved", "Not Approved")

        'Specify name to display if dataFieldValue is a database NULL
        If currentteamNameValue.Length = 0 Then
            currentteamNameValue = "Unknown"
        End If

        'See if there's been a change in value
        If lastteamNameValue <> currentteamNameValue Or lastApprovedValue <> currentApprovedValue Then
            'There's been a change! Record the change and emit the table row
            lastteamNameValue = currentteamNameValue
            lastApprovedValue = currentApprovedValue

            Return String.Format("<tr class=""group""><td colspan=""10"">Team: {0} - Budget Status: {1} </td></tr>", currentteamNameValue, currentApprovedValue)
        Else
            'No change, return an empty string
            Return String.Empty
        End If
    End Function

    Protected Function TestForEnterpriseNull(ByVal enterprise As Object, ByVal customer As Object) As String
        'inital hidden
        If IsDBNull(enterprise) Then
            Return "<tr class=""seg"">"
        Else
            If IsDBNull(customer) Then
                Return "<tr class=""ent hidden"">"
            End If
            Return "<tr class=""cust hidden"">"
        End If
    End Function

    Protected Function SegmentLabel(ByVal Enterprise As Object) As String
        If IsDBNull(Enterprise) Then
            'If no enterprise, it is the segment summary, put plus sign
            Return "<img src=""../_assets/img/plus.png"" alt='<%# Eval(""segmentName"")%>' onclick=""toggleGroup(this);"" />"
        Else
            'Enterprise present
            Return Nothing
        End If
    End Function

    Protected Function EnterpriseLabel(ByVal Enterprise As Object, ByVal Customer As Object) As String
        If Not IsDBNull(Enterprise) And IsDBNull(Customer) Then
            'If no customer, enterprise summary, put plus sign
            Return "<img src=""../_assets/img/plus.png"" alt='<%# Eval(""EnterpriseName"")%>' onclick=""toggleGroupCust(this);"" />"
        Else
            'Customer line (No plus)
            Return Nothing
        End If
    End Function

    Protected Sub Listview1_OnItemCommand(ByVal sender As Object, ByVal e As ListViewCommandEventArgs)
        Dim MyConnection As SqlConnection
        Dim MyCommand As SqlCommand
        Dim dataItem As ListViewDataItem = CType(e.Item, ListViewDataItem)
        Dim forecastdetailid As String = ListView1.DataKeys(dataItem.DisplayIndex).Value.ToString()

        'Create a Connection object.
        MyConnection = New SqlConnection("server=lcl-sql2k5-s;database=Forecaster;Trusted_Connection=yes")
        If String.Equals(e.CommandName, "setMngr") Then
            'Create a Command object, and then set the connection.
            'The following SQL statements check whether a GetAuthorsByLastName stored procedure 
            'already exists.
            MyCommand = New SqlCommand("exec setmngr @forecastdetailid = " & forecastdetailid, MyConnection)

            With MyCommand
                'Set the command type that you will run.
                .CommandType = CommandType.Text

                'Open the connection.
                .Connection.Open()

                'Run the SQL statement, and then get the returned rows to the DataReader.
                .ExecuteNonQuery()

                .Dispose()  'Dispose of the Command object.
                MyConnection.Close() 'Close the connection.
                Response.Redirect("Customers.aspx")
            End With
        ElseIf String.Equals(e.CommandName, "setSpec") Then
            'Create a Command object, and then set the connection.
            'The following SQL statements check whether a GetAuthorsByLastName stored procedure 
            'already exists.
            MyCommand = New SqlCommand("exec setspec @forecastdetailid = " & forecastdetailid, MyConnection)

            With MyCommand
                'Set the command type that you will run.
                .CommandType = CommandType.Text

                'Open the connection.
                .Connection.Open()

                'Run the SQL statement, and then get the returned rows to the DataReader.
                .ExecuteNonQuery()

                .Dispose()  'Dispose of the Command object.
                MyConnection.Close() 'Close the connection.
                Response.Redirect("Customers.aspx")
            End With
        End If
    End Sub
End Class