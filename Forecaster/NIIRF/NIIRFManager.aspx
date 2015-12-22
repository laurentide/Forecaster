<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="NIIRFManager.aspx.vb" Inherits="Forecaster.NIIRFManager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Inventory Item Request Form</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <Triggers>
           <asp:PostBackTrigger ControlID="niirfInsert" />
          </Triggers>
        <ContentTemplate>
        <asp:FormView ID="niirfInsert" runat="server" DefaultMode="Edit" DataKeyNames="NIIRF_ID" DataSourceID="sdsInsert" OnDataBound="niirfInsert_DataBound">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>ID:</td>
                    <td>
                        <asp:Label ID="MASTIDLabel" runat="server" Text='<%# Eval("NIIRF_ID")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Short Description:</td>
                    <td>
                        <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Long Description:</td>
                    <td>
                        <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription")%>' Width="500" />
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
                    </td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td>
                        <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Cost (CND$):</td>
                    <td>
                        <asp:TextBox ID="CostTextBox" runat="server" Text='<%# Bind("Cost")%>' Width="500" />
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
                        <asp:TextBox ID="OriginatorTextBox" runat="server" Text='<%# Bind("Originator")%>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td><asp:RadioButtonList ID="StateList" runat="server" SelectedValue='<%# Bind("State")%>' RepeatDirection="Horizontal">
                        <asp:ListItem ID="StateNew" runat="server" Value="0" Text="New" GroupName="State" AutoPostBack="true" />
                        <asp:ListItem ID="StateUsed" runat="server" Value="1" Text="Used" GroupName="State" AutoPostBack="true" />
                    </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td>Set as Reorder?:</td>
                    <td><asp:RadioButtonList runat="server" ID="ReorderList" SelectedValue='<%# Bind("Reorder")%>' OnSelectedIndexChanged="ReorderList_SelectedIndexChanged" AutoPostBack="true"
                        RepeatDirection="Horizontal">
                        <asp:ListItem ID="ReorderYes" runat="server" Value="0" Text="Yes" GroupName="Reorder" AutoPostBack="true"/>
                        <asp:ListItem ID="ReorderNo" runat="server" Value="1" Text="No" GroupName="Reorder" AutoPostBack="true"/>
                    </asp:RadioButtonList></td>
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
                    <td><asp:RadioButtonList runat="server" ID="StockInvestmentList" OnSelectedIndexChanged="StockInvestmentList_SelectedIndexChanged"
                        Visible="false" AutoPostBack="true" RepeatDirection="Horizontal" SelectedValue='<%# Bind("StockInvestment")%>'>                    
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
                <td>Status:</td>
                <td>
                    <asp:DropDownList ID="StatusDropDown" runat="server"  AppendDataBoundItems="true"  DataSourceID="sdsStatus" DataValueField="StatusID" DataTextField="Status" 
                        SelectedValue='<%# Bind("StatusID")%>' CausesValidation="true" AutoPostBack="true">
                        <asp:ListItem Text="(Select the status)" Value="" />
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
            <asp:GridView ID="MASTGridView" runat="server" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" DataSourceID="sdsNIIRF" OnSelectedIndexChanged="MASTGridView_SelectedIndexChanged"
                HeaderStyle-CssClass="grid_Header" DataKeyNames="NIIRF_ID" DefaultMode="Edit" RowStyle-CssClass="grid_RowStyle" CellPadding="4" ForeColor="#333333" Font-Size="10px" PageSize="50">
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
    </asp:UpdatePanel>
<asp:SqlDataSource ID="sdsNIIRF" runat="server" ConnectionString="<%$ ConnectionStrings:NIIRFConnectionString %>"
    SelectCommand="SELECT * FROM [NIIRF] WHERE Visible = 1"
    DeleteCommand="update NIIRF set visible = 0 where NIIRF_ID = @NIIRF_ID">
</asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsInsert" runat="server" 
        ConnectionString="<%$ ConnectionStrings:NIIRFConnectionString %>"
        SelectCommand="SELECT * FROM [NIIRF]
                       WHERE [NIIRF_ID] = @ID"
        UpdateCommand="UPDATE [NIIRF] SET
            [ShortDescription] = @ShortDescription,
            [LongDescription] = @LongDescription,
            [SupplierDescription] = @SupplierDescription,
            [SupplierProductNumber] = @SupplierProductNumber,
            [ListPrice] = @ListPrice,
            [ListPriceCurrency] = @ListPriceCurrency,
            [ProductCode] = @ProductCode,
            [Quantity] = @Quantity,
            [Cost] = @Cost,
            [Date] = @Date,
            [Originator] = @Originator,
            [OriginalOrder] = @OriginalOrder,
            [OriginalPO] = @OriginalPO,
            [Justification] = @Justification,
            [BusinessReason] = @BusinessReason,
            [StockInvestment] = @StockInvestment,
            [NoExplain] = @NoExplain,
            [InitialInvestment] = @InitialInvestment,
            [SourcedFrom] = @SourcedFrom,
            [LeadTime] = @LeadTime,
            [Reorder] = @Reorder,
            [State] = @State,
            [StatusID] = @StatusID
            WHERE [NIIRF_ID] = @NIIRF_ID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="MASTGridView" PropertyName="SelectedValue" />
        </SelectParameters>
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
            <asp:Parameter Name="Date" Type="DateTime" />
            <asp:Parameter Name="Originator" />
            <asp:Parameter Name="OriginalOrder" />
            <asp:Parameter Name="OriginalPO" />
            <asp:Parameter Name="Justification" />
            <asp:Parameter Name="BusinessReason" />
            <asp:Parameter Name="StockInvestment" />
            <asp:Parameter Name="NoExplain" />
            <asp:Parameter Name="InitialInvestment" />
            <asp:Parameter Name="SourcedFrom" />
            <asp:Parameter Name="Reorder" />
            <asp:Parameter Name="State" />
            <asp:Parameter Name="StatusID"/>
        </UpdateParameters>
        </asp:SqlDataSource>
       <asp:SqlDataSource ID="sdsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:NIIRFConnectionString %>"
        SelectCommand="select * from tblStatuses order by Statusid">
   </asp:SqlDataSource>
</asp:Content>