Imports System.Data
Imports System.Data.SqlClient

Public Class Funnel_Old
    Inherits System.Web.UI.Page


    Protected WithEvents GridView1 As Global.System.Web.UI.WebControls.GridView
    Protected WithEvents GridView2 As Global.System.Web.UI.WebControls.GridView
    Protected WithEvents FormView1 As Global.System.Web.UI.WebControls.FormView

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Accordion1.DataBind()
    End Sub

    Protected Sub Accordion1_ItemDataBound(ByVal sender As Object, ByVal e As AjaxControlToolkit.AccordionItemEventArgs) Handles Accordion1.ItemDataBound
        Dim sql As String
        Dim opportunityID As Integer
        If (e.ItemType = AjaxControlToolkit.AccordionItemType.Content) Then
            'Bind formview to table tblopportunities with the good opportunityID
            opportunityID = CType(e.AccordionItem.FindControl("txt_OpportunityID"), HiddenField).Value

            'Get subaccordion
            Dim accordion As New AjaxControlToolkit.Accordion
            accordion = CType(e.AccordionItem.FindControl("Accordion2"), AjaxControlToolkit.Accordion)

            sql = "select * from tblopportunities where opportunityid = " & opportunityID
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("ForecasterConnectionString").ConnectionString)
            Dim command As New SqlCommand(sql, connection)
            command.CommandType = CommandType.Text
            connection.Open()

            Dim sqladapter As New SqlDataAdapter(command)
            Dim myDataset As New DataSet()
            sqladapter.Fill(myDataset)

            'Get the formview inside the first pane of the accordion and bind it
            Dim frm As New FormView()
            frm = CType(accordion.FindControl("FormView1"), FormView)
            frm.DataSource = myDataset
            frm.DataBind()

            'Bind the product grid to tblopportunitydetails with the good opportunityID
            sql = "select * from tblopportunitydetails a inner join tblFunnelCategories b on a.funnelproductid = b.funnelproductid where opportunityid = " & opportunityID

            command.CommandText = sql
            sqladapter.SelectCommand = command
            sqladapter.Fill(myDataset)
            connection.Close()

            'Get the gridview inside the 2nd pane of the accordion and bind it
            Dim grd As New GridView()
            grd = CType(accordion.FindControl("GridView2"), GridView)
            grd.DataSource = myDataset
            grd.DataBind()
        End If
    End Sub

    Private Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim pan As Panel
        If e.Row.RowType = DataControlRowType.DataRow Then
            Select Case Trim(e.Row.Cells(0).Text)
                Case "PSS"
                    pan = CType(e.Row.FindControl("panel9"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel10"), Panel)
                    pan.Visible = True
                Case "Services"
                    pan = CType(e.Row.FindControl("panel11"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel12"), Panel)
                    pan.Visible = True
                Case "Wireless"
                    pan = CType(e.Row.FindControl("panel13"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel14"), Panel)
                    pan.Visible = True
                Case "RSMT PTL"
                    pan = CType(e.Row.FindControl("panel15"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel16"), Panel)
                    pan.Visible = True
            End Select
        End If
    End Sub

    Private Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        Dim pan As Panel
        If e.Row.RowType = DataControlRowType.DataRow Then
            Select Case Trim(e.Row.Cells(0).Text)
                Case "PSS"
                    pan = CType(e.Row.FindControl("panel9"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel10"), Panel)
                    pan.Visible = True
                Case "Services"
                    pan = CType(e.Row.FindControl("panel11"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel12"), Panel)
                    pan.Visible = True
                Case "Wireless"
                    pan = CType(e.Row.FindControl("panel13"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel14"), Panel)
                    pan.Visible = True
                Case "RSMT PTL"
                    pan = CType(e.Row.FindControl("panel15"), Panel)
                    pan.Visible = True
                    pan = CType(e.Row.FindControl("panel16"), Panel)
                    pan.Visible = True
            End Select
        End If
    End Sub

    Sub Formview2_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles FormView2.ItemInserted

    End Sub
End Class