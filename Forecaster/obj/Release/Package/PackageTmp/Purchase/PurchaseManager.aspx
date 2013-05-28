<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="PurchaseManager.aspx.vb" Inherits="Forecaster.PurchaseManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Purchase Request Approval</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmView" runat="server" DataSourceID="sdsUpdate" DefaultMode="Edit" DataKeyNames="PurchaseRequestID" OnItemUpdated="frmView_ItemUpdated" OnDataBound="frmView_DataBound">
        <EditItemTemplate>
            <table border="1px">
                <tr>
                    <td>ID:</td>
                    <td><asp:Label ID="PurchaseRequestIDLabel1" runat="server" ReadOnly="True" Text='<%# Eval("PurchaseRequestID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Requester Name:
                    </td>
                    <td>
                        <asp:Label ID="RequesterNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("RequesterName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Requester Username:
                    </td>
                    <td>
                        <asp:Label ID="RequesterUsernameTextBox" runat="server" Text='<%# Bind("RequesterUsername") %>' />
                    </td>
                </tr>
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
                        <asp:Label ID="ItemNameTextBox"  Width="500" runat="server" ReadOnly="True" Text='<%# Bind("ItemName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server"  TextMode="MultiLine" Rows="5" Width="500" Text='<%# Bind("Description") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Link:
                    </td>
                    <td>
                        <asp:Hyperlink ID="LinkTextbox" Width="500" runat="server"  NavigateUrl='<%# Bind("Link")%>' Text='<%# Bind("Link")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server"  TextMode="MultiLine" Rows="5" Width="500" Text='<%# Bind("Reason") %>'  />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:
                    </td>
                    <td>
                        <asp:Textbox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ValidationGroup="Update" ErrorMessage="Quantity required" ControlToValidate="QuantityTextBox" />
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ForeColor="Red" ErrorMessage="Numbers only" Type="double" MinimumValue="0" MaximumValue="1000000" ControlToValidate="QuantityTextBox" ValidationGroup="Update" />
                    </td>
                </tr>
                <tr>
                    <td>Total Price:
                    </td>
                    <td>
                        <asp:Textbox ID="TotalPriceTextBox" runat="server"  Text='<%# Bind("TotalPrice")%>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" ValidationGroup="Update" ErrorMessage="Price required" ControlToValidate="TotalPriceTextBox" />
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar sign" Type="double" MinimumValue="0" MaximumValue="1000000" ControlToValidate="TotalPriceTextBox" ValidationGroup="Update" />
                    </td>
                </tr>
<%--                <tr>
                    <td>Approval Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="ApprovalDropDown" runat="server" DataSourceID="sdsApprovalTypes" AppendDataBoundItems="true" DataValueField="ApprovalTypeID" DataTextField="ApprovalType" SelectedValue='<%# Bind("ApprovalType")%>'>
                            <asp:ListItem Text="(Select the purpose of the purchase)" Value="" />
                        </asp:DropDownList>
                        <asp:Label ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("Approval")%>' />
                    </td>
                </tr>--%>
<%--                <tr>
                    <td>Customer (If Resell):
                    </td>
                    <td>
                        <asp:Label ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>--%>
 <%--               <tr>
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
                </tr>--%>
                <tr>
                    <td>Approver:
                    </td>
                    <td>
                        <asp:Label ID="ManagerIDTextBox"  runat="server" Text='<%# Bind("ManagerName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Approval Date:
                    </td>
                    <td>
                        <asp:Label ID="ManagerApprovalDateTextBox" runat="server" readonly="true" Text='<%# Bind("ManagerApprovalDate") %>' />
                    </td>
                </tr>
<%--                <tr>
                    <td>Approved:
                    </td>
                    <td>
                        <asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Status:
                    </td>
                    <td>
                        <asp:DropDownList ID="StatusDropDown" runat="server" DataSourceID="sdsStatuses" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" SelectedValue='<%# Bind("StatusID")%>'>
                        </asp:DropDownList>
                        <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Please approve or deny this request" Type="Integer" MinimumValue="2" MaximumValue="3" ControlToValidate="StatusDropDown" ValidationGroup="Update" />
                    </td>
                </tr>
                <tr>
                    <td>Is this an IT item? <br /><span style="font-weight:bold">(If yes, the buyer needs to be Johanne Legault)</span> 
                    </td>
                    <td>
                        <asp:CheckBox ID="ITReviewCheckBox" runat="server" Checked='<%# Bind("ITReview")%>' OnCheckedChanged="ITReviewCheckBox_CheckedChanged" AutoPostBack="true" />
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
                </tr>--%>
                <tr>
                    <td>Buyer:
                    </td>
                    <td>
                        <asp:DropDownList ID="BuyerDropDown" runat="server" DataSourceID="sdsBuyers" AppendDataBoundItems="true" DataValueField="BuyerID" DataTextField="BuyerName" SelectedValue='<%# Bind("BuyerID")%>'>
                            <asp:ListItem Text="(Select your buyer)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your buyer" ControlToValidate="BuyerDropDown" />
                        <%--<asp:TextBox ID="BuyerIDTextBox" runat="server" Text='<%# Bind("BuyerID") %>' />--%>
                    </td>
                </tr>
                <%-- %><tr>
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
                    <td></td>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="Update" CommandName="Update" Text="Update" />
                        <%--&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
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
            <asp:BoundField DataField="TotalPrice" HeaderText="Total"  dataformatstring="{0:c2}" SortExpression="TotalPrice" />
            <%--<asp:BoundField DataField="ManagerID" HeaderText="ManagerID" SortExpression="ManagerID" />--%>
            <asp:BoundField DataField="ManagerApprovalDate" HeaderText="Approval Date" SortExpression="ManagerApprovalDate" />
            <%--<asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <%--<asp:BoundField DataField="Approval" HeaderText="Approval Type" SortExpression="Approval" />--%>
            <asp:CheckBoxField DataField="ITReview" HeaderText="IT Review" SortExpression="ITReview" />
<%--        <asp:BoundField DataField="PMInitials" HeaderText="PMInitials" SortExpression="PMInitials" />
            <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
            <asp:BoundField DataField="ProjectCode" HeaderText="ProjectCode" SortExpression="ProjectCode" />
            <asp:BoundField DataField="ChangeOrderNotice" HeaderText="Change Order Notice" SortExpression="ChangeOrderNotice" />--%>
            <%--<asp:BoundField DataField="LCLPurchaseOrder" HeaderText="LCLPurchaseOrder" SortExpression="LCLPurchaseOrder" />--%>
            <asp:BoundField DataField="BuyerName" HeaderText="Buyer" SortExpression="BuyerName" />
            <%--<asp:BoundField DataField="OrderEntryByID" HeaderText="OrderEntryByID" SortExpression="OrderEntryByID" />
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
        SelectCommand="SELECT *, ManagerName
                       FROM  [tblPurchaseRequests] a 
                       INNER JOIN [tblDepartments] c
                       ON a.DepartmentID = c.DepartmentID 
                       INNER JOIN tblManagers ON a.ManagerID = tblManagers.ManagerID
                       WHERE PurchaseRequestID = @ID"
        InsertCommand=""
        UpdateCommand="UPDATE [PurchaseRequest].[dbo].[tblPurchaseRequests]
                       SET [ManagerApprovalDate] = @ManagerApprovalDate
                          ,[ITReview] = @ITReview
                          ,[ITMessage]=@ITMessage
                          ,[BuyerID] = @BuyerID
                          ,[Description] = @Description
                          ,[Reason] = @Reason
                          ,[Quantity] = @Quantity
                          ,[TotalPrice] = @TotalPrice
                          ,[StatusID] = @StatusID
                     WHERE PurchaseRequestID = @PurchaseRequestID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvPurchaseRequests" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter SessionField="DateApproved" Name="ManagerApprovalDate" />
            <asp:Parameter Name="ITReview" />
            <asp:Parameter Name="ITMessage" />
            <asp:Parameter Name="BuyerID" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Reason" />
            <asp:Parameter Name="Quantity" />
            <asp:Parameter Name="TotalPrice" />
            <asp:Parameter Name="StatusID" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT     tblPurchaseRequests.*, tblManagers.ManagerName, tblDepartments.DepartmentName,BuyerName, Status
                       FROM       tblPurchaseRequests 
                       INNER JOIN tblDepartments 
                       ON tblPurchaseRequests.DepartmentID = tblDepartments.DepartmentID 
                       INNER JOIN tblManagers 
                       ON tblPurchaseRequests.ManagerID = tblManagers.ManagerID
                       LEFT JOIN tblbuyers 
                       on tblPurchaseRequests.buyerid = tblbuyers.buyerid
                       LEFT JOIN tblStatuses
                       on tblPurchaseRequests.statusid = tblstatuses.statusid
                       where managerDomainUser=@Username 
                       and visible = 1 
                       Order by purchaserequestid desc">
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
    <asp:SqlDataSource ID="sdsBuyers" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblBuyers order by buyername"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblStatuses order by StatusID"></asp:SqlDataSource>
</asp:Content>
