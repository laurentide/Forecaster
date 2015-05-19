<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="QLTMgmt.aspx.vb" Inherits="Forecaster.QLTMgmt" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>QLT Management page</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound" DefaultMode="Edit" DataKeyNames="QLTID" OnItemInserted="frmInsert_ItemInserted" 
        OnItemUpdated="frmInsert_ItemUpdated">
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
                    <asp:TextBox class="textboxWidth" ID="CauseTextBox" runat="server" TextMode="MultiLine" Rows="5" Text='<%# Bind("Cause") %>' />
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
                <td>
                    <asp:DropDownList ID="StatusDropDown" runat="server" DataSourceID="sdsStatus" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" 
                        SelectedValue='<%# Bind("StatusID")%>' OnSelectedIndexChanged="StatusDropDown_SelectedIndexChanged" CausesValidation="true" AutoPostBack="true">
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
            <tr>
                <td>Reassignment:</td>
                <td>
                    <asp:DropDownList ID="ReassignmentDropDown" runat="server" DataSourceID="sdsActiveUsers" AutoPostBack="true" OnSelectedIndexChanged="ReassignmentDropDown_SelectedIndexChanged" AppendDataBoundItems="true" DataValueField="FullName" DataTextField="FullName" SelectedValue='<%# Bind("Reassignment")%>' >
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
            </tr>
            <tr>
                <td>Permanent Corrective Action:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="PermanentCorrectiveActionTextBox" runat="server" Text='<%# Bind("PermanentCorrectiveAction") %>' TextMode="MultiLine" Rows="5" />
                </td>
            </tr>
            <tr>
                <td>QLT Approved:</td>
                <td>
                    <asp:CheckBox ID="QLTApprovedCheckBox" runat="server" Checked='<%# Bind("QLTApproved") %>' />
                </td>
            </tr>
            <tr>
                <td>Additional Corrective Action:</td>
                <td>
                    <asp:TextBox class="textboxWidth" ID="AdditionalCorrectiveActionTextBox" runat="server" Text='<%# Bind("AdditionalCorrectiveAction") %>' TextMode="MultiLine" Rows="5" />
                </td>
            </tr>
            <tr>
                <td>Root Cause Analysis:</td>
                <td><asp:TextBox ID="RootCauseAnalysisTextbox" runat="server" Text='<%# Bind("RootCauseAnalysis")%>' class="textboxWidth" /></td>
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
            <asp:BoundField DataField="Reassignment" HeaderText="Reassignment" SortExpression="Reassignment" />
<%--            <asp:BoundField DataField="DateReAssigned" HeaderText="DateReAssigned" SortExpression="DateReAssigned" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            
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
              ,[Reassignment] =                        @Reassignment
              ,[ReassignmentUsername] =                @ReassignmentUsername
              ,[ReassignmentEmail] =                   @ReassignmentEmail
              ,[DateReAssigned]  =                     case when dateReassigned is null then @DateReAssigned end
              ,[PermanentCorrectiveAction] =           @PermanentCorrectiveAction
              ,[QLTApproved] =                         @QLTApproved
              ,[AdditionalCorrectiveAction] =          @AdditionalCorrectiveAction
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
            <asp:Parameter Name="Reassignment" />
            <asp:Parameter Name="ReassignmentUsername" />
            <asp:Parameter Name="ReassignmentEmail" />
            <asp:SessionParameter Name="DateReAssigned" SessionField="IssuedDate" />
            <asp:Parameter Name="Cause" />
            <asp:Parameter Name="PermanentCorrectiveAction" />
            <asp:Parameter Name="QLTApproved" defaultvalue="0"/>
            <asp:Parameter Name="AdditionalCorrectiveAction" />
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
            <asp:Parameter Name="QLTID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsQLTGrid" runat="server" ConnectionString="<%$ ConnectionStrings:QLTConnectionString %>"
        SelectCommand="SELECT *,customerid as CustomerName,vendorid as VendorName,left(description,50) as ShortDescription, 
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
                         and (@ManagerDomainUser in (select QLTMemberUserName from tblQLTMembers) or ReassignmentUsername = @ManagerDomainUser)
                        Order by QLTID Desc"
        DeleteCommand="Update tblQLT set visible = 0 where QLTID = @QLTID">
        <SelectParameters>
             <asp:SessionParameter SessionField="Username" Name="ManagerDomainUser" />
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
        SelectCommand="select * from tblStatus order by Statusid"></asp:SqlDataSource>
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

</asp:Content>

