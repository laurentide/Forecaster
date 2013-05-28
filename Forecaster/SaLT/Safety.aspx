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
                    <td>Description
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextbox" runat="server" Text='<%# Bind("Description")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Description required" ControlToValidate="DescriptionTextbox" />
                    </td>
                </tr>
                <tr>
                    <td>Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="TypeDropDown" runat="server" DataSourceID="sdsSafetyTypes" AppendDataBoundItems="true" DataValueField="SafetyTypeID" DataTextField="SafetyType" SelectedValue='<%# Bind("SafetyTypeID")%>'>
                            <asp:ListItem Text="(Select the type)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Edit" ForeColor="Red" ErrorMessage="Select the type" ControlToValidate="TypeDropDown" />
                        <%--<asp:TextBox ID="SafetyTypeIDTextBox" runat="server" Text='<%# Bind("SafetyTypeID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Cause:
                    </td>
                    <td>
                        <asp:DropDownList ID="SafetyCauseDrowDown" runat="server" DataSourceID="sdsSafetyCauses" AppendDataBoundItems="true" DataValueField="SafetyCauseID" DataTextField="SafetyCause" SelectedValue='<%# Bind("SafetyCauseID")%>'>
                            <asp:ListItem Text="(Select the cause)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Edit" ForeColor="Red" ErrorMessage="Select the cause" ControlToValidate="SafetyCauseDrowDown" />
                        <%--<asp:TextBox ID="SafetyCauseIDTextBox" runat="server" Text='<%# Bind("SafetyCauseID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Issued By:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Name required" ControlToValidate="IssuedByTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Email:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Email required" ControlToValidate="IssuedByEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="IssuedByEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
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
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Witness name:
                    </td>
                    <td>
                        <asp:TextBox ID="WitnessTextBox" runat="server" Text='<%# Bind("Witness") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Victim name:
                    </td>
                    <td>
                        <asp:TextBox ID="VictimTextBox" runat="server" Text='<%# Bind("Victim") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Notify as well (Emails seperated by semi-colon):
                    </td>
                    <td>
                        <asp:TextBox ID="NotificationTextBox" runat="server" Text='<%# Bind("Notification") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Circumstances/Background:
                    </td>
                    <td>
                        <asp:TextBox ID="CircumstancesTextBox" runat="server" Text='<%# Bind("Circumstances")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Circumstances required" ControlToValidate="CircumstancesTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5>Impact (Amount/$)</h5>
                    </td>
                </tr>
                <tr>
                    <td>Property Damage:
                    </td>
                    <td>
                        <asp:TextBox ID="PropertyDamageTextBox" runat="server" Text='<%# Bind("PropertyDamage")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Fire:
                    </td>
                    <td>
                        <asp:TextBox ID="FireTextbox" runat="server" Text='<%# Bind("Fire")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Environmental Release:
                    </td>
                    <td>
                        <asp:TextBox ID="EnvironmentalReleaseTextbox" runat="server" Text='<%# Bind("EnvironmentalRelease")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Lost time:
                    </td>
                    <td>
                        <asp:TextBox ID="LostTimeTextbox" runat="server" Text='<%# Bind("LostTime")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Health Care:
                    </td>
                    <td>
                        <asp:TextBox ID="HealthCareTextbox" runat="server" Text='<%# Bind("HealthCare")%>' />
                    </td>
                </tr>
                <tr>
                    <td>First Aid:
                    </td>
                    <td>
                        <asp:TextBox ID="FirstAidsTextbox" runat="server" Text='<%# Bind("FirstAids")%>' />
                    </td>
                </tr>
                <tr></tr>
                <tr>
                    <td colspan="2">In your opinion, what are the root causes of this incident (Human error, equipement defect, wrong materials, environment factors, error(s) in a process)?</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:TextBox ID="SuspectedRootCauseTextbox" runat="server" Text='<%# Bind("SuspectedRootCause")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Suspected root cause required" ControlToValidate="SuspectedRootCauseTextbox" />
                    </td>
                    
                </tr>
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
                    <td>Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="TypeDropDown" runat="server" DataSourceID="sdsSafetyTypes" AppendDataBoundItems="true" DataValueField="SafetyTypeID" DataTextField="SafetyType" SelectedValue='<%# Bind("SafetyTypeID")%>'>
                            <asp:ListItem Text="(Select the type)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the type" ControlToValidate="TypeDropDown" />
                        <%--<asp:TextBox ID="SafetyTypeIDTextBox" runat="server" Text='<%# Bind("SafetyTypeID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Cause:
                    </td>
                    <td>
                        <asp:DropDownList ID="SafetyCauseDrowDown" runat="server" DataSourceID="sdsSafetyCauses" AppendDataBoundItems="true" DataValueField="SafetyCauseID" DataTextField="SafetyCause" SelectedValue='<%# Bind("SafetyCauseID")%>'>
                            <asp:ListItem Text="(Select the cause)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select the cause" ControlToValidate="SafetyCauseDrowDown" />
                        <%--<asp:TextBox ID="SafetyCauseIDTextBox" runat="server" Text='<%# Bind("SafetyCauseID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Issued By:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Name required" ControlToValidate="IssuedByTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Email:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Email required" ControlToValidate="IssuedByEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="IssuedByEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />

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
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td>Witness name:
                    </td>
                    <td>
                        <asp:TextBox ID="WitnessTextBox" runat="server" Text='<%# Bind("Witness") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Victim name:
                    </td>
                    <td>
                        <asp:TextBox ID="VictimTextBox" runat="server" Text='<%# Bind("Victim") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Notify as well (Emails seperated by semi-colon):
                    </td>
                    <td>
                        <asp:TextBox ID="NotificationTextBox" runat="server" Text='<%# Bind("Notification") %>' Width="250" />
                    </td>
                </tr>
                <tr>
                    <td>Circumstances/Background:
                    </td>
                    <td>
                        <asp:TextBox ID="CircumstancesTextBox" runat="server" Text='<%# Bind("Circumstances")%>' TextMode="MultiLine" Rows="5" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Circumstances required" ControlToValidate="CircumstancesTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5>Impact (Amount/$)</h5>
                    </td>
                </tr>
                <tr>
                    <td>Property Damage:
                    </td>
                    <td>
                        <asp:TextBox ID="PropertyDamageTextBox" runat="server" Text='<%# Bind("PropertyDamage")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Fire:
                    </td>
                    <td>
                        <asp:TextBox ID="FireTextbox" runat="server" Text='<%# Bind("Fire")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Environmental Release:
                    </td>
                    <td>
                        <asp:TextBox ID="EnvironmentalReleaseTextbox" runat="server" Text='<%# Bind("EnvironmentalRelease")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Lost time:
                    </td>
                    <td>
                        <asp:TextBox ID="LostTimeTextbox" runat="server" Text='<%# Bind("LostTime")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Health Care:
                    </td>
                    <td>
                        <asp:TextBox ID="HealthCareTextbox" runat="server" Text='<%# Bind("HealthCare")%>' />
                    </td>
                </tr>
                <tr>
                    <td>First Aid:
                    </td>
                    <td>
                        <asp:TextBox ID="FirstAidsTextbox" runat="server" Text='<%# Bind("FirstAids")%>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">In your opinion, what are the root causes of this incident (Human error, equipement defect, wrong materials, environment factors, error in a process)?</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:TextBox ID="SuspectedRootCauseTextbox" runat="server" Text='<%# Bind("SuspectedRootCause")%>' TextMode="MultiLine" Rows="5" Width="500" />
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
            <asp:BoundField DataField="SafetyCause" HeaderText="SafetyCause" SortExpression="SafetyCause" />
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
    <asp:SqlDataSource ID="sdsInsert" runat="server"
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
           ,[Notification]
           ,[Circumstances]
           ,[CorrectiveAction]
           ,[FollowUpComments]
           ,[Witness]
           ,[PropertyDamage]
           ,[Fire]
           ,[EnvironmentalRelease]
           ,[LostTime]
           ,[HealthCare]
           ,[FirstAids]
           ,[ManagerID]
           ,[SuspectedRootCause])
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
           ,@Notification
           ,@Circumstances
           ,@CorrectiveAction
           ,@FollowUpComments
           ,@Witness
           ,@PropertyDamage
           ,@Fire
           ,@EnvironmentalRelease
           ,@LostTime
           ,@HealthCare
           ,@FirstAids
           ,@ManagerID
           ,@SuspectedRootCause)"
        UpdateCommand="UPDATE [Safety].[dbo].[tblSafetyCases]
   SET [SafetyTypeID] = @SafetyTypeID
      ,[SafetyCauseID] = @SafetyCauseID
      ,[StatusID] = @StatusID
      ,[Description] = @Description
      ,[IssuedBy] = @IssuedBy
      ,[IssuedByEmail] = @IssuedByEmail
      ,[IssuedByUsername] = @IssuedByUsername
      ,[Victim] = @Victim
      ,[IssuedDate] = @IssuedDate
      ,[Notification] = @Notification
      ,[Circumstances] = @Circumstances
      ,[CorrectiveAction] = @CorrectiveAction
      ,[FollowUpComments] = @FollowUpComments
      ,[Witness] = @Witness
      ,[PropertyDamage] = @PropertyDamage
      ,[Fire] = @Fire
      ,[EnvironmentalRelease] = @EnvironmentalRelease
      ,[LostTime] = @LostTime
      ,[HealthCare] = @HealthCare
      ,[FirstAids] = @FirstAids
      ,[ManagerID] = @ManagerID
      ,[SuspectedRootCause] = @SuspectedRootCause
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
            <%--<asp:Parameter Name="IssuedByUsername" />--%>
            <asp:SessionParameter Name="IssuedByUsername" SessionField="Username" />
            <asp:Parameter Name="Victim" />
            <%--<asp:Parameter Name="IssuedDate" />--%>
            <asp:SessionParameter Name="IssuedDate" SessionField="IssuedDate" />
            <asp:Parameter Name="Notification" />
            <asp:Parameter Name="Circumstances" />
            <asp:Parameter Name="CorrectiveAction" />
            <asp:Parameter Name="FollowUpComments" />
            <asp:Parameter Name="PropertyDamage" />
            <asp:Parameter Name="Fire" />
            <asp:Parameter Name="EnvironmentalRelease" />
            <asp:Parameter Name="LostTime" />
            <asp:Parameter Name="HealthCare" />
            <asp:Parameter Name="FirstAids" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="SuspectedRootCause" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="SafetyCauseID" />
            <asp:Parameter Name="SafetyTypeID" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="IssuedBy" />
            <asp:Parameter Name="IssuedByEmail" />
            <asp:Parameter Name="ManagerID" />
            <%--<asp:Parameter Name="IssuedByUsername" />--%>
            <asp:SessionParameter Name="IssuedByUsername" SessionField="Username" />
            <asp:Parameter Name="Victim" />
            <%--<asp:Parameter Name="IssuedDate" />--%>
            <asp:SessionParameter Name="IssuedDate" SessionField="IssuedDate" />
            <asp:Parameter Name="Notification" />
            <asp:Parameter Name="Circumstances" />
            <asp:Parameter Name="CorrectiveAction" />
            <asp:Parameter Name="FollowUpComments" />
            <asp:Parameter Name="PropertyDamage" />
            <asp:Parameter Name="Fire" />
            <asp:Parameter Name="EnvironmentalRelease" />
            <asp:Parameter Name="LostTime" />
            <asp:Parameter Name="HealthCare" />
            <asp:Parameter Name="FirstAids" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="SuspectedRootCause" />
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
        SelectCommand="select * from tblSaLtMembers order by SaLtMember"></asp:SqlDataSource>
</asp:Content>
