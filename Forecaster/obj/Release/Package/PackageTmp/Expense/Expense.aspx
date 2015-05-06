<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="Expense.aspx.vb" Inherits="Forecaster.Expense" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>New Expense Report</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView runat="server" ID="frmExpense" DefaultMode="Insert" DataKeyNames="ExpenseReportID" DataSourceID="sdsForm"
        OnItemInserted="frmExpense_ItemInserted"
        OnDataBound="frmExpense_DataBound"
        OnItemUpdated="frmExpense_ItemUpdated"
        OnItemInserting="frmExpense_ItemInserting"
        OnItemUpdating="frmExpense_ItemUpdating">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>Expense Report ID:</td>
                    <td>
                        <asp:Label ID="ExpenseReportIDLabel" runat="server" Text='<%# Eval("ExpenseReportID") %>' /></td>
                </tr>
                <tr>
                    <td>Employee Name:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' Width="250" />
                    </td>
                </tr>
                <%--                <tr>
                    <td>EmployeeDomainUser:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeDomainUserTextBox" runat="server" Text='<%# Bind("EmployeeDomainUser") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Employee Email:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeEmailTextBox" runat="server" Text='<%# Bind("EmployeeEmail") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="update" ForeColor="Red" ErrorMessage="Email of requester required" ControlToValidate="EmployeeEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="update" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="EmployeeEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select your department)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="update" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
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
                <%--                <tr>
                    <td>Payment Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPaymentTypes" runat="server" DataSourceID="sdsPaymentTypes" AppendDataBoundItems="true" DataValueField="PaymentTypeID" DataTextField="PaymentType" SelectedValue='<%# Bind("PaymentTypeID")%>'>
                            <asp:ListItem Text="(Select your payment type)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="update" ForeColor="Red" ErrorMessage="Select your Payment Type" ControlToValidate="ddlPaymentTypes" />
                        <%--<asp:TextBox ID="PaymentTypeIDTextBox" runat="server" Text='<%# Bind("PaymentTypeID") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Expense Report Date:
                    </td>
                    <td>
                        <asp:TextBox ID="ExpenseDateTextBox" runat="server" Text='<%# Bind("ExpenseDate")%>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender" Format="MM/dd/yyyy" runat="server" TargetControlID="ExpenseDateTextBox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeExpenseDate" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ExpenseDateTextBox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator" ValidationGroup="update" runat="server" ForeColor="Red" ControlToValidate="ExpenseDateTextBox" ControlExtender="meeExpenseDate" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
                <%--                <tr>
                    <td>Advance Amount:
                    </td>
                    <td>
                        <asp:TextBox ID="AdvanceAmountTextBox" runat="server" Text='<%# Bind("AdvanceAmount") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Business Purpose:
                    </td>
                    <td>
                        <asp:TextBox ID="BusinessPurposeTextBox" runat="server" Text='<%# Bind("BusinessPurpose") %>' Width="500" />
                    </td>
                </tr>
                <tr>
                    <td>Exchange Rate<br />
                        (If expenses were incurred in the US):
                    </td>
                    <td>
                        <asp:TextBox ID="ExchangeRateTextBox" runat="server" Text='<%# Bind("ExchangeRate") %>' />
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">Enter an expense
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlExpenseCategories" runat="server" AutoPostBack="True" DataSourceID="sdsExpenseCategories" DataValueField="CategoryID" AppendDataBoundItems="true" DataTextField="label" OnSelectedIndexChanged="ddlExpenseCategories_SelectedIndexChanged">
                            <asp:ListItem Text="(Choose an expense category)" Value="" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">Expense details:</td>
                    <td>
                        <asp:Panel ID="panStd" runat="server" Visible="false">
                            <asp:FormView runat="server" ID="frmStdExpenseDetails" DefaultMode="Insert" OnItemInserting="frmStdExpenseDetails_ItemInserting" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px">
                                <InsertItemTemplate>
                                    <table>
                                        <tr>
                                            <td>Expense Date:
                                            </td>
                                            <td>
                                                <asp:TextBox Text='<%# Bind("ExpenseDate") %>' runat="server" ID="ExpenseDateTextBox2" />
                                                <asp:Image runat="server" ID="Calendar_scheduleDR2" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                                <asp:CalendarExtender ID="CalendarExtender2" Format="MM/dd/yyyy" runat="server" TargetControlID="ExpenseDateTextBox2" PopupButtonID="Calendar_scheduleDR2" />
                                                <asp:MaskedEditExtender ID="meeExpenseDate2" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ExpenseDateTextBox2" PromptCharacter="_" />
                                                <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="InsertDetails" runat="server" ForeColor="Red" ControlToValidate="ExpenseDateTextBox2" ControlExtender="meeExpenseDate2" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Type:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlExpenseTypes" runat="server" AppendDataBoundItems="false" AutoPostBack="true" OnSelectedIndexChanged="ddlExpenseTypes_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <%--<asp:TextBox Text='<%# Bind("ExpenseType") %>' runat="server" ID="ExpenseTypeTextBox" />--%>
                                            </td>
                                        </tr>
                                        <asp:Panel ID="panKM" runat="server">
                                            <tr>
                                                <td>Km:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Km") %>' runat="server" ID="KmTextBox" /></td>
                                            </tr>
                                            <tr>
                                                <td>Km Rate:
                                                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="http://lcl-adimp/_layouts/15/start.aspx#/SitePages/Kilometer%20Rate.aspx" Text="Intranet link" Target="_blank"></asp:HyperLink>
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Km_Rate") %>' runat="server" ID="Km_RateTextBox" /><asp:Button runat="server" ID="btnCalculate" OnClick="btnCalculate_Click" Text="Calculate Total" /></td>
                                            </tr>
                                        </asp:Panel>
                                        <tr>
                                            <td>Total Amount (incl. tax/tip):
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="ExpenseItemAmountTextBox" />
                                                <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="ExpenseItemAmountTextBox" ValidationGroup="InsertDetails" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="InsertDetails" ForeColor="Red" ErrorMessage="Amount required" ControlToValidate="ExpenseItemAmountTextBox" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" Text="Description" ID="DescriptionLabel" />
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="ExpenseItemDescriptionTextBox" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="InsertDetails" ForeColor="Red" ErrorMessage="Description required" ControlToValidate="ExpenseItemDescriptionTextBox" />
                                            </td>
                                        </tr>
                                        <asp:Panel ID="panExtras" runat="server">
                                            <tr>
                                                <td>Non-Taxable Extras:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("NonTaxableExtras")%>' runat="server" ID="Non_TaxableExtrasTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator5" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="Non_TaxableExtrasTextBox" ValidationGroup="InsertDetails" />
                                                </td>
                                            </tr>
                                        </asp:Panel>

                                        <%-- %><tr>
                                            <td>TaxCategory:
                                            </td>
                                            <td>
                                                <asp:TextBox Text='<%# Bind("TaxCategory") %>' runat="server" ID="TaxCategoryTextBox" /></td>
                                        </tr>--%>

                                        <asp:Panel ID="panTip" runat="server" Visible="false">
                                            <tr>
                                                <td>Tip:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Tip") %>' runat="server" ID="TipTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator6" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="TipTextBox" ValidationGroup="InsertDetails" />
                                                </td>
                                            </tr>
                                        </asp:Panel>

                                        <asp:Panel ID="panGuests" runat="server" Visible="false">
                                            <tr>
                                                <td>List of guests <br />(specify name, company and remarks):
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Guests")%>' runat="server" ID="GuestsTextbox" textmode="MultiLine" Rows="5" width="500"/></td>
                                            </tr>
                                        </asp:Panel>
                                        <asp:Panel ID="panLodging" runat="server">
                                            <tr>
                                                <td>Lodging Taxes:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Lodging_Taxes") %>' runat="server" ID="Lodging_TaxesTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator4" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="Lodging_TaxesTextBox" ValidationGroup="InsertDetails" />
                                                </td>

                                            </tr>
                                        </asp:Panel>
                                        <asp:Panel ID="panAir" runat="server">
                                            <tr>
                                                <td>XG: GST/HST Taxes:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("AGST") %>' runat="server" ID="AGSTTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator7" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="AGSTTextBox" ValidationGroup="InsertDetails" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>XQ: QST Taxes:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("AQST") %>' runat="server" ID="AQSTTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator8" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="AQSTTextBox" ValidationGroup="InsertDetails" />
                                                </td>
                                            </tr>
                                        </asp:Panel>
                                        <tr>
                                            <td>Province:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ProvinceDropDown" runat="server" DataSourceID="sdsProvinces" AppendDataBoundItems="true" DataValueField="ProvinceID" DataTextField="Province" SelectedValue='<%# Bind("ProvinceID")%>'>
                                                    <asp:ListItem Text="(Select your province)" Value="" />
                                                </asp:DropDownList>
                                                <%--<asp:TextBox runat="server" ID="ProvinceIDTextBox" Text='<%# Bind("ProvinceID")%>' /></td>--%>
                                        </tr>
                                        <%--                                        <tr>
                                            <td>Type of transaction:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="TransactionDropDown" runat="server" SelectedValue='<%# Bind("Transaction")%>'>
                                                    <asp:ListItem Text="Paid by employee" Value="Paid by employee" />
                                                    <asp:ListItem Text="Paid by company" Value="Paid by company" />
                                                </asp:DropDownList>
                                        </tr>--%>
                                        <tr>
                                            <td>Currency of transaction:
                                            </td>
                                            <td>
                                                <%--<asp:TextBox runat="server" Text='<%# Bind("Currency") %>' ID="CurrencyTextBox" />--%>
                                                <asp:DropDownList ID="CurrencyDropDown" runat="server" SelectedValue='<%# Bind("Currency")%>'>
                                                    <asp:ListItem Text="Canadian Funds" Value="CD$" />
                                                    <asp:ListItem Text="US Currency" Value="US$" />
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Department:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                                                    <asp:ListItem Text="(Select your department)" Value="" />
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="InsertDetails" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button runat="server" Text="Add expense line" CommandName="Insert" ID="InsertButton" CausesValidation="True" ValidationGroup="InsertDetails" />
                                                <%--&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />--%>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                            </asp:FormView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">Expenses List</td>
                    <td>
                        <asp:GridView ID="gvExpenseDetails" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle"
                            CellPadding="4" ForeColor="#333333"
                            Font-Size="10px" OnSelectedIndexChanged="gvExpenseDetails_SelectedIndexChanged" OnRowDataBound="gvExpenseDetails_RowDataBound" OnRowDeleting="gvExpenseDetails_RowDeleting">
                            <Columns>
                                <%--<asp:BoundField DataField="ExpenseDetailID" HeaderText="ExpenseDetailID" InsertVisible="False" ReadOnly="True" SortExpression="ExpenseDetailID" />--%>
                                <%--<asp:BoundField DataField="ExpenseReportID" HeaderText="ExpenseReportID" SortExpression="ExpenseReportID" />--%>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:TemplateField HeaderText="Category" SortExpression="CategoryID">
                                    <ItemTemplate>
                                        <asp:Label ID="CategoryLabel" runat="server" Text='<%# FindCategory(Eval("CategoryID")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type" SortExpression="ExpenseTypeID">
                                    <ItemTemplate>
                                        <asp:Label ID="TypeLabel" runat="server" Text='<%# FindType(Eval("ExpenseTypeID"))%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="ExpenseType" HeaderText="ExpenseType" SortExpression="ExpenseType" />--%>
                                <asp:BoundField DataField="ExpenseItemDescription" HeaderText="Description" SortExpression="ExpenseItemDescription" />
                                <asp:BoundField DataField="ExpenseDate" HeaderText="Date" SortExpression="ExpenseDate" DataFormatString="{0:d}" />
                                <%--<asp:BoundField DataField="Tip" HeaderText="Tip" SortExpression="Tip" />
                                <asp:BoundField DataField="Lodging_Taxes" HeaderText="Lodging_Taxes" SortExpression="Lodging_Taxes" />
                                <asp:BoundField DataField="NonTaxableExtras" HeaderText="NonTaxableExtras" SortExpression="NonTaxableExtras" />--%>
                                <asp:TemplateField HeaderText="Province" SortExpression="ProvinceID">
                                    <ItemTemplate>
                                        <asp:Label ID="ProvinceLabel" runat="server" Text='<%# findProvince(Eval("ProvinceID"))%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="TaxCategory" HeaderText="TaxCategory" SortExpression="TaxCategory" />--%>
                                <%--<asp:BoundField DataField="Transaction" HeaderText="Transaction" SortExpression="Transaction" />--%>
                                <asp:BoundField DataField="Currency" HeaderText="Currency" SortExpression="Currency" />
                                <asp:TemplateField HeaderText="Total Amount" SortExpression="ExpenseItemAmount">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Bind("ExpenseItemAmount", "{0:c}")%>' runat="server" ID="AmountTextbox" Style="text-align: right" />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Literal ID="AmountTotal" runat="server" />
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <%--                            <asp:BoundField DataField="AGST" HeaderText="AGST" SortExpression="AGST" />
                                <asp:BoundField DataField="AQST" HeaderText="AQST" SortExpression="AQST" />--%>
                                <%--                            <asp:BoundField DataField="Km" HeaderText="Km" SortExpression="Km" />
                                <asp:BoundField DataField="Km_Rate" HeaderText="Km Rate" SortExpression="Km_Rate" />--%>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No expense entered yet!
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
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                        <%--&nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                    </td>
                    <td></td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>Employee Name:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Name of requester required" ControlToValidate="EmployeeNameTextBox" />
                    </td>
                </tr>
                <%--                <tr>
                    <td>EmployeeDomainUser:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeDomainUserTextBox" runat="server" Text='<%# Bind("EmployeeDomainUser") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Employee Email:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeEmailTextBox" runat="server" Text='<%# Bind("EmployeeEmail") %>' Width="250" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Email of requester required" ControlToValidate="EmployeeEmailTextBox" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Enter a valid email" ControlToValidate="EmployeeEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <%--<asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />--%>
                        <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                            <asp:ListItem Text="(Select your department)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                    </td>
                </tr>
                <tr>
                    <td>Manager:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select your manager)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>
                </tr>
                <%--                <tr>
                    <td>Payment Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPaymentTypes" runat="server" DataSourceID="sdsPaymentTypes" AppendDataBoundItems="true" DataValueField="PaymentTypeID" DataTextField="PaymentType" SelectedValue='<%# Bind("PaymentTypeID")%>'>
                            <asp:ListItem Text="(Select your payment type)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Select your Payment Type" ControlToValidate="ddlPaymentTypes" />
                        <%--<asp:TextBox ID="PaymentTypeIDTextBox" runat="server" Text='<%# Bind("PaymentTypeID") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Expense Report Date:
                    </td>
                    <td>
                        <asp:TextBox ID="ExpenseDateTextBox" runat="server" Text='<%# Bind("ExpenseDate")%>' />
                        <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                        <asp:CalendarExtender ID="CalendarExtender" Format="MM/dd/yyyy" runat="server" TargetControlID="ExpenseDateTextBox" PopupButtonID="Calendar_scheduleDR" />
                        <asp:MaskedEditExtender ID="meeExpenseDate" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ExpenseDateTextBox" PromptCharacter="_" />
                        <asp:MaskedEditValidator ID="Maskededitvalidator" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="ExpenseDateTextBox" ControlExtender="meeExpenseDate" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                    </td>
                </tr>
                <%--                <tr>
                    <td>Advance Amount:
                    </td>
                    <td>
                        <asp:TextBox ID="AdvanceAmountTextBox" runat="server" Text='<%# Bind("AdvanceAmount") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Business Purpose:
                    </td>
                    <td>
                        <asp:TextBox ID="BusinessPurposeTextBox" runat="server" Text='<%# Bind("BusinessPurpose") %>' Width="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ForeColor="Red" ErrorMessage="Business Purpose required" ControlToValidate="BusinessPurposeTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>Exchange Rate<br />
                        (If expenses were incurred in the US):
                    </td>
                    <td>
                        <asp:TextBox ID="ExchangeRateTextBox" runat="server" Text='<%# Bind("ExchangeRate") %>' />
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold">Enter an expense
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlExpenseCategories" runat="server" AutoPostBack="True" DataSourceID="sdsExpenseCategories" DataValueField="CategoryID" AppendDataBoundItems="true" DataTextField="label" OnSelectedIndexChanged="ddlExpenseCategories_SelectedIndexChanged">
                            <asp:ListItem Text="(Choose an expense category)" Value="" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold">Expense details:</td>
                    <td>
                        <asp:Panel ID="panStd" runat="server" Visible="false">
                            <asp:FormView runat="server" ID="frmStdExpenseDetails" DefaultMode="Insert" OnItemInserting="frmStdExpenseDetails_ItemInserting" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px">
                                <InsertItemTemplate>
                                    <table>
                                        <tr>
                                            <td>Expense Date:
                                            </td>
                                            <td>
                                                <asp:TextBox Text='<%# Bind("ExpenseDate") %>' runat="server" ID="ExpenseDateTextBox2" />
                                                <asp:Image runat="server" ID="Calendar_scheduleDR2" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                                <asp:CalendarExtender ID="CalendarExtender2" Format="MM/dd/yyyy" runat="server" TargetControlID="ExpenseDateTextBox2" PopupButtonID="Calendar_scheduleDR2" />
                                                <asp:MaskedEditExtender ID="meeExpenseDate2" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ExpenseDateTextBox2" PromptCharacter="_" />
                                                <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="InsertDetails" runat="server" ForeColor="Red" ControlToValidate="ExpenseDateTextBox2" ControlExtender="meeExpenseDate2" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Type:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlExpenseTypes" runat="server" AppendDataBoundItems="false" AutoPostBack="true" OnSelectedIndexChanged="ddlExpenseTypes_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <%--<asp:TextBox Text='<%# Bind("ExpenseType") %>' runat="server" ID="ExpenseTypeTextBox" />--%>
                                            </td>
                                        </tr>
                                        <asp:Panel ID="panKM" runat="server">
                                            <tr>
                                                <td>Km:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Km") %>' runat="server" ID="KmTextBox" /></td>
                                            </tr>
                                            <tr>
                                                <td>Km Rate:
                                                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="http://lcl-adimp/_layouts/15/start.aspx#/SitePages/Kilometer%20Rate.aspx" Text="Intranet link" Target="_blank"></asp:HyperLink>
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Km_Rate") %>' runat="server" ID="Km_RateTextBox" /><asp:Button runat="server" ID="btnCalculate" OnClick="btnCalculate_Click" Text="Calculate Total" /></td>
                                            </tr>
                                        </asp:Panel>
                                        <tr>
                                            <td>Total Amount (incl. tax/tip):
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="ExpenseItemAmountTextBox" />
                                                <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="ExpenseItemAmountTextBox" ValidationGroup="InsertDetails" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="InsertDetails" ForeColor="Red" ErrorMessage="Amount required" ControlToValidate="ExpenseItemAmountTextBox" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" Text="Description" ID="DescriptionLabel" />
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="ExpenseItemDescriptionTextBox" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="InsertDetails" ForeColor="Red" ErrorMessage="Description required" ControlToValidate="ExpenseItemDescriptionTextBox" />
                                            </td>
                                        </tr>
                                        <asp:Panel ID="panExtras" runat="server">
                                            <tr>
                                                <td>Non-Taxable Extras:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("NonTaxableExtras")%>' runat="server" ID="Non_TaxableExtrasTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="Non_TaxableExtrasTextBox" ValidationGroup="InsertDetails" /></td>
                                            </tr>
                                        </asp:Panel>

                                        <%-- %><tr>
                                            <td>TaxCategory:
                                            </td>
                                            <td>
                                                <asp:TextBox Text='<%# Bind("TaxCategory") %>' runat="server" ID="TaxCategoryTextBox" /></td>
                                        </tr>--%>

                                        <asp:Panel ID="panTip" runat="server" Visible="false">
                                            <tr>
                                                <td>Tip:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Tip") %>' runat="server" ID="TipTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator2" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="TipTextBox" ValidationGroup="InsertDetails" /></td>
                                            </tr>
                                        </asp:Panel>
                                        <asp:Panel ID="panGuests" runat="server" visible="false">
                                            <tr>
                                                <td>List of guests  <br />(specify name, company and remarks):
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Guests")%>' runat="server" ID="GuestsTextbox" textmode="MultiLine" Rows="5" width="500" /></td>
                                            </tr>
                                        </asp:Panel>
                                        <asp:Panel ID="panLodging" runat="server">
                                            <tr>
                                                <td>Lodging Taxes:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("Lodging_Taxes") %>' runat="server" ID="Lodging_TaxesTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator9" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="Lodging_TaxesTextBox" ValidationGroup="InsertDetails" /></td>
                                                </td>
                                            </tr>
                                        </asp:Panel>
                                        <asp:Panel ID="panAir" runat="server">
                                            <tr>
                                                <td>XG: GST/HST Taxes:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("AGST") %>' runat="server" ID="AGSTTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator10" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="AGSTTextBox" ValidationGroup="InsertDetails" /></td>
                                            </tr>
                                            <tr>
                                                <td>XQ: QST Taxes:
                                                </td>
                                                <td>
                                                    <asp:TextBox Text='<%# Bind("AQST") %>' runat="server" ID="AQSTTextBox" />
                                                    <asp:RangeValidator ID="RangeValidator11" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="AQSTTextBox" ValidationGroup="InsertDetails" /></td>
                                            </tr>
                                        </asp:Panel>
                                        <tr>
                                            <td>Province:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ProvinceDropDown" runat="server" DataSourceID="sdsProvinces" AppendDataBoundItems="true" DataValueField="ProvinceID" DataTextField="Province" SelectedValue='<%# Bind("ProvinceID")%>'>
                                                    <asp:ListItem Text="(Select your province)" Value="" />
                                                </asp:DropDownList>
                                                <%--<asp:TextBox runat="server" ID="ProvinceIDTextBox" Text='<%# Bind("ProvinceID")%>' /></td>--%>
                                        </tr>
                                        <%--                                        <tr>
                                            <td>Type of transaction:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="TransactionDropDown" runat="server" SelectedValue='<%# Bind("Transaction")%>'>
                                                    <asp:ListItem Text="Paid by employee" Value="Paid by employee" />
                                                    <asp:ListItem Text="Paid by company" Value="Paid by company" />
                                                </asp:DropDownList>
                                        </tr>--%>
                                        <tr>
                                            <td>Currency of transaction:
                                            </td>
                                            <td>
                                                <%--<asp:TextBox runat="server" Text='<%# Bind("Currency") %>' ID="CurrencyTextBox" />--%>
                                                <asp:DropDownList ID="CurrencyDropDown" runat="server" SelectedValue='<%# Bind("Currency")%>'>
                                                    <asp:ListItem Text="Canadian Funds" Value="CD$" />
                                                    <asp:ListItem Text="US Currency" Value="US$" />
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Department:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DepartmentDropDown" runat="server" DataSourceID="sdsDepartments" AppendDataBoundItems="true" DataValueField="DepartmentID" DataTextField="DepartmentName" SelectedValue='<%# Bind("DepartmentID")%>'>
                                                    <asp:ListItem Text="(Select your department)" Value="" />
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="InsertDetails" ForeColor="Red" ErrorMessage="Select your department" ControlToValidate="DepartmentDropDown" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button runat="server" Text="Add expense line" CommandName="Insert" ID="InsertButton" CausesValidation="True" ValidationGroup="InsertDetails" />
                                                <%--&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />--%>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                            </asp:FormView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">Expenses List</td>
                    <td>
                        <asp:GridView ID="gvExpenseDetails" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle"
                            CellPadding="4" ForeColor="#333333"
                            Font-Size="10px" OnSelectedIndexChanged="gvExpenseDetails_SelectedIndexChanged" OnRowDeleting="gvExpenseDetails_RowDeleting">
                            <Columns>
                                <%--<asp:BoundField DataField="ExpenseDetailID" HeaderText="ExpenseDetailID" InsertVisible="False" ReadOnly="True" SortExpression="ExpenseDetailID" />--%>
                                <%--<asp:BoundField DataField="ExpenseReportID" HeaderText="ExpenseReportID" SortExpression="ExpenseReportID" />--%>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:TemplateField HeaderText="Category" SortExpression="CategoryID">
                                    <ItemTemplate>
                                        <asp:Label ID="CategoryLabel" runat="server" Text='<%# FindCategory(Eval("CategoryID")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type" SortExpression="ExpenseTypeID">
                                    <ItemTemplate>
                                        <asp:Label ID="TypeLabel" runat="server" Text='<%# FindType(Eval("ExpenseTypeID"))%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="ExpenseTypeID" HeaderText="Expense Type" SortExpression="ExpenseTypeID" />--%>
                                <asp:BoundField DataField="ExpenseItemDescription" HeaderText="Description" SortExpression="ExpenseItemDescription" />
                                <asp:BoundField DataField="ExpenseDate" HeaderText="Date" SortExpression="ExpenseDate" />
                                <%--<asp:BoundField DataField="Tip" HeaderText="Tip" SortExpression="Tip" />
                                <asp:BoundField DataField="Lodging_Taxes" HeaderText="Lodging_Taxes" SortExpression="Lodging_Taxes" />
                                <asp:BoundField DataField="NonTaxableExtras" HeaderText="NonTaxableExtras" SortExpression="NonTaxableExtras" />--%>
                                <asp:TemplateField HeaderText="Province" SortExpression="ProvinceID">
                                    <ItemTemplate>
                                        <asp:Label ID="ProvinceLabel" runat="server" Text='<%# findProvince(Eval("ProvinceID"))%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="TaxCategory" HeaderText="TaxCategory" SortExpression="TaxCategory" />--%>
                                <%--<asp:BoundField DataField="Transaction" HeaderText="Transaction" SortExpression="Transaction" />--%>
                                <asp:BoundField DataField="Currency" HeaderText="Currency" SortExpression="Currency" />
                                <asp:TemplateField HeaderText="Total Amount" SortExpression="ExpenseItemAmount">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Bind("ExpenseItemAmount", "{0:c}")%>' runat="server" ID="AmountTextbox" Style="text-align: right" />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Literal ID="AmountTotal" runat="server" />
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <%--                            <asp:BoundField DataField="AGST" HeaderText="AGST" SortExpression="AGST" />
                                <asp:BoundField DataField="AQST" HeaderText="AQST" SortExpression="AQST" />--%>
                                <%--                            <asp:BoundField DataField="Km" HeaderText="Km" SortExpression="Km" />
                                <asp:BoundField DataField="Km_Rate" HeaderText="Km Rate" SortExpression="Km_Rate" />--%>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No expense entered yet!
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
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" ValidationGroup="Insert" CommandName="Insert" Text="Save Expense Report" />
                        <%--&nbsp;<asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                    </td>
                    <td></td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvExpenseReports" runat="server" AutoGenerateColumns="False" DataKeyNames="ExpenseReportID" DataSourceID="sdsExpenseReportGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvExpenseReports_SelectedIndexChanged" OnSelectedIndexChanging="gvExpenseReports_SelectedIndexChanging" OnRowCommand="gvExpenseReports_RowCommand">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this Expense report?');" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                    <asp:LinkButton ID="btnAddToCard" runat="server" CausesValidation="false" Text="Show & Print Report" ForeColor="Black"
                        CommandName="ShowReport" CommandArgument='<%# Eval("ExpenseReportID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ExpenseReportID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ExpenseReportID" />
            <asp:BoundField DataField="ManagerName" HeaderText="Manager" SortExpression="ManagerName" />
            <asp:BoundField DataField="ExpenseDate" HeaderText="Expense Date" SortExpression="ExpenseDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="shortBusiness" HeaderText="Business Purpose" SortExpression="shortBusiness" />
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="EmployeeDomainUser" HeaderText="EmployeeDomainUser" SortExpression="EmployeeDomainUser" />
            <%--<asp:BoundField DataField="EmployeeEmail" HeaderText="Employee Email" SortExpression="EmployeeEmail" />--%>
            <%--<asp:BoundField DataField="AdvanceAmount" HeaderText="Advance Amount" SortExpression="AdvanceAmount" />--%>
            <%--<asp:BoundField DataField="PaymentType" HeaderText="Payment Type" SortExpression="PaymentType" />--%>
            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:c}" />
            <%--<asp:BoundField DataField="ExchangeRate" HeaderText="Exchange Rate" SortExpression="ExchangeRate" />--%>
            <asp:CheckBoxField DataField="Paid" HeaderText="Paid" SortExpression="Paid" />
            <asp:BoundField DataField="PaidDate" HeaderText="PaidDate" SortExpression="PaidDate" DataFormatString="{0:d}" />
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
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="SELECT * 
                    FROM tblExpenseReports
                    where Visible = 1 and ExpenseReportID=@ExpenseReportID"
        InsertCommand="INSERT INTO [ExpenseReport].[dbo].[tblExpenseReports]
           ([DepartmentID]
           ,[EmployeeName]
           ,[EmployeeDomainUser]
           ,[EmployeeEmail]
           ,[ExpenseDate]
           ,[AdvanceAmount]
           ,[BusinessPurpose]
           ,[ExchangeRate]
           ,[Paid]
           ,[ManagerID])
     VALUES
           (@DepartmentID
           ,@EmployeeName
           ,@EmployeeDomainUser
           ,@EmployeeEmail
           ,@ExpenseDate
           ,@AdvanceAmount
           ,@BusinessPurpose
           ,@ExchangeRate
           ,@Paid
           ,@ManagerID);
        select @ID = @@IDENTITY"
        UpdateCommand="UPDATE [ExpenseReport].[dbo].[tblExpenseReports]
   SET [DepartmentID] = @DepartmentID
      ,[EmployeeName] = @EmployeeName
      ,[EmployeeEmail] = @EmployeeEmail
      ,[ExpenseDate] = @ExpenseDate
      ,[AdvanceAmount] = @AdvanceAmount
      ,[BusinessPurpose] = @BusinessPurpose
      ,[ExchangeRate] = @ExchangeRate
      ,[ManagerID] = @ManagerID
 WHERE ExpenseReportID = @ExpenseReportID"
        OnInserted="sdsForm_Inserted">
        <SelectParameters>
            <asp:ControlParameter Name="ExpenseReportID" ControlID="gvExpenseReports" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="DepartmentID" />
            <asp:Parameter Name="EmployeeName" />
            <asp:SessionParameter Name="EmployeeDomainUser" SessionField="Username" />
            <asp:Parameter Name="EmployeeEmail" />
            <%--<asp:Parameter Name="PaymentTypeID" />--%>
            <asp:Parameter Name="ExpenseDate" />
            <asp:Parameter Name="AdvanceAmount" DefaultValue="0" />
            <asp:Parameter Name="BusinessPurpose" />
            <asp:Parameter Name="ExchangeRate" DefaultValue="0" />
            <asp:Parameter Name="Paid" DefaultValue="false" />
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="ID" Direction="Output" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="DepartmentID" />
            <asp:Parameter Name="EmployeeName" />
            <asp:Parameter Name="EmployeeEmail" />
            <%--<asp:Parameter Name="PaymentTypeID" />--%>
            <asp:Parameter Name="ExpenseDate" />
            <asp:Parameter Name="AdvanceAmount" DefaultValue="0" />
            <asp:Parameter Name="BusinessPurpose" />
            <asp:Parameter Name="ExchangeRate" DefaultValue="0" />
            <asp:Parameter Name="ManagerID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDetailsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="SELECT tblExpenseDetails.*, tblExpenseCategories.Category
                     FROM tblExpenseCategories RIGHT JOIN tblExpenseDetails ON tblExpenseCategories.CategoryID = tblExpenseDetails.CategoryID
                     ORDER BY tblExpenseDetails.ExpenseDate desc"
        DeleteCommand="update tblexpensereports set visible = 0 where expensereportID = @ExpenseReportID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStdDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="SELECT tblExpenseDetails.*, tblExpenseCategories.Category
                     FROM tblExpenseCategories RIGHT JOIN tblExpenseDetails ON tblExpenseCategories.CategoryID = tblExpenseDetails.CategoryID
                     ORDER BY tblExpenseDetails.ExpenseDate desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsExpenseReportGrid" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="SELECT *, left(businesspurpose,25) as shortBusiness
                    FROM tblExpenseReports 
               left join (select a.expensereportid, sum(ExpenseItemAmount * CASE WHEN currency = 'US$' THEN exchangerate ELSE 1 END) as total 
                           from  tblExpenseDetails a inner join tblexpensereports b on a.expensereportid = b.expensereportid group by a.expensereportid) as a
                      on tblExpenseReports.expensereportid = a.expensereportid
               left join tblManagers
                      on tblExpenseReports.managerid = tblManagers.managerid
               left join tblPayDates
                      on tblexpensereports.paiddateid = tblPayDates.paiddateid
              where visible = 1
                   and EmployeeDomainUser = @Username
               order by tblExpenseReports.ExpenseReportID desc"
        DeleteCommand="Update tblexpensereports set visible = 0 where expensereportID = @ExpenseReportID">
        <SelectParameters>
            <asp:SessionParameter Name="Username" SessionField="Username" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="select * from tblDepartments order by departmentName"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsExpenseCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="select *,category + ' (' + Exemples + ')' as label from tblExpenseCategories order by Category"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsExpenseTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="select * from tblExpenseTypes where CategoryID = @CategoryID">
        <SelectParameters>
            <asp:Parameter Name="CategoryID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsProvinces" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="select * from tblProvinceRates order by Province"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPaymentTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="select * from tblPaymentTypes order by PaymentType"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="select * from tblManagers order by managername"></asp:SqlDataSource>
</asp:Content>
