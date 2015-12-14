<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="NIIRF.aspx.vb" Inherits="Forecaster.NIIRF" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Inventory Item Request Form</h2>
        <asp:ScriptManager ID="ScriptManager" runat="server" />
       <Triggers>
           <asp:PostBackTrigger ControlID="niirfInsert" />
       </Triggers>
        <ContentTemplate>
        <asp:FormView ID="niirfInsert" AutoPostBack="True" runat="server" DefaultMode="Insert">
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>Short Description:</td>
                    <td>
                        <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Long Description:</td>
                    <td>
                        <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Supplier Description:</td>
                    <td>
                        <asp:TextBox ID="SupplierDescriptionTextBox" runat="server" Text='<%# Bind("SupplierDescription")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Supplier Product Number:</td>
                    <td>
                        <asp:TextBox ID="SupplierProductNumberTextBox" runat="server" Text='<%# Bind("SupplierProductNumber")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>List Price:</td>
                    <td>
                        <asp:TextBox ID="ListPriceTextBox" runat="server" Text='<%# Bind("ListPrice")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>List Price Currency:</td>
                    <td>
                        <asp:DropDownList ID="CurrencyDropDownList" runat="server" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem Text="CAN" Value="0" />
                            <asp:ListItem Text="USD" Value="1" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Product Code:</td>
                    <td>
                        <asp:TextBox ID="ProductCodeTextBox" runat="server" Text='<%# Bind("ProductCode")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Cost (CND$):</td>
                    <td>
                        <asp:TextBox ID="CostTextBox" runat="server" Text='<%# Bind("Cost")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Original Order & Original P.O.#:</td>
                    <td>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("OriginalOrder")%>' Width="200" /><asp:Label ID="blah" runat="server" Text=" " /><asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("OriginalPO")%>' Width="200" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Date:</td>
                   <td>                                                 
                        <asp:TextBox ID="DateTextbox" runat="server" Text='<%# Bind("Date")%>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DateTextbox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeDateNeeded" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DateTextbox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="DateTextbox" ControlExtender="meeDateNeeded" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a due date" ControlToValidate="DateTextbox" />                       
                    </td>
                </tr>
                <tr>
                    <td>Originator:</td>
                    <td>
                        <asp:TextBox ID="OriginatorTextBox" runat="server" Text='<%# Bind("Originator")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Set as Reorder?:</td>
                    <td>
                        <asp:RadioButton ID="ReorderYes" runat="server" Text="Yes" GroupName="Reorder" AutoPostBack="true" OnCheckedChanged="ReorderYes_CheckedChanged"/>
                        <asp:RadioButton ID="ReorderNo" runat="server" Text="No" GroupName="Reorder" AutoPostBack="true" OnCheckedChanged="ReorderYes_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td>
                        <asp:RadioButton ID="StateNew" runat="server" Text="New" GroupName="State" AutoPostBack="true" OnCheckedChanged="StateNew_CheckedChanged"/>
                        <asp:RadioButton ID="StateUsed" runat="server" Text="Used" GroupName="State" AutoPostBack="true" OnCheckedChanged="StateNew_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>Please explain busniess reason for the additional stock:</td>
                    <td>
                        <asp:TextBox ID="BuisnessReasonTextBox" runat="server" Text='<%# Bind("BusinessReason")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Our stock investment target is "turns" * "margin" = 1.0. Will this stock meet this?:</td>
                    <td>
                        <asp:RadioButton ID="StockInvestmentYes" runat="server" Text="Yes" GroupName="StockInvestment" AutoPostBack="true" OnCheckedChanged="StockInvestmentYes_CheckedChanged"/>
                        <asp:RadioButton ID="StockInvestmentNo" runat="server" Text="No" GroupName="StockInvestment" AutoPostBack="true" OnCheckedChanged="StockInvestmentYes_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>What is the initial investment?:</td>
                    <td>
                        <asp:TextBox ID="InitialInvestmentTextBox" runat="server" Text='<%# Bind("InitialInvestment")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>Where is this sourced from?:</td>
                    <td>
                        <asp:TextBox ID="SourcedTextBox" runat="server" Text='<%# Bind("SourcedFrom")%>' Width="500" /></td>
                    </td>
                </tr>
                <tr>
                    <td>What is the lead time from factory?:</td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("LeadTime")%>' Width="500" /></td>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        </asp:FormView>
    </ContentTemplate>
    <asp:SqlDataSource ID="sdsInsert" runat="server">
    </asp:SqlDataSource>
</asp:Content>