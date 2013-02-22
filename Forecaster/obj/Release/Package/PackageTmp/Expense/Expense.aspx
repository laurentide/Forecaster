<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Expense.aspx.vb" Inherits="Forecaster.Expense" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="frmExpense" DefaultMode="Insert" DataKeyNames="ExpenseReportID" DataSourceID="sdsForm">
        <EditItemTemplate>
            <table>
                <tr>
                    <td></td>
                    <td>ExpenseReportID: <asp:Label ID="ExpenseReportIDLabel1" runat="server" Text='<%# Eval("ExpenseReportID") %>' /></td>
                </tr>
                <tr>
                    <td>DepartmentID:
                    </td>
                    <td>
                        <asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>EmployeeName:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>EmployeeDomainUser:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeDomainUserTextBox" runat="server" Text='<%# Bind("EmployeeDomainUser") %>' />
                    </td>
                </tr>
                <tr>
                    <td>EmployeeEmail:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeEmailTextBox" runat="server" Text='<%# Bind("EmployeeEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PaymentTypeID:
                    </td>
                    <td>
                        <asp:TextBox ID="PaymentTypeIDTextBox" runat="server" Text='<%# Bind("PaymentTypeID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ExpenseDate:
                    </td>
                    <td>
                        <asp:TextBox ID="ExpenseDateTextBox" runat="server" Text='<%# Bind("ExpenseDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>AdvanceAmount:
                    </td>
                    <td>
                        <asp:TextBox ID="AdvanceAmountTextBox" runat="server" Text='<%# Bind("AdvanceAmount") %>' />
                    </td>
                </tr>
                <tr>
                    <td>BusinessPurpose:
                    </td>
                    <td>
                        <asp:TextBox ID="BusinessPurposeTextBox" runat="server" Text='<%# Bind("BusinessPurpose") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ExchangeRate:
                    </td>
                    <td>
                        <asp:TextBox ID="ExchangeRateTextBox" runat="server" Text='<%# Bind("ExchangeRate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Paid:
                    </td>
                    <td>
                        <asp:CheckBox ID="PaidCheckBox" runat="server" Checked='<%# Bind("Paid") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>DepartmentID:
                    </td>
                    <td>
                        <asp:TextBox ID="DepartmentIDTextBox" runat="server" Text='<%# Bind("DepartmentID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>EmployeeName:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>EmployeeDomainUser:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeDomainUserTextBox" runat="server" Text='<%# Bind("EmployeeDomainUser") %>' />
                    </td>
                </tr>
                <tr>
                    <td>EmployeeEmail:
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeEmailTextBox" runat="server" Text='<%# Bind("EmployeeEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PaymentTypeID:
                    </td>
                    <td>
                        <asp:TextBox ID="PaymentTypeIDTextBox" runat="server" Text='<%# Bind("PaymentTypeID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ExpenseDate:
                    </td>
                    <td>
                        <asp:TextBox ID="ExpenseDateTextBox" runat="server" Text='<%# Bind("ExpenseDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>AdvanceAmount:
                    </td>
                    <td>
                        <asp:TextBox ID="AdvanceAmountTextBox" runat="server" Text='<%# Bind("AdvanceAmount") %>' />
                    </td>
                </tr>
                <tr>
                    <td>BusinessPurpose:
                    </td>
                    <td>
                        <asp:TextBox ID="BusinessPurposeTextBox" runat="server" Text='<%# Bind("BusinessPurpose") %>' />
                    </td>
                </tr>
                <tr>
                    <td>ExchangeRate:
                    </td>
                    <td>
                        <asp:TextBox ID="ExchangeRateTextBox" runat="server" Text='<%# Bind("ExchangeRate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Paid:
                    </td>
                    <td>
                        <asp:CheckBox ID="PaidCheckBox" runat="server" Checked='<%# Bind("Paid") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <table>
                <tr>
                    <td></td>
                    <td>ExpenseReportID: <asp:Label ID="ExpenseReportIDLabel" runat="server" Text='<%# Eval("ExpenseReportID") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>DepartmentID: <asp:Label ID="DepartmentIDLabel" runat="server" Text='<%# Bind("DepartmentID") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>EmployeeName: <asp:Label ID="EmployeeNameLabel" runat="server" Text='<%# Bind("EmployeeName") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>EmployeeDomainUser: <asp:Label ID="EmployeeDomainUserLabel" runat="server" Text='<%# Bind("EmployeeDomainUser") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>EmployeeEmail: <asp:Label ID="EmployeeEmailLabel" runat="server" Text='<%# Bind("EmployeeEmail") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>PaymentTypeID: <asp:Label ID="PaymentTypeIDLabel" runat="server" Text='<%# Bind("PaymentTypeID") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>ExpenseDate: <asp:Label ID="ExpenseDateLabel" runat="server" Text='<%# Bind("ExpenseDate") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>AdvanceAmount: <asp:Label ID="AdvanceAmountLabel" runat="server" Text='<%# Bind("AdvanceAmount") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>BusinessPurpose: <asp:Label ID="BusinessPurposeLabel" runat="server" Text='<%# Bind("BusinessPurpose") %>' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>ExchangeRate: <asp:Label ID="ExchangeRateLabel" runat="server" Text='<%# Bind("ExchangeRate") %>' /></td>
                </tr>
                <tr>
                    <td>Paid:
                    </td>
                    <td>
                        <asp:CheckBox ID="PaidCheckBox" runat="server" Checked='<%# Bind("Paid") %>' Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>

    <asp:GridView ID="gvExpenseReports" runat="server" AutoGenerateColumns="False" DataKeyNames="ExpenseReportID" DataSourceID="sdsExpenseReportGrid">
        <Columns>
            <asp:BoundField DataField="ExpenseReportID" HeaderText="ExpenseReportID" InsertVisible="False" ReadOnly="True" SortExpression="ExpenseReportID" />
            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
            <asp:BoundField DataField="EmployeeDomainUser" HeaderText="EmployeeDomainUser" SortExpression="EmployeeDomainUser" />
            <asp:BoundField DataField="EmployeeEmail" HeaderText="EmployeeEmail" SortExpression="EmployeeEmail" />
            <asp:BoundField DataField="PaymentTypeID" HeaderText="PaymentTypeID" SortExpression="PaymentTypeID" />
            <asp:BoundField DataField="ExpenseDate" HeaderText="ExpenseDate" SortExpression="ExpenseDate" />
            <asp:BoundField DataField="AdvanceAmount" HeaderText="AdvanceAmount" SortExpression="AdvanceAmount" />
            <asp:BoundField DataField="BusinessPurpose" HeaderText="BusinessPurpose" SortExpression="BusinessPurpose" />
            <asp:BoundField DataField="ExchangeRate" HeaderText="ExchangeRate" SortExpression="ExchangeRate" />
            <asp:CheckBoxField DataField="Paid" HeaderText="Paid" SortExpression="Paid" />
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
                    FROM tblExpenseReports"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDetailsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="SELECT tblExpenseDetails.*, tblExpenseCategories.Category
                     FROM tblExpenseCategories RIGHT JOIN tblExpenseDetails ON tblExpenseCategories.CategoryID = tblExpenseDetails.CategoryID
                     ORDER BY tblExpenseDetails.ExpenseDate desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsExpenseReportGrid" runat="server" ConnectionString="<%$ ConnectionStrings:ExpenseReportConnectionString %>"
        SelectCommand="SELECT * 
                    FROM tblExpenseReports"></asp:SqlDataSource>
</asp:Content>
