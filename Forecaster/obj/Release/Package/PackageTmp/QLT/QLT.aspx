<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="QLT.aspx.vb" Inherits="Forecaster.QLT" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Quality Case</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />--%>
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound" DefaultMode="Insert" DataKeyNames="QLTID" OnItemInserted="frmInsert_ItemInserted" OnItemUpdated="frmInsert_ItemUpdated">
        <InsertItemTemplate>
            <tr>
                <td><b>Event Type (*):</b></td>
                <td>
                    <asp:DropDownList ID="EventTypeDropDown" runat="server" DataSourceID="sdsEventTypes" AppendDataBoundItems="true" DataValueField="EventTypeID" DataTextField="EventType" SelectedValue='<%# Bind("EventTypeID")%>'>
                        <asp:ListItem Text="(Select the event type)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the event type" ControlToValidate="EventTypeDropDown" />
                </td>
            </tr>
            <tr>
                <td><b>Origin of Event (*):</b></td>
                <td>
                    <asp:DropDownList ID="OriginDropDown" runat="server" DataSourceID="sdsOrigins" AppendDataBoundItems="true" DataValueField="OriginID" DataTextField="Origin" SelectedValue='<%# Bind("OriginID")%>'>
                        <asp:ListItem Text="(Select the origin)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the origin" ControlToValidate="OriginDropDown" />
                </td>
            </tr>
            <tr>
                <td><b>Category (*):</b></td>
                <td>
                    <asp:DropDownList ID="TypeDropDown" runat="server" DataSourceID="sdsTypes" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="TypeID" DataTextField="Type" SelectedValue='<%# Bind("TypeID")%>' OnSelectedIndexChanged="TypeDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="(Select the complaint type)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the type" ControlToValidate="TypeDropDown" />
                    <br />
                    <asp:Label runat="server" Text="Other complaint type:" Visible="false" ID="TypeLabel" />
                    <br />
                    <asp:TextBox class="textboxWidth" ID="TypeTextBox" runat="server" Text='<%# Bind("Type") %>' Visible="false" />
                </td>
            </tr>
            <tr>
                <td><b>Incident Date (*):</b></td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="DateIncidentTextbox" runat="server" Text='<%# Bind("DateIncident")%>' />
                    <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DateIncidentTextbox" PopupButtonID="Calendar_scheduleDR" />
                    <asp:MaskedEditExtender ID="meeDateincident" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DateIncidentTextbox" PromptCharacter="_" />
                    <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="DateIncidentTextbox" ControlExtender="meeDateincident" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter the incident date" ControlToValidate="DateIncidentTextbox" />
                </td>
            </tr>
            <tr>
                <td><b>Issued By:(*)</b></td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter who issued this case" ControlToValidate="IssuedByTextBox" />
                </td>
            </tr>
            <tr>
                <td><b>Email:</b></td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter an email" ControlToValidate="IssuedByEmailTextBox" />
                </td>
            </tr>
            <tr>
                <td><b>Manager (*):</b></td>
                <td>
                    <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                        <asp:ListItem Text="(Select your manager)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                </td>
            </tr>
            <tr>
                <td><b>Department (*):</b></td>
                <td>
                    <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="Department" SelectedValue='<%# Bind("DepartmentID")%>'>
                        <asp:ListItem Text="(Select your department)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                </td>
            </tr>
            <tr>
                <td>Customer:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="CustomerTextbox" runat="server" Text='<%# Bind("CustomerID")%>'/>
                    <asp:AutoCompleteExtender ID="AutocompleteExtender1" TargetControlID="CustomerTextbox" runat="server" ServiceMethod="GetCompletionList" 
                                                MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="true" CompletionSetCount="10" BehaviorID="AutoCompleteEx" 
                        CompletionListCssClass="autocomplete_completionListElement"
                        CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Name:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerNameTextBox" runat="server" Text='<%# Bind("CustomerContactName")%>' />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Tel:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerContactTelTextBox" runat="server" Text='<%# Bind("CustomerContactTel")%>' />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Email:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerContactEmailTextBox" runat="server" Text='<%# Bind("CustomerContactEmail")%>' />
                </td>
            </tr>

            <tr>
                <td>Sales Order #:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="SalesOrderTextBox" runat="server" Text='<%# Bind("SalesOrder") %>' />
                </td>
            </tr>
            <tr>
                <td>Supplier:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="VendorTextbox" runat="server" Text='<%# Bind("VendorID")%>'/>
                    <asp:AutoCompleteExtender ID="AutocompleteExtender2" TargetControlID="VendorTextbox" runat="server" ServiceMethod="GetCompletionList_Vendor" 
                                                MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="true" CompletionSetCount="10" BehaviorID="AutoCompleteVen" 
                        CompletionListCssClass="autocomplete_completionListElement"
                        CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" />
                </td>
            </tr>
            <tr>
                <td>Supplier Contact Name:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactNameTextBox" runat="server" Text='<%# Bind("VendorContactName")%>' />
                </td>
            </tr>
            <tr>
                <td>Supplier Contact Tel:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactTelTextBox" runat="server" Text='<%# Bind("VendorContactTel")%>' />
                </td>
            </tr>
            <tr>
                <td>Vendor Contact Email:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactEmailTextBox" runat="server" Text='<%# Bind("VendorContactEmail")%>' />
                </td>
            </tr>

            <tr>
                <td>Purchase Order #:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="PurchaseOrderTextBox" runat="server" Text='<%# Bind("PurchaseOrder") %>' />
                </td>
            </tr>
            <tr>
                <td><b>Description (*):</b></td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Rows="8" Text='<%# Bind("Description") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter a description" ControlToValidate="DescriptionTextBox" />
                </td>
            </tr>
            <tr>
                <td><b>Corrective action taken (*):</b></td>
                <td>
                    <asp:DropDownList ID="CorrectiveActionDropDown" runat="server" DataSourceID="sdsCorrectiveActions" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="CorrectiveActionID" DataTextField="CorrectiveAction" SelectedValue='<%# Bind("CorrectiveActionID")%>' OnSelectedIndexChanged="CorrectiveActionDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="(Select the corrective action)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the corrective action" ControlToValidate="CorrectiveActionDropDown" /><br />
                    <asp:Label runat="server" Text="Corrective action taken:" Visible="false" ID="CorrectiveActionLabel" />
                    <br />
                    <asp:TextBox class="textboxWidth" ID="CorrectiveActionTakenTextBox" runat="server" TextMode="MultiLine" Rows="5" Text='<%# Bind("CorrectiveActionTaken") %>' Visible="false" />
                </td>
            </tr>
            <tr>
                <td>Was there contact with the customer?</td>
                <td>
                    <asp:CheckBox ID="ClientContactCheckBox" runat="server" Checked='<%# Bind("ClientContact") %>' />
                </td>
            </tr>
            <tr>
                <td>In your opinion, what is the root 
                    <br />
                    cause of this occurence:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="CauseTextBox" runat="server" TextMode="MultiLine" Rows="5" Text='<%# Bind("Cause") %>' />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" ValidationGroup="Insert" />
                    &nbsp;<asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td>
            </tr>
        </InsertItemTemplate>
        <EditItemTemplate>
            <tr>
                    <td>ID
                    </td>
                    <td>
                        <asp:Label ID="IDTextbox" runat="server" Text='<%# Bind("QLTID")%>' />
                    </td>
                </tr>
            <tr>
                <td>Event Type:</td>
                <td>
                    <asp:DropDownList ID="EventTypeDropDown" runat="server" DataSourceID="sdsEventTypes" AppendDataBoundItems="true" DataValueField="EventTypeID" DataTextField="EventType" SelectedValue='<%# Bind("EventTypeID")%>'>
                        <asp:ListItem Text="(Select the event type)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the event type" ControlToValidate="EventTypeDropDown" />
                </td>
            </tr>
            <tr>
                <td>Origin of Event:</td>
                <td>
                    <asp:DropDownList ID="OriginDropDown" runat="server" DataSourceID="sdsOrigins" AppendDataBoundItems="true" DataValueField="OriginID" DataTextField="Origin" SelectedValue='<%# Bind("OriginID")%>'>
                        <asp:ListItem Text="(Select the origin)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the origin" ControlToValidate="OriginDropDown" />
                </td>
            </tr>
            <tr>
                <td>Category:</td>
                <td>
                    <asp:DropDownList ID="TypeDropDown" runat="server" DataSourceID="sdsTypes" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="TypeID" DataTextField="Type" SelectedValue='<%# Bind("TypeID")%>' OnSelectedIndexChanged="TypeDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="(Select the complaint type)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the type" ControlToValidate="TypeDropDown" />
                    <br />
                    <asp:Label runat="server" Text="Other complaint type:" Visible="false" ID="TypeLabel" />
                    <br />
                    <asp:TextBox class="textboxWidth" ID="TypeTextBox" runat="server" Text='<%# Bind("Type") %>' Visible="false" />
                </td>
            </tr>
            <tr>
                <td>Incident Date:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="DateIncidentTextbox" runat="server" Text='<%# Bind("DateIncident")%>' />
                    <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DateIncidentTextbox" PopupButtonID="Calendar_scheduleDR" />
                    <asp:MaskedEditExtender ID="meeDateincident" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DateIncidentTextbox" PromptCharacter="_" />
                    <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Update" runat="server" ForeColor="Red" ControlToValidate="DateIncidentTextbox" ControlExtender="meeDateincident" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter the incident date" ControlToValidate="DateIncidentTextbox" />
                </td>
            </tr>
            <tr>
                <td>Issued By:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' />
                </td>
            </tr>
            <tr>
                <td>Email:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' />
                </td>
            </tr>
            <tr>
                <td>Manager:</td>
                <td>
                    <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                        <asp:ListItem Text="(Select your manager)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                </td>
            </tr>
            <tr>
                <td>Department:</td>
                <td>
                    <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="Department" SelectedValue='<%# Bind("DepartmentID")%>'>
                        <asp:ListItem Text="(Select your department)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                </td>
            </tr>
            <tr>
                <td>Customer:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="CustomerTextbox" runat="server" Text='<%# Bind("CustomerID")%>'/>
                    <asp:AutoCompleteExtender ID="AutocompleteExtender1" TargetControlID="CustomerTextbox" runat="server" ServiceMethod="GetCompletionList" 
                                                MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="true" CompletionSetCount="10" BehaviorID="AutoCompleteEx" 
                        CompletionListCssClass="autocomplete_completionListElement"
                        CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Name:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerNameTextBox" runat="server" Text='<%# Bind("CustomerContactName")%>' />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Tel:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerContactTelTextBox" runat="server" Text='<%# Bind("CustomerContactTel")%>' />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Email:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerContactEmailTextBox" runat="server" Text='<%# Bind("CustomerContactEmail")%>' />
                </td>
            </tr>

            <tr>
                <td>Sales Order #:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="SalesOrderTextBox" runat="server" Text='<%# Bind("SalesOrder") %>' />
                </td>
            </tr>
            <tr>
                <td>Supplier:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="VendorTextbox" runat="server" Text='<%# Bind("VendorID")%>'/>
                    <asp:AutoCompleteExtender ID="AutocompleteExtender2" TargetControlID="VendorTextbox" runat="server" ServiceMethod="GetCompletionList_Vendor" 
                                                MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="true" CompletionSetCount="10" BehaviorID="AutoCompleteVen" 
                        CompletionListCssClass="autocomplete_completionListElement"
                        CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" />
                </td>
            </tr>
            <tr>
                <td>Supplier Contact Name:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactNameTextBox" runat="server" Text='<%# Bind("VendorContactName")%>' />
                </td>
            </tr>
            <tr>
                <td>Supplier Contact Tel:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactTelTextBox" runat="server" Text='<%# Bind("VendorContactTel")%>' />
                </td>
            </tr>
            <tr>
                <td>Supplier Contact Email:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactEmailTextBox" runat="server" Text='<%# Bind("VendorContactEmail")%>' />
                </td>
            </tr>

            <tr>
                <td>Purchase Order #:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="PurchaseOrderTextBox" runat="server" Text='<%# Bind("PurchaseOrder") %>' />
                </td>
            </tr>
            <tr>
                <td>Description:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Rows="8" Text='<%# Bind("Description") %>' />
                </td>
            </tr>
            <tr>
                <td>Corrective action taken:</td>
                <td>
                    <asp:DropDownList ID="CorrectiveActionDropDown" runat="server" DataSourceID="sdsCorrectiveActions" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="CorrectiveActionID" DataTextField="CorrectiveAction" SelectedValue='<%# Bind("CorrectiveActionID")%>' OnSelectedIndexChanged="CorrectiveActionDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="(Select the corrective action)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the corrective action" ControlToValidate="CorrectiveActionDropDown" /><br />
                    <asp:Label runat="server" Text="Corrective action taken:" Visible="false" ID="CorrectiveActionLabel" />
                    <br />
                    <asp:TextBox class="textboxWidth" ID="CorrectiveActionTakenTextBox" runat="server" TextMode="MultiLine" Rows="5" Text='<%# Bind("CorrectiveActionTaken") %>' Visible="false" />
                </td>
            </tr>
            <tr>
                <td>Was there contact with the customer?</td>
                <td>
                    <asp:CheckBox ID="ClientContactCheckBox" runat="server" Checked='<%# Bind("ClientContact") %>' />
                </td>
            </tr>
            <tr>
                <td>In your opinion, what is the root 
                    <br />
                    cause of this occurence:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="CauseTextBox" runat="server" TextMode="MultiLine"  Rows="5" Text='<%# Bind("Cause") %>' />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                    &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </td>

            </tr>

        </EditItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvQLT" runat="server" AutoGenerateColumns="False" DataSourceID="sdsQLTGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvQLT_SelectedIndexChanged" DataKeyNames="QLTID">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
            <asp:BoundField DataField="QLTID" HeaderText="QLTID" InsertVisible="False" ReadOnly="True" SortExpression="QLTID" />
            <asp:BoundField DataField="EventType" HeaderText="EventType" SortExpression="EventType" />
            <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" />
            <asp:BoundField DataField="ShortDescription" HeaderText="Description" SortExpression="Description" />
            <%--<asp:BoundField DataField="IssuedBy" HeaderText="IssuedBy" SortExpression="IssuedBy" />--%>
            <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="CustomerName" />
            <asp:BoundField DataField="CustomerContactName" HeaderText="Customer Contact" SortExpression="CustomerContactName" />
            <asp:BoundField DataField="VendorName" HeaderText="Supplier" SortExpression="VendorName" />
            <asp:BoundField DataField="VendorContactName" HeaderText="Supplier Contact" SortExpression="VendorContactName" />
            <%--<asp:BoundField DataField="SalesOrder" HeaderText="SalesOrder" SortExpression="SalesOrder" />
            <asp:BoundField DataField="PurchaseOrder" HeaderText="PurchaseOrder" SortExpression="PurchaseOrder" />--%>
            <%--<asp:BoundField DataField="shortcorrect" HeaderText="CorrectiveActionTaken" SortExpression="CorrectiveActionTaken" />--%>
            <%--<asp:BoundField DataField="AssignedTo" HeaderText="AssignedTo" SortExpression="AssignedTo" />
            <asp:BoundField DataField="DateAssigned" HeaderText="DateAssigned" SortExpression="DateAssigned" />
            <asp:BoundField DataField="Reassignment" HeaderText="Reassignment" SortExpression="Reassignment" />
            <asp:BoundField DataField="DateReAssigned" HeaderText="DateReAssigned" SortExpression="DateReAssigned" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
            <%--<asp:BoundField DataField="QLTMemberName" HeaderText="QLTMemberName" SortExpression="QLTMemberName" />
            <asp:BoundField DataField="ManagerName" HeaderText="ManagerName" SortExpression="ManagerName" /--%>
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
    <asp:SqlDataSource ID="sdsInsert" runat="server" OnInserted="sdsInsert_Inserted"
        ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="SELECT * FROM [tblQLT] where QLTID=@ID"
        InsertCommand="INSERT INTO [QLT].[dbo].[tblQLT]
           ([EventTypeID]
           ,[OriginID]
           ,[TypeID]
           ,[StatusID]
           ,[CorrectiveActionID]
           ,[DateCreated]
           ,[DateIncident]
           ,[Description]
           ,[IssuedBy]
           ,[IssuedByEmail]
           ,[IssuedByUsername]
           ,[ManagerID]
           ,[DepartmentID]
           ,[CustomerContactName]
           ,[CustomerContactTel]
           ,[CustomerContactEmail]
           ,[CustomerID]
           ,[VendorContactName]
           ,[VendorContactTel]
           ,[VendorContactEmail]
           ,[VendorID]
           ,[SalesOrder]
           ,[PurchaseOrder]
           ,[CorrectiveActionTaken]
           ,[AssignedTo]
           ,[DateAssigned]
           ,[Reassignment]
           ,[DateReAssigned]
           ,[Cause]
           ,[PermanentCorrectiveAction]
           ,[QLTApproved]
           ,[AdditionalCorrectiveAction]
           ,[Visible]
           ,[Type]
           ,[ClientContact])
     VALUES
           (@EventTypeID
           ,@OriginID
           ,@TypeID
           ,@StatusID
           ,@CorrectiveActionID 
           ,@DateCreated 
           ,@DateIncident 
           ,@Description 
           ,@IssuedBy 
           ,@IssuedByEmail
           ,@IssuedByUsername
           ,@ManagerID
           ,@DepartmentID
           ,@CustomerContactName
           ,@CustomerContactTel
           ,@CustomerContactEmail
           ,@CustomerID
           ,@VendorContactName
           ,@VendorContactTel 
           ,@VendorContactEmail
           ,@VendorID
           ,@SalesOrder
           ,@PurchaseOrder
           ,@CorrectiveActionTaken
           ,@AssignedTo
           ,@DateAssigned
           ,@Reassignment
           ,@DateReAssigned
           ,@Cause
           ,@PermanentCorrectiveAction
           ,@QLTApproved
           ,@AdditionalCorrectiveAction
           ,@Visible
           ,@Type
           ,@ClientContact);
        select @ID = @@IDENTITY"
        UpdateCommand="UPDATE [QLT].[dbo].[tblQLT]
           SET [EventTypeID] =                         @EventTypeID
              ,[OriginID] =                            @OriginID  
              ,[TypeID] =						       @TypeID 
              ,[StatusID] =						       @StatusID 
              ,[CorrectiveActionID] =			       @CorrectiveActionID
              ,[DateIncident] =					       @DateIncident
              ,[Description] =					       @Description 
              ,[ManagerID] =					       @ManagerID 
              ,[DepartmentID] =					       @DepartmentID
              ,[CustomerContactName] =			       @CustomerContactName 
              ,[CustomerContactTel] =			       @CustomerContactTel 
              ,[CustomerContactEmail] =			       @CustomerContactEmail 
              ,[CustomerID] =					       @CustomerID 
              ,[VendorContactName] =			       @VendorContactName
              ,[VendorContactTel] =				       @VendorContactTel 
              ,[VendorContactEmail] =			       @VendorContactEmail 
              ,[VendorID] =						       @VendorID 
              ,[SalesOrder] =					       @SalesOrder 
              ,[PurchaseOrder] =				       @PurchaseOrder 
              ,[CorrectiveActionTaken] =		       @CorrectiveActionTaken 
              ,[AssignedTo] =                          @AssignedTo
              ,[DateAssigned] =                        @DateAssigned
              ,[Reassignment] =                        @Reassignment
              ,[ReassignmentUsername] =                @ReassignmentUsername
              ,[ReassignmentEmail] =                   @ReassignmentEmail
              ,[DateReAssigned]  =                     @DateReAssigned
              ,[PermanentCorrectiveAction] =           @PermanentCorrectiveAction
              ,[QLTApproved] =                         @QLTApproved
              ,[AdditionalCorrectiveAction] =          @AdditionalCorrectiveAction
              ,[Cause] =						       @Cause 
              ,[Type] =							       @Type 
              ,[ClientContact] =                       @ClientContact
               WHERE QLTID = @QLTID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvQLT" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:parameter Name="EventTypeID"/>
            <asp:parameter Name="OriginID"/>
            <asp:parameter Name="TypeID"/>
            <asp:parameter Name="StatusID" DefaultValue="1"/>
            <asp:parameter Name="CorrectiveActionID"/>
            <asp:SessionParameter Name="DateCreated" SessionField="IssuedDate" />
            <asp:parameter Name="DateIncident"/>
            <asp:parameter Name="Description"/>
            <asp:parameter Name="IssuedBy"/>
            <asp:parameter Name="IssuedByEmail"/>
            <asp:SessionParameter Name="IssuedByUsername" SessionField="Username" />
            <asp:parameter Name="ManagerID"/>
            <asp:parameter Name="DepartmentID"/>
            <asp:parameter Name="CustomerContactName"/>
            <asp:parameter Name="CustomerContactTel"/>
            <asp:parameter Name="CustomerContactEmail"/>
            <asp:parameter Name="CustomerID"/>
            <asp:parameter Name="VendorContactName"/>
            <asp:parameter Name="VendorContactTel"/>
            <asp:parameter Name="VendorContactEmail"/>
            <asp:parameter Name="VendorID"/>
            <asp:parameter Name="SalesOrder"/>
            <asp:parameter Name="PurchaseOrder"/>
            <asp:parameter Name="CorrectiveActionTaken"/>
            <asp:parameter Name="AssignedTo"/>
            <asp:parameter Name="DateAssigned"/>
            <asp:parameter Name="Reassignment"/>
            <asp:parameter Name="DateReAssigned"/>
            <asp:parameter Name="Cause"/>
            <asp:parameter Name="PermanentCorrectiveAction"/>
            <asp:parameter Name="QLTApproved" DefaultValue="0"/>
            <asp:parameter Name="AdditionalCorrectiveAction"/>
            <asp:parameter Name="Visible" DefaultValue="1"/>
            <asp:parameter Name="Type"/>
            <asp:parameter Name="ClientContact" DefaultValue="0"/>
            <asp:Parameter Name="ID" Direction="Output" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EventTypeID" />
            <asp:Parameter Name="OriginID" />
            <asp:Parameter Name="TypeID" />
            <asp:Parameter Name="StatusID" />
            <asp:Parameter Name="CorrectiveActionID" />
            <%--<asp:SessionParameter Name="DateCreated" SEssionField="IssuedDate"/>--%>
            <asp:Parameter Name="DateIncident" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="IssuedBy" />
            <asp:Parameter Name="IssuedByEmail" />
            <%--<asp:SessionParameter Name="IssuedByUsername" SessionField="Username"/>--%>
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="DepartmentID" />
            <asp:Parameter Name="CustomerContactName" />
            <asp:Parameter Name="CustomerContactTel" />
            <asp:Parameter Name="CustomerContactEmail" />
            <asp:Parameter Name="CustomerID" />
            <asp:Parameter Name="VendorContactName" />
            <asp:Parameter Name="VendorContactTel" />
            <asp:Parameter Name="VendorContactEmail" />
            <asp:Parameter Name="VendorID" />
            <asp:Parameter Name="SalesOrder" />
            <asp:Parameter Name="PurchaseOrder" />
            <asp:Parameter Name="CorrectiveActionTaken" />
            <asp:Parameter Name="AssignedTo" />
            <asp:Parameter Name="DateAssigned" />
            <asp:Parameter Name="Reassignment" />
            <asp:Parameter Name="ReassignmentUsername" />
            <asp:Parameter Name="ReassignmentEmail" />
            <asp:Parameter Name="DateReAssigned" />
            <asp:Parameter Name="Cause" />
            <asp:Parameter Name="PermanentCorrectiveAction" />
            <asp:Parameter Name="QLTApproved" defaultvalue="0"/>
            <asp:Parameter Name="AdditionalCorrectiveAction" />
            <asp:Parameter Name="Visible" DefaultValue="1" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="ClientContact" DefaultValue="0" />
            <asp:Parameter Name="QLTID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsQLTGrid" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="SELECT *, customerid as CustomerName,vendorid as VendorName,left(description,50) as ShortDescription,left(CorrectiveActionTaken,50) as shortcorrect
                         FROM  tblQLT 
                       LEFT JOIN tblEventTypes
                          on  tblQLT.EventTypeID = tblEventTypes.EventTypeID
                       LEFT JOIN tblStatus
                          on tblQLT.StatusID = tblStatus.StatusID
                       LEFT JOIN tblOrigins
                          on tblQLT.OriginID = tblOrigins.OriginID
                        LEFT JOIN tblQLTMembers
                            on tblQLT.AssignedTo = tblQLTMembers.QLTMemberID
                        LEFT JOIN tblManagers
                            on tblQLT.ManagerID = tblManagers.ManagerID
                       where IssuedByUsername=@IssuedByUsername and visible = 1
                        Order by QLTID Desc"
        DeleteCommand="Update tblQLT set visible = 0 where QLTID = @QLTID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="IssuedByUsername" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsEventTypes" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblEventTypes order by EventType"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblDepartments order by Department"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOrigins" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblOrigins order by Origin"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTypes" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblTypes order by Type"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblManagers order by ManagerName"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblStatus order by Status"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCorrectiveActions" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select * from tblCorrectiveActions order by CorrectiveAction"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCustomers" SelectCommand="select cazxnb,rtrim(CACSTX) + ' - ' + rtrim(CAZXNB) as CustName
                             from Nomis.S1018252.NOMDBF95.CUSPHY01
                            where cafesu ='A'
                            order by CACSTX"
        runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsVendors" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="select lrrccd,rtrim(lrrktx) + ' - ' + lrrccd  as VendorName
                         from Nomis.NOMDBF95.VENPHY01 
                        where lrfesu = 'A'
                        order by lrrktx"></asp:SqlDataSource>

</asp:Content>
