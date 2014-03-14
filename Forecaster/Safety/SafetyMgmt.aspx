<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="SafetyMgmt.aspx.vb" Inherits="Forecaster.SafetyMgmt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Safety Mgmt page</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" DefaultMode="Edit" DataKeyNames="SafetyCaseID" OnItemUpdated="frmInsert_ItemUpdated">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>ID
                    </td>
                    <td>
                        <asp:Label ID="IDTextbox" runat="server" Text='<%# Bind("SafetyCaseID")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Description
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextbox" runat="server" Text='<%# Bind("Description")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Description required" ControlToValidate="DescriptionTextbox" />
                    </td>
                </tr>
                <tr>
                    <td>Catégorie/Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="TypeDropDown" runat="server" DataSourceID="sdsSafetyTypes" AppendDataBoundItems="true" DataValueField="SafetyTypeID" DataTextField="SafetyType" SelectedValue='<%# Bind("SafetyTypeID")%>'>
                            <asp:ListItem Text="(Select the type)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the type" ControlToValidate="TypeDropDown" />
                        <%--<asp:TextBox ID="SafetyTypeIDTextBox" runat="server" Text='<%# Bind("SafetyTypeID") %>' />--%>
                    </td>
                </tr>
                <%--<tr>
                    <td>Cause:
                    </td>
                    <td>
                        <asp:DropDownList ID="SafetyCauseDrowDown" runat="server" DataSourceID="sdsSafetyCauses" AppendDataBoundItems="true" DataValueField="SafetyCauseID" DataTextField="SafetyCause" SelectedValue='<%# Bind("SafetyCauseID")%>'>
                            <asp:ListItem Text="(Select the cause)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the cause" ControlToValidate="SafetyCauseDrowDown" />
                        <%--<asp:TextBox ID="SafetyCauseIDTextBox" runat="server" Text='<%# Bind("SafetyCauseID") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Créé par/Issued By:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Name required" ControlToValidate="IssuedByTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Issued Date:
                    </td>
                    <td>
                        <asp:Label ID="IssuedDateTextBox" runat="server" Text='<%# Bind("IssuedDate")%>'/>
                    </td>
                </tr>
                <tr>
                    <td>Revised Date:
                    </td>
                    <td>
                        <asp:Label ID="RevisedDateLabel" runat="server" Text='<%# Bind("RevisedDate")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Courriel/Email:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Email required" ControlToValidate="IssuedByEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="IssuedByEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />

                    </td>
                </tr>
                <tr>
                    <td>Superviseur/Manager:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select your manager)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Témoin/Witness name:
                    </td>
                    <td>
                        <asp:TextBox ID="WitnessTextBox" runat="server" Text='<%# Bind("Witness") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Victime/Victim name:
                    </td>
                    <td>
                        <asp:TextBox ID="VictimTextBox" runat="server" Text='<%# Bind("Victim") %>' Width="250" />
                    </td>
                </tr>
                <%--                <tr>
                    <td>Notify as well (Emails seperated by semi-colon):
                    </td>
                    <td>
                        <asp:TextBox ID="NotificationTextBox" runat="server" Text='<%# Bind("Notification") %>' Width="250" />
                    </td>
                </tr>--%>
                <tr>
                    <td>Circonstances/Circumstances:
                    </td>
                    <td>
                        <asp:TextBox ID="CircumstancesTextBox" runat="server" Text='<%# Bind("Circumstances")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Circumstances required" ControlToValidate="CircumstancesTextBox" />
                    </td>
                </tr>
                <tr>
                    <td style="font-weight:bold;">Urgent?</td>
                    <td>
                        <asp:Checkbox ID="UrgentCheckbox" runat="server" Checked='<%# Bind("Urgent")%>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>Impact</h2>
                    </td>
                </tr>
                <tr>
                    <td>Problème de Santé ou blessure/Health Care or Injury:
                    </td>
                    <td>
                        <asp:CheckBox ID="HealthCareCheckbox" runat="server" Checked='<%# Bind("HealthCarechk")%>' />
                        <%--<asp:TextBox ID="HealthCareTextbox" runat="server" Text='<%# Bind("HealthCare")%>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Dommage à la propriété/Property Damage:
                    </td>
                    <td>
                        <asp:CheckBox ID="PropertyDamageCheckBox" runat="server" Checked='<%# Bind("PropertyDamagechk")%>' />
                        <%--asp:TextBox ID="PropertyDamageTextBox" runat="server" Text='<%# Bind("PropertyDamage")%>' />--%></td>
                </tr>
                <tr>
                    <td>Feu/Fire:
                    </td>
                    <td>
                        <asp:CheckBox ID="FireTextCheckbox" runat="server" Checked='<%# Bind("Firechk")%>' />
                        <%--<asp:TextBox ID="FireTextbox" runat="server" Text='<%# Bind("Fire")%>' /--%>
                    </td>
                </tr>
                <tr>
                    <td>Dommage environnemental/Environmental Release:
                    </td>
                    <td>
                        <asp:CheckBox ID="EnvironmentalReleaseCheckbox" runat="server" Checked='<%# Bind("EnvironmentalReleasechk")%>' />
                        <%--<asp:TextBox ID="EnvironmentalReleaseTextbox" runat="server" Text='<%# Bind("EnvironmentalRelease")%>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Temps perdu/Lost time:
                    </td>
                    <td>
                        <asp:CheckBox ID="LostTimeCheckbox" runat="server" Checked='<%# Bind("LostTimechk")%>' />
                        <%--<asp:TextBox ID="LostTimeTextbox" runat="server" Text='<%# Bind("LostTime")%>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Premiers Soins/First Aid:
                    </td>
                    <td>
                        <asp:CheckBox ID="FirstAidsCheckbox" runat="server" Checked='<%# Bind("FirstAidschk")%>' />
                        <%--<asp:TextBox ID="FirstAidsTextbox" runat="server" Text='<%# Bind("FirstAids")%>' />--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Selon vous, quels sont les causes de cet incident ou potentiel incident (erreur humaine, problème d'équipement, mauvais matériels, facteurs environnementales, erreur dans un procédé)?<br />
                        In your opinion, what are the root causes of this incident or potential incident (Human error, equipement defect, wrong materials, environment factors, error(s) in a process)?</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:TextBox ID="SuspectedRootCauseTextbox" runat="server" Text='<%# Bind("SuspectedRootCause")%>' TextMode="MultiLine" Rows="7" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Suspected root cause required" ControlToValidate="SuspectedRootCauseTextbox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5>Safety committee team</h5>
                    </td>
                </tr>
                <tr>
                    <td>Status:
                    </td>
                    <td>
                        <asp:DropDownList ID="StatusDropDown" runat="server" DataSourceID="sdsStatus" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" SelectedValue='<%# Bind("StatusID")%>'>
                            <asp:ListItem Text="(Select the status)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the status" ControlToValidate="StatusDropDown" />
                        <%--<asp:TextBox ID="StatusIDTextBox" runat="server" Text='<%# Bind("StatusID") %>' /> --%>
                    </td>
                </tr>
                <tr>
                    <td>Assign to (Safety committee member):
                    </td>
                    <td>
                        <asp:DropDownList ID="SaLtMemberDropDown" runat="server" DataSourceID="sdsSaLTMembers"   AppendDataBoundItems="true" DataValueField="SaLTMemberID" DataTextField="SaLTMember" SelectedValue='<%# Bind("SaLTMemberID")%>' OnDataBinding="SaLtMemberDropDown_DataBinding">
                            <asp:ListItem Text="(Select the SaLT member)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the SaLT member" ControlToValidate="SaLtMemberDropDown"  />
                        <%--<asp:TextBox ID="StatusIDTextBox" runat="server" Text='<%# Bind("StatusID") %>' /> --%>
                    </td>
                </tr>
                <tr>
                    <td>Additional Impact:
                    </td>
                    <td>
                        <asp:TextBox ID="AdditionalImpactTextbox" runat="server" Text='<%# Bind("AdditionalImpact") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Is a root cause analysis required?
                    </td>
                    <td>
                        <asp:CheckBox ID="RootCauseRequiredCheckbox" runat="server" Checked='<%# Bind("RootCauseRequired")%>' OnCheckedChanged="RootCauseRequiredCheckbox_CheckedChanged" AutoPostBack="true" />
                    </td>
                </tr>
                <div id="RootCause" runat="server" visible="false">
                <tr>
                    <td>1. Why did the accident or incident occur?
                    </td>
                    <td>
                        <asp:TextBox ID="RootCauseReasonTextbox" runat="server" Text='<%# Bind("RootCauseReason")%>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                
                    <tr>
                        <td>2. Why did number 1 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason2Textbox" runat="server" Text='<%# Bind("RootCauseReason2")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>3. Why did number 1 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason3Textbox" runat="server" Text='<%# Bind("RootCauseReason3")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>4. Why did number 1 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason4Textbox" runat="server" Text='<%# Bind("RootCauseReason4")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>5. Why did number 4 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason5Textbox" runat="server" Text='<%# Bind("RootCauseReason5")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>Conclusions of the root cause analysis:
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseConclusionTextbox" runat="server" Text='<%# Bind("RootCauseConclusion")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                </div>
                <tr>
                    <td>Corrective Action:
                    </td>
                    <td>
                        <asp:TextBox ID="CorrectiveActionTextBox" runat="server" Text='<%# Bind("CorrectiveAction") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Follow Up Date:
                    </td>
                    <td>
                        <asp:TextBox ID="FollowupDateTextbox" runat="server" Text='<%# Bind("FollowUpDate") %>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" Format="MM/dd/yyyy" runat="server" TargetControlID="FollowupDateTextbox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateRequired" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="FollowupDateTextbox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Update" runat="server" ForeColor="Red" ControlToValidate="FollowupDateTextbox" ControlExtender="meeDateRequired" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
                <tr>
                    <td>Follow Up Comments:
                    </td>
                    <td>
                        <asp:TextBox ID="FollowUpCommentsTextBox" runat="server" Text='<%# Bind("FollowUpComments") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>SALT Review?
                    </td>
                    <td>
                        <asp:CheckBox ID="SALTReviewCheckbox" runat="server"  Checked='<%# Bind("SALTReview")%>' />
                    </td>
                </tr>
                <tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
             <%--               &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                        </td>

                    </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvSafetyCases" runat="server" AutoGenerateColumns="False" DataKeyNames="SafetyCaseID" DataSourceID="sdsSafetyCasesGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvSafetyCases_SelectedIndexChanged1">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this safety case?');" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
            <asp:BoundField DataField="SafetyCaseID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="SafetyCaseID" />
            <%--<asp:BoundField DataField="SafetyTypeID" HeaderText="SafetyTypeID" SortExpression="SafetyTypeID" />--%>
            <asp:BoundField DataField="SafetyType" HeaderText="Type" SortExpression="SafetyType" />
            <%--<asp:BoundField DataField="SafetyCauseID" HeaderText="SafetyCauseID" SortExpression="SafetyCauseID" />--%>
            <asp:BoundField DataField="SafetyCause" HeaderText="Cause" SortExpression="SafetyCause" />
            <%--<asp:BoundField DataField="StatusID" HeaderText="StatusID" SortExpression="StatusID" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="IssuedBy" HeaderText="Issued By" SortExpression="IssuedBy" />
            <%--<asp:BoundField DataField="IssuedByEmail" HeaderText="IssuedByEmail" SortExpression="IssuedByEmail" />
            <asp:BoundField DataField="IssuedByUsername" HeaderText="IssuedByUsername" SortExpression="IssuedByUsername" />--%>
            <asp:BoundField DataField="Victim" HeaderText="Victim" SortExpression="Victim" />
            <asp:BoundField DataField="IssuedDate" HeaderText="Issued Date" SortExpression="IssuedDate" />
            <%--<asp:BoundField DataField="Notification" HeaderText="Notification" SortExpression="Notification" />
            <asp:BoundField DataField="Circumstances" HeaderText="Circumstances" SortExpression="Circumstances" />
            <asp:BoundField DataField="CorrectiveAction" HeaderText="CorrectiveAction" SortExpression="CorrectiveAction" />
            <asp:BoundField DataField="FollowUpComments" HeaderText="FollowUpComments" SortExpression="FollowUpComments" />--%>
            <%--<asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />--%>
            <asp:BoundField DataField="Witness" HeaderText="Witness" SortExpression="Witness" />
            <asp:BoundField DataField="ManagerName" HeaderText="Manager" SortExpression="ManagerName" />
            <asp:BoundField DataField="SaLTMember" HeaderText="Assigned To" SortExpression="SaLTMember" />
            <asp:BoundField DataField="FollowupDate" HeaderText="Followup Date" SortExpression="FollowupDate" />
            <asp:BoundField DataField="RevisedDate" HeaderText="Revised Date" SortExpression="RevisedDate" />
            <asp:BoundField DataField="Urgent" HeaderText="Urgent" SortExpression="Urgent" />
            <asp:BoundField DataField="SALTReview" HeaderText="SALT Review" SortExpression="SALTReview" />
            <%--<asp:BoundField DataField="People" HeaderText="People" SortExpression="People" />
            <asp:BoundField DataField="Equipment" HeaderText="Equipment" SortExpression="Equipment" />
            <asp:BoundField DataField="Materials" HeaderText="Materials" SortExpression="Materials" />
            <asp:BoundField DataField="Environment" HeaderText="Environment" SortExpression="Environment" />
            <asp:BoundField DataField="Process" HeaderText="Process" SortExpression="Process" />
            <asp:BoundField DataField="PropertyDamage" HeaderText="PropertyDamage" SortExpression="PropertyDamage" />
            <asp:BoundField DataField="Fire" HeaderText="Fire" SortExpression="Fire" />
            <asp:BoundField DataField="EnvironmentalRelease" HeaderText="EnvironmentalRelease" SortExpression="EnvironmentalRelease" />
            <asp:BoundField DataField="LostTime" HeaderText="LostTime" SortExpression="LostTime" />
            <asp:BoundField DataField="HealthCare" HeaderText="HealthCare" SortExpression="HealthCare" />
            <asp:BoundField DataField="FirstAids" HeaderText="FirstAids" SortExpression="FirstAids" />
            <asp:BoundField DataField="NearMiss" HeaderText="NearMiss" SortExpression="NearMiss" />--%>
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
        ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="SELECT * FROM [tblSafetyCases] where SafetyCaseID=@ID"
        UpdateCommand="UPDATE [Safety].[dbo].[tblSafetyCases]
                       SET [SafetyTypeID] = @SafetyTypeID
                          ,[SafetyCauseID] = @SafetyCauseID
                          ,[StatusID] = @StatusID
                          ,[Description] = @Description
                          ,[Victim] = @Victim
                          ,[RevisedDate] = @RevisedDate
                          ,[Notification] = @Notification
                          ,[Circumstances] = @Circumstances
                          ,[CorrectiveAction] = @CorrectiveAction
                          ,[FollowUpComments] = @FollowUpComments
                          ,[Witness] = @Witness
                          ,[PropertyDamageChk] = @PropertyDamageChk
                          ,[FireChk] = @FireChk
                          ,[EnvironmentalReleaseChk] = @EnvironmentalReleaseChk
                          ,[LostTimeChk] = @LostTimeChk
                          ,[HealthCareChk] = @HealthCareChk
                          ,[FirstAidsChk] = @FirstAidsChk
                          ,[ManagerID] = @ManagerID
                          ,[SuspectedRootCause] = @SuspectedRootCause
                          ,[AdditionalImpact] = @AdditionalImpact
                          ,[RootCauseAnalysis] = @RootCauseAnalysis
                          ,[SaLTMemberID] = @SaLTMemberID
                          ,[FollowUpDate] = @FollowUpDate
                          ,[RootCauseRequired] = @RootCauseRequired
                          ,[RootCauseReason] = @RootCauseReason
                          ,[RootCauseReason2] = @RootCauseReason2
                          ,[RootCauseReason3] = @RootCauseReason3
                          ,[RootCauseReason4] = @RootCauseReason4
                          ,[RootCauseReason5] = @RootCauseReason5
                          ,[RootCauseConclusion] = @RootCauseConclusion
                          ,[Urgent] = @Urgent
                          ,[SALTReview] = @SALTReview
                     WHERE SafetyCaseID = @SafetyCaseID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvSafetyCases" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="SafetyCauseID" />
            <asp:Parameter Name="SafetyTypeID" />
            <asp:Parameter Name="Description" />
<%--            <asp:Parameter Name="IssuedBy" />
            <asp:Parameter Name="IssuedByEmail" />--%>
            <asp:Parameter Name="ManagerID" />
            <%--<asp:Parameter Name="IssuedByUsername" />--%>
            <%--<asp:SessionParameter Name="IssuedByUsername" SessionField="Username" />--%>
            <asp:Parameter Name="Victim" />
            <%--<asp:Parameter Name="IssuedDate" />--%>
            <asp:SessionParameter Name="RevisedDate" SessionField="RevisedDate" />
            <asp:Parameter Name="Notification" />
            <asp:Parameter Name="Circumstances" />
            <asp:Parameter Name="CorrectiveAction" />
            <asp:Parameter Name="FollowUpComments" />
            <asp:Parameter Name="PropertyDamageChk" />
            <asp:Parameter Name="FireChk" />
            <asp:Parameter Name="EnvironmentalReleaseChk" />
            <asp:Parameter Name="LostTimeChk" />
            <asp:Parameter Name="HealthCareChk" />
            <asp:Parameter Name="FirstAidsChk" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="SuspectedRootCause" />
            <asp:Parameter Name="AdditionalImpact" />
            <asp:Parameter Name="RootCauseAnalysis" />
            <asp:Parameter Name="SaLTMemberID" />
            <asp:Parameter Name="FollowUpDate" />
            <asp:Parameter Name="RootCauseRequired" />
            <asp:Parameter Name="RootCauseReason" />
            <asp:Parameter Name="RootCauseReason2" />
            <asp:Parameter Name="RootCauseReason3" />
            <asp:Parameter Name="RootCauseReason4" />
            <asp:Parameter Name="RootCauseReason5" />
            <asp:Parameter Name="Urgent" />
            <asp:Parameter Name="SALTReview" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSafetyCasesGrid" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="SELECT *
                         FROM  tblSafetyCases 
                       LEFT JOIN tblSafetyCauses
                          on  tblSafetyCases.SafetyCauseID = tblSafetyCauses.SafetyCauseID
                       LEFT JOIN tblSafetyStatus
                          on tblSafetyCases.StatusID = tblSafetyStatus.StatusID
                       LEFT JOIN tblSafetyTypes
                          on tblSafetyCases.SafetyTypeID = tblSafetyTypes.SafetyTypeID
                        LEFT JOIN tblSaLtMembers
                            on tblSafetyCases.SaLtMemberID = tblSaLtMembers.SaLtMemberID
                        LEFT JOIN tblManagers
                            on tblSafetyCases.ManagerID = tblManagers.ManagerID
                       where visible = 1 and 
                   (@Username in (select SaLTUsername from tblSALTMembers) or @Username = ManagerDomainUser) 
                        order by issueddate desc"
        DeleteCommand="Update tblSafetyCases set visible = 0 where SafetyCaseID = @SafetyCaseID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="Username" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSafetyCauses" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyCauses order by SafetyCause"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyStatus order by Status"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSafetyTypes" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyTypes order by SafetyType "></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblManagers order by managername"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSaLTMembers" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSaLtMembers where active = 1 order by SaLtMember"></asp:SqlDataSource>
</asp:Content>
