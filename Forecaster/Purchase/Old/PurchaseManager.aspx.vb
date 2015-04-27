﻿Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class PurchaseManager
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Username") = Me.User.Identity.Name.ToString
        Session("DateApproved") = Now()
    End Sub

    Protected Sub frmView_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        If CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Approved" Then
            'Find manager email
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select managerEmail from tblManagers where managername = '" & CType(frmView.FindControl("ManagerIDTextBox"), Label).Text & "'", SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim managerEmail As String = reader.GetString(0)
            reader.Close()

            '-----------------------------------------------------------------
            'Send Email back to user telling him that his request was approved
            '-----------------------------------------------------------------
            Dim body As String = "This Email was automatically generated by the purchase request tool!" & vbCrLf & _
                                 "Item: " & CType(frmView.FindControl("ItemNameTextbox"), Label).Text & vbCrLf & _
                                 "Description: " & CType(frmView.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Reason: " & CType(frmView.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                                 "Quantity: " & CType(frmView.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                                 "Cost not to exceed: " & CType(frmView.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                                 "Date Required: " & CType(frmView.FindControl("DateRequiredTextBox"), Label).Text & vbCrLf & _
                                 "Requested by: " & CType(frmView.FindControl("RequesterNameTextBox"), Label).Text & vbCrLf & _
                                 "Approved by: " & CType(frmView.FindControl("ManagerIDTextBox"), Label).Text & vbCrLf & _
                                 "Approved on: " & Session("DateApproved")

            Dim mm As New MailMessage(managerEmail, CType(frmView.FindControl("RequesterEmailTextBox"), Label).Text, "Request Approved (ID: " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text & ")", body)
            If CType(frmView.FindControl("ITReviewCheckBox"), CheckBox).Checked Then
                'CC IT if IT review was checked
                mm.Body = body & vbCrLf & "Message to IT: " & CType(frmView.FindControl("ITMessageTextBox"), TextBox).Text
                mm.CC.Add("support@laurentide.com")
            End If
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            smtp.Send(mm)

            '---------------------------------------------------------------
            'send email to buyer to warn them about new action to execute on
            '---------------------------------------------------------------

            'Get Buyer's Email
            sc.CommandText = "select buyeremail from tblbuyers where buyerid = " & CType(frmView.FindControl("BuyerDropDown"), DropDownList).SelectedValue.ToString
            reader = sc.ExecuteReader()
            reader.Read()
            Dim BuyerEmail As String = reader.GetString(0)
            reader.Close()

            'Send Email to buyer
            mm.To.RemoveAt(0)
            mm.To.Add(BuyerEmail)
            If mm.CC.Count > 0 Then
                mm.CC.RemoveAt(0)
            End If
            mm.Body = body & vbCrLf & "Please go to this address: http://lcl-sql2k5-s:81/Purchase/PurchaseEntry.aspx to continue."
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        ElseIf CType(frmView.FindControl("StatusDropDown"), DropDownList).SelectedItem.Text = "Denied" Then
            'Find manager email
            Dim connectionString As String
            connectionString = "Server=lcl-sql2k5-s;Database=PurchaseRequest;Trusted_Connection=true"

            Dim SqlConnection As New SqlConnection(connectionString)
            Dim sc As New SqlCommand("select managerEmail from tblManagers where managername = '" & CType(frmView.FindControl("ManagerIDTextBox"), Label).Text & "'", SqlConnection)
            SqlConnection.Open()

            Dim reader As SqlDataReader = sc.ExecuteReader()
            reader.Read()
            Dim managerEmail As String = reader.GetString(0)
            reader.Close()

            '-----------------------------------------------------------------
            'Send Email back to user telling him that his request was denied
            '-----------------------------------------------------------------
            Dim body As String = "This Email was automatically generated by the purchase request tool!" & vbCrLf & _
                                 "Item: " & CType(frmView.FindControl("ItemNameTextbox"), Label).Text & vbCrLf & _
                                 "Description: " & CType(frmView.FindControl("DescriptionTextBox"), TextBox).Text & vbCrLf & _
                                 "Reason: " & CType(frmView.FindControl("ReasonTextBox"), TextBox).Text & vbCrLf & _
                                 "Quantity: " & CType(frmView.FindControl("QuantityTextBox"), TextBox).Text & vbCrLf & _
                                 "Cost not to exceed: " & CType(frmView.FindControl("TotalPriceTextBox"), TextBox).Text & vbCrLf & _
                                 "Your request was denied! Please see with your manager for more information."
            Dim mm As New MailMessage(managerEmail, CType(frmView.FindControl("RequesterEmailTextBox"), Label).Text, "Request Denied (ID: " & CType(frmView.FindControl("PurchaseRequestIDLabel1"), Label).Text & ")", body)
            Dim smtp As New SmtpClient("lcl-exc.adc.laurentidecontrols.com")
            smtp.Send(mm)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertemail();", True)
        Else
            '            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "alertnotsent();", True)
        End If
        'Refresh Gridview
        gvPurchaseRequests.DataBind()
    End Sub

    Protected Sub ITReviewCheckBox_CheckedChanged(sender As Object, e As EventArgs)
        Dim BuyerDropDown As DropDownList
        BuyerDropDown = CType(frmView.FindControl("BuyerDropDown"), DropDownList)
        Dim ITReviewCheckBox As CheckBox = CType(frmView.FindControl("ITReviewCheckBox"), CheckBox)
        If ITReviewCheckBox.checked Then
            BuyerDropDown.SelectedValue = 38
            BuyerDropDown.Enabled = False
        Else
            BuyerDropDown.Enabled = True
        End If
    End Sub

    Protected Sub frmView_DataBound(sender As Object, e As EventArgs)
        Dim BuyerDropDown As DropDownList
        BuyerDropDown = CType(frmView.FindControl("BuyerDropDown"), DropDownList)
        Dim ITReviewCheckBox As CheckBox = CType(frmView.FindControl("ITReviewCheckBox"), CheckBox)
        If Not ITReviewCheckBox Is Nothing Then
            If ITReviewCheckBox.Checked Then
                BuyerDropDown.SelectedValue = 38
                BuyerDropDown.Enabled = False
            Else
                BuyerDropDown.Enabled = True
            End If
        End If
    End Sub
End Class