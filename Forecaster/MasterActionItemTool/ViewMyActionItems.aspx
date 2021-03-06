﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="ViewMyActionItems.aspx.vb" Inherits="Forecaster.ViewMyActionItems" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Master Action Item Tool</h2>
    <asp:ScriptManager ID="MyScriptManager" runat="server" />
<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
      <Triggers>
           <asp:PostBackTrigger ControlID="mastInsert" />
       </Triggers>--%>
        <ContentTemplate>
        <asp:FormView ID="mastInsert" runat="server" DefaultMode="Edit" DataKeyNames="MAST_ID" DataSourceID="sdsInsert" OnItemUpdated="mastInsert_ItemUpdated" OnDataBound="mastInsert_DataBound">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>ID:</td>
                    <td>
                        <asp:Label ID="MASTIDLabel" runat="server" Text='<%# Eval("MAST_ID")%>' />
                    </td>
                </tr>
<%--                <tr>
                    <td>Name:</td>
                    <td>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name")%>' Width="500" /></td>
                    </td>
                </tr>--%>
<%--                <tr>
                    <td>Team(s):</td>
                    <td>
                        <asp:DropDownList ID="TeamsDropDownList" runat="server" AutoPostBack="true" DataSourceID="sdsTeams" AppendDataBoundItems="true">
                            <asp:ListItem Text="(Choose team)" Value="" />
                        </asp:DropDownList>
                    </td><td><asp:TextBox ID="HiddenTeamNameTextbox" runat="server" Visible="false" Text='<%# Eval("TeamName")%>'></asp:TextBox></td>
                    <td><asp:TextBox ID="HiddenTeamIDTextbox" runat="server" Visible="false" Text='<%# Eval("TeamID")%>'></asp:TextBox></td>
                </tr>--%>
                <tr>
                    <td>Team(s):</td>
                    <td>
                        <asp:DropDownList ID="TeamsDropDownList" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="TeamsDropDownList_SelectedIndexChanged">
                            <asp:ListItem Text="(Choose team)" Value="" />
                            <asp:ListItem Text="Individual" Value="16" />
                        </asp:DropDownList>
                    </td><td><asp:TextBox ID="HiddenTeamNameTextbox" runat="server" Visible="false" Text='<%# Bind("TeamName")%>'></asp:TextBox></td>
                    <td><asp:TextBox ID="HiddenTeamIDTextbox" runat="server" Visible="false"  Text='<%# Bind("TeamID") %>'></asp:TextBox></td>
                </tr>
<%--                <tr>
                    <td>Topic:</td>
                    <td>
                        <asp:TextBox ID="TopicTextBox" runat="server" Text='<%# Bind("Topic")%>' Width="500" /></td>
                    </td>
                </tr>--%>
                <tr>
                    <td>Description:</td>
                    <td>
                        <asp:TextBox ID="SubTextBox" runat="server" Text='<%# Bind("SubTopic")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Action:</td>
                    <td><asp:TextBox ID="ActionTextBox" runat="server" Text='<%# Bind("Action")%>' Width="500" /></td>
                </tr>
                <tr>
                    <td>Responsable:</td>
                    <td><asp:DropDownList ID="RespDropDownList" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="RespDropDownList_SelectedIndexChanged" OnDataBound="RespDropDownList_DataBound"/>
                             <asp:ListItem Text="(Select the responsable)" Value="" />
                        </asp:DropDownList><td><asp:TextBox ID="HiddenResponsableTextbox" runat="server" Visible="false" Text='<%# Bind("Responsable") %>'></asp:TextBox></td>
                    </td>
                </tr>
                <tr>
                    <td>Due Date:</td>
                  <td>                                                 
                        <asp:TextBox ID="DueDateTextbox" runat="server" Text='<%# Bind("DueDate")%>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DueDateTextbox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateNeeded" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DueDateTextbox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="DueDateTextbox" ControlExtender="meeDateNeeded" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
                <tr>
                    <td>Date Completed:</td>
                       <td>
                            <asp:TextBox ID="CompletedDateTextbox" runat="server" Text='<%# Bind("DateCompleted")%>' />
                            <asp:Image runat="server" ID="Image1" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="CompletedDateTextbox" PopupButtonID="Image1" />
                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="CompletedDateTextbox" PromptCharacter="_" />
                            <asp:MaskedEditValidator ID="Maskededitvalidator1" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="CompletedDateTextbox" ControlExtender="MaskedEditExtender1" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                        </td>
                </tr>
                <tr>
                    <td>Notes:</td>
                    <td>
                           <asp:GridView ID="gvNotes" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" AutoGenerateDeleteButton="true" OnRowDeleting="gvNotes_RowDeleting"
                            CellPadding="4" ForeColor="#333333"
                            Font-Size="10px" DataSourceID="sdsNotes">
                             <Columns>
<%--                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:BoundField DataField="NotesID" HeaderText="Note ID" SortExpression="NotesID" />
                                <asp:BoundField DataField="Note" HeaderText="Note" SortExpression="Note" />
                                <asp:BoundField DataField="DatePosted" HeaderText="Date Posted" SortExpression="DatePosted" DataFormatString="{0:d}" ApplyFormatInEditMode="true" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Notes Entered. 
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
<%--                        <asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes")%>' TextMode="MultiLine" Rows="5" Width="500" />--%>
                    </td>
                </tr>
                <tr><td>New Note:</td><td><asp:TextBox ID="NewNoteTextbox" runat="server" Width="500px"/></td></tr>
                <tr>
                    <td>Item Status:</td>
                    <td>
                        <asp:DropDownList ID="ItemStatusDropDown" runat="server" AutoPostBack="true" AppendDataBoundItems="true" 
                            SelectedValue='<%# Bind("ItemStatus")%>' DataTextField="ItemStatus" DataSourceID="sdsItemStatuses" >
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
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
        </asp:FormView>
            <table><tr><td>
        Filter by: </td><td><asp:Label ID="Label1" Text="Team" runat="server" /></td>
                <td><asp:DropDownList runat="server" DataSourceID="sdsTeamFilter" ID="TeamFilterDropdown" OnLoad="TeamFilterDropdown_Load" AppendDataBoundItems="true" AutoPostBack="true">
                    <asp:ListItem Text="(no filter)" Value="" />
                    <asp:ListItem Text="Individual" Value="16" />
                    </asp:DropDownList></td><td><asp:Label ID="Label2" Text="Responsable" runat="server" /></td>
                <td><asp:DropDownList runat="server" ID="ResponsableFilterDropdown" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="sdsResponsable" DataTextField="MemberName" DataValueField="MemberName">
                    <asp:ListItem Text="(no filter)" Value="" />
                    </asp:DropDownList></td>
                <td><asp:Label ID="ItemStatusFilterLabel" runat="server" Text="Item Status" />
                    <asp:DropDownList ID="ItemStatusFilterDropDown" runat="server" DataSourceID="sdsItemStatus" AppendDataBoundItems="true" AutoPostBack="true" DataTextField="ItemStatus" 
                        DataValueField="ItemStatus">
                        <asp:ListItem Text="(no filter)" Value="" />
                    </asp:DropDownList></td>
                <td><asp:Label ID="Label3" Text="Search:" runat="server" /></td>
                <td><asp:TextBox runat="server" ID="TopicFilterTextbox" /></td>
                <td><asp:Button ID="SearchButton" runat="server" Text="Search" /></td>
                <td><asp:Button ID="ResetButton" runat="server" Text="Reset" OnClick="ResetButton_Click" CausesValidation="true" /></td>
            </tr></table>
        <asp:GridView ID="mastEdit" runat="server" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"
                HeaderStyle-CssClass="grid_Header" OnDataBound="mastEdit_DataBound"
                RowStyle-CssClass="grid_RowStyle" DefaultMode="Edit" DataKeyNames="MAST_ID" DataSourceID="sdsEdit"
                CellPadding="4" ForeColor="#333333"
                Font-Size="Large" PageSize="50" OnSelectedIndexChanged="mastEdit_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteButton" CommandName="Delete" ForeColor="Black" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this action item?');" />
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:CommandField ShowSelectButton="True" SelectText="Edit"/>
                    <asp:BoundField DataField="MAST_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="MAST_ID" />
                    <asp:BoundField DataField="DateCreated" HeaderText="Date Created" ReadOnly="true" SortExpression="DateCreated" DataFormatString="{0:d}" ApplyFormatInEditMode="true"/>
<%--                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />--%>
                    <asp:BoundField DataField="TeamName" HeaderText="Team" SortExpression="TeamName" />
<%--                    <asp:BoundField DataField="Topic" HeaderText="Topic" SortExpression="Topic" />--%>
                    <asp:BoundField DataField="SubTopic" HeaderText="Description" SortExpression="SubTopic" />
                    <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
                    <asp:BoundField DataField="Responsable" HeaderText="Responsable" SortExpression="Responsable" />
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate" DataFormatString="{0:d}" ApplyFormatInEditMode="true" />
                    <asp:BoundField DataField="DateCompleted" HeaderText="Date Completed" SortExpression="DateCompleted" DataFormatString="{0:d}" ApplyFormatInEditMode="true" />
                    <asp:BoundField DataField="ItemStatus" HeaderText="Item Status" SortExpression="ItemStatus" />
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
        </ContentTemplate>
   <%--     </asp:UpdatePanel>--%>
        <asp:SqlDataSource ID="sdsEdit" runat="server" FilterExpression="(TeamID = '{0}' or '{0}' = '-1') AND (Responsable = '{1}' or '{1}' = '-1') AND ((SubTopic LIKE '%{2}%' or '{2}' = '-1') OR (Action LIKE '%{3}%' or '{3}' = '-1')) AND (ItemStatus = '{4}' or '{4}' = '-1')"
        ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        DeleteCommand="update tblMasterActionItemTool set visible = 0 where MAST_ID = @MAST_ID">
            <FilterParameters>
                <asp:ControlParameter Name="TeamID" ControlID="TeamFilterDropdown" PropertyName="SelectedValue" DefaultValue="-1" />
                <asp:ControlParameter Name="Responsable" ControlID="ResponsableFilterDropdown" PropertyName="SelectedValue" DefaultValue="-1" />
                <asp:ControlParameter Name="Description" ControlID="TopicFilterTextbox" PropertyName="Text" DefaultValue="-1" />
                <asp:ControlParameter Name="Action" ControlID="TopicFilterTextbox" PropertyName="Text" DefaultValue="-1" />
                <asp:ControlParameter Name="ItemStatus" ControlID="ItemStatusFilterDropDown" PropertyName="SelectedValue" DefaultValue="-1" />
            </FilterParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsTeamFilter" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsInsert" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        SelectCommand="SELECT * FROM [tblMasterActionItemTool] WHERE MAST_ID = @ID"
        UpdateCommand="UPDATE [tblMasterActionItemTool]
        SET [TeamID] = @TeamID, 
        [TeamName] = @TeamName,
        [SubTopic] = @SubTopic,
        [Action] = @Action,
        [Responsable] = @Responsable,
        [DueDate] = @DueDate,
        [DateCompleted] = @DateCompleted,
        [ItemStatus] = @ItemStatus
        WHERE MAST_ID = @MAST_ID">
        <UpdateParameters>
            <asp:Parameter Name="Name" />
<%--            <asp:Parameter Name="Topic" />--%>
            <asp:Parameter Name="TeamID" />
            <asp:Parameter Name="TeamName" />
            <asp:Parameter Name="SubTopic" />
            <asp:Parameter Name="Action" />
            <asp:Parameter Name="Responsable" />
            <asp:Parameter Name="DueDate" Type="DateTime" />
            <asp:Parameter Name="DateCompleted" Type="DateTime" />
            <asp:Parameter Name="ItemStatus" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="mastEdit" PropertyName="SelectedValue" />
        </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsResponsable" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        SelectCommand="SELECT * FROM tblMembers ORDER BY MemberName"></asp:SqlDataSource>
<%--     WHERE MemberID <> 28--%>
    <asp:SqlDataSource ID="sdsItemStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        SelectCommand="SELECT * FROM tblItemStatuses"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsNotes" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        SelectCommand="SELECT * FROM tblNotes JOIN tblMasterActionItemTool ON tblMasterActionItemTool.MAST_ID = tblNotes.MAST_ID WHERE tblNotes.MAST_ID = @ID AND tblNotes.Visible = 1 ORDER BY tblNotes.DatePosted">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="mastEdit" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
 <%--   <asp:SqlDataSource ID="sdsTeams" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
SelectCommand="SELECT * FROM tblTeams JOIN tblTeamMembership ON tblTeams.TeamID = tblTeamMembership.TeamID JOIN tblMembers ON tblTeamMembership.MemberName = tblMembers.MemberUserName WHERE tblTeamMembership.MemberName = @Username ORDER BY TeamName">
<SelectParameters><asp:SessionParameter Name="Username" SessionField="Username" /></SelectParameters>
</asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="sdsItemStatus" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        SelectCommand="SELECT * FROM tblItemStatuses" />
    </asp:Content>

