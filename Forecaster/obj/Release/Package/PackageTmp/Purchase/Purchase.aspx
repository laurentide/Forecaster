<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="Purchase.aspx.vb" Inherits="Forecaster.Purchase" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Purchase Request</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" OnDataBound="frmInsert_DataBound" runat="server" DataSourceID="sdsInsert" DefaultMode="Insert" DataKeyNames="PurchaseRequestID" OnItemInserted="frmInsert_ItemInserted" 
        OnItemUpdated="frmInsert_ItemUpdated">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>ID:
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("PurchaseRequestID") %>' />
                    </td>
                </tr>
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
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="RequesterEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select the department)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Approver:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select the approver)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Price is over your self-approval limit" ControlToValidate="ManagerDropDown" OnServerValidate="ManagerDropDown_CustomValidation" />
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
                    <td>Link:
                    </td>
                    <td>
                        <asp:TextBox ID="LinkTextbox" Width="500" runat="server" Text='<%# Bind("Link")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Reason / Benefit:
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
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ForeColor="Red" ErrorMessage="Numbers only" Type="double" MinimumValue="0" MaximumValue="1000000" ControlToValidate="QuantityTextBox" ValidationGroup="Update" />
                    </td>
                </tr>
                <tr>
                    <td>Price not to exceed:
                    </td>
                    <td>
                        <asp:TextBox ID="TotalPriceTextBox" runat="server" Text='<%# Bind("TotalPrice") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Price required" ControlToValidate="TotalPriceTextBox" />
                        <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="TotalPriceTextBox" ValidationGroup="Update" />
                    </td>
                </tr>
                <tr>
                    <td>Purchase Category:
                    </td>
                    <td>
                        <asp:DropDownList ID="PurchaseCategoryDropDown" runat="server" DataSourceID="sdsPurchaseCategories"  AppendDataBoundItems="true" DataValueField="PurchaseCategoryID" DataTextField="DescString" SelectedValue='<%# Bind("PurchaseCategoryID")%>' >
                            <asp:ListItem Text="(Select the purchasing category)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select a category" ControlToValidate="PurchaseCategoryDropDown" />
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
                <tr><td>Attachment</td>
                    <td>
                        <asp:FileUpload ID="fuDialog" runat="server" allowmultiple="true"/>  
                        FileName:<asp:TextBox ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' />
                        Path:<asp:Hyperlink ID="PathTextbox" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("Path")),"",Eval("Path")))%>' Text='<%# IIf(IsDBNull(Eval("Path")),"",Eval("Path"))%>' Target="_blank" />
                    </td>
                </tr>
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
                            <asp:ListItem Text="(Select the department)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Approver:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select the approver)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Price is over your self-approval limit" ControlToValidate="ManagerDropDown" OnServerValidate="ManagerDropDown_CustomValidation" />
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
                    <td>Link:
                    </td>
                    <td>
                        <asp:TextBox ID="LinkTextbox" Width="500" runat="server" Text='<%# Bind("Link") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Reason / Benefit:
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
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ForeColor="Red" ErrorMessage="Numbers only" Type="double" MinimumValue="0" MaximumValue="1000000" ControlToValidate="QuantityTextBox" ValidationGroup="Insert" />
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
                <%-- </td>
                </tr>--%>
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
                    <td>Purchase Category:
                    </td>                   
                    <td>
                        <asp:DropDownList ID="PurchaseCategoryDropDown" runat="server" DataSourceID="sdsPurchaseCategories"  AppendDataBoundItems="true" DataValueField="PurchaseCategoryID" DataTextField="DescString" SelectedValue='<%# Bind("PurchaseCategoryID")%>' >
                            <asp:ListItem Text="(Select the purchasing category)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select a category" ControlToValidate="PurchaseCategoryDropDown" />
                    </td>
                </tr>
                <tr><td>Attachment</td>
                    <td>
                        <asp:FileUpload ID="fuDialog" runat="server"/>  <%--                        FileName:<asp:TextBox ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' />
                        Path:<asp:Hyperlink ID="PathTextbox" runat="server" NavigateUrl='<%# Bind("Path")%>' Text='<%# Eval("Path") %>' ></asp:Hyperlink>--%>
                    </td>

                         </tr>
                <tr><td>Does this purchase request require an Investment sheet? (beta): </td><td><asp:CheckBox ID="InvestmentSheetCheckbox" runat="server" 
                    OnCheckedChanged="InvestmentSheetCheckbox_CheckedChanged" CausesValidation="true" AutoPostBack="true"  /></td></tr>
                        <asp:Panel ID="InvestmentSheetPanel" runat="server" Visible="false">
                        <tr><td><br /></td></tr>
                        <tr><td><asp:Label Text="Investment" runat="server" ID="InvestmentSheetHeader" style="font-size:200%;" /></td></tr>
                        <tr>
                            <td>Investment Owner: </td>
                            <td>
                                <asp:TextBox ID="InvestmentOwnerID" runat="server" Text='<%# Bind("InvestmentOwner")%>' Width="500" /></td>
                        </tr>                        
                        <tr>
                            <td>Investment Start Date:</td>
                            <td>
                                <asp:TextBox ID="ISD_TextBox" runat="server" Text='<%# Bind("InvestmentStartDate")%>' />
                                <asp:Image runat="server" ID="ISD_Image" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                <asp:CalendarExtender ID="ISD_CalendarExtender" runat="server" TargetControlID="ISD_TextBox" PopupButtonID="ISD_Image" />
                                <asp:MaskedEditExtender ID="ISD_MaskedEditExtender" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ISD_TextBox" PromptCharacter="_" />
                                <asp:MaskedEditValidator ID="ISD_Maskededitvalidator" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="ISD_TextBox" ControlExtender="ISD_MaskedEditExtender" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                            </td>
                        </tr>
                      <tr>
                            <td>Definition of Investment (What is the investment that is proposed?):</td>
                            <td>
                                <asp:TextBox ID="DOF_ID" runat="server" Text='<%# Bind("InvestmentDefinition")%>' TextMode="MultiLine" Rows="5" Width="500" /></td>
                        </tr>
                        <tr>
                            <td>Benefit to Laurentide (Why should we consider doing this? - both hard and soft benefits):</td>
                            <td>
                                <asp:TextBox ID="BenefitTextBox" runat="server" Text='<%# Bind("InvestmentLaurentideBenefit")%>' TextMode="MultiLine" Rows="5" Width="500" /></td>
                        </tr>    
                        <tr>
                            <td>Projected ROI (if applicable):</td>
                            <td>
                                <asp:Button ID="AddPROIButton" runat="server" CausesValidation="True" Text="Add new Projected ROI" OnClick="AddPROIButton_Click" />
                            </td>
                       </tr>  
                       <tr>
                           <td></td>
                           <td>
                           <asp:Panel ID="proi_panel" runat="server" Visible="false">
                                <asp:FormView runat="server" ID="proiDetails" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="proiDetails_ItemInserting">   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Benefit (description):</td><td>
                                    <asp:TextBox ID="BenefitsTextBox" runat="server" Text='<%# Bind("Benefit") %>' />
                                </td></tr>
                                     <tr><td>Period:</td><td><asp:DropDownList runat="server" ID="PROIPeriodDropDownList" AutoPostBack="true" CausesValidation="true" 
                                         OnSelectedIndexChanged="PROIPeriodDropDownList_SelectedIndexChanged">
                                        <asp:ListItem Text="Quarterly" Value="Quarterly" />
                                        <asp:ListItem Text="Yearly" Value="Yearly" />
                                    </asp:DropDownList></td></tr>
                                    <tr><td><asp:Label ID="PROI_P1" runat="server" Text="Q1:" /></td><td><asp:TextBox ID="year0" runat="server"  Text='<%# Bind("PROI_Year0")%>' />
                                        <asp:CompareValidator ID="CVYear0" runat="server" Operator="DataTypeCheck" Type="Double"
                                             ControlToValidate="year0" ErrorMessage="Value must be a decimal number (dollar value)" /></td></tr>
                                    <tr><td><asp:Label ID="PROI_P2" runat="server" Text="Q2:" /></td><td><asp:TextBox ID="year1" runat="server"  Text='<%# Bind("PROI_Year1")%>'/>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" Operator="DataTypeCheck" Type="Double"
                                             ControlToValidate="year1" ErrorMessage="Value must be a decimal number (dollar value)" /></td></tr>
                                    <tr><td><asp:Label ID="PROI_P3" runat="server" Text="Q3:" /></td><td><asp:TextBox ID="year2" runat="server"  Text='<%# Bind("PROI_Year2")%>'/>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" Operator="DataTypeCheck" Type="Double"
                                             ControlToValidate="year2" ErrorMessage="Value must be a decimal number (dollar value)" /></td></tr>
                                    <tr><td><asp:Label ID="PROI_P4" runat="server" Text="Q4:" /></td><td><asp:TextBox ID="year3" runat="server"  Text='<%# Bind("PROI_Year3")%>'/>
                                        <asp:CompareValidator ID="CompareValidator3" runat="server" Operator="DataTypeCheck" Type="Double"
                                             ControlToValidate="year3" ErrorMessage="Value must be a decimal number (dollar value)" /></td></tr>
                                    <tr><td><asp:Label ID="PROI_P5" runat="server" Text="Q5:" /></td><td><asp:TextBox ID="year4" runat="server" Text='<%# Bind("PROI_Year4")%>'/>
                                        <asp:CompareValidator ID="CompareValidator4" runat="server" Operator="DataTypeCheck" Type="Double"
                                             ControlToValidate="year4" ErrorMessage="Value must be a decimal number (dollar value)" /></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Projected ROI" CommandName="Insert" ID="InsertButton" CausesValidation="True" ValidationGroup="InsertDetails" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelPROIButton" CausesValidation="true" OnClick="CancelPROIButton_Click"/></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                       </tr></asp:Panel>
                       <tr>
                           <td>Projected ROI list:</td>
                           <td>
                           <asp:GridView ID="gvPROIDetails" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnDataBinding="gvPROIDetails_DataBinding" OnSelectedIndexChanged="gvPROIDetails_SelectedIndexChanged"
                            CellPadding="4" ForeColor="#333333" OnRowDataBound="gvPROIDetails_RowDataBound"
                            Font-Size="10px" OnRowDeleting="gvPROIDetails_RowDeleting">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="Benefit" HeaderText="Benefit" SortExpression="Benefit" />
                                <asp:BoundField DataField="PROI_Year0" HeaderText="Year 0" SortExpression="PROI_Year0" />
                                <asp:BoundField DataField="PROI_Year1" HeaderText="Year 1" SortExpression="PROI_Year1" />
                                <asp:BoundField DataField="PROI_Year2" HeaderText="Year 2" SortExpression="PROI_Year2" />
                                <asp:BoundField DataField="PROI_Year3" HeaderText="Year 3" SortExpression="PROI_Year3" />
                                <asp:BoundField DataField="PROI_Year4" HeaderText="Year 4" SortExpression="PROI_Year4" />
                               </Columns>

                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Projected ROI entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                           </td>
                       </tr>
                        <tr>
                            <td>Program Costs:</td>
                            <td>
                               <asp:Button ID="AddProgramCostButton" runat="server" Text="Add new Program Cost" CausesValidation="true" OnClick="AddProgramCostButton_Click" />
                            </td>
                        </tr>
                       <tr>
                           <td></td>
                           <td>
                           <asp:Panel ID="ProgramCostsPanel" runat="server" Visible="false">
                                <asp:FormView runat="server" ID="frmProgramCosts" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="frmProgramCosts_ItemInserting">   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Program Cost (description):</td><td>
                                    <asp:TextBox ID="ProgramCostTextBox" runat="server" Text='<%# Bind("ProgramCostDetail")%>'/>
                                </td></tr>
                                    <tr><td>Period:</td><td><asp:DropDownList runat="server" ID="PCPeriodDropDownList" AutoPostBack="true" CausesValidation="true" OnSelectedIndexChanged="PCPeriodDropDownList_SelectedIndexChanged">
                                        <asp:ListItem Text="Quarterly" />
                                        <asp:ListItem Text="Yearly" />
                                    </asp:DropDownList></td></tr>
                                    <tr><td><asp:Label ID="PC_P1" runat="server" Text="Q1:" /></td><td><asp:TextBox ID="PCYear0" runat="server" Text='<%# Bind("PC_Year0")%>' /></td></tr>
                                    <tr><td><asp:Label ID="PC_P2" runat="server" Text="Q2:" /></td><td><asp:TextBox ID="PCYear1" runat="server" Text='<%# Bind("PC_Year1")%>'/></td></tr>
                                    <tr><td><asp:Label ID="PC_P3" runat="server" Text="Q3:" /></td><td><asp:TextBox ID="PCYear2" runat="server" Text='<%# Bind("PC_Year2")%>'/></td></tr>
                                    <tr><td><asp:Label ID="PC_P4" runat="server" Text="Q4:" /></td><td><asp:TextBox ID="PCYear3" runat="server" Text='<%# Bind("PC_Year3")%>'/></td></tr>
                                    <tr><td><asp:Label ID="PC_P5" runat="server" Text="Q5:" /></td><td><asp:TextBox ID="PCYear4" runat="server" Text='<%# Bind("PC_Year4")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Program Cost" CommandName="Insert" ID="InsertButton" CausesValidation="True" ValidationGroup="InsertDetails" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelProgramCostButton" CausesValidation="true" OnClick="CancelProgramCostButton_Click"/></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                        <tr>
                           <td>Program Costs List:</td>
                           <td>
                           <asp:GridView ID="gvProgramCostsDetails" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnRowDataBound="gvProgramCostsDetails_RowDataBound"
                            CellPadding="4" ForeColor="#333333" OnDataBinding="gvProgramCostsDetails_DataBinding"
                            Font-Size="10px" OnRowDeleting="gvProgramCostsDetails_RowDeleting" OnSelectedIndexChanged="gvProgramCostsDetails_SelectedIndexChanged">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="ProgramCostDetail" HeaderText="Program Cost" SortExpression="ProgramCostDetail" />
                                <asp:BoundField DataField="PC_Year0" HeaderText="Year 0" SortExpression="PC_Year0" />
                                <asp:BoundField DataField="PC_Year1" HeaderText="Year 1" SortExpression="PC_Year1" />
                                <asp:BoundField DataField="PC_Year2" HeaderText="Year 2" SortExpression="PC_Year2" />
                                <asp:BoundField DataField="PC_Year3" HeaderText="Year 3" SortExpression="PC_Year3" />
                                <asp:BoundField DataField="PC_Year4" HeaderText="Year 4" SortExpression="PC_Year4" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Program Costs entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                           </td>
                        </tr>
                      </tr>
                        <asp:Panel ID="NCFPanel" runat="server">
                       <tr>
                           <td><asp:Label Text="Net Cash Flow:" ID="NetCashFlowID" runat="server" /></td>
                           <td>
                               <table border="solid" width="100%" style="background-color:#F7F6F3;">
                                   <tr style="background:#c1ddff;"><td></td><td><b>Year 0</b></td><td><b>Year 1</b></td><td><b>Year 2</b></td><td><b>Year 3</b></td><td><b>Year 4</b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Net Cash Flow:</b></td><td><b><asp:Label ID="NCFYear0" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear1" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear2" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear3" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear4" runat="server" /></b></td>
                                   </tr>
                                   <tr style="background:#c1ddff;"><td><b>Discount Rate:</b></td><td><b>10%</b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Discount Factor:</b></td><td><b>100%</b></td><td><b>91%</b></td><td><b>83%</b></td><td><b>75%</b></td><td><b>68%</b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Discounted Net Cash Flow:</b></td>
                                       <td><b><asp:Label ID="DNCFYear0" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear1" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear2" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear3" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear4" runat="server" /></b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Five Year Net Present Value (NPV):</b></td><td><b><asp:Label ID="NPVLabel" runat="server" /></b></td></tr>
                               </table>
                           </td>
                       </tr>
                        </asp:Panel>
                        <tr>
                            <td>Success Criteria (ie. how will we measure success/progress quarterly?)</td>
                            <td>
                                <asp:Button ID="SuccessCriteriaButton" runat="server" CausesValidation="true" Text="Add new Success Criteria" OnClick="SuccessCriteriaButton_Click" />
                            </td>
                        </tr>
                        <tr><td></td>
                            <td>
                           <asp:Panel ID="SuccessCriteriaPanel" runat="server" Visible="False">
                                <asp:FormView runat="server" ID="frmSuccessCriteria" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="frmSuccessCriteria_ItemInserting" >   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Success Criteria:</td><td>
                                    <asp:TextBox ID="SuccessCriteriaTextbox" runat="server" Width="500" Text='<%# Bind("SuccessCriteriaDetail")%>'/>
                                </td></tr>
                                    <tr><td>Product Code:</td><td><asp:DropDownList runat="server" ID="ProductCodeDropDownList" 
                                        DataSourceID="sdsProductCode" DataTextField="PCDescription" DataValueField="AQC5AA">
                                        <asp:ListItem Text="(Choose a product code)" Value="" />
                                    </asp:DropDownList><%--<asp:Label ID="ProductCodeDescriptionLabel" runat="server" Text=" " />--%></td></tr>
                                    <tr><td>Period:</td><td><asp:DropDownList runat="server" ID="PeriodDropDownList" OnSelectedIndexChanged="PeriodDropDownList_SelectedIndexChanged" AutoPostBack="true" CausesValidation="true">
                                        <asp:ListItem Text="Quarterly" />
                                        <asp:ListItem Text="Yearly" />
                                    </asp:DropDownList></td></tr>
                                    <tr><td>Baseline:</td><td><asp:TextBox ID="BaselineID" runat="server" Width="500" Text='<%# Bind("Baseline")%>' /></td></tr>
                                    <tr><td><asp:Label ID="LabelQ1" runat="server" Text="Q1:" /></td><td><asp:TextBox ID="Q1" runat="server" Width="500" Text='<%# Bind("Q1")%>'/></td></tr>
                                    <tr><td><asp:Label ID="LabelQ2" runat="server" Text="Q2:" /></td><td><asp:TextBox ID="Q2" runat="server" Width="500" Text='<%# Bind("Q2")%>'/></td></tr>
                                    <tr><td><asp:Label ID="LabelQ3" runat="server" Text="Q3:" /></td><td><asp:TextBox ID="Q3" runat="server" Width="500" Text='<%# Bind("Q3")%>'/></td></tr>
                                    <tr><td><asp:Label ID="LabelQ4" runat="server" Text="Q4:" /></td><td><asp:TextBox ID="Q4" runat="server" Width="500" Text='<%# Bind("Q4")%>'/></td></tr>
                                    <tr><td><asp:Label ID="LabelQ5" runat="server" Text="Q5:" /></td><td><asp:TextBox ID="Q5" runat="server" Width="500" Text='<%# Bind("Q5")%>'/></td></tr>
                                    <tr><td><asp:Label ID="LabelQ6" runat="server" Text="Q6:" /></td><td><asp:TextBox ID="Q6" runat="server" Width="500" Text='<%# Bind("Q6")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Success Criteria" CommandName="Insert" ID="InsertSuccessCriteriaButton" CausesValidation="True" ValidationGroup="InsertDetails" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelSuccessCriteriaButton" CausesValidation="true" OnClick="CancelSuccessCriteriaButton_Click"/></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>Success Criteria List:</td>
                            <td>
                           <asp:GridView ID="gvSuccessCriteria" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnSelectedIndexChanged="gvSuccessCriteria_SelectedIndexChanged"
                            CellPadding="4" ForeColor="#333333"
                            Font-Size="10px" OnRowDeleting="gvSuccessCriteria_RowDeleting">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="SuccessCriteriaDetail" HeaderText="Success Criteria" SortExpression="SuccessCriteriaDetail" />
                                <asp:BoundField DataField="Baseline" HeaderText="Baseline" SortExpression="Baseline" />
                                <asp:BoundField DataField="Q1" HeaderText="P1" SortExpression="Q1" />
                                <asp:BoundField DataField="Q2" HeaderText="P2" SortExpression="Q2" />
                                <asp:BoundField DataField="Q3" HeaderText="P3" SortExpression="Q3" />
                                <asp:BoundField DataField="Q4" HeaderText="P4" SortExpression="Q4" />
                                <asp:BoundField DataField="Q5" HeaderText="P5" SortExpression="Q5" />
                                <asp:BoundField DataField="Q6" HeaderText="P6" SortExpression="Q6" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Success Criteria entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>Implementation & Follow-Up Plan (ie. what will be done to ensure success?)</td>
                            <td><asp:Button ID="AddImplementationButton" runat="server" CausesValidation="true" Text="Add new Implementation/Follow-Up Plan" OnClick="AddImplementationButton_Click" /></td>
                        </tr>
                        <tr><td></td>
                            <td>
                           <asp:Panel ID="ImplementationPanel" runat="server" Visible="False">
                                <asp:FormView runat="server" ID="frmImplementation" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="frmImplementation_ItemInserting">   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Event:</td><td>
                                    <asp:TextBox ID="EventTextbox" runat="server" Width="500" Text='<%# Bind("Event")%>'/>
                                </td></tr>
                                    <tr><td>When:</td><td><asp:TextBox ID="WhenID" runat="server" Width="500" Text='<%# Bind("When")%>'/></td></tr>
                                    <tr><td>% Compl.:</td><td><asp:TextBox ID="ComplID" runat="server" Width="500" Text='<%# Bind("Compl")%>' /></td></tr>
                                    <tr><td>Resp.:</td><td><asp:TextBox ID="RespID" runat="server" Width="500" Text='<%# Bind("Resp")%>'/></td></tr>
                                    <tr><td>Notes:</td><td><asp:TextBox ID="NotesID" runat="server" Width="500" Text='<%# Bind("Notes")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Implementation/Follow-Up Plan" CommandName="Insert" ID="InsertImplementationButton" CausesValidation="True" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelImplementationButton" CausesValidation="true" OnClick="CancelImplementationButton_Click" /></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>Implementation/Follow-Up Plan list:</td>
                            <td>
                           <asp:GridView ID="gvImplementation" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnSelectedIndexChanged="gvImplementation_SelectedIndexChanged"
                            CellPadding="4" ForeColor="#333333"
                            Font-Size="10px" OnRowDeleting="gvImplementation_RowDeleting">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="Event" HeaderText="Event" SortExpression="Event" />
                                <asp:BoundField DataField="FUPWhen" HeaderText="When" SortExpression="FUPWhen" />
                                <asp:BoundField DataField="Compl" HeaderText="Compl" SortExpression="Compl" />
                                <asp:BoundField DataField="Resp" HeaderText="Resp" SortExpression="Resp" />
                                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Implementation/Follow-Up Plan entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>Contingency Plan (ie. what will you do if it does not meet objectives?)</td>
                            <td><asp:TextBox ID="ContingencyPlanTextbox" runat="server" Text='<%# Bind("ContingencyPlan") %>' TextMode="MultiLine" Rows="5" Width="500"></asp:TextBox></td>
                        </tr>
                </asp:Panel>
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
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
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
            <asp:BoundField DataField="ManagerName" HeaderText="Approver" SortExpression="ManagerName" />
            <asp:BoundField DataField="ManagerApprovalDate" HeaderText="Approved/Denied Date" SortExpression="ManagerApprovalDate" />
            <%--<asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />--%>
            <asp:BoundField DataField="LCLPurchaseOrder" HeaderText="LCL Purchase Order" SortExpression="LCLPurchaseOrder" />
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
    
<%--       
           ,[ApprovalType]
           ,[PMInitials]
           ,[Customer]
           ,[ProjectCode]
           ,[ChangeOrderNotice]
    
           ,@ApprovalType
           ,@PMInitials
           ,@Customer
           ,@ProjectCode
           ,@ChangeOrderNotice
    --%>
    
<%--           ,[InvestmentOwner]
           ,[InvestmentStartDate]
           ,[InvestmentDefinition]
           ,[InvestmentLaurentideBenefit]
           ,[ContingencyPlan]
        
           ,@InvestmentOwner
           ,@InvestmentStartDate
           ,@InvestmentDefinition,
           ,@InvestmentLaurentideBenefit
           ,@ContingencyPlan--%>

    <asp:SqlDataSource ID="sdsInsert" runat="server" OnInserted="sdsInsert_Inserted"
        ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT * FROM [tblPurchaseRequests] where purchaserequestid=@ID" 
        InsertCommand="INSERT INTO [PurchaseRequest].[dbo].[tblPurchaseRequests]
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
           ,[TotalPrice]
           ,[LCLPurchaseOrder]
           ,[BuyerID]
           ,[DateOrderEntry]
           ,[ITReview]
           ,[Visible]
           ,[StatusID]
           ,[Link]
           ,[PurchaseCategoryID])
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
           ,@TotalPrice
           ,@LCLPurchaseOrder
           ,@BuyerID
           ,@DateOrderEntry
           ,@ITReview
           ,@Visible
           ,@StatusID
           ,@Link
           ,@PurchaseCategoryID);
        select @ID = @@IDENTITY"
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
                      ,[Link] = @Link
                      ,[ManagerID] = @ManagerID
                      ,[ManagerApprovalDate]=null
                      ,[PurchaseCategoryID] = @PurchaseCategoryID
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
            <asp:Parameter Name="TotalPrice" />
<%--            <asp:Parameter Name="ApprovalType" />
            <asp:Parameter Name="PMinitials" />
            <asp:Parameter Name="Customer" />
            <asp:Parameter Name="ProjectCode" />
            <asp:Parameter Name="ChangeOrderNotice" />--%>
            <asp:Parameter Name="LCLPurchaseOrder" />
            <asp:Parameter Name="BuyerID" />
            <asp:Parameter Name="DateOrderEntry" />
            <asp:Parameter Name="Link" />
            <asp:Parameter Name="ITReview" DefaultValue="false" />
            <asp:Parameter Name="Visible" DefaultValue="true" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="PurchaseCategoryID" />
<%--            <asp:Parameter Name="InvestmentSheetPanel$InvestmentOwner" />
            <asp:Parameter Name="InvestmentSheetPanel$InvestmentStartDate" Type="DateTime" />
            <asp:Parameter Name="InvestmentSheetPanel$InvestmentDefinition" />
            <asp:Parameter Name="InvestmentSheetPanel$InvestmentLaurentideBenefit" />
            <asp:Parameter Name="InvestmentSheetPanel$ContingencyPlan" />--%>
            <asp:Parameter Name="ID"  Direction="Output" Type="Int32" />
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
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="ManagerApprovalDate" DefaultValue="" />
            <asp:Parameter Name="TotalPrice" />
            <asp:Parameter Name="ApprovalType" />
            <asp:Parameter Name="PMinitials" />
            <asp:Parameter Name="Customer" />
            <asp:Parameter Name="ProjectCode" />
            <asp:Parameter Name="ChangeOrderNotice" />
            <asp:Parameter Name="Link" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="PurchaseCategoryID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT     tblPurchaseRequests.*, tblManagers.ManagerName, tblDepartments.DepartmentName, BuyerName, Status, purchasecategory
                       FROM       tblPurchaseRequests 
                       INNER JOIN tblDepartments 
                       ON tblPurchaseRequests.DepartmentID = tblDepartments.DepartmentID 
                       INNER JOIN tblManagers 
                       ON tblPurchaseRequests.ManagerID = tblManagers.ManagerID
                       LEFT JOIN tblBuyers
                       ON tblpurchaseRequests.BuyerID = tblBuyers.BuyerID
                       LEFT JOIN Tblstatuses
                       ON tblpurchaseRequests.statusid = tblstatuses.statusID
                       LEFT JOIN tblpurchasecategories
                       on Tblpurchaserequests.purchasecategoryid = tblpurchasecategories.purchasecategoryid
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
        SelectCommand="select * from tblDepartments where departmentid <> 16 order by departmentName"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsApprovalTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblApprovalTypes"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseCategories" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select *,left(purchaseCategory + replicate(' ',30),30) + ' | ' + Examples as DescString from tblPurchaseCategories order by PurchaseCategory"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsProductCode" runat="server" ConnectionString="<%$ ConnectionStrings:NomisConnectionString %>"
        SelectCommand="select AQC5AA, (AQC5AA + ' - ' + AQC6AA) AS PCDescription from NOMDBF95.PCDPHY01 order by AQC5AA"></asp:SqlDataSource>
</asp:Content>
