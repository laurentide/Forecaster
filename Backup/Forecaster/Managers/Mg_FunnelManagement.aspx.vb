Imports System.Data
Imports System.Data.SqlClient

Public Class Mg_FunnelManagement
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnInsert_onClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim username As String
        If Me.txtInsert.Text <> "" Then
            username = txtInsert.Text
            If Me.ddlTeams.SelectedValue <> 0 Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

                Dim SqlConnection As SqlConnection = New SqlConnection
                SqlConnection.ConnectionString = connectionString

                Dim SqlCommand As SqlCommand = New SqlCommand
                SqlCommand.CommandText = "Insert into [Forecaster].[dbo].[tblPermissions]  " & _
                                         "(TeamID,Username)  " & _
                                        " select @teamid, @username "

                SqlCommand.Parameters.Add("@teamid", SqlDbType.VarChar, 50).Value = Me.ddlTeams.Text
                SqlCommand.Parameters.Add("@username", SqlDbType.VarChar, 50).Value = username
                SqlCommand.Connection = SqlConnection

                SqlConnection.Open()
                SqlCommand.ExecuteNonQuery()
                SqlConnection.Close()
                Response.Redirect("/Managers/Mg_FunnelManagement.aspx")
            Else
                MsgBox("Please select a team")
            End If
        Else
            MsgBox("Please enter a Username")
        End If
    End Sub

    Protected Sub btnInsertSpecialist_onClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim username As String
        If Me.txtSpecialist.Text <> "" Then
            username = txtSpecialist.Text
            If Me.ddlFunnelProducts.SelectedValue <> 0 Then
                Dim connectionString As String
                connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

                Dim SqlConnection As SqlConnection = New SqlConnection
                SqlConnection.ConnectionString = connectionString

                Dim SqlCommand As SqlCommand = New SqlCommand
                SqlCommand.CommandText = "Insert into [Forecaster].[dbo].[tblProductPermissions]  " & _
                                         "(FunnelProductID,Username)  " & _
                                        " select @FunnelProductID, @username "

                SqlCommand.Parameters.Add("@FunnelProductID", SqlDbType.Int).Value = Me.ddlFunnelProducts.SelectedValue
                SqlCommand.Parameters.Add("@username", SqlDbType.VarChar, 50).Value = username
                SqlCommand.Connection = SqlConnection

                SqlConnection.Open()
                SqlCommand.ExecuteNonQuery()
                SqlConnection.Close()
                Response.Redirect("/Managers/Mg_FunnelManagement.aspx")
            Else
                MsgBox("Please select a product category")
            End If
        Else
            MsgBox("Please enter a Username")
        End If
    End Sub

    Protected Sub btnInsertAdmin_onClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim username As String
        If Me.txtAdmin.Text <> "" Then
            username = txtAdmin.Text

            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

            Dim SqlConnection As SqlConnection = New SqlConnection
            SqlConnection.ConnectionString = connectionString

            Dim SqlCommand As SqlCommand = New SqlCommand
            SqlCommand.CommandText = "Insert into [Forecaster].[dbo].[tblFunnelAdmins]  " & _
                                     "(Username)  " & _
                                    " select @username "

            SqlCommand.Parameters.Add("@username", SqlDbType.VarChar, 50).Value = username
            SqlCommand.Connection = SqlConnection

            SqlConnection.Open()
            SqlCommand.ExecuteNonQuery()
            SqlConnection.Close()
            Response.Redirect("/Managers/Mg_FunnelManagement.aspx")
        Else
            MsgBox("Please enter a Username")
        End If
    End Sub
End Class