<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="Safety.aspx.vb" Inherits="Forecaster.Safety" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Safety Case</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound" DefaultMode="Insert" DataKeyNames="SafetyCaseID" OnItemInserted="frmInsert_ItemInserted" OnItemUpdated="frmInsert_ItemUpdated">
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
                        <asp:TextBox ID="IssuedByTextbox" runat="server" Text='<%# Bind("IssuedBy") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Name required" ControlToValidate="IssuedByTextbox" />
                    </td>
                </tr>
                <tr>
                    <td>Date de l'incident/Incident date:
                    </td>
                    <td>
                        <asp:TextBox ID="IncidentDateTextbox" runat="server" Text='<%# Bind("IncidentDate")%>' Width="250" />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="IncidentDateTextbox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateRequired" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="IncidentDateTextbox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="IncidentDateTextbox" ControlExtender="meeDateRequired" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Incident date required" ControlToValidate="IncidentDateTextbox" />
                    </td>
                </tr>
                <tr>
                    <td>Issued Date:
                    </td>
                    <td>
                        <asp:Label ID="IssuedDateTextBox" runat="server" Text='<%# Bind("IssuedDate")%>' />
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
                <tr>
                    <td>Departement de la victime/Victim's department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="Department" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select the department of the victim)" Value="" />
                        </asp:DropDownList>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the department of the victim" ControlToValidate="DepartmentDropDown" />--%>
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
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
                    <td>Province de l'incident/Province where the incident occured
                    </td>
                    <td>
                        <asp:DropDownList ID="ProvinceDropDown" runat="server" DataSourceID="sdsProvinces" AppendDataBoundItems="true" DataValueField="ProvinceID" DataTextField="Province" SelectedValue='<%# Bind("ProvinceID")%>'>
                            <asp:ListItem Text="(Select your manager)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select a province" ControlToValidate="ProvinceDropDown" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Circonstances/Circumstances (Lieu de l'évènement/Description exacte/À quelle heure/Conséquences)|(Where/Description/Exact time/Consequences):</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:TextBox ID="CircumstancesTextBox" runat="server" Text='<%# Bind("Circumstances")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Circumstances required" ControlToValidate="CircumstancesTextBox" />
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">Urgent?</td>
                    <td>
                        <asp:CheckBox ID="UrgentCheckbox" runat="server" Checked='<%# Bind("Urgent")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Attachment</td>
                    <td>
                        <asp:FileUpload ID="fuDialog" runat="server" />
                        <br />
                        FileName:<asp:TextBox ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' /><br />
                        Path:<asp:Hyperlink ID="PathTextbox" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("Path")),"",Eval("Path")))%>' Text='<%# IIf(IsDBNull(Eval("Path")),"",Eval("Path"))%>' Target="_blank" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>Dommage sur la personne/Damage on a person</h2>
                    </td>
                </tr>
                <tr>
                    <td>Blessure et traitement requis/Wound and required treatment
                    </td>
                    <td>
                        <asp:DropDownList ID="TreatmentDropDown" runat="server" DataSourceID="sdsTreatments" AppendDataBoundItems="true" DataValueField="TreatmentID" DataTextField="Treatment" SelectedValue='<%# Bind("TreatmentID")%>'>
                            <asp:ListItem Text="(Select a injury/treatment)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select a injury/treatment" ControlToValidate="TreatmentDropDown" />
                    </td>
                </tr>
                <%--<tr>
                    <td>Problème de Santé ou blessure/Health Care or Injury:
                    </td>
                    <td>
                        <asp:CheckBox ID="HealthCareCheckbox" runat="server" Checked='<%# Bind("HealthCarechk")%>' />
                        Endroit de la blessure/Location of the injury:<asp:TextBox ID="LesionLocationTextbox" runat="server" Text='<%# Bind("Lesionlocation")%>' />

                    </td>
                </tr>--%>
                <tr>
                    <td>Endroit de la blessure/Location of the injury:</td>
                    <td>
                        <asp:DropDownList ID="LesionDropdown" runat="server" DataSourceID="sdsLesions" AppendDataBoundItems="true" DataValueField="LesionID" DataTextField="Lesion" SelectedValue='<%# Bind("LesionID")%>'>
                            <asp:ListItem Text="(Select the location of your lesion )" Value="" />
                        </asp:DropDownList>

                    </td>
                </tr>
                <tr>
                    <td>
                        Nombre de journées manqués/Number of missed Days:
                    </td>
                    <td>
                        <asp:TextBox ID="MissedDaysTextbox" runat="server" Text='<%# Bind("MissedDays")%>' />
                    </td>
                </tr>
<%--                <tr>
                    <td>Temps perdu/Lost time:
                    </td>
                    <td>
                        <asp:CheckBox ID="LostTimeCheckbox" runat="server" Checked='<%# Bind("LostTimechk")%>' />
                    </td>
                </tr>--%>
                 <tr>
                    <td>Assignation temporaire/Temporary Assignment
                    </td>
                    <td>
                        <asp:CheckBox ID="TemporaryAssignmentCheckbox" runat="server" Checked='<%# Bind("TemporaryAssignment")%>' />
                        <%--<asp:TextBox ID="FirstAidsTextbox" runat="server" Text='<%# Bind("FirstAids")%>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>Autre Dommage/Other damage</h2>
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
                    </td>
                </tr>

<%--                <tr>
                    <td>Premiers Soins/First Aid:
                    </td>
                    <td>
                        <asp:CheckBox ID="FirstAidsCheckbox" runat="server" Checked='<%# Bind("FirstAidschk")%>' />
                        
                    </td>
                </tr>
                <tr>
                    <td>Visite au doctor/Doctor Visit
                    </td>
                    <td>
                        <asp:CheckBox ID="DoctorVisitCheckBox" runat="server" Checked='<%# Bind("DoctorVisit")%>' />
                        
                    </td>
                </tr>--%>
               
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
                        <h2>Safety committee team</h2>
                    </td>
                </tr>
                <tr>
                    <td>Status:
                    </td>
                    <td>
                        <asp:DropDownList ID="StatusDropDown" runat="server" Enabled="false" DataSourceID="sdsStatus" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" SelectedValue='<%# Bind("StatusID")%>'>
                            <asp:ListItem Text="(Select the status)" Value="" />
                        </asp:DropDownList>
                        <%--<asp:TextBox ID="StatusIDTextBox" runat="server" Text='<%# Bind("StatusID") %>' /> --%>
                    </td>
                </tr>
                <tr>
                    <td>Assign to (Safety committee member):
                    </td>
                    <td>
                        <asp:DropDownList ID="SaLtMemberDropDown" runat="server" Enabled="false" DataSourceID="sdsSaLTMembers" AppendDataBoundItems="true" DataValueField="SaLTMemberID" DataTextField="SaLTMember" SelectedValue='<%# Bind("SaLTMemberID")%>'>
                            <asp:ListItem Text="(Select the SaLT member)" Value="" />
                        </asp:DropDownList>
                        <%--<asp:TextBox ID="StatusIDTextBox" runat="server" Text='<%# Bind("StatusID") %>' /> --%>
                    </td>
                </tr>
                <tr>
                    <td>Additional Impact:
                    </td>
                    <td>
                        <asp:TextBox ID="AdditionalImpactTextbox" runat="server" Enabled="false" Text='<%# Bind("AdditionalImpact") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Is a root cause analysis required?
                    </td>
                    <td>
                        <asp:CheckBox ID="RootCauseRequiredCheckbox" runat="server" Enabled="false" Checked='<%# Bind("RootCauseRequired")%>' AutoPostBack="true" />
                    </td>
                </tr>
                <div id="RootCause" runat="server" visible="false">
                    <tr>
                        <td>1. Why did the accident or incident occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReasonTextbox" runat="server" Enabled="false" Text='<%# Bind("RootCauseReason")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>

                    <tr>
                        <td>2. Why did number 1 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason2Textbox" runat="server" Enabled="false" Text='<%# Bind("RootCauseReason2")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>3. Why did number 2 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason3Textbox" runat="server" Enabled="false" Text='<%# Bind("RootCauseReason3")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>4. Why did number 3 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason4Textbox" runat="server" Enabled="false" Text='<%# Bind("RootCauseReason4")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>5. Why did number 4 occur?
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseReason5Textbox" runat="server" Enabled="false" Text='<%# Bind("RootCauseReason5")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                    <tr>
                        <td>Conclusions of the root cause analysis:
                        </td>
                        <td>
                            <asp:TextBox ID="RootCauseConclusionTextbox" runat="server" Enabled="false" Text='<%# Bind("RootCauseConclusion")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        </td>
                    </tr>
                </div>
                <tr>
                    <td>Corrective Action:
                    </td>
                    <td>
                        <asp:TextBox ID="CorrectiveActionTextBox" runat="server" Enabled="false" Text='<%# Bind("CorrectiveAction") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Follow Up Date:
                    </td>
                    <td>
                        <asp:TextBox ID="FollowupDateTextbox" runat="server" Enabled="false" Text='<%# Bind("FollowUpDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Follow Up Comments:
                    </td>
                    <td>
                        <asp:TextBox ID="FollowUpCommentsTextBox" runat="server" Enabled="false" Text='<%# Bind("FollowUpComments") %>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
<%--                <tr>
                    <td>SALT Review?
                    </td>
                    <td>
                        <asp:CheckBox ID="SALTReviewCheckbox" runat="server" Enabled="false" Checked='<%# Bind("SALTReview")%>' />
                    </td>
                </tr>--%>
                <tr>
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Name required" ControlToValidate="IssuedByTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Date de l'incident/Incident date:
                    </td>
                    <td>
                        <asp:TextBox ID="IncidentDateTextbox" runat="server" Text='<%# Bind("IncidentDate")%>' Width="250" />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="IncidentDateTextbox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateRequired" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="IncidentDateTextbox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="IncidentDateTextbox" ControlExtender="meeDateRequired" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Incident date required" ControlToValidate="IncidentDateTextbox" />
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
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
                <tr>
                    <td>Departement de la victime/Victim's department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="Department" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select the department of the victim)" Value="" />
                        </asp:DropDownList>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the department of the victim" ControlToValidate="DepartmentDropDown" />--%>
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
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
                    <td>Province de l'incident/Province where the incident occured
                    </td>
                    <td>
                        <asp:DropDownList ID="ProvinceDropDown" runat="server" DataSourceID="sdsProvinces" AppendDataBoundItems="true" DataValueField="ProvinceID" DataTextField="Province" SelectedValue='<%# Bind("ProvinceID")%>'>
                            <asp:ListItem Text="(Select a province)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select a province" ControlToValidate="ProvinceDropDown" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Circonstances/Circumstances (Lieu de l'évènement/Description exacte/À quelle heure/Conséquences)|(Where/Description/Exact time/Consequences):</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:TextBox ID="CircumstancesTextBox" runat="server" Text='<%# Bind("Circumstances")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Circumstances required" ControlToValidate="CircumstancesTextBox" />
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">Urgent?</td>
                    <td>
                        <asp:CheckBox ID="UrgentCheckbox" runat="server" Checked='<%# Bind("Urgent")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Attachment</td>
                    <td>
                        <asp:FileUpload ID="fuDialog" runat="server" />
                        <br />
                        <%--FileName:<asp:TextBox ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' /><br />
                        Path:<asp:Hyperlink ID="PathTextbox" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("Path")),"",Eval("Path")))%>' Text='<%# IIf(IsDBNull(Eval("Path")),"",Eval("Path"))%>' Target="_blank" />--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>Dommage sur la personne/Damage on a person</h2>
                    </td>
                </tr>
                <tr>
                    <td>Blessure et traitement requis/Wound and required treatment
                    </td>
                    <td>
                        <asp:DropDownList ID="TreatmentDropDown" runat="server" DataSourceID="sdsTreatments" AppendDataBoundItems="true" DataValueField="TreatmentID" DataTextField="Treatment" SelectedValue='<%# Bind("TreatmentID")%>'>
                            <asp:ListItem Text="(Select a injury/treatment)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select a injury/treatment" ControlToValidate="TreatmentDropDown" />
                    </td>
                </tr>
                <%--<tr>
                    <td>Problème de Santé ou blessure/Health Care or Injury:
                    </td>
                    <td>
                        <asp:CheckBox ID="HealthCareCheckbox" runat="server" Checked='<%# Bind("HealthCarechk")%>' />
                        Endroit de la blessure/Location of the injury:<asp:TextBox ID="LesionLocationTextbox" runat="server" Text='<%# Bind("Lesionlocation")%>' />

                    </td>
                </tr>--%>
                <tr>
                    <td>Endroit de la blessure/Location of the injury:</td>
                    <td>
                        <asp:DropDownList ID="LesionDropdown" runat="server" DataSourceID="sdsLesions" AppendDataBoundItems="true" DataValueField="LesionID" DataTextField="Lesion" SelectedValue='<%# Bind("LesionID")%>'>
                            <asp:ListItem Text="(Select the location of your lesion )" Value="" />
                        </asp:DropDownList>

                    </td>
                </tr>
                <tr>
                    <td>
                        Nombre de journées manqués/Number of missed Days:
                    </td>
                    <td>
                        <asp:TextBox ID="MissedDaysTextbox" runat="server" Text='<%# Bind("MissedDays")%>' />
                    </td>
                </tr>
<%--                <tr>
                    <td>Temps perdu/Lost time:
                    </td>
                    <td>
                        <asp:CheckBox ID="LostTimeCheckbox" runat="server" Checked='<%# Bind("LostTimechk")%>' />
                    </td>
                </tr>--%>
                 <tr>
                    <td>Assignation temporaire/Temporary Assignment
                    </td>
                    <td>
                        <asp:CheckBox ID="TemporaryAssignmentCheckbox" runat="server" Checked='<%# Bind("TemporaryAssignment")%>' />
                        <%--<asp:TextBox ID="FirstAidsTextbox" runat="server" Text='<%# Bind("FirstAids")%>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>Autre Dommage/Other damage</h2>
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

<%--                <tr>
                    <td>Premiers Soins/First Aid:
                    </td>
                    <td>
                        <asp:CheckBox ID="FirstAidsCheckbox" runat="server" Checked='<%# Bind("FirstAidschk")%>' />
                        
                    </td>
                </tr>
                <tr>
                    <td>Visite au doctor/Doctor Visit
                    </td>
                    <td>
                        <asp:CheckBox ID="DoctorVisitCheckBox" runat="server" Checked='<%# Bind("DoctorVisit")%>' />
                        
                    </td>
                </tr>--%>
               
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
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" ValidationGroup="Insert" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </InsertItemTemplate>
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
            <asp:BoundField DataField="SafetyCaseID" HeaderText="SafetyCaseID" InsertVisible="False" ReadOnly="True" SortExpression="SafetyCaseID" />
            <%--<asp:BoundField DataField="SafetyTypeID" HeaderText="SafetyTypeID" SortExpression="SafetyTypeID" />--%>
            <asp:BoundField DataField="SafetyType" HeaderText="SafetyType" SortExpression="SafetyType" />
            <%--<asp:BoundField DataField="SafetyCauseID" HeaderText="SafetyCauseID" SortExpression="SafetyCauseID" />--%>
            <%--<asp:BoundField DataField="SafetyCause" HeaderText="SafetyCause" SortExpression="SafetyCause" />--%>
            <%--<asp:BoundField DataField="StatusID" HeaderText="StatusID" SortExpression="StatusID" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="IssuedBy" HeaderText="IssuedBy" SortExpression="IssuedBy" />
            <%--<asp:BoundField DataField="IssuedByEmail" HeaderText="IssuedByEmail" SortExpression="IssuedByEmail" />
            <asp:BoundField DataField="IssuedByUsername" HeaderText="IssuedByUsername" SortExpression="IssuedByUsername" />--%>
            <asp:BoundField DataField="Victim" HeaderText="Victim" SortExpression="Victim" />
            <asp:BoundField DataField="IssuedDate" HeaderText="IssuedDate" SortExpression="IssuedDate" />
            <%--<asp:BoundField DataField="Notification" HeaderText="Notification" SortExpression="Notification" />
            <asp:BoundField DataField="Circumstances" HeaderText="Circumstances" SortExpression="Circumstances" />
            <asp:BoundField DataField="CorrectiveAction" HeaderText="CorrectiveAction" SortExpression="CorrectiveAction" />
            <asp:BoundField DataField="FollowUpComments" HeaderText="FollowUpComments" SortExpression="FollowUpComments" />--%>
            <%--<asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />--%>
            <asp:BoundField DataField="Witness" HeaderText="Witness" SortExpression="Witness" />
            <asp:BoundField DataField="ManagerName" HeaderText="Manager" SortExpression="ManagerName" />
            <asp:BoundField DataField="SaLTMember" HeaderText="Assigned To" SortExpression="SaLTMember" />
            <asp:BoundField DataField="Urgent" HeaderText="Urgent" SortExpression="Urgent" />
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
            <asp:BoundField DataField="FirstAids" HeaderText="FirstAids" SortExpression="FirstAids" /> --%>
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
        ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="SELECT * FROM [tblSafetyCases] where SafetyCaseID=@ID"
        InsertCommand="INSERT INTO [Safety].[dbo].[tblSafetyCases]
           ([SafetyTypeID]
           ,[SafetyCauseID]
           ,[StatusID]
           ,[Description]
           ,[IssuedBy]
           ,[IssuedByEmail]
           ,[IssuedByUsername]
           ,[Victim]
           ,[IssuedDate]
           ,[IncidentDate]
           ,[Notification]
           ,[Circumstances]
           ,[CorrectiveAction]
           ,[FollowUpComments]
           ,[Witness]
           ,[PropertyDamageChk]
           ,[FireChk]
           ,[EnvironmentalReleaseChk]
           ,[ManagerID]
           ,[SuspectedRootCause]
           ,[RootCauseRequired]
           ,[Urgent]
           ,[MissedDays]
           ,[TemporaryAssignment]
           ,[LesionLocation]
           ,[ProvinceID]
           ,[TreatmentID]
           ,[LesionID]
           ,[DepartmentID])
     VALUES
           (@SafetyTypeID
           ,@SafetyCauseID
           ,@StatusID
           ,@Description
           ,@IssuedBy
           ,@IssuedByEmail
           ,@IssuedByUsername
           ,@Victim
           ,@IssuedDate
           ,@IncidentDate
           ,@Notification
           ,@Circumstances
           ,@CorrectiveAction
           ,@FollowUpComments
           ,@Witness
           ,@PropertyDamageChk
           ,@FireChk
           ,@EnvironmentalReleaseChk
           ,@ManagerID
           ,@SuspectedRootCause
           ,@RootCauseRequired
           ,@Urgent
           ,@MissedDays
           ,@TemporaryAssignment
           ,@LesionLocation
           ,@ProvinceID
           ,@TreatmentID
           ,@LesionID
           ,@DepartmentID);
        select @ID = @@IDENTITY"
        UpdateCommand="UPDATE [Safety].[dbo].[tblSafetyCases]
   SET [SafetyTypeID] = @SafetyTypeID
      ,[SafetyCauseID] = @SafetyCauseID
      ,[StatusID] = @StatusID
      ,[Description] = @Description
      ,[RevisedDate] = @RevisedDate
      ,[IncidentDate] = @IncidentDate
      ,[Victim] = @Victim
      ,[Notification] = @Notification
      ,[Circumstances] = @Circumstances
      ,[CorrectiveAction] = @CorrectiveAction
      ,[FollowUpComments] = @FollowUpComments
      ,[Witness] = @Witness
      ,[PropertyDamageChk] = @PropertyDamageChk
      ,[FireChk] = @FireChk
      ,[EnvironmentalReleaseChk] = @EnvironmentalReleaseChk
      ,[ManagerID] = @ManagerID
      ,[SuspectedRootCause] = @SuspectedRootCause
      ,[Urgent] = @Urgent
      ,[MissedDays] = @MissedDays
      ,[TemporaryAssignment] = @TemporaryAssignment
      ,[LesionLocation] = @LesionLocation
      ,[ProvinceID] = @ProvinceID
      ,[TreatmentID] = @TreatmentID
      ,[LesionID] = @LesionID
      ,[DepartmentID] = @DepartmentID
 WHERE SafetyCaseID = @SafetyCaseID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvSafetyCases" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="SafetyCauseID" />
            <asp:Parameter Name="SafetyTypeID" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="IssuedBy" />
            <asp:Parameter Name="IssuedByEmail" />
            <asp:Parameter Name="ManagerID" />
            <asp:SessionParameter Name="IssuedByUsername" SessionField="Username" />
            <asp:Parameter Name="Victim" />
            <asp:Parameter Name="Witness" />
            <asp:SessionParameter Name="IssuedDate" SessionField="IssuedDate" />
            <asp:Parameter Name="IncidentDate" />
            <asp:Parameter Name="Notification" />
            <asp:Parameter Name="Circumstances" />
            <asp:Parameter Name="CorrectiveAction" />
            <asp:Parameter Name="FollowUpComments" />
            <asp:Parameter Name="PropertyDamageChk" />
            <asp:Parameter Name="FireChk" />
            <asp:Parameter Name="EnvironmentalReleaseChk" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="SuspectedRootCause" />
            <asp:Parameter Name="RootCauseRequired" Type="Boolean" DefaultValue="False" />
            <asp:Parameter Name="Urgent" Type="Boolean" DefaultValue="False" />
            <asp:Parameter Name="MissedDays" />
            <asp:Parameter Name="TemporaryAssignment" />
            <asp:Parameter Name="LesionLocation" />
            <asp:Parameter Name="ProvinceID" />
            <asp:Parameter Name="TreatmentID" />
            <asp:Parameter Name="LesionID" />
            <asp:Parameter Name="DepartmentID" />
            <asp:Parameter Name="ID" Direction="Output" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="SafetyCauseID" />
            <asp:Parameter Name="SafetyTypeID" />
            <asp:Parameter Name="Description" />
            <%--<asp:Parameter Name="IssuedBy" />
            <asp:Parameter Name="IssuedByEmail" />--%>
            <asp:Parameter Name="ManagerID" />
            <%--<asp:SessionParameter Name="IssuedByUsername" SessionField="Username" />--%>
            <asp:Parameter Name="Victim" />
            <asp:Parameter Name="Witness" />
            <%--<asp:Parameter Name="IssuedDate" />--%>
            <asp:SessionParameter Name="RevisedDate" SessionField="RevisedDate" />
            <asp:Parameter Name="IncidentDate" />
            <asp:Parameter Name="Notification" />
            <asp:Parameter Name="Circumstances" />
            <asp:Parameter Name="CorrectiveAction" />
            <asp:Parameter Name="FollowUpComments" />
            <asp:Parameter Name="PropertyDamageChk" />
            <asp:Parameter Name="FireChk" />
            <asp:Parameter Name="EnvironmentalReleaseChk" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="SuspectedRootCause" />
            <asp:Parameter Name="Urgent" Type="Boolean" DefaultValue="False" />
            <asp:Parameter Name="MissedDays" />
            <asp:Parameter Name="TemporaryAssignment" />
            <asp:Parameter Name="LesionLocation" />
            <asp:Parameter Name="ProvinceID" />
            <asp:Parameter Name="TreatmentID" />
            <asp:Parameter Name="LesionID" />
            <asp:Parameter Name="DepartmentID" />
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
                       where IssuedByUsername=@IssuedByUsername and visible = 1"
        DeleteCommand="Update tblSafetyCases set visible = 0 where SafetyCaseID = @SafetyCaseID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="IssuedByUsername" />
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
    <asp:SqlDataSource ID="sdsProvinces" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyProvinces order by Province"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLesions" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyLesions order by Lesion"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTreatments" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyTreatments order by Treatment"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:SafetyConnectionString %>"
        SelectCommand="select * from tblSafetyDepartments order by Department"></asp:SqlDataSource>
</asp:Content>
