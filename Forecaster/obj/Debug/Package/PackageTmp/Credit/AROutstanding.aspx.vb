Imports System.Data
Imports System.Data.SqlClient
Imports AjaxControlToolkit
Imports Telerik.Web.UI

Public Class AROutstanding
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
    End Sub

    Private Sub RadGrid1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadGrid1.SelectedIndexChanged
        Session("CustNumber") = RadGrid1.SelectedItems(0).Cells(3).Text
        modalpopupextender1.Show()
        frmUpdate.DataBind()
    End Sub

    Protected Sub frmUpdate_DataBound(ByVal sender As Object, ByVal e As EventArgs)

    End Sub

    Public Sub refreshListView(ByVal sender As Object, ByVal e As EventArgs)
        Call Update(sender, e)
        modalpopupextender1.Hide()
    End Sub

    Public Sub Cancel(ByVal sender As Object, ByVal e As EventArgs)
        modalpopupextender1.Hide()
    End Sub

    Protected Sub Update(ByVal sender As Object, ByVal e As EventArgs)
        Try
            'Check if customer is already in table,if not, insert.
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=Forecaster;Trusted_Connection=true"

            Dim SqlConnection As SqlConnection = New SqlConnection
            SqlConnection.ConnectionString = connectionString

            Dim SqlCommand As SqlCommand = New SqlCommand

            SqlCommand.CommandText = "select count(*) from [Nomis].[dbo].[tblARCust] where custNumber = " & Session("CustNumber")
            SqlCommand.Connection = SqlConnection
            SqlConnection.Open()
            Dim custCount = SqlCommand.ExecuteScalar()


            If custCount = 0 Then


                SqlCommand.CommandText = _
                    "INSERT INTO [Nomis].[dbo].[tblARCust]" & _
                    "([CustNumber],[ARContact],[ARContactTel],[ARContactFax],[ARContactEmail],[FinDirContact],[FinDirContactTel],[FinDirContactEmail],[OldCreditLimit],[Followup])" & _
                    "VALUES(@CustNumber,@ARContact,@ARContactTel,@ARContactFax,@ARContactEmail,@FinDirContact,@FinDirContactTel,@FinDirContactEmail,@OldCreditLimit,@Followup)"

                SqlCommand.Parameters.Add("@CustNumber", SqlDbType.Int).Value = Session("CustNumber")
                SqlCommand.Parameters.Add("@ARContact", SqlDbType.VarChar, 50).Value = CType(Me.frmUpdate.FindControl("ARContact"), TextBox).Text
                SqlCommand.Parameters.Add("@ARContactTel", SqlDbType.VarChar, 20).Value = CType(Me.frmUpdate.FindControl("ARContactTel"), TextBox).Text
                SqlCommand.Parameters.Add("@ARContactFax", SqlDbType.VarChar, 15).Value = CType(Me.frmUpdate.FindControl("ARContactFax"), TextBox).Text
                SqlCommand.Parameters.Add("@ARContactEmail", SqlDbType.VarChar, 75).Value = CType(Me.frmUpdate.FindControl("ARContactEmail"), TextBox).Text
                SqlCommand.Parameters.Add("@FinDirContact", SqlDbType.VarChar, 25).Value = CType(Me.frmUpdate.FindControl("FinDirContact"), TextBox).Text
                SqlCommand.Parameters.Add("@FinDirContactTel", SqlDbType.VarChar, 20).Value = CType(Me.frmUpdate.FindControl("FinDirContactTel"), TextBox).Text
                SqlCommand.Parameters.Add("@FinDirContactEmail", SqlDbType.VarChar, 75).Value = CType(Me.frmUpdate.FindControl("FinDirContactEmail"), TextBox).Text
                SqlCommand.Parameters.Add("@OldCreditLimit", SqlDbType.Float).Value = IIf(CType(Me.frmUpdate.FindControl("OldCreditLimit"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("OldCreditLimit"), TextBox).Text)
                SqlCommand.Parameters.Add("@Followup", SqlDbType.DateTime).Value = IIf(CType(Me.frmUpdate.FindControl("Followup"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("Followup"), TextBox).Text)

                SqlCommand.ExecuteNonQuery()

                lblnotification.Text = "Updated " & Now.ToString
                frmUpdate.DataBind()
            Else
                SqlCommand.CommandText = _
                    "Update [Nomis].[dbo].[tblARCust]" & _
                    "set [ARContact]          = @ARContact         " & _
                        ",[ARContactTel]       = @ARContactTel      " & _
                        ",[ARContactFax]       = @ARContactFax      " & _
                        ",[ARContactEmail]     = @ARContactEmail    " & _
                        ",[FinDirContact]      = @FinDirContact     " & _
                        ",[FinDirContactTel]   = @FinDirContactTel  " & _
                        ",[FinDirContactEmail] = @FinDirContactEmail" & _
                        ",[OldCreditLimit]     = @OldCreditLimit    " & _
                        ",[Followup]           = @Followup          " & _
                        " Where CustNumber = @CustNumber"

                SqlCommand.Parameters.Add("@CustNumber", SqlDbType.Int).Value = Session("CustNumber")
                SqlCommand.Parameters.Add("@ARContact", SqlDbType.VarChar, 50).Value = CType(Me.frmUpdate.FindControl("ARContact"), TextBox).Text
                SqlCommand.Parameters.Add("@ARContactTel", SqlDbType.VarChar, 20).Value = CType(Me.frmUpdate.FindControl("ARContactTel"), TextBox).Text
                SqlCommand.Parameters.Add("@ARContactFax", SqlDbType.VarChar, 15).Value = CType(Me.frmUpdate.FindControl("ARContactFax"), TextBox).Text
                SqlCommand.Parameters.Add("@ARContactEmail", SqlDbType.VarChar, 75).Value = CType(Me.frmUpdate.FindControl("ARContactEmail"), TextBox).Text
                SqlCommand.Parameters.Add("@FinDirContact", SqlDbType.VarChar, 25).Value = CType(Me.frmUpdate.FindControl("FinDirContact"), TextBox).Text
                SqlCommand.Parameters.Add("@FinDirContactTel", SqlDbType.VarChar, 20).Value = CType(Me.frmUpdate.FindControl("FinDirContactTel"), TextBox).Text
                SqlCommand.Parameters.Add("@FinDirContactEmail", SqlDbType.VarChar, 75).Value = CType(Me.frmUpdate.FindControl("FinDirContactEmail"), TextBox).Text
                SqlCommand.Parameters.Add("@OldCreditLimit", SqlDbType.Float).Value = IIf(CType(Me.frmUpdate.FindControl("OldCreditLimit"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("OldCreditLimit"), TextBox).Text)
                SqlCommand.Parameters.Add("@Followup", SqlDbType.DateTime).Value = IIf(CType(Me.frmUpdate.FindControl("Followup"), TextBox).Text = "", DBNull.Value, CType(Me.frmUpdate.FindControl("Followup"), TextBox).Text)

                SqlCommand.ExecuteNonQuery()

                lblnotification.Text = "Updated " & Now.ToString
                frmUpdate.DataBind()
            End If
        Catch ex As Exception
            lblnotification.Text = "Error: " & ex.ToString
        End Try
    End Sub

    Protected Sub RadGrid3_InsertCommand(ByVal source As Object, ByVal e As GridCommandEventArgs) Handles Radgrid3.InsertCommand
        sdsCustComments.InsertParameters("CommentDate").DefaultValue = Now
    End Sub

    Protected Sub RadGrid2_InsertCommand(ByVal source As Object, ByVal e As GridCommandEventArgs) Handles Radgrid2.InsertCommand
        sdsInvoiceComments.InsertParameters("CommentDate").DefaultValue = Now
        Dim parentItem As GridDataItem = CType(e.Item.OwnerTableView.ParentItem, GridDataItem)
        sdsInvoiceComments.InsertParameters("Invoice").DefaultValue = parentItem.OwnerTableView.DataKeyValues(parentItem.ItemIndex)("INVOICE").ToString()
    End Sub

End Class