<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="BuildingManager.aspx.vb" Inherits="Forecaster.BuildingManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Building Maintenance and improvement request</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound" DefaultMode="Edit" DataKeyNames="RequestID" OnItemUpdated="frmInsert_ItemUpdated">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>ID:
                    </td>
                    <td>
                        <asp:Label ID="RequestIDLabel1" runat="server" Text='<%# Eval("RequestID") %>' />
                    </td>
                </tr>
                <%--                <tr>
                    <td>StatusID:
                    </td>
                    <td>
                        <asp:TextBox ID="StatusIDTextBox" runat="server" Text='<%# Bind("StatusID") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Description needed" ControlToValidate="DescriptionTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Créé par/Issued By:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByTextBox" runat="server" Text='<%# Bind("IssuedBy") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Issued by needed" ControlToValidate="IssuedByTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Email:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByEmailTextBox" runat="server" Text='<%# Bind("IssuedByEmail") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Email needed" ControlToValidate="IssuedByEmailTextBox" />
                    </td>
                </tr>
                <%--                <tr>
                    <td>IssuedByUsername:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedByUsernameTextBox" runat="server" Text='<%# Bind("IssuedByUsername") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Bureau/Office:
                    </td>
                    <td>
                        <%--<asp:TextBox ID="OfficeIDTextBox" runat="server" Text='<%# Bind("OfficeID") %>' />--%>
                        <asp:DropDownList ID="OfficeDropDown" runat="server" DataSourceID="sdsBuildingOffices" AppendDataBoundItems="true" DataValueField="OfficeID" DataTextField="Office" SelectedValue='<%# Bind("OfficeID")%>'>
                            <asp:ListItem Text="(Select the office)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Office needed" ControlToValidate="OfficeDropDown" />
                    </td>
                </tr>
                <tr>
                    <td>IssuedDate:
                    </td>
                    <td>
                        <asp:TextBox ID="IssuedDateTextBox" runat="server" Text='<%# Bind("IssuedDate") %>' readonly="true"/>
                    </td>
                </tr>
                <%--                <tr>
                    <td>RevisedDate:
                    </td>
                    <td>
                        <asp:TextBox ID="RevisedDateTextBox" runat="server" Text='<%# Bind("RevisedDate") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Détail/Additional Info:
                    </td>
                    <td>
                        <asp:TextBox ID="AdditionalInfoTextBox" runat="server" Text='<%# Bind("AdditionalInfo") %>' TextMode="MultiLine" Rows="10" Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Additional info needed" ControlToValidate="AdditionalInfoTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Urgent?:
                    </td>
                    <td>
                        <asp:CheckBox ID="UrgentCheckBox" runat="server" Checked='<%# Bind("Urgent") %>' />
                    </td>
                </tr>
                <tr><td>Attachment</td>
                    <td>
                        <asp:FileUpload ID="fuDialog" runat="server"/>  <br />
                        FileName:<asp:TextBox ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' /><br />
                        Path:<asp:Hyperlink ID="PathTextbox" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("Path")),"",Eval("Path")))%>' Text='<%# IIf(IsDBNull(Eval("Path")),"",Eval("Path"))%>' Target="_blank" />
                    </td>

                </tr>
                <tr>
                    <td>
                        <h2>Comité du bâtiment/Building Committee section</h2>
                    </td>
                </tr>
                <tr>
                    <td>Mesures correctives/Corrective Action:
                    </td>
                    <td>
                        <asp:TextBox ID="CorrectiveActionTextBox" runat="server" Text='<%# Bind("CorrectiveAction") %>' TextMode="MultiLine" Rows="10" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Coût/Cost:
                    </td>
                    <td>
                        <asp:TextBox ID="CostTextBox" runat="server" Text='<%# Bind("Cost") %>' />
                    </td>
                </tr>

                <tr>
                    <td>Assigné à/Assigned To:
                    </td>
                    <td>
                        <%--<asp:CheckBox ID="FundingApprovalCheckBox" runat="server" Checked='<%# Bind("FundingApproval") %>' Enabled="false" />--%>
                        <asp:DropDownList ID="ddlAssignments" runat="server" DataSourceID="sdsAssignments" AutoPostBack="true" AppendDataBoundItems="true" DataValueField="FullName" DataTextField="FullName"  OnSelectedIndexChanged="ddlAssignments_SelectedIndexChanged" SelectedValue='<%# Bind("AssignToName")%>'>
                            <asp:ListItem Text="(Assign To)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Assign To needed" ControlToValidate="ddlAssignments" />
                    </td>
                </tr>
                <tr>
                    <td>Email de la personne assignée/Assigned to Email address:
                    </td>
                    <td>
                        <asp:TextBox ID="AssignToEmailTextbox" runat="server" Text='<%# Bind("AssignToEmail")%>' Enabled="false" Width="250"  />
                    </td>
                </tr>
                <tr>
                    <td>Nom d'utilisateur de la personne assignée/Assigned username:
                    </td>
                    <td>
                        <asp:TextBox ID="AssignToUsernameTextbox" runat="server" Text='<%# Bind("AssignToUsername")%>' Enabled="false" Width="250"  />
                    </td>
                </tr>
                <tr>
                    <td>Status:
                    </td>
                    <td>
                        <%--<asp:CheckBox ID="FundingApprovalCheckBox" runat="server" Checked='<%# Bind("FundingApproval") %>' Enabled="false" />--%>
                        <asp:DropDownList ID="StatusDropDown" runat="server" DataSourceID="sdsSTatus" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" SelectedValue='<%# Bind("StatusID")%>'>
                            <asp:ListItem Text="(Change the status)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Status needed" ControlToValidate="StatusDropDown" />
                    </td>
                </tr>
                <tr>
                    <td>Approbation de financement/Funding Approval:
                    </td>
                    <td>
                        <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("FundingApproval") %>' />
                    </td>
                </tr>
                <%--                <tr>
                    <td>Visible:
                    </td>
                    <td>
                        <asp:CheckBox ID="VisibleCheckBox" runat="server" Checked='<%# Bind("Visible") %>' />
                    </td>
                </tr>--%>

                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                        &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>

                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvBuidingRequests" runat="server" AutoGenerateColumns="False" DataSourceID="sdsOfficeRequestsGrid" AllowPaging="True" AllowSorting="True" DataKeyNames="RequestID"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvBuidingRequests_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this request?');" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
            <asp:BoundField DataField="RequestID" HeaderText="RequestID" InsertVisible="False" ReadOnly="True" SortExpression="RequestID" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="IssuedBy" HeaderText="Issued By" SortExpression="IssuedBy" />
            <asp:BoundField DataField="IssuedByEmail" HeaderText="Issued By Email" SortExpression="IssuedByEmail" />
            <asp:BoundField DataField="AssignToName" HeaderText="Assigned to" SortExpression="AssignToName" />
            <%--<asp:BoundField DataField="IssuedByUsername" HeaderText="IssuedByUsername" SortExpression="IssuedByUsername" />--%>
            <asp:BoundField DataField="Office" HeaderText="Office" SortExpression="Office" />
            <asp:BoundField DataField="IssuedDate" HeaderText="Issued Date" SortExpression="IssuedDate" />
            <asp:BoundField DataField="RevisedDate" HeaderText="Revised Date" SortExpression="RevisedDate" />
            <%--<asp:BoundField DataField="AdditionalInfo" HeaderText="Additional Info" SortExpression="AdditionalInfo" />--%>
            <%--<asp:BoundField DataField="CorrectiveAction" HeaderText="Corrective Action" SortExpression="CorrectiveAction" />--%>
            <asp:BoundField DataField="Cost" HeaderText="Cost" SortExpression="Cost" />
            <asp:CheckBoxField DataField="Urgent" HeaderText="Urgent" SortExpression="Urgent" />
            <asp:CheckBoxField DataField="FundingApproval" HeaderText="Funding Approval" SortExpression="FundingApproval" />
            <%--            <asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />--%>
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
        ConnectionString="<%$ ConnectionStrings:BuildingConnectionString %>"
        SelectCommand="SELECT * FROM [tblBuildingRequests] where RequestID=@ID"
        UpdateCommand="UPDATE [Building].[dbo].[tblBuildingRequests]
   SET [StatusID] =          @StatusID    
      ,[Description] =       @Description 
      ,[OfficeID] =          @OfficeID 
      ,[RevisedDate] =       @RevisedDate
      ,[AdditionalInfo] =    @AdditionalInfo 
      ,[CorrectiveAction] =  @CorrectiveAction
      ,[Cost] =              @Cost 
      ,[Urgent] =            @Urgent 
      ,[FundingApproval] =   @FundingApproval 
      ,[Visible] =           @Visible 
      ,[AssignToName] =      @AssignToName
      ,[AssignToEmail] =     @AssignToEmail
      ,[AssignToUsername] =  @AssignToUsername
 WHERE RequestID = @RequestID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvBuidingRequests" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="IssuedBy" />
            <asp:Parameter Name="OfficeID" />
            <asp:SessionParameter Name="RevisedDate" SessionField="RevisedDate" />
            <asp:Parameter Name="AdditionalInfo" />
            <asp:Parameter Name="Visible" DefaultValue="true" />
            <asp:Parameter Name="CorrectiveAction" />
            <asp:Parameter Name="Cost" />
            <asp:Parameter Name="FundingApproval" />
            <asp:Parameter Name="Urgent" />
            <asp:Parameter Name="AssignToName" />
            <asp:Parameter Name="AssignToEmail" />
            <asp:Parameter Name="AssignToUsername" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOfficeRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BuildingConnectionString %>"
        SelectCommand="SELECT *
                         FROM  tblbuildingrequests 
                    LEFT JOIN  tblbuildingoffices
                           ON  tblbuildingrequests.officeid = tblbuildingoffices.officeid
                    LEFT JOIN  tblbuildingstatus
                           ON  tblbuildingrequests.statusid = tblbuildingstatus.statusid
                        where visible = 1 and 
                   (@Username in (select ManagerUsername from tblBuildingManagers) or @Username = AssignToUsername )
                    order by requestid desc"
        DeleteCommand="Update tblbuildingrequests set visible = 0 where RequestID = @RequestID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="Username" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBuildingOffices" runat="server" ConnectionString="<%$ ConnectionStrings:BuildingConnectionString %>"
        SelectCommand="select * from tblbuildingOffices order by Office"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAssignments" runat="server" ConnectionString="<%$ ConnectionStrings:BuildingConnectionString %>"
        SelectCommand="select * from vwAllADUsers order by fullname"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:BuildingConnectionString %>"
        SelectCommand="select * from tblBuildingStatus order by status"></asp:SqlDataSource>
</asp:Content>
