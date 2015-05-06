﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="MasterActionItemTool.aspx.vb" Inherits="Forecaster.MasterActionItemTool" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Master Action Item Tool</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
       <Triggers>
           <asp:PostBackTrigger ControlID="mastInsert" />
       </Triggers>
        <ContentTemplate>
        <asp:FormView ID="mastInsert" runat="server" DefaultMode="Insert" DataKeyNames="MAST_ID" DataSourceID="sdsInsert" OnDataBound="mastInsert_DataBound">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>NERID:</td>
                            <td>
                                <asp:Label ID="MASTIDLABEL" runat="server" Text='<%# Eval("MAST_ID") %>' />
                            </td>
                        </tr>
                <tr>
                    <td>Name:</td>
                    <td>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Eval("Name")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Team(s):</td>
                    <td>
                        <asp:DropDownList ID="TeamsDropDownList" runat="server">
                            <asp:ListItem Text="(Choose team)" Value="" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Topic:</td>
                    <td>
                        <asp:TextBox ID="TopicTextBox" runat="server" Text='<%# Eval("Topic")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Sub-Topic:</td>
                    <td>
                        <asp:TextBox ID="SubTextBox" runat="server" Text='<%# Eval("SubTopic")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Action:</td>
                    <td><asp:TextBox ID="ActionTextBox" runat="server" Text='<%# Eval("Action")%>' Width="500" /></td>
                </tr>
                <tr>
                    <td>Responsable:</td>
                    <td><asp:TextBox ID="RespTextBox" runat="server" Text='<%# Eval("Responsable") %>' Width="500" /></td>
                </tr>
                <tr>
                    <td>Notes:</td>
                    <td>
                        <asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes")%>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>Name:</td>
                    <td>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Team(s):</td>
                    <td>
                        <asp:DropDownList ID="TeamsDropDownList" runat="server">
                            <asp:ListItem Text="(Choose team)" Value="" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Topic:</td>
                    <td>
                        <asp:TextBox ID="TopicTextBox" runat="server" Text='<%# Bind("Topic") %>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Sub-Topic:</td>
                    <td>
                        <asp:TextBox ID="SubTextBox" runat="server" Text='<%# Bind("SubTopic") %>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Action:</td>
                    <td><asp:TextBox ID="ActionTextBox" runat="server" Text='<%# Bind("Action") %>' Width="500" /></td>
                </tr>
                <tr>
                    <td>Responsable:</td>
                    <td><asp:TextBox ID="RespTextBox" runat="server" Text='<%# Bind("Responsable") %>' Width="500" /></td>
                </tr>
                <tr>
                    <td>Due Date:</td>
<%--                   <td>                                                 
                        <asp:TextBox ID="DueDateTextbox" runat="server" Text='<%# Bind("DueDate")%>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DueDateTextbox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateNeeded" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DueDateTextbox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="DueDateTextbox" ControlExtender="meeDateNeeded" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a due date" ControlToValidate="DueDateTextbox" />                       
                    </td>--%>
                </tr>
                <tr>
                    <td>Date Completed:</td>
<%--                       <td>
                            <asp:TextBox ID="CompletedDateTextbox" runat="server" Text='<%# Bind("CompletedDate")%>' />
                            <asp:Image runat="server" ID="Image1" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="CompletedDateTextbox" PopupButtonID="Image1" />
                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="CompletedDateTextbox" PromptCharacter="_" />
                            <asp:MaskedEditValidator ID="Maskededitvalidator1" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="CompletedDateTextbox" ControlExtender="MaskedEditExtender1" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a completed date" ControlToValidate="CompletedDateTextbox" />
                        </td>--%>
                </tr>
                <tr>
                    <td>Notes:</td>
                    <td>
                        <asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes")%>' TextMode="MultiLine" Rows="5" Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" ValidationGroup="Insert" />
                    </td>
                </tr>      
            </table>
            <asp:GridView ID="MASTGridView" runat="server" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnSelectedIndexChanged="MASTGridView_SelectedIndexChanged"
                HeaderStyle-CssClass="grid_Header" OnRowDeleting="MASTGridView_RowDeleting"
                RowStyle-CssClass="grid_RowStyle"
                CellPadding="4" ForeColor="#333333"
                Font-Size="10px" PageSize="50">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this request?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                    <asp:BoundField DataField="MAST_ID" HeaderText="MASTID" InsertVisible="False" ReadOnly="True" SortExpression="MAST_ID" />
                    <asp:BoundField DataField="DateCreated" HeaderText="Date Created" ReadOnly="true" SortExpression="DateCreated" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Topic" HeaderText="Topic" SortExpression="Topic" />
                    <asp:BoundField DataField="SubTopic" HeaderText="Sub Topic" SortExpression="SubTopic" />
                    <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
                    <asp:BoundField DataField="Responsable" HeaderText="Responsable" SortExpression="Responsable" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
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
        </InsertItemTemplate>
        </asp:FormView>
    </ContentTemplate>
    </asp:UpdatePanel>
<%--    <asp:SqlDataSource ID="sdsMAST" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
    SelectCommand="SELECT * FROM tblMasterActionItemTool"></asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="sdsInsert" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
        InsertCommand="INSERT INTO [tblMasterActionItemTool]
        ([DateCreated],
        [Name],
        [Topic],
        [SubTopic],
        [Action],
        [Responsable],
        [Notes])
     VALUES
        (getDate(),
        @Name,
        @Topic,
        @SubTopic,
        @Action,
        @Responsable,
        @Notes)"></asp:SqlDataSource>
</asp:Content>