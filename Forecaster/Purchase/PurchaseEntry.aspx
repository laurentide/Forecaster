﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="PurchaseEntry.aspx.vb" Inherits="Forecaster.PurchaseEntry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Purchase Request</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" DefaultMode="Insert" DataKeyNames="PurchaseRequestID">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>PurchaseRequestID:
                    </td>
                    <td>
                        <asp:Label ID="PurchaseRequestIDLabel1" runat="server" Text='<%# Eval("PurchaseRequestID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>RequesterName:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterNameTextBox" runat="server" Text='<%# Bind("RequesterName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>RequesterUsername:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterUsernameTextBox" runat="server" Text='<%# Bind("RequesterUsername") %>' />
                    </td>
                </tr>
                <tr>
                    <td>RequesterEmail:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterEmailTextBox" runat="server" Text='<%# Bind("RequesterEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td>DepartmentID:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DatasourceID="sdsDepartments" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>' />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>DateRequested:
                    </td>
                    <td>
                        <asp:TextBox ID="DateRequestedTextBox" runat="server" Text='<%# Bind("DateRequested") %>' />
                    </td>
                </tr>
                <tr>
                    <td>DateRequired:
                    </td>
                    <td>
                        <asp:TextBox ID="DateRequiredTextBox" runat="server" Text='<%# Bind("DateRequired") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ItemName:
                    </td>
                    <td>
                        <asp:TextBox ID="ItemNameTextBox" runat="server" Text='<%# Bind("ItemName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server" Text='<%# Bind("Reason") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:
                    </td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ManagerID:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DatasourceID="sdsManagers" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>' />
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>ManagerApprovalDate:
                    </td>
                    <td>
                        <asp:TextBox ID="ManagerApprovalDateTextBox" runat="server" Text='<%# Bind("ManagerApprovalDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Approved:
                    </td>
                    <td>
                        <asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' />
                    </td>
                </tr>
                <tr>
                    <td>TotalPrice:
                    </td>
                    <td>
                        <asp:TextBox ID="TotalPriceTextBox" runat="server" Text='<%# Bind("TotalPrice") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ApprovalType:
                    </td>
                    <td>
                        <asp:TextBox ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("ApprovalType") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Usage:
                    </td>
                    <td>
                        <asp:TextBox ID="UsageTextBox" runat="server" Text='<%# Bind("Usage") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Customer:
                    </td>
                    <td>
                        <asp:TextBox ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ProjectCode:
                    </td>
                    <td>
                        <asp:TextBox ID="ProjectCodeTextBox" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ChangeOrderNotice:
                    </td>
                    <td>
                        <asp:TextBox ID="ChangeOrderNoticeTextBox" runat="server" Text='<%# Bind("ChangeOrderNotice") %>' />
                    </td>
                </tr>
                <tr>
                    <td>LCLPurchaseOrder:
                    </td>
                    <td>
                        <asp:TextBox ID="LCLPurchaseOrderTextBox" runat="server" Text='<%# Bind("LCLPurchaseOrder") %>' />
                    </td>
                </tr>
                <tr>
                    <td>BuyerID:
                    </td>
                    <td>
                        <asp:TextBox ID="BuyerIDTextBox" runat="server" Text='<%# Bind("BuyerID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>OrderEntryByID:
                    </td>
                    <td>
                        <asp:TextBox ID="OrderEntryByIDTextBox" runat="server" Text='<%# Bind("OrderEntryByID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>DateOrderEntry:
                    </td>
                    <td>
                        <asp:TextBox ID="DateOrderEntryTextBox" runat="server" Text='<%# Bind("DateOrderEntry") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>Requester Name:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterNameTextBox" runat="server" Text='<%# Bind("RequesterName") %>' />
                    </td>
                </tr>
<%--                <tr>
                    <td>Requester Username:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterUsernameTextBox" runat="server" Text='<%# Bind("RequesterUsername") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Requester Email:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterEmailTextBox" runat="server" Text='<%# Bind("RequesterEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DatasourceID="sdsDepartments" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>' />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                    </td>
                </tr>
<%--                <tr>
                    <td>Date Requested:
                    </td>
                    <td>
                        <asp:TextBox ID="DateRequestedTextBox" runat="server" Text='<%# Bind("DateRequested") %>' />
                        <asp:Image runat="server" ID="Calendar_scheduleHS" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="DateRequestedTextBox" PopupButtonID="Calendar_scheduleHS" />
                        <asp:MaskedEditExtender ID="meeDateRequested" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DateRequestedTextBox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator1" runat="server" ControlToValidate="DateRequestedTextBox" ControlExtender="meeDateRequested" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>--%>
                <tr>
                    <td>Date Required:
                    </td>
                    <td>
                        <asp:TextBox ID="DateRequiredTextBox" runat="server" Text='<%# Bind("DateRequired") %>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DateRequiredTextBox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateRequired" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DateRequiredTextBox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" runat="server" ControlToValidate="DateRequiredTextBox" ControlExtender="meeDateRequired" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
                <tr>
                    <td>Item Name:
                    </td>
                    <td>
                        <asp:TextBox ID="ItemNameTextBox" runat="server" Text='<%# Bind("ItemName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server" Text='<%# Bind("Reason") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:
                    </td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Total Price:
                    </td>
                    <td>
                        <asp:TextBox ID="TotalPriceTextBox" runat="server" Text='<%# Bind("TotalPrice") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Manager:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DatasourceID="sdsManagers" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>' />
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>
                </tr>
<%--                <tr>
                    <td>Manager Approval Date:
                    </td>
                    <td>
                        <asp:TextBox ID="ManagerApprovalDateTextBox" runat="server" Text='<%# Bind("ManagerApprovalDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Approved:
                    </td>
                    <td>
                        <asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' />
                    </td>
                </tr>--%>

<%--                <tr>
                    <td>Approval Type:
                    </td>
                    <td>
                        <asp:TextBox ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("ApprovalType") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Usage:
                    </td>
                    <td>
                        <asp:TextBox ID="UsageTextBox" runat="server" Text='<%# Bind("Usage") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Customer:
                    </td>
                    <td>
                        <asp:TextBox ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Project Code:
                    </td>
                    <td>
                        <asp:TextBox ID="ProjectCodeTextBox" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Change Order Notice:
                    </td>
                    <td>
                        <asp:TextBox ID="ChangeOrderNoticeTextBox" runat="server" Text='<%# Bind("ChangeOrderNotice") %>' />
                    </td>
                </tr>
                <tr>
                    <td>LCL Purchase Order:
                    </td>
                    <td>
                        <asp:TextBox ID="LCLPurchaseOrderTextBox" runat="server" Text='<%# Bind("LCLPurchaseOrder") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Buyer ID:
                    </td>
                    <td>
                        <asp:TextBox ID="BuyerIDTextBox" runat="server" Text='<%# Bind("BuyerID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Order Entry By ID:
                    </td>
                    <td>
                        <asp:TextBox ID="OrderEntryByIDTextBox" runat="server" Text='<%# Bind("OrderEntryByID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Date Order Entry:
                    </td>
                    <td>
                        <asp:TextBox ID="DateOrderEntryTextBox" runat="server" Text='<%# Bind("DateOrderEntry") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        <%--&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                    </td>
                    <td></td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>

    <asp:GridView ID="gvPurchaseRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="PurchaseRequestID" DataSourceID="sdsPurchaseRequestsGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="PurchaseRequestID" HeaderText="PurchaseRequestID" InsertVisible="False" ReadOnly="True" SortExpression="PurchaseRequestID" />
            <asp:BoundField DataField="RequesterName" HeaderText="RequesterName" SortExpression="RequesterName" />
            <asp:BoundField DataField="RequesterUsername" HeaderText="RequesterUsername" SortExpression="RequesterUsername" />
            <asp:BoundField DataField="RequesterEmail" HeaderText="RequesterEmail" SortExpression="RequesterEmail" />
            <asp:BoundField DataField="DepartmentID" HeaderText="DepartmentID" SortExpression="DepartmentID" />
            <asp:BoundField DataField="DateRequested" HeaderText="DateRequested" SortExpression="DateRequested" />
            <asp:BoundField DataField="DateRequired" HeaderText="DateRequired" SortExpression="DateRequired" />
            <asp:BoundField DataField="ItemName" HeaderText="ItemName" SortExpression="ItemName" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
            <asp:BoundField DataField="ManagerID" HeaderText="ManagerID" SortExpression="ManagerID" />
            <asp:BoundField DataField="ManagerApprovalDate" HeaderText="ManagerApprovalDate" SortExpression="ManagerApprovalDate" />
            <asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />
            <asp:BoundField DataField="TotalPrice" HeaderText="TotalPrice" SortExpression="TotalPrice" />
            <asp:BoundField DataField="ApprovalType" HeaderText="ApprovalType" SortExpression="ApprovalType" />
            <asp:BoundField DataField="Usage" HeaderText="Usage" SortExpression="Usage" />
            <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
            <asp:BoundField DataField="ProjectCode" HeaderText="ProjectCode" SortExpression="ProjectCode" />
            <asp:BoundField DataField="ChangeOrderNotice" HeaderText="ChangeOrderNotice" SortExpression="ChangeOrderNotice" />
            <asp:BoundField DataField="LCLPurchaseOrder" HeaderText="LCLPurchaseOrder" SortExpression="LCLPurchaseOrder" />
            <asp:BoundField DataField="BuyerID" HeaderText="BuyerID" SortExpression="BuyerID" />
            <asp:BoundField DataField="OrderEntryByID" HeaderText="OrderEntryByID" SortExpression="OrderEntryByID" />
            <asp:BoundField DataField="DateOrderEntry" HeaderText="DateOrderEntry" SortExpression="DateOrderEntry" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="8px" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsInsert" runat="server"
        ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT * FROM [tblPurchaseRequests]" InsertCommand="INSERT INTO [PurchaseRequest].[dbo].[tblPurchaseRequests]
           ([RequesterName]
           ,[RequesterUsername]
           ,[RequesterEmail]
           ,[DepartmentID]
           ,[DateRequested]
           ,[DateRequired]
           ,[ItemName]
           ,[Description]
           ,[Reason]
           ,[Quantity]
           ,[ManagerID]
           ,[ManagerApprovalDate]
           ,[Approved]
           ,[TotalPrice]
           ,[ApprovalType]
           ,[Usage]
           ,[Customer]
           ,[ProjectCode]
           ,[ChangeOrderNotice]
           ,[LCLPurchaseOrder]
           ,[BuyerID]
           ,[OrderEntryByID]
           ,[DateOrderEntry])
     VALUES
           (@RequesterName
           ,@RequesterUsername
           ,@RequesterEmail
           ,@DepartmentID
           ,@DateRequested
           ,@DateRequired
           ,@ItemName
           ,@Description
           ,@Reason
           ,@Quantity
           ,@ManagerID
           ,@ManagerApprovalDate
           ,@Approved
           ,@TotalPrice
           ,@ApprovalType
           ,@Usage
           ,@Customer
           ,@ProjectCode
           ,@ChangeOrderNotice
           ,@LCLPurchaseOrder
           ,@BuyerID
           ,@OrderEntryByID
           ,@DateOrderEntry)">
        <InsertParameters>
            <asp:Parameter Name="RequesterName" />
            <%--<asp:Parameter Name="RequesterUsername" />--%>
            <asp:SessionParameter Name="RequesterUsername" SessionField="Username" />
            <asp:Parameter Name="RequesterEmail" />
            <asp:Parameter Name="DepartmentID" />
            <%--<asp:Parameter Name="DateRequested" />--%>
            <asp:SessionParameter Name="DateRequested" SessionField="DateRequested" />
            <asp:Parameter Name="DateRequired" />
            <asp:Parameter Name="ItemName" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Reason" />
            <asp:Parameter Name="Quantity" />
            <asp:Parameter Name="UnitPrice" />
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="ManagerApprovalDate" />
            <asp:Parameter Name="Approved" />
            <asp:Parameter Name="TotalPrice" />
            <asp:Parameter Name="ApprovalType" />
            <asp:Parameter Name="Usage" />
            <asp:Parameter Name="Customer" />
            <asp:Parameter Name="ProjectCode" />
            <asp:Parameter Name="ChangeOrderNotice" />
            <asp:Parameter Name="LCLPurchaseOrder" />
            <asp:Parameter Name="BuyerID" />
            <asp:Parameter Name="OrderEntryByID" />
            <asp:Parameter Name="DateOrderEntry" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblPurchaseRequests"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblManagers"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblDepartments"></asp:SqlDataSource>
</asp:Content>
