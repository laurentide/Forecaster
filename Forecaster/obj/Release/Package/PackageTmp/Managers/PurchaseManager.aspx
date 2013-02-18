<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="PurchaseManager.aspx.vb" Inherits="Forecaster.PurchaseManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Purchase Request Approval</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmView" runat="server" DataSourceID="sdsUpdate" DefaultMode="Edit" DataKeyNames="PurchaseRequestID" OnItemUpdated="frmView_ItemUpdated">
        <EditItemTemplate>
            <table>
                <tr>
                    <td></td>
                    <td>ID: <asp:Label ID="PurchaseRequestIDLabel1" runat="server" ReadOnly="True" Text='<%# Eval("PurchaseRequestID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Requester Name:
                    </td>
                    <td>
                        <asp:Label ID="RequesterNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("RequesterName") %>' />
                    </td>
                </tr>
                <%--<tr>
                    <td>RequesterUsername:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterUsernameTextBox" runat="server" Text='<%# Bind("RequesterUsername") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Requester Email:
                    </td>
                    <td>
                        <asp:Label ID="RequesterEmailTextBox" runat="server" Text='<%# Bind("RequesterEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:Label ID="DepartmentIDTextBox" runat="server" ReadOnly="True" Text='<%# Bind("DepartmentName")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Date Requested:
                    </td>
                    <td>
                        <asp:Label ID="DateRequestedTextBox" runat="server" ReadOnly="True" Text='<%# Bind("DateRequested") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Date Required:
                    </td>
                    <td>
                        <asp:Label ID="DateRequiredTextBox" runat="server" ReadOnly="True" Text='<%# Bind("DateRequired") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Item Name:
                    </td>
                    <td>
                        <asp:Label ID="ItemNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("ItemName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" ReadOnly="True" TextMode="MultiLine" Height="100" Width="500" Text='<%# Bind("Description") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server" ReadOnly="True" TextMode="MultiLine" Height="100" Width="500" Text='<%# Bind("Reason") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:
                    </td>
                    <td>
                        <asp:Label ID="QuantityTextBox" runat="server" ReadOnly="True" Text='<%# Bind("Quantity") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Total Price:
                    </td>
                    <td>
                        <asp:Label ID="TotalPriceTextBox" runat="server" ReadOnly="True" Text='<%# Bind("TotalPrice", "{0:c2}")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Approval Type:
                    </td>
                    <td>
<%--                        <asp:DropDownList ID="ApprovalDropDown" runat="server" DataSourceID="sdsApprovalTypes" AppendDataBoundItems="true" DataValueField="ApprovalTypeID" DataTextField="ApprovalType" SelectedValue='<%# Bind("ApprovalType")%>'>
                            <asp:ListItem Text="(Select the purpose of the purchase)" Value="" />
                        </asp:DropDownList>--%>
                        <asp:Label ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("Approval")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Customer (If Resell):
                    </td>
                    <td>
                        <asp:Label ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Project Code (If Project):
                    </td>
                    <td>
                        <asp:Label ID="ProjectCodeTextBox" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PM Initials
                    </td>
                    <td>
                        <asp:Label ID="PMInitialsTextBox" runat="server" Text='<%# Bind("PMInitials") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Change Order Notice:
                    </td>
                    <td>
                        <asp:Label ID="ChangeOrderNoticeTextBox" runat="server" Text='<%# Bind("ChangeOrderNotice") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ManagerID:
                    </td>
                    <td>
                        <asp:TextBox ID="ManagerIDTextBox"  Visible="false" runat="server" Text='<%# Bind("ManagerName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Manager Approval Date:
                    </td>
                    <td>
                        <asp:Label ID="ManagerApprovalDateTextBox" runat="server" readonly="true" Text='<%# Bind("ManagerApprovalDate") %>' />
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
                    <td>ITReview:
                    </td>
                    <td>
                        <asp:CheckBox ID="ITReviewCheckBox" runat="server" Checked='<%# Bind("ITReview")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Message to IT
                    </td>
                    <td>
                        <asp:TextBox ID="ITMessageTextBox" runat="server" TextMode="MultiLine" Height="100" Width="500" Text='<%# Bind("ITMessage")%>' />
                    </td>
                </tr>

                <%--<tr>
                    <td>LCL Purchase Order:
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
                </tr>--%>
                <tr>
                    <td>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        <%--&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                    </td>
                    <td></td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
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
                        <asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />
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
                    <td>TotalPrice:
                    </td>
                    <td>
                        <asp:TextBox ID="TotalPriceTextBox" runat="server" Text='<%# Bind("TotalPrice") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ManagerID:
                    </td>
                    <td>
                        <asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />
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
                    <td>ApprovalType:
                    </td>
                    <td>
                        <asp:TextBox ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("ApprovalType") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PMInitials:
                    </td>
                    <td>
                        <asp:TextBox ID="PMInitialsTextBox" runat="server" Text='<%# Bind("PMInitials") %>' />
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
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <table>
                <tr>
                    <td></td>
                    <td>PurchaseRequestID: <asp:Label ID="PurchaseRequestIDLabel" runat="server" Text='<%# Eval("PurchaseRequestID") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>RequesterName: <asp:Label ID="RequesterNameLabel" runat="server" Text='<%# Bind("RequesterName") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>RequesterUsername: <asp:Label ID="RequesterUsernameLabel" runat="server" Text='<%# Bind("RequesterUsername") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>RequesterEmail: <asp:Label ID="RequesterEmailLabel" runat="server" Text='<%# Bind("RequesterEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>DepartmentID: <asp:Label ID="DepartmentIDLabel" runat="server" Text='<%# Bind("DepartmentID") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>DateRequested: <asp:Label ID="DateRequestedLabel" runat="server" Text='<%# Bind("DateRequested") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>DateRequired: <asp:Label ID="DateRequiredLabel" runat="server" Text='<%# Bind("DateRequired") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>ItemName: <asp:Label ID="ItemNameLabel" runat="server" Text='<%# Bind("ItemName") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>Description: <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>Reason: <asp:Label ID="ReasonLabel" runat="server" Text='<%# Bind("Reason") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>Quantity: <asp:Label ID="QuantityLabel" runat="server" Text='<%# Bind("Quantity") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>TotalPrice: <asp:Label ID="TotalPriceLabel" runat="server" Text='<%# Bind("TotalPrice") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>ManagerID: <asp:Label ID="ManagerIDLabel" runat="server" Text='<%# Bind("ManagerID") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>ManagerApprovalDate: <asp:Label ID="ManagerApprovalDateLabel" runat="server" Text='<%# Bind("ManagerApprovalDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Approved:
                    </td>
                    <td>
                        <asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>ApprovalType: <asp:Label ID="ApprovalTypeLabel" runat="server" Text='<%# Bind("ApprovalType") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>PMInitials: <asp:Label ID="PMInitialsLabel" runat="server" Text='<%# Bind("PMInitials") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>Customer: <asp:Label ID="CustomerLabel" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>ProjectCode: <asp:Label ID="ProjectCodeLabel" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>ChangeOrderNotice: <asp:Label ID="ChangeOrderNoticeLabel" runat="server" Text='<%# Bind("ChangeOrderNotice") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>LCLPurchaseOrder: <asp:Label ID="LCLPurchaseOrderLabel" runat="server" Text='<%# Bind("LCLPurchaseOrder") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>BuyerID: <asp:Label ID="BuyerIDLabel" runat="server" Text='<%# Bind("BuyerID") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>OrderEntryByID: <asp:Label ID="OrderEntryByIDLabel" runat="server" Text='<%# Bind("OrderEntryByID") %>' />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>DateOrderEntry: <asp:Label ID="DateOrderEntryLabel" runat="server" Text='<%# Bind("DateOrderEntry") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvPurchaseRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="PurchaseRequestID" DataSourceID="sdsPurchaseRequestsGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="PurchaseRequestID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="PurchaseRequestID" />
            <asp:BoundField DataField="RequesterName" HeaderText="Requester" SortExpression="RequesterName" />
            <%--<asp:BoundField DataField="RequesterUsername" HeaderText="RequesterUsername" SortExpression="RequesterUsername" />--%>
            <asp:BoundField DataField="RequesterEmail" HeaderText="Email" SortExpression="RequesterEmail" />
            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName" />
            <asp:BoundField DataField="DateRequested" HeaderText="Date Requested" dataformatstring="{0:MM/dd/yyyy}" SortExpression="DateRequested" />
            <asp:BoundField DataField="DateRequired" HeaderText="Date Required" dataformatstring="{0:MM/dd/yyyy}" SortExpression="DateRequired" />
            <asp:BoundField DataField="ItemName" HeaderText="Item Name" SortExpression="ItemName" />
            <%--<asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />--%>
            <%--<asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />--%>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
            <asp:BoundField DataField="TotalPrice" HeaderText="Total"  DataFormatString="{0:c2}" SortExpression="TotalPrice" />
            <%--<asp:BoundField DataField="ManagerID" HeaderText="ManagerID" SortExpression="ManagerID" />--%>
            <asp:BoundField DataField="ManagerApprovalDate" HeaderText="Approval Date" SortExpression="ManagerApprovalDate" />
            <asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />
            <asp:BoundField DataField="Approval" HeaderText="Approval Type" SortExpression="Approval" />
            <asp:CheckBoxField DataField="ITReview" HeaderText="IT Review" SortExpression="ITReview" />
<%--        <asp:BoundField DataField="PMInitials" HeaderText="PMInitials" SortExpression="PMInitials" />
            <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
            <asp:BoundField DataField="ProjectCode" HeaderText="ProjectCode" SortExpression="ProjectCode" />
            <asp:BoundField DataField="ChangeOrderNotice" HeaderText="Change Order Notice" SortExpression="ChangeOrderNotice" />--%>
            <%--<asp:BoundField DataField="LCLPurchaseOrder" HeaderText="LCLPurchaseOrder" SortExpression="LCLPurchaseOrder" />
            <asp:BoundField DataField="BuyerID" HeaderText="BuyerID" SortExpression="BuyerID" />
            <asp:BoundField DataField="OrderEntryByID" HeaderText="OrderEntryByID" SortExpression="OrderEntryByID" />
            <asp:BoundField DataField="DateOrderEntry" HeaderText="DateOrderEntry" SortExpression="DateOrderEntry" />--%>
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
    <asp:SqlDataSource ID="sdsUpdate" runat="server"
        ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT *,b.ApprovalType  as Approval 
                       FROM  [tblPurchaseRequests] a 
                       INNER JOIN [tblApprovalTypes] b 
                       ON a.approvaltype = b.approvaltypeid
                       INNER JOIN [tblDepartments] c
                       ON a.DepartmentID = c.DepartmentID 
                       INNER JOIN tblManagers ON a.ManagerID = tblManagers.ManagerID
                       WHERE PurchaseRequestID = @ID"
        InsertCommand=""
        UpdateCommand="UPDATE [PurchaseRequest].[dbo].[tblPurchaseRequests]
                       SET [ManagerApprovalDate] = @ManagerApprovalDate
                          ,[Approved] = @Approved
                          ,[ITReview] = @ITReview
                     WHERE PurchaseRequestID = @PurchaseRequestID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvPurchaseRequests" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter SessionField="DateApproved" Name="ManagerApprovalDate" />
            <asp:Parameter Name="Approved" />
            <asp:Parameter Name="ITReview" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT     tblPurchaseRequests.*, tblManagers.ManagerName, tblDepartments.DepartmentName,tblApprovalTypes.ApprovalType  as Approval 
                       FROM       tblPurchaseRequests 
                       INNER JOIN tblDepartments 
                       ON tblPurchaseRequests.DepartmentID = tblDepartments.DepartmentID 
                       INNER JOIN tblApprovalTypes
                       ON tblPurchaseRequests.approvaltype = tblApprovalTypes.approvaltypeid
                       INNER JOIN
                       tblManagers ON tblPurchaseRequests.ManagerID = tblManagers.ManagerID
                       where managerDomainUser=@Username Order by purchaserequestid desc">
        <SelectParameters>
            <asp:SessionParameter Name="Username" SessionField="Username" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblManagers"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblDepartments"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsApprovalTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblApprovalTypes"></asp:SqlDataSource>
</asp:Content>
