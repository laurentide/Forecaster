<%@ Page Title="Product Codes" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Sp_ProductCode.aspx.vb" Inherits="Forecaster.SP_ProductCode" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Product families forecast
    </h2>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="odsProducts" GroupItemCount="1" DataKeyNames="ForecastDetailID">
            <AlternatingItemTemplate>
                <%# AddGroupingRowIfcategoryHasChanged() %>
                <tr style="background-color: white; color: #284775">
                    <td><asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> </td>
                    <td style="text-align: left;"><asp:Label ID="ProductCategoryLabel" runat="server" Text='<%# Eval("TeamName") %>' /> </td>
                    <td><asp:Label ID="FY09_BudgetLabel" runat="server" Text='<%# Eval("FY09_Budget"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY09_ActualLabel" runat="server" Text='<%# Eval("FY09_Actual"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY10_BudgetLabel" runat="server" Text='<%# Eval("FY10_Budget"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY10_ActualLabel" runat="server" Text='<%# Eval("FY10_Actual"," {0:C0}") %>' /> </td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY11_ActualLabel" runat="server" Text='<%# Eval("FY11_Actual"," {0:C0}") %>' /> </td>
                    <td class="specialistCol"><asp:Label ID="Label1" runat="server" Text='<%# Eval("SpecialistBudget"," {0:C0}") %>' /> </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <%# AddGroupingRowIfcategoryHasChanged() %>
                <tr class="editrow">
                    <td><asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" /> <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        <td style="text-align: left;"><asp:Label ID="ProductCategoryLabel0" runat="server" Text='<%# Eval("TeamName") %>' /> </td>
                        <td><asp:Label ID="FY09_BudgetLabel0" runat="server" Text='<%# Eval("FY09_Budget"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="FY09_ActualLabel0" runat="server" Text='<%# Eval("FY09_Actual"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="FY10_BudgetLabel0" runat="server" Text='<%# Eval("FY10_Budget"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="FY10_ActualLabel0" runat="server" Text='<%# Eval("FY10_Actual"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="BudgetedTextBox" runat="server" Text='<%# eval("Budgeted"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="FY11_ActualLabel0" runat="server" Text='<%# Eval("FY11_Actual"," {0:C0}") %>' /> </td>
                        <td><asp:TextBox ID="SpecialistBudgetTextbox" runat="server" Text='<%# bind("SpecialistBudget"," {0:C0}") %>' /> </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <%# AddGroupingRowIfcategoryHasChanged() %>
                <tr style="background-color: #F7F6F3; color: #333333;">
                    <td><asp:Button ID="EditButton0" runat="server" CommandName="Edit" Text="Edit" /> </td>
                    <td style="text-align: left;"><asp:Label ID="ProductCategoryLabel2" runat="server" Text='<%# Eval("TeamName") %>' /> </td>
                    <td><asp:Label ID="FY09_BudgetLabel2" runat="server" Text='<%# Eval("FY09_Budget"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY09_ActualLabel2" runat="server" Text='<%# Eval("FY09_Actual"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY10_BudgetLabel2" runat="server" Text='<%# Eval("FY10_Budget"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY10_ActualLabel2" runat="server" Text='<%# Eval("FY10_Actual"," {0:C0}") %>' /> </td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel0" runat="server" Text='<%# Eval("Budgeted"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="FY11_ActualLabel2" runat="server" Text='<%# Eval("FY11_Actual"," {0:C0}") %>' /> </td>
                    <td class="specialistCol"><asp:Label ID="Label1" runat="server" Text='<%# Eval("SpecialistBudget"," {0:C0}") %>' /> </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" class="listviewtable">
                                <tr runat="server" class="listviewHeader">
                                    <th></th>
                                    <th runat="server">Product Category</th>
                                    <th runat="server">FY09 Budget</th>
                                    <th runat="server">FY09 Actual</th>
                                    <th runat="server">FY10 Budget</th>
                                    <th runat="server">FY10 Actual</th>
                                    <th runat="server">FY11 Budget</th>
                                    <th runat="server">FY11 Actual</th>
                                    <th runat="server">Specialist Budget</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                                <tfoot>
                                    <tr class="listviewFooter">
                                        <td colspan="4">Total </td>
                                        <td><asp:Literal ID="FY09Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="FY09Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="FY10Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="FY10Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="FY11Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="FY11Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="ManagerBudget" runat="server" /> </td>
                                        <td><asp:Literal ID="SpecialistBudget" runat="server" /> </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style=""></td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </p>
    <p>
        <asp:ObjectDataSource ID="odsProducts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Forecaster.getSalesmanbyProductTableAdapters.getSalesmanByProductTableAdapter" UpdateMethod="updatespecialistForecast">
            <SelectParameters>
                <asp:SessionParameter Name="User" SessionField="User" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="original_forecastdetailid" Type="Int32" />
                <asp:Parameter Name="specialistbudget" Type="Decimal" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    </p>
</asp:Content>
