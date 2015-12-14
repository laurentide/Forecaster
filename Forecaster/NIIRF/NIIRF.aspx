<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="NIIRF.aspx.vb" Inherits="Forecaster.NIIRF" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Inventory Item Request Form</h2>
        <asp:ScriptManager ID="ScriptManager" runat="server" />
       <Triggers>
           <asp:PostBackTrigger ControlID="frmInsert" />
       </Triggers>
        <ContentTemplate>
        <asp:FormView ID="frmInsert" AutoPostBack="True" runat="server" DefaultMode="Insert" DataSourceID="sdsInsert">
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
                        <asp:DropDownList ID="CurrencyDropDownList" runat="server" AutoPostBack="true" AppendDataBoundItems="true" SelectedValue='<%# Bind("ListPriceCurrency")%>'>
                            <asp:ListItem Text="CND" Value="0" />
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
                    <td>State:</td>
                    <td>
                        <asp:RadioButton ID="StateNew" runat="server" Text="New" GroupName="State" AutoPostBack="true" OnCheckedChanged="StateNew_CheckedChanged"/>
                        <asp:RadioButton ID="StateUsed" runat="server" Text="Used" GroupName="State" AutoPostBack="true" OnCheckedChanged="StateNew_CheckedChanged" />
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
                    <td><asp:Label ID="OriginalOrderLabel" runat="server" Text="Original Order & Original P.O.#:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="OriginalOrderTextBox" runat="server" Text='<%# Bind("OriginalOrder")%>' Width="200" Visible="false" /><asp:Label ID="blah" runat="server" Text=" " /><asp:TextBox ID="OriginalPOTextBox" runat="server" Text='<%# Bind("OriginalPO")%>' Width="200" Visible="false"/></td>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="JustificationLabel" runat="server" text="Justification:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="JustificationTextBox" runat="server" Text='<%# Bind("Justification")%>' Width="500" Visible="false" /></td>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="BusinessReasonLabel" runat="server" Text="Please explain the busniess reason for the additional stock:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="BuisnessReasonTextBox" runat="server" Text='<%# Bind("BusinessReason")%>' Width="500" Visible="false" /></td>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="StockInvestmentLabel" runat="server" Text="Our stock investment target is &quot;turns&quot; * &quot;margin&quot; = 1.0.<br />Will this stock meet this?:" Visible="false"/></td>
                    <td>
                        <asp:RadioButton ID="StockInvestmentYes" runat="server" Text="Yes" GroupName="StockInvestment" AutoPostBack="true" OnCheckedChanged="StockInvestmentYes_CheckedChanged" Visible="false"/>
                        <asp:RadioButton ID="StockInvestmentNo" runat="server" Text="No" GroupName="StockInvestment" AutoPostBack="true" OnCheckedChanged="StockInvestmentYes_CheckedChanged" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="NoExplainLabel" runat="server" Text="If no, explain:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="NoExplainTextBox" runat="server" Text='<%# Bind("NoExplain")%>' Width="500" Visible="false" /></td>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="InitialInvestmentLabel" runat="server" Text="What is the initial investment?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="InitialInvestmentTextBox" runat="server" Text='<%# Bind("InitialInvestment")%>' Width="500" Visible="false"/></td>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="SourcedFromLabel" runat="server" Text="Where is this sourced from?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="SourcedTextBox" runat="server" Text='<%# Bind("SourcedFrom")%>' Width="500" Visible="false"/></td>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="LeadTimeLabel" runat="server" Text="What is the lead time from factory?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="LeadTimeTextBox" runat="server" Text='<%# Bind("LeadTime")%>' Width="500" Visible="false"/></td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" ValidationGroup="Insert" />
                    </td>
                </tr> 
            </table>
        </InsertItemTemplate>
        </asp:FormView>
    </ContentTemplate>
    <asp:SqlDataSource ID="sdsInsert" runat="server" OnInserted="sdsInsert_Inserted"
        ConnectionString="<%$ ConnectionStrings:NIIRFConnectionString %>"
        InsertCommand="INSERT INTO [NIIRF]
           ([ShortDescription]
           ,[LongDescription]
           ,[SupplierDescription]
           ,[SupplierProductNumber]
           ,[ListPrice]
           ,[ListPriceCurrency]
           ,[ProductCode]
           ,[Quantity]
           ,[Cost]
           ,[Date]
           ,[Originator]
           ,[OriginalOrder]
           ,[OriginalPO]
           ,[Justification]
           ,[BusinessReason]
           ,[NoExplain]
           ,[InitialInvestment]
           ,[SourcedFrom]
           ,[LeadTime])
     VALUES
           (@ShortDescription
           ,@LongDescription
           ,@SupplierDescription
           ,@SupplierProductNumber
           ,@ListPrice
           ,@ListPriceCurrency
           ,@ProductCode
           ,@Quantity
           ,@Cost
           ,@Date
           ,@Originator
           ,@OriginalOrder
           ,@OriginalPO
           ,@Justification
           ,@BusinessReason
           ,@NoExplain
           ,@InitialInvestment
           ,@SourcedFrom
           ,@LeadTime)
        select @ID = @@IDENTITY">
        <InsertParameters>
            <asp:Parameter Name="ShortDescription" />
            <asp:Parameter Name="LongDescription" />
            <asp:Parameter Name="SupplierDescription" />
            <asp:Parameter Name="SupplierProductNumber" />
            <asp:Parameter Name="ListPrice" />
            <asp:Parameter Name="ListPriceCurrency" />
            <asp:Parameter Name="ProductCode" />
            <asp:Parameter Name="Quantity" />
            <asp:Parameter Name="Cost" />
            <asp:Parameter Name="Date" />
            <asp:Parameter Name="Originator" />
            <asp:Parameter Name="OriginalOrder" />
            <asp:Parameter Name="OriginalPO" />
            <asp:Parameter Name="Justification" />
            <asp:Parameter Name="BusinessReason" />
            <asp:Parameter Name="NoExplain" />
            <asp:Parameter Name="InitialInvestment" />
            <asp:Parameter Name="SourcedFrom" />
            <asp:Parameter Name="LeadTime" />
            <asp:Parameter Name="ID" Direction="Output" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>