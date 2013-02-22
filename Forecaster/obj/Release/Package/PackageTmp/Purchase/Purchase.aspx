<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="Purchase.aspx.vb" Inherits="Forecaster.Purchase" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Purchase Request</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" DefaultMode="Insert" DataKeyNames="PurchaseRequestID" OnItemInserted="frmInsert_ItemInserted" OnItemUpdated="frmInsert_ItemUpdated">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>Requester Name:
                    </td>
                    <td>
                        <asp:TextBox ID="RequesterNameTextBox" runat="server" Text='<%# Bind("RequesterName") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Name of requester required" ControlToValidate="RequesterNameTextBox" />
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Email of requester required" ControlToValidate="RequesterEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="RequesterEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select your department)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Manager:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select your manager)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Requester and manager can't be the same" ControlToValidate="ManagerDropDown" OnServerValidate="ManagerDropDown_CustomValidation" />
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
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
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Update" runat="server" ForeColor="Red" ControlToValidate="DateRequiredTextBox" ControlExtender="meeDateRequired" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
                <tr>
                    <td>Item Name:
                    </td>
                    <td>
                        <asp:TextBox ID="ItemNameTextBox" Width="500" runat="server" Text='<%# Bind("ItemName") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Item name required" ControlToValidate="ItemNameTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server" Text='<%# Bind("Reason") %>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Reason required" ControlToValidate="ReasonTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:
                    </td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Quantity required" ControlToValidate="QuantityTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Price not to exceed:
                    </td>
                    <td>
                        <asp:TextBox ID="TotalPriceTextBox" runat="server" Text='<%# Bind("TotalPrice") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Price required" ControlToValidate="TotalPriceTextBox" />
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

                <%--<tr>
                    <td>Purpose:
                    </td>
                    <td>
                        <asp:DropDownList ID="ApprovalDropDown" runat="server" DataSourceID="sdsApprovalTypes" AppendDataBoundItems="true" DataValueField="ApprovalTypeID" DataTextField="ApprovalType" SelectedValue='<%# Bind("ApprovalType")%>'>
                            <asp:ListItem Text="(Select the purpose of the purchase)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the purpose of your purchase" ControlToValidate="ApprovalDropDown" />
                        <asp:TextBox ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("ApprovalType") %>' />
                    </td>
                </tr>
               <tr>

                   <td>Customer (resell):
                   </td>
                   <td>
                       <asp:TextBox ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                   </td>
               </tr>
                <tr>
                    <td>Project Code (project):
                    </td>
                    <td>
                        <asp:TextBox ID="ProjectCodeTextBox" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PM Initials (project):
                    </td>
                    <td>
                        <asp:TextBox ID="PMInitialsTextBox" runat="server" Text='<%# Bind("PMInitials") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Change Order Notice (project):
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
                </tr>
                --%>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                            &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </td>

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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Name of requester required" ControlToValidate="RequesterNameTextBox" />
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Email of requester required" ControlToValidate="RequesterEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="RequesterEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select your department)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Manager:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select your manager)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Requester and manager can't be the same" ControlToValidate="ManagerDropDown" OnServerValidate="ManagerDropDown_CustomValidation" />
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
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
                        <asp:TextBox ID="ItemNameTextBox" Width="500" runat="server" Text='<%# Bind("ItemName") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ValidationGroup="Insert" ErrorMessage="Item name required" ControlToValidate="ItemNameTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server" Text='<%# Bind("Reason") %>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" ValidationGroup="Insert" ErrorMessage="Reason required" ControlToValidate="ReasonTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:
                    </td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ValidationGroup="Insert" ErrorMessage="Quantity required" ControlToValidate="QuantityTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Price not to exceed:
                    </td>
                    <td>
                        <asp:TextBox ID="TotalPriceTextBox" runat="server" Text='<%# Bind("TotalPrice") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" ValidationGroup="Insert" ErrorMessage="Price required" ControlToValidate="TotalPriceTextBox" />
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="TotalPriceTextBox" ValidationGroup="Insert" />
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

 <%--               <tr>
                    <td>Purpose:
                    </td>
                    <td>
                        <asp:DropDownList ID="ApprovalDropDown" runat="server" DataSourceID="sdsApprovalTypes" AppendDataBoundItems="true" DataValueField="ApprovalTypeID" DataTextField="ApprovalType" SelectedValue='<%# Bind("ApprovalType")%>'>
                            <asp:ListItem Text="(Select the purpose of the purchase)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red" ValidationGroup="Insert" ErrorMessage="Select the purpose of your purchase" ControlToValidate="ApprovalDropDown" />
                        <%--<asp:TextBox ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("ApprovalType") %>' />--%>
                    </td>
                </tr>
                <%--                <tr>

                    <td>Customer (resell):
                    </td>
                    <td>
                        <asp:TextBox ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>--%>
  <%--              <tr>
                    <td>Project Code (project):
                    </td>
                    <td>
                        <asp:TextBox ID="ProjectCodeTextBox" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PM Initials (project):
                    </td>
                    <td>
                        <asp:TextBox ID="PMInitialsTextBox" runat="server" Text='<%# Bind("PMInitials") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Change Order Notice (project):
                    </td>
                    <td>
                        <asp:TextBox ID="ChangeOrderNoticeTextBox" runat="server" Text='<%# Bind("ChangeOrderNotice") %>' />
                    </td>
                </tr>
                <tr>--%>
                    <%--
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
                        <td></td>
                        <td>
                            <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" ValidationGroup="Insert" />
                            <%--&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                        </td>
                    </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvPurchaseRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="PurchaseRequestID" DataSourceID="sdsPurchaseRequestsGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvPurchaseRequests_SelectedIndexChanged1">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this purchase request?');" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="PurchaseRequestID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="PurchaseRequestID" />
            <asp:BoundField DataField="RequesterName" HeaderText="Requester Name" SortExpression="RequesterName" />
            <%--<asp:BoundField DataField="RequesterUsername" HeaderText="RequesterUsername" SortExpression="RequesterUsername" />--%>
            <asp:BoundField DataField="RequesterEmail" HeaderText="Requester Email" SortExpression="RequesterEmail" />
            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName" />
            <asp:BoundField DataField="DateRequested" HeaderText="Date Requested" DataFormatString="{0:MM/dd/yyyy}" SortExpression="DateRequested" />
            <asp:BoundField DataField="DateRequired" HeaderText="Date Required" DataFormatString="{0:MM/dd/yyyy}" SortExpression="DateRequired" />
            <asp:BoundField DataField="ItemName" HeaderText="Item Name" SortExpression="ItemName" />
            <%--<asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />--%>
            <%--<asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />--%>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
            <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="{0:c2}" SortExpression="TotalPrice" />
            <asp:BoundField DataField="ManagerName" HeaderText="Manager" SortExpression="ManagerName" />
            <asp:BoundField DataField="ManagerApprovalDate" HeaderText="Manager Approved/Denied Date" SortExpression="ManagerApprovalDate" />
            <%--<asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <%--        <asp:BoundField DataField="ApprovalType" HeaderText="ApprovalType" SortExpression="ApprovalType" />
            <asp:BoundField DataField="PMInitials" HeaderText="PMInitials" SortExpression="PMInitials" />
            <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
            <asp:BoundField DataField="ProjectCode" HeaderText="ProjectCode" SortExpression="ProjectCode" />
            <asp:BoundField DataField="ChangeOrderNotice" HeaderText="ChangeOrderNotice" SortExpression="ChangeOrderNotice" />--%>

            <%--        <asp:BoundField DataField="LCLPurchaseOrder" HeaderText="LCLPurchaseOrder" SortExpression="LCLPurchaseOrder" /> --%>
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
    <asp:SqlDataSource ID="sdsInsert" runat="server"
        ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT * FROM [tblPurchaseRequests] where purchaserequestid=@ID" InsertCommand="INSERT INTO [PurchaseRequest].[dbo].[tblPurchaseRequests]
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
           ,[TotalPrice]
           ,[ApprovalType]
           ,[PMInitials]
           ,[Customer]
           ,[ProjectCode]
           ,[ChangeOrderNotice]
           ,[LCLPurchaseOrder]
           ,[BuyerID]
           ,[DateOrderEntry]
           ,[ITReview]
           ,[Visible]
           ,[StatusID])
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
           ,@TotalPrice
           ,@ApprovalType
           ,@PMInitials
           ,@Customer
           ,@ProjectCode
           ,@ChangeOrderNotice
           ,@LCLPurchaseOrder
           ,@BuyerID
           ,@DateOrderEntry
           ,@ITReview
           ,@Visible
           ,@StatusID)"
        UpdateCommand="UPDATE [PurchaseRequest].[dbo].[tblPurchaseRequests]
                   SET [RequesterName] = @RequesterName
                      ,[RequesterUsername] = @RequesterUsername
                      ,[RequesterEmail] = @RequesterEmail
                      ,[DepartmentID] = @DepartmentID
                      ,[DateRequested] = @DateRequested
                      ,[DateRequired] = @DateRequired
                      ,[ItemName] = @ItemName
                      ,[Description] = @Description
                      ,[Reason] = @Reason
                      ,[Quantity] = @Quantity
                      ,[TotalPrice] = @TotalPrice
                      ,[ApprovalType] = @ApprovalType
                      ,[PMInitials] = @PMInitials
                      ,[Customer] = @Customer
                      ,[ProjectCode] = @ProjectCode
                      ,[ChangeOrderNotice] = @ChangeOrderNotice
                      ,[StatusID] = @StatusID
                 WHERE PurchaseRequestID = @PurchaseRequestID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvPurchaseRequests" PropertyName="SelectedValue" />
        </SelectParameters>
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
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="ManagerApprovalDate" />
            <asp:Parameter Name="TotalPrice" />
            <asp:Parameter Name="ApprovalType" />
            <asp:Parameter Name="PMinitials" />
            <asp:Parameter Name="Customer" />
            <asp:Parameter Name="ProjectCode" />
            <asp:Parameter Name="ChangeOrderNotice" />
            <asp:Parameter Name="LCLPurchaseOrder" />
            <asp:Parameter Name="BuyerID" />
            <asp:Parameter Name="DateOrderEntry" />
            <asp:Parameter Name="ITReview" DefaultValue="false" />
            <asp:Parameter Name="Visible" DefaultValue="true" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
        </InsertParameters>
        <UpdateParameters>
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
            <asp:Parameter Name="TotalPrice" />
            <asp:Parameter Name="ApprovalType" />
            <asp:Parameter Name="PMinitials" />
            <asp:Parameter Name="Customer" />
            <asp:Parameter Name="ProjectCode" />
            <asp:Parameter Name="ChangeOrderNotice" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT     tblPurchaseRequests.*, tblManagers.ManagerName, tblDepartments.DepartmentName, BuyerName, Status
                       FROM       tblPurchaseRequests 
                       INNER JOIN tblDepartments 
                       ON tblPurchaseRequests.DepartmentID = tblDepartments.DepartmentID 
                       INNER JOIN tblManagers 
                       ON tblPurchaseRequests.ManagerID = tblManagers.ManagerID
                       LEFT JOIN tblBuyers
                       ON tblpurchaseRequests.BuyerID = tblBuyers.BuyerID
                       LEFT JOIN Tblstatuses
                       ON tblpurchaseRequests.statusid = tblstatuses.statusID
                       where RequesterUsername = @RequesterUsername
                       and visible = 1
                       order by purchaseRequestID desc"
        DeleteCommand="update tblpurchaseRequests set visible = 0 where purchaserequestid = @PurchaseRequestID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="RequesterUsername" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblManagers order by managername"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblDepartments order by departmentName"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsApprovalTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblApprovalTypes"></asp:SqlDataSource>
</asp:Content>
