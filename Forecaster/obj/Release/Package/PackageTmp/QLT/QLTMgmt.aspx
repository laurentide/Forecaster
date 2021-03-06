﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="QLTMgmt.aspx.vb" Inherits="Forecaster.QLTMgmt" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" TagPrefix="RK" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>QLT Management page</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound" DefaultMode="Edit" DataKeyNames="QLTID" OnItemUpdated="frmInsert_ItemUpdated" 
        OnItemUpdating="frmInsert_ItemUpdating">
        <EditItemTemplate>
        <table>
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the event type" ControlToValidate="EventTypeDropDown" SetFocusOnError="true" />
                </td>
            </tr>
            <tr>
                <td>Origin of Feedback:</td>
                <td>
                    <asp:DropDownList ID="OriginDropDown" runat="server" DataSourceID="sdsOrigins" AppendDataBoundItems="true" DataValueField="OriginID" DataTextField="Origin" SelectedValue='<%# Bind("OriginID")%>'>
                        <asp:ListItem Text="(Select the origin)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the origin" ControlToValidate="OriginDropDown" SetFocusOnError="true" />
                </td>
            </tr>
            <tr>
                <td>Category:</td>
                <td>
                    <asp:DropDownList ID="TypeDropDown" runat="server" DataSourceID="sdsTypes" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="TypeID" DataTextField="Type" SelectedValue='<%# Bind("TypeID")%>' OnSelectedIndexChanged="TypeDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="(Select the complaint type)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the type" ControlToValidate="TypeDropDown" SetFocusOnError="true" />
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter the incident date" ControlToValidate="DateIncidentTextbox" SetFocusOnError="true" />
                </td>
            </tr>
            <tr>
                <td>Issued By:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' MaxLength="50" />
                </td>
            </tr>
            <tr>
                <td>Email:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' MaxLength="50" />
                </td>
            </tr>
            <tr>
                <td>Manager:</td>
                <td>
                    <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                        <asp:ListItem Text="(Select your manager)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" SetFocusOnError="true" />
                </td>
            </tr>
            <tr>
                <td>Department:</td>
                <td>
                    <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="Department" SelectedValue='<%# Bind("DepartmentID")%>'>
                        <asp:ListItem Text="(Select your department)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" SetFocusOnError="true" />
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
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerNameTextBox" runat="server" Text='<%# Bind("CustomerContactName")%>' MaxLength="100" />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Tel:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerContactTelTextBox" runat="server" Text='<%# Bind("CustomerContactTel")%>' MaxLength="25" />
                </td>
            </tr>
            <tr>
                <td>Customer Contact Email:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="CustomerContactEmailTextBox" runat="server" Text='<%# Bind("CustomerContactEmail")%>' MaxLength="50" />
                </td>
            </tr>

            <tr>
                <td>Sales Order #:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="SalesOrderTextBox" runat="server" Text='<%# Bind("SalesOrder") %>' MaxLength="25" />
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
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactNameTextBox" runat="server" Text='<%# Bind("VendorContactName")%>' MaxLength="100" />
                </td>
            </tr>
            <tr>
                <td>Supplier Contact Tel:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactTelTextBox" runat="server" Text='<%# Bind("VendorContactTel")%>' MaxLength="25" />
                </td>
            </tr>
            <tr>
                <td>Vendor Contact Email:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="VendorContactEmailTextBox" runat="server" Text='<%# Bind("VendorContactEmail")%>' MaxLength="50" />
                </td>
            </tr>

            <tr>
                <td>Purchase Order #:</td>
                <td>
                    <asp:TextBox class="smallTextboxWidth" ID="PurchaseOrderTextBox" runat="server" Text='<%# Bind("PurchaseOrder") %>' MaxLength="25" />
                </td>
            </tr>
            <tr>
                <td>Description:</td>
                <td>
                    <asp:TextBox width="500px" ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Rows="8" Text='<%# Bind("Description") %>' CssClass="disabled" ReadOnly="true"/>
                </td>
            </tr>
            <tr>
                <td>Corrective action taken:</td>
                <td>
                    <asp:DropDownList ID="CorrectiveActionDropDown" runat="server" DataSourceID="sdsCorrectiveActions" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="CorrectiveActionID" DataTextField="CorrectiveAction" SelectedValue='<%# Bind("CorrectiveActionID")%>' OnSelectedIndexChanged="CorrectiveActionDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="(Select the corrective action)" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the corrective action" ControlToValidate="CorrectiveActionDropDown" SetFocusOnError="true" /><br />
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
                    <asp:TextBox width="500px" ID="CauseTextBox" runat="server" TextMode="MultiLine" Rows="5" Text='<%# Bind("Cause") %>' CssClass="disabled" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>Immediate action required?</td>
                <td><asp:CheckBox ID="ImmediateActionRequiredCheckbox" runat="server" Checked='<%# Bind("ImmediateActionRequired")%>' OnCheckedChanged="ImmediateActionRequiredCheckbox_CheckedChanged"
                    CausesValidation="true" AutoPostBack="true" /></td>
            </tr>
            <asp:Panel ID="ImmediateActionRequiredPanel" runat="server" Visible="false">
                <tr>
                    <td>Immediate action:</td>
                    <td><asp:TextBox ID="ImmediateActionTextbox" runat="server" Text='<%# Bind("ImmediateAction")%>' class="textboxWidth" /></td>
                </tr>
            </asp:Panel>
                <tr>
                    <td>FileName:</td>
                    <td>
                        <asp:Label ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' /></td>
                </tr>
                <tr>
                    <td>Path:
                    </td>
                    <td><asp:HyperLink ID="PathTextbox" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("Path")),"",Eval("Path")))%>' Text='<%# IIf(IsDBNull(Eval("Path")),"",Eval("Path"))%>' Target="_blank" /></td>
                </tr>
            <tr><td><h2>QLT Team</h2></td></tr>
            <tr>
                <td>Assigned To:</td>
                <td>
                    <asp:DropDownList ID="QLTMembersDropDown" runat="server" DataSourceID="sdsQLTMembers" AppendDataBoundItems="true" DataValueField="QLTMemberID" DataTextField="QLTMemberName" SelectedValue='<%# Bind("AssignedTo")%>' >
                        <asp:ListItem Text="(Assign a QLT Member)" Value="" />
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Status:</td>
                <%--DataSourceID="sdsStatus"--%>
                <td>
                    <asp:DropDownList ID="StatusDropDown" runat="server"  AppendDataBoundItems="true"  DataSourceID="sdsStatus" DataValueField="StatusID" DataTextField="Status" 
                        SelectedValue='<%# Bind("StatusID")%>' OnSelectedIndexChanged="StatusDropDown_SelectedIndexChanged" CausesValidation="true" AutoPostBack="true" OnDataBound="StatusDropDown_DataBound">
                        <asp:ListItem Text="(Select the status)" Value="" />
                    </asp:DropDownList>
                </td>
            </tr>
            <asp:Panel ID="FollowUpDatePanel" runat="server" Visible="false">
                <tr>
                    <td>Follow-up Date:</td>
                    <td>
                                <asp:TextBox ID="FollowUpDateTextbox" runat="server" Text='<%# Bind("FollowupDate")%>' />
                                <asp:Image runat="server" ID="ISD_Image" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                <asp:CalendarExtender ID="ISD_CalendarExtender" runat="server" TargetControlID="FollowUpDateTextbox" PopupButtonID="ISD_Image" />
                                <asp:MaskedEditExtender ID="ISD_MaskedEditExtender" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="FollowUpDateTextbox" PromptCharacter="_" />
                                <asp:MaskedEditValidator ID="ISD_Maskededitvalidator" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="FollowUpDateTextbox" ControlExtender="ISD_MaskedEditExtender" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
            </asp:Panel>
<%--            <tr>
                <td>Reassignment:</td>
                <td>
                    <asp:DropDownList ID="ReassignmentDropDown" runat="server" DataSourceID="sdsActiveUsers" AutoPostBack="true" OnSelectedIndexChanged="ReassignmentDropDown_SelectedIndexChanged" 
                        AppendDataBoundItems="true" DataValueField="FullName" DataTextField="FullName" SelectedValue='<%# Bind("Reassignment")%>' >
                        <asp:ListItem Text="(Reassign to somebody)" Value="" />
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td>Reassignment Username:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="ReassignmentUsernameTextBox" runat="server" Text='<%# Bind("ReassignmentUsername")%>' ReadOnly="true" BackColor="WhiteSmoke" />
                </td>
            </tr>
                        <tr>
                <td>Reassignment Email:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="ReassignmentEmailTextBox" runat="server" Text='<%# Bind("ReassignmentEmail")%>' ReadOnly="true" BackColor="WhiteSmoke" />
                </td>
            </tr>--%>
            <tr>
                <td>Root Cause Analysis:</td>
                <td><asp:TextBox ID="RootCauseAnalysisTextbox" runat="server" Text='<%# Bind("RootCauseAnalysis")%>' class="textboxWidth" TextMode="MultiLine" Rows="5" /></td>
            </tr>
            <tr>
                <td>Corrective Action:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="AdditionalCorrectiveActionTextBox" runat="server" TextMode="MultiLine" Rows="5" />
                </td></tr><tr><td>Corrective Action List:</td><td colspan="2">
                        <asp:GridView ID="gvAdditionalCorrectiveAction" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle"
                            CellPadding="4" ForeColor="#333333"
                            Font-Size="10px" OnRowDeleting="gvAdditionalCorrectiveAction_RowDeleting">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this action?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
<%--                               <asp:CommandField ShowSelectButton="True" SelectText="Edit" />--%>
                                <asp:TemplateField HeaderText="ID" SortExpression="ACAID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="ACALabel" runat="server" Text='<%# Eval("ACAID")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AdditionalCorrectiveAction" HeaderText="Additional Corrective Action" SortExpression="AdditionalCorrectiveAction" />
                                <asp:BoundField DataField="Timestamp" HeaderText="Date Posted" SortExpression="Timestamp" DataFormatString="{0:d}" />
                                <asp:BoundField DataField="PostedBy" HeaderText="Posted By" SortExpression="PostedBy" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Corrective Action entered yet.
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
                        </asp:GridView></td></tr>
            <tr>
                <td>Next Action Due Date:</td>
                <td>
                            <asp:TextBox ID="NextActionDueDateTextbox" runat="server" Text='<%# Bind("NextActionDueDate")%>' />
                            <asp:Image runat="server" ID="Image1" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="NextActionDueDateTextbox" PopupButtonID="Image1" />
                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="NextActionDueDateTextbox" PromptCharacter="_" />
                            <asp:MaskedEditValidator ID="MaskedEditValidator1" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="NextActionDueDateTextbox" ControlExtender="MaskedEditExtender1" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                </td>
            </tr>
            <tr>
                <td>Permanent Corrective Actions:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="PermanentCorrectiveActionTextBox" runat="server" TextMode="MultiLine" Rows="5" />
                </td></tr><tr><td>Permanent Corrective Action List:</td><td colspan="2">
                        <asp:GridView ID="gvPermanentCorrectiveAction" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnRowCancelingEdit="gvPermanentCorrectiveAction_RowCancelingEdit"
                            CellPadding="4" ForeColor="#333333" OnRowDeleting="gvPermanentCorrectiveAction_RowDeleting" OnRowEditing="gvPermanentCorrectiveAction_RowEditing"
                            Font-Size="10px" OnRowUpdating="gvPermanentCorrectiveAction_RowUpdating" DatKeyNames="PCAID">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this action?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ID" SortExpression="PCAID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="PCALabel" runat="server" Text='<%# Eval("PCAID")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PermanentCorrectiveAction" HeaderText="Permanent Corrective Action" SortExpression="PermanentCorrectiveAction">
                                <ControlStyle Width="100%" /></asp:BoundField>
                                <asp:BoundField DataField="Timestamp" HeaderText="Date Posted" SortExpression="Timestamp" DataFormatString="{0:d}" ReadOnly="true"/>
                                <asp:BoundField DataField="PostedBy" HeaderText="Posted By" SortExpression="PostedBy" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Permanent Corrective Action entered yet.
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
                        </asp:GridView></td></tr>
            </tr>
            <tr>
                <td>QLT Approved:</td>
                <td>
                    <asp:CheckBox ID="QLTApprovedCheckBox" runat="server" Checked='<%# Bind("QLTApproved") %>' />
                </td>
            </tr>
            <tr>
                <td>Cost To Laurentide:</td>
                <td><asp:TextBox ID="CostToLaurentideTextbox" runat="server" Text='<%# Bind("LaurentideCost") %>' class="textboxWidth" /></td>
            </tr>
            <tr>
                <td>Should a manager contact the client?</td>
                <td>
                    <asp:CheckBox ID="ManagerContactCheckbox" runat="server" Checked='<%# Bind("ManagerContact")%>' />
                </td>
            </tr>
            <tr>
                <td>Did a manager speak to the client?</td>
                <td>
                    <asp:CheckBox ID="ManagerContactedCheckbox" runat="server" Checked='<%# Bind("ManagerContacted")%>' />
                </td>
            </tr>
            <tr>
                <td>Manager Contact Note:</td>
                <td>
                    <asp:TextBox ID="ManagerNoteTextbox" runat="server" Text='<%# Bind("ManagerContactedNote") %>' class="textboxWidth" />
                </td>
            </tr>
            <tr>
                <td>Learning Opportunity?</td>
                <td>
                    <asp:CheckBox ID="LearningOpportunityCheckbox" runat="server" Checked='<%# Bind("LearningOpportunity")%>' OnCheckedChanged="LearningOpportunityCheckbox_CheckedChanged"
                        CausesValidation="true" AutoPostBack="true"/>
                </td>
            </tr>
            <asp:Panel ID="LearningOpportunityPanel" runat="server" Visible="false">
            <tr>
                <td>Learning Opportunity note:</td>               
                <td>
                    <asp:TextBox ID="LearningOpportunityTextbox" runat="server" class="textboxWidth" Text='<%# Bind("LearningOpportunityNote")%>' />
                </td>
            </tr>
            </asp:Panel>
            <tr>
                <td>Feedback to Issuer: </td>
                <td><asp:TextBox ID="FeedbackToIssuerTextBox" runat="server" Text='<%# Bind("FeedbackToIssuer")%>' class="textboxWidth" TextMode="MultiLine" Rows="5"  /> </td>
            </tr>
            <tr><td>Add Attachment (for case handler, not visible to issuer)</td><td>
                <asp:FileUpload ID="CasehandlerfuDialog" runat="server" allowmultiple="true"/></td></tr>
            <tr><td>  
                 FileName:</td><td><asp:Label ID="CaseHandlerFileName" runat="server" Text='<%# Bind("CasehandlerFilename")%>' /></td></tr>
                <tr><td>Path:</td><td><asp:Hyperlink ID="CasehandlerPath" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("CasehandlerPath")), "", Eval("CasehandlerPath")))%>' Text='<%# IIf(IsDBNull(Eval("CasehandlerPath")),"",Eval("CasehandlerPath"))%>' Target="_blank" />
                </td>
            </tr>
            <tr><td><br /></td></tr>
            <tr><td><br /></td></tr>
            <tr>
                <td>Send update notification e-mail to QLT?</td>
                <td>
                    <asp:CheckBox ID="SendEmailCheckbox" runat="server" CausesValidation="true" AutoPostBack="true"/>
                </td>
            </tr>
            <tr>
                <td>Send update notification e-mail to ticket originator?</td>
                <td>
                    <asp:CheckBox ID="SendEmailOriginatorCheckbox" runat="server" CausesValidation="true" AutoPostBack="true" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                    &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </td>
            </tr>
            <tr><td><br /></td></tr>
            <tr><td><br /></td></tr>
          </table>
        </EditItemTemplate>
    </asp:FormView>
    <table>
        <tr>
            <td>Filter by department:
                <asp:DropDownList ID="DeptFilterDropDownList" runat="server" DataSourceID="sdsDepartments" DataValueField="DepartmentID" DataTextField="Department"
                    AppendDataBoundItems="true" CausesValidation="true" OnSelectedIndexChanged="DeptFilterDropDownList_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="(Select the department)" Value="" />
                </asp:DropDownList>
                <asp:Button ID="PSSFilterButton" runat="server" Text="View PSS/Service cases only" OnClick="PSSFilterButton_Click" CausesValidation="true" />
                <asp:Button ID="ResetPSSFilterButton" runat="server" Text="Reset" CausesValidation="true" OnClick="ResetPSSFilterButton_Click" /></td>
        </tr>
        <tr>
            <td>Filter by Assignee:
            <asp:DropDownList ID="AssigneeDropDownList" runat="server" DataSourceID="sdsQLTMembers" DataValueField="QLTMemberID" DataTextField="QLTMemberName"
                    AppendDataBoundItems="true" CausesValidation="true" OnSelectedIndexChanged="AssigneeDropDownList_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="(Select the Assignee)" Value="" />
                </asp:DropDownList></td>            
        </tr>
         <tr>
            <td>Filter by Status:
            <asp:DropDownList ID="StatusDropDownList" runat="server" DataSourceID="sdsStatus" DataValueField="statusID" DataTextField="Status"
                    AppendDataBoundItems="true" CausesValidation="true" OnSelectedIndexChanged="StatusDropDownList_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="(Select the status)" Value="" />
                </asp:DropDownList></td>            
        </tr>
         <tr>
            <td>Filter by Category:
            <asp:DropDownList ID="TypeDropDownList" runat="server" DataSourceID="sdsTypes" DataValueField="TypeID" DataTextField="Type"
                    AppendDataBoundItems="true" CausesValidation="true" OnSelectedIndexChanged="TypeDropDownList_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="(Select the category)" Value="" />
                </asp:DropDownList></td>            
        </tr>
        <tr>
            <td>Issued:
                <asp:Label ID="IssuedCount" runat="server" />
                Assigned:
                <asp:Label ID="AssignedCount" runat="server" />
                Waiting For QLT Review:
                <asp:Label ID="QLTReviewCount" runat="server" />
                Resolved:
                <asp:Label ID="ResolvedCount" runat="server" />
                Waiting For QT Review:
                <asp:Label ID="QTReviewCount" runat="server" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="gvQLT" runat="server" AutoGenerateColumns="False" DataSourceID="sdsQLTGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333" OnDataBound="gvQLT_DataBound"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvQLT_SelectedIndexChanged" DataKeyNames="QLTID">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this request?');" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="QLTID" HeaderText="QLTID" InsertVisible="False" ReadOnly="True" SortExpression="QLTID" />
            <asp:BoundField DataField="EventType" HeaderText="Event Type" SortExpression="EventType" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
            <asp:BoundField DataField="category" HeaderText="Category" SortExpression="Type" />
            <asp:BoundField DataField="DateCreated" HeaderText="Date Created" SortExpression="DateCreated" />
            <asp:BoundField DataField="ShortDescription" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="IssuedBy" HeaderText="IssuedBy" SortExpression="IssuedBy" />
            <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="CustomerName" />
<%--            <asp:BoundField DataField="CustomerContactName" HeaderText="Customer Contact" SortExpression="CustomerContactName" />
            <asp:BoundField DataField="VendorName" HeaderText="Supplier" SortExpression="VendorName" />
            <asp:BoundField DataField="VendorContactName" HeaderText="Supplier Contact" SortExpression="VendorContactName" />--%>
            <%--<asp:BoundField DataField="SalesOrder" HeaderText="SalesOrder" SortExpression="SalesOrder" />
            <asp:BoundField DataField="PurchaseOrder" HeaderText="PurchaseOrder" SortExpression="PurchaseOrder" />--%>
            <%--<asp:BoundField DataField="shortcorrect" HeaderText="CorrectiveActionTaken" SortExpression="CorrectiveActionTaken" />--%>
            <asp:BoundField DataField="QLTMemberName" HeaderText="Assigned To" SortExpression="AssignedTo" />
            <%--<asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="Date Assigned" />--%>
<%--            <asp:BoundField DataField="Reassignment" HeaderText="Reassignment" SortExpression="Reassignment" />--%>
<%--            <asp:BoundField DataField="DateReAssigned" HeaderText="DateReAssigned" SortExpression="DateReAssigned" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="NextActionDueDate" HeaderText="Next Action Date" SortExpression="NextActionDueDate" DataFormatString="{0:d}" ApplyFormatInEditMode="true" />
            
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
              ,[DateAssigned] =                        case when DateAssigned is null then @DateAssigned end
              ,[DateReAssigned]  =                     case when dateReassigned is null then @DateReAssigned end
              ,[QLTApproved] =                         @QLTApproved
              ,[NextActionDueDate] =                   @NextActionDueDate
              ,[Cause] =						       @Cause 
              ,[Type] =							       @Type 
              ,[ClientContact] =                       @ClientContact
              ,[ImmediateActionRequired] =             @ImmediateActionRequired
              ,[ImmediateAction] =                     @ImmediateAction
              ,[FollowupDate] =                        @FollowupDate
              ,[RootCauseAnalysis] =                   @RootCauseAnalysis
              ,[LaurentideCost] =                      @LaurentideCost
              ,[ManagerContact] =                      @ManagerContact
              ,[ManagerContacted] =                    @ManagerContacted
              ,[ManagerContactedNote] =                @ManagerContactedNote
              ,[DateClose] =                           CASE WHEN @StatusID = 6 THEN getDate() ELSE NULL END 
              ,[LearningOpportunity] =                 @LearningOpportunity
              ,[LearningOpportunityNote] =             @LearningOpportunityNote
              ,[FeedbackToIssuer] =                    @FeedbackToIssuer
               WHERE QLTID = @QLTID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvQLT" PropertyName="SelectedValue" />
        </SelectParameters>        
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
            <asp:SessionParameter Name="DateAssigned" SessionField="IssuedDate" />
<%--            <asp:Parameter Name="Reassignment" />
            <asp:Parameter Name="ReassignmentUsername" />
            <asp:Parameter Name="ReassignmentEmail" />--%>
            <asp:SessionParameter Name="DateReAssigned" SessionField="IssuedDate" />
            <asp:Parameter Name="Cause" />
            <asp:Parameter Name="PermanentCorrectiveAction" />
            <asp:Parameter Name="QLTApproved" defaultvalue="0"/>
            <asp:Parameter Name="AdditionalCorrectiveAction" />
            <asp:Parameter Name="NextActionDueDate" />
            <asp:Parameter Name="Visible" DefaultValue="1" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="ClientContact" DefaultValue="0" />
            <asp:Parameter Name="ImmediateActionRequired" />
            <asp:Parameter Name="ImmediateAction" />
            <asp:Parameter Name="FollowupDate" />
            <asp:Parameter Name="RootCauseAnalysis" />
            <asp:Parameter Name="LaurentideCost" />
            <asp:Parameter Name="ManagerContact" />
            <asp:Parameter Name="ManagerContacted" />
            <asp:Parameter Name="ManagerContactedNote" />
            <asp:Parameter Name="DateClose" />
            <asp:Parameter Name="LearningOpportunity" />
            <asp:Parameter Name="LearningOpportunityNote" />
            <asp:Parameter Name="FeedbackToIssuer" />
            <asp:Parameter Name="QLTID" />
        </UpdateParameters>
    </asp:SqlDataSource>
<%--            SelectCommand="SELECT *,customerid as CustomerName,vendorid as VendorName,left(description,50) as ShortDescription, 
                        case when tbltypes.type = 'Other' and tblQLT.Type is not null then tblQLT.Type else tblTypes.Type end as category
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
                        LEFT JOIN tblTypes
                            on tblQLT.TypeID = tblTypes.TypeID
                       where  visible = 1 
                         and (tblQLT.AssignedTo = @AssignedTo or @AssignedTo = 0)
                         and (tblQLT.StatusID = @StatusID or @StatusID = 0)
                         and (tblQLT.DepartmentID = @DeptID or @DeptID = 0)
                         and (tblQLT.TypeID = @TypeID or @TypeID = 0)
                        Order by QLTID Desc"--%>
    <asp:SqlDataSource ID="sdsQLTGrid" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        DeleteCommand="Update tblQLT set visible = 0 where QLTID = @QLTID">
        <SelectParameters>
             <asp:SessionParameter SessionField="Username" Name="ManagerDomainUser"  />
             <asp:ControlParameter Name="AssignedTo" ControlID="AssigneeDropDownList" PropertyName="SelectedValue" DefaultValue="0" />
             <asp:ControlParameter Name="StatusID" ControlID="StatusDropDownList" PropertyName="SelectedValue" DefaultValue="0" />
             <asp:ControlParameter Name="DeptID" ControlID="DeptFilterDropDownList" PropertyName="SelectedValue" DefaultValue="0"  />
            <asp:ControlParameter Name="TypeID" ControlID="TypeDropDownList" PropertyName="SelectedValue" DefaultValue="0"  />
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
        SelectCommand="select * from tblStatus order by Statusid">
   </asp:SqlDataSource>
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
    <asp:SqlDataSource ID="sdsQLTMembers" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
    SelectCommand="select * from tblQLTMembers order by QLTMemberName"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsActiveUsers" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
    SelectCommand="select * from vwActiveUsers order by FullName"></asp:SqlDataSource>
<RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" Charset="utf-8" ContentEncoding="windows-1250"
EnableHyperLinks="True" ExportFileName="QLT.xls" IncludeTimeStamp="True" PageSize="All" 
Text="Export To Excel" GridViewID="gvQLT" />
</asp:Content>

