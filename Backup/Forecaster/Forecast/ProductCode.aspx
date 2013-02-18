<%@ Page Title="Product Codes" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="ProductCode.aspx.vb" Inherits="Forecaster.ProductCode" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>
        Product families forecast
    </h2>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="odsgetForecastByUser" GroupItemCount="1" DataKeyNames="ForecastDetailID" OnItemDataBound="lvForecasts_OnItemDataBound">
            <AlternatingItemTemplate>
                <%# AddGroupingRowIfTeamHasChanged() %>
                <tr style="background-color: white; color: #284775">
                    <td style="text-align: left;"><asp:Label ID="ProductCategoryLabel" runat="server" Text='<%# Eval("ProductCategory") %>' /> </td>
                    <td><asp:Label ID="Two_Year_Ago_ActualLabel" runat="server" Text='<%# Eval("Two_Year_Ago_Actual"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_ActualLabel" runat="server" Text='<%# Eval("Last_Year_Actual"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="Current_Year_ActualLabel" runat="server" Text='<%# Eval("Current_Year_Actual"," {0:C0}") %>' /> </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <%# AddGroupingRowIfTeamHasChanged() %>
                <tr class="editrow">
                        <td style="text-align: left;"><asp:Label ID="ProductCategoryLabel0" runat="server" Text='<%# Eval("ProductCategory") %>' /> </td>
                        <td><asp:Label ID="Two_Year_Ago_ActualLabel0" runat="server" Text='<%# Eval("Two_Year_Ago_Actual"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="Last_Year_ActualLabel0" runat="server" Text='<%# Eval("Last_Year_Actual"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                        <td><asp:Label ID="BudgetedTextBox" runat="server" Text='<%# Eval("Budgeted"," {0:C0}") %>' /> </td>
                        <td><asp:Label ID="Current_Year_ActualLabel0" runat="server" Text='<%# Eval("Current_Year_Actual"," {0:C0}") %>' /> </td>
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
                <%# AddGroupingRowIfTeamHasChanged() %>
                <tr style="background-color: #F7F6F3; color: #333333;">
                    <td style="text-align: left;"><asp:Label ID="ProductCategoryLabel2" runat="server" Text='<%# Eval("ProductCategory") %>' /> </td>
                    <td><asp:Label ID="Two_Year_Ago_ActualLabel2" runat="server" Text='<%# Eval("Two_Year_Ago_Actual"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_ActualLabel2" runat="server" Text='<%# Eval("Last_Year_Actual"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel0" runat="server" Text='<%# Eval("Budgeted"," {0:C0}") %>' /> </td>
                    <td><asp:Label ID="Current_Year_ActualLabel2" runat="server" Text='<%# Eval("Current_Year_Actual"," {0:C0}") %>' /> </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" class="listviewtable">
                                <tr runat="server" class="listviewHeader">
                                    <th runat="server">Product Category</th>
                                    <th runat="server">FY10 Actual</th>
                                    <th runat="server">FY11 Actual</th>
                                    <th runat="server">FY11 Budget</th>
                                    <th runat="server">FY12 Budget</th>
                                    <th runat="server">FY12 Actual</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                                <tfoot>
                                    <tr class="listviewFooter">
                                        <td colspan="1">Total </td>
                                        <td><asp:Literal ID="Two_Year_Ago_Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="Last_year_Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="Last_year_Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="Current_Year_Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="Current_Year_Actual" runat="server" /> </td>
                                        <%--<td><asp:Literal ID="ManagerBudget" runat="server" /> </td>--%>
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
        <asp:ObjectDataSource ID="odsgetForecastByUser" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="Forecaster._getForecastByUserTableAdapters.getForecastByUserTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="User" SessionField="User" Type="String" />
                <asp:SessionParameter DefaultValue="" Name="current_year" SessionField="current_year" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </p>
</asp:Content>
