<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="NIIRF.aspx.vb" Inherits="Forecaster.NIIRF" MaintainScrollPositionOnPostback="true"%>
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
        <asp:FormView ID="frmInsert" AutoPostBack="True" runat="server" DefaultMode="Insert" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound">
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>Short Description:</td>
                    <td>
                        <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Short Description Required" ControlToValidate="ShortDescriptionTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Long Description:</td>
                    <td>
                        <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Long Description Required" ControlToValidate="LongDescriptionTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Supplier Description:</td>
                    <td>
                        <asp:TextBox ID="SupplierDescriptionTextBox" runat="server" Text='<%# Bind("SupplierDescription")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Supplier Product Number:</td>
                    <td>
                        <asp:TextBox ID="SupplierProductNumberTextBox" runat="server" Text='<%# Bind("SupplierProductNumber")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>List Price:</td>
                    <td>
                        <asp:TextBox ID="ListPriceTextBox" runat="server" Text='<%# Bind("ListPrice")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="List Price Required" ControlToValidate="ListPriceTextBox" />
                        <asp:CompareValidator ID="CompareValidator3" runat="server" Operator="DataTypeCheck" Type="Double" ControlToValidate="ListPriceTextBox" 
                            ErrorMessage="Value must be a decimal number (dollar value)" />
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
                        <asp:TextBox ID="ProductCodeTextBox" runat="server" Text='<%# Bind("ProductCode")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Product Code Required" ControlToValidate="ProductCodeTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Quantity Required" ControlToValidate="QuantityTextBox" />
                        <asp:CompareValidator ID="CompareValidator1" runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="QuantityTextBox" 
                            ErrorMessage="Value must be a number" />
                    </td>
                </tr>
                <tr>
                    <td>Cost (CND$):</td>
                    <td>
                        <asp:TextBox ID="CostTextBox" runat="server" Text='<%# Bind("Cost")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Cost Required" ControlToValidate="CostTextBox" />
                        <asp:CompareValidator ID="CompareValidator2" runat="server" Operator="DataTypeCheck" Type="Double" ControlToValidate="CostTextBox" 
                            ErrorMessage="Value must be a decimal number (dollar value)" />
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Date Required" ControlToValidate="DateTextbox" />                       
                    </td>
                </tr>
                <tr>
                    <td>Originator:</td>
                    <td>
                        <asp:TextBox ID="OriginatorTextBox" runat="server" Text='<%# Bind("Originator")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Originator Required" ControlToValidate="OriginatorTextBox" />     
                    </td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td><asp:RadioButtonList ID="StateList" runat="server" SelectedValue='<%# Bind("State")%>' RepeatDirection="Horizontal">
                        <asp:ListItem ID="StateNew" runat="server" Value="0" Text="New" GroupName="State" AutoPostBack="true" />
                        <asp:ListItem ID="StateUsed" runat="server" Value="1" Text="Used" GroupName="State" AutoPostBack="true" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="State Required" ControlToValidate="StateList" />    
                    </td>
                </tr>
                <tr>
                    <td>Set as Reorder?:</td>
                    <td><asp:RadioButtonList runat="server" ID="ReorderList" SelectedValue='<%# Bind("Reorder")%>' OnSelectedIndexChanged="ReorderList_SelectedIndexChanged" AutoPostBack="true"
                        RepeatDirection="Horizontal">
                        <asp:ListItem ID="ReorderYes" runat="server" Value="0" Text="Yes" GroupName="Reorder" AutoPostBack="true"/>
                        <asp:ListItem ID="ReorderNo" runat="server" Value="1" Text="No" GroupName="Reorder" AutoPostBack="true"/>
                    </asp:RadioButtonList></td><asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Reorder Information Required" ControlToValidate="ReorderList" />
                </tr>
                <tr>
                    <td><asp:Label ID="OriginalOrderLabel" runat="server" Text="Original Order & Original P.O.#:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="OriginalOrderTextBox" runat="server" Text='<%# Bind("OriginalOrder")%>' Width="200" Visible="false" /><asp:Label ID="blah" runat="server" Text=" " /><asp:TextBox ID="OriginalPOTextBox" runat="server" Text='<%# Bind("OriginalPO")%>' Width="200" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="JustificationLabel" runat="server" text="Justification:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="JustificationTextBox" runat="server" Text='<%# Bind("Justification")%>' Width="500" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="BusinessReasonLabel" runat="server" Text="Please explain the busniess reason for the additional stock:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="BuisnessReasonTextBox" runat="server" Text='<%# Bind("BusinessReason")%>' Width="500" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="StockInvestmentLabel" runat="server" Text="Our stock investment target is &quot;turns&quot; * &quot;margin&quot; = 1.0.<br />Will this stock meet this?:" Visible="false"/></td>
                    <td><asp:RadioButtonList runat="server" ID="StockInvestmentList" SelectedValue='<%# Bind("StockInvestment")%>' OnSelectedIndexChanged="StockInvestmentList_SelectedIndexChanged" 
                        Visible="false" AutoPostBack="true" RepeatDirection="Horizontal">                    
                        <asp:ListItem ID="StockInvestmentYes" runat="server" Value="0" Text="Yes" GroupName="StockInvestment" AutoPostBack="true"/>
                        <asp:ListItem ID="StockInvestmentNo" runat="server" Value="1" Text="No" GroupName="StockInvestment" AutoPostBack="true"/>
                    </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td><asp:Label ID="NoExplainLabel" runat="server" Text="If no, explain:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="NoExplainTextBox" runat="server" Text='<%# Bind("NoExplain")%>' Width="500" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="InitialInvestmentLabel" runat="server" Text="What is the initial investment?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="InitialInvestmentTextBox" runat="server" Text='<%# Bind("InitialInvestment")%>' Width="500" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="SourcedFromLabel" runat="server" Text="Where is this sourced from?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="SourcedTextBox" runat="server" Text='<%# Bind("SourcedFrom")%>' Width="500" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="LeadTimeLabel" runat="server" Text="What is the lead time from factory?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="LeadTimeTextBox" runat="server" Text='<%# Bind("LeadTime")%>' Width="500" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" ValidationGroup="Insert" />
                    </td>
                </tr> 
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <table>
                <tr>
                    <td>ID:
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("NIIRF_ID")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Short Description:</td>
                    <td>
                        <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Short Description Required" ControlToValidate="ShortDescriptionTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Long Description:</td>
                    <td>
                        <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Long Description Required" ControlToValidate="LongDescriptionTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Supplier Description:</td>
                    <td>
                        <asp:TextBox ID="SupplierDescriptionTextBox" runat="server" Text='<%# Bind("SupplierDescription")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Supplier Product Number:</td>
                    <td>
                        <asp:TextBox ID="SupplierProductNumberTextBox" runat="server" Text='<%# Bind("SupplierProductNumber")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>List Price:</td>
                    <td>
                        <asp:TextBox ID="ListPriceTextBox" runat="server" Text='<%# Bind("ListPrice")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="List Price Required" ControlToValidate="ListPriceTextBox" />
                        <asp:CompareValidator ID="CompareValidator3" runat="server" Operator="DataTypeCheck" Type="Double" ControlToValidate="ListPriceTextBox" 
                            ErrorMessage="Value must be a decimal number (dollar value)" />
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
                        <asp:TextBox ID="ProductCodeTextBox" runat="server" Text='<%# Bind("ProductCode")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Product Code Required" ControlToValidate="ProductCodeTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Quantity Required" ControlToValidate="QuantityTextBox" />
                        <asp:CompareValidator ID="CompareValidator1" runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="QuantityTextBox" 
                            ErrorMessage="Value must be a number" />
                    </td>
                </tr>
                <tr>
                    <td>Cost (CND$):</td>
                    <td>
                        <asp:TextBox ID="CostTextBox" runat="server" Text='<%# Bind("Cost")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Cost Required" ControlToValidate="CostTextBox" />
                        <asp:CompareValidator ID="CompareValidator2" runat="server" Operator="DataTypeCheck" Type="Double" ControlToValidate="CostTextBox" 
                            ErrorMessage="Value must be a decimal number (dollar value)" />
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Date Required" ControlToValidate="DateTextbox" />                       
                    </td>
                </tr>
                <tr>
                    <td>Originator:</td>
                    <td>
                        <asp:TextBox ID="OriginatorTextBox" runat="server" Text='<%# Bind("Originator")%>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Originator Required" ControlToValidate="OriginatorTextBox" />     
                    </td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td><asp:RadioButtonList ID="StateList" runat="server" SelectedValue='<%# Bind("State")%>' RepeatDirection="Horizontal">
                        <asp:ListItem ID="StateNew" runat="server" Value="0" Text="New" GroupName="State" AutoPostBack="true" />
                        <asp:ListItem ID="StateUsed" runat="server" Value="1" Text="Used" GroupName="State" AutoPostBack="true" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="State Required" ControlToValidate="StateList" />    
                    </td>
                </tr>
                <tr>
                    <td>Set as Reorder?:</td>
                    <td><asp:RadioButtonList runat="server" ID="ReorderList" SelectedValue='<%# Bind("Reorder")%>' OnSelectedIndexChanged="ReorderList_SelectedIndexChanged" AutoPostBack="true"
                        RepeatDirection="Horizontal">
                        <asp:ListItem ID="ReorderYes" runat="server" Value="0" Text="Yes" GroupName="Reorder" AutoPostBack="true"/>
                        <asp:ListItem ID="ReorderNo" runat="server" Value="1" Text="No" GroupName="Reorder" AutoPostBack="true"/>
                    </asp:RadioButtonList></td><asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Reorder Information Required" ControlToValidate="ReorderList" />
                </tr>
                <tr>
                    <td><asp:Label ID="OriginalOrderLabel" runat="server" Text="Original Order & Original P.O.#:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="OriginalOrderTextBox" runat="server" Text='<%# Bind("OriginalOrder")%>' Width="200" Visible="false" /><asp:Label ID="blah" runat="server" Text=" " /><asp:TextBox ID="OriginalPOTextBox" runat="server" Text='<%# Bind("OriginalPO")%>' Width="200" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="JustificationLabel" runat="server" text="Justification:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="JustificationTextBox" runat="server" Text='<%# Bind("Justification")%>' Width="500" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="BusinessReasonLabel" runat="server" Text="Please explain the busniess reason for the additional stock:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="BuisnessReasonTextBox" runat="server" Text='<%# Bind("BusinessReason")%>' Width="500" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="StockInvestmentLabel" runat="server" Text="Our stock investment target is &quot;turns&quot; * &quot;margin&quot; = 1.0.<br />Will this stock meet this?:" Visible="false"/></td>
                    <td><asp:RadioButtonList runat="server" ID="StockInvestmentList" SelectedValue='<%# Bind("StockInvestment")%>' OnSelectedIndexChanged="StockInvestmentList_SelectedIndexChanged" 
                        Visible="false" AutoPostBack="true" RepeatDirection="Horizontal">                    
                        <asp:ListItem ID="StockInvestmentYes" runat="server" Value="0" Text="Yes" GroupName="StockInvestment" AutoPostBack="true"/>
                        <asp:ListItem ID="StockInvestmentNo" runat="server" Value="1" Text="No" GroupName="StockInvestment" AutoPostBack="true"/>
                    </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td><asp:Label ID="NoExplainLabel" runat="server" Text="If no, explain:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="NoExplainTextBox" runat="server" Text='<%# Bind("NoExplain")%>' Width="500" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="InitialInvestmentLabel" runat="server" Text="What is the initial investment?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="InitialInvestmentTextBox" runat="server" Text='<%# Bind("InitialInvestment")%>' Width="500" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="SourcedFromLabel" runat="server" Text="Where is this sourced from?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="SourcedTextBox" runat="server" Text='<%# Bind("SourcedFrom")%>' Width="500" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="LeadTimeLabel" runat="server" Text="What is the lead time from factory?:" Visible="false" /></td>
                    <td>
                        <asp:TextBox ID="LeadTimeTextBox" runat="server" Text='<%# Bind("LeadTime")%>' Width="500" Visible="false"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                    </td>
                </tr> 
            </table>
        </EditItemTemplate>
        </asp:FormView>
        <asp:GridView ID="gvNIIRF" runat="server" AutoGenerateColumns="False" DataKeyNames="NIIRF_ID" DataSourceID="sdsNIIRFGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvNIIRF_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this NIIRF item?');" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
            <asp:BoundField DataField="NIIRF_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="NIIRF_ID" />
            <asp:BoundField DataField="ShortDescription" HeaderText="Short Description" SortExpression="ShortDescription" />
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
    <asp:SqlDataSource ID="sdsInsert" runat="server" OnInserted="sdsInsert_Inserted" OnUpdated="sdsInsert_Updated"
        ConnectionString="<%$ ConnectionStrings:NIIRFConnectionString %>"
        SelectCommand="SELECT * FROM [NIIRF] where NIIRF_ID=@ID" 
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
           ,[StockInvestment]
           ,[NoExplain]
           ,[InitialInvestment]
           ,[SourcedFrom]
           ,[LeadTime]  
           ,[Visible]         
           ,[Reorder]
           ,[State]
           ,[StatusID])
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
           ,@StockInvestment
           ,@NoExplain
           ,@InitialInvestment
           ,@SourcedFrom
           ,@LeadTime
           ,1           
           ,@Reorder
           ,@State
           ,1)
        select @ID = @@IDENTITY"
        UpdateCommand="UPDATE [NIIRF].[dbo].[NIIRF]
                   SET [ShortDescription] = @ShortDescription
                      ,[LongDescription] = @LongDescription
                      ,[SupplierDescription] = @SupplierDescription
                      ,[SupplierProductNumber] = @SupplierProductNumber
                      ,[ListPrice] = @ListPrice
                      ,[ListPriceCurrency] = @ListPriceCurrency
                      ,[ProductCode] = @ProductCode
                      ,[Quantity] = @Quantity
                      ,[Cost] = @Cost
                      ,[Date] = @Date
                      ,[Originator] = @Originator
                      ,[OriginalOrder] = @OriginalOrder
                      ,[OriginalPO] = @OriginalPO
                      ,[Justification] = @Justification
                      ,[BusinessReason] = @BusinessReason
                      ,[StockInvestment] = CASE WHEN @StockInvestment IS NULL THEN 1 ELSE @StockInvestment END
                      ,[NoExplain] = @NoExplain
                      ,[InitialInvestment] = @InitialInvestment
                      ,[SourcedFrom] = @SourcedFrom
                      ,[LeadTime]=@LeadTime
                      ,[Reorder] = @Reorder
                      ,[State] = @State
                 WHERE NIIRF_ID = @NIIRF_ID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvNIIRF" PropertyName="SelectedValue" />
        </SelectParameters>
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
            <asp:Parameter Name="StockInvestment" />
            <asp:Parameter Name="NoExplain" />
            <asp:Parameter Name="InitialInvestment" />
            <asp:Parameter Name="SourcedFrom" />
            <asp:Parameter Name="LeadTime" />
            <asp:Parameter Name="Visible" />            
            <asp:Parameter Name="Reorder" />
            <asp:Parameter Name="State" />
            <asp:Parameter Name="ID" Direction="Output" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
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
            <asp:Parameter Name="StockInvestment" />
            <asp:Parameter Name="NoExplain" />
            <asp:Parameter Name="InitialInvestment" />
            <asp:Parameter Name="SourcedFrom" />
            <asp:Parameter Name="LeadTime" />
            <asp:Parameter Name="Visible" />            
            <asp:Parameter Name="Reorder" />
            <asp:Parameter Name="State" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsNIIRFGrid" runat="server" ConnectionString="<%$ ConnectionStrings:NIIRFConnectionString %>" OnDeleting="sdsNIIRFGrid_Deleting"
        SelectCommand="SELECT *
                       FROM NIIRF
                       where RequesterUsername = @RequesterUsername
                       and visible = 1 
                       order by NIIRF_ID desc"
        DeleteCommand="update NIIRF set visible = 0 where NIIRF_ID = @NIIRF_ID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="RequesterUsername" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>