<%@ Page Title="Territory Code Totals" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Mg_Segments.aspx.vb" Inherits="Forecaster.Mg_Segments" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent"></asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <h2>
        Segment Forecast
    </h2>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="odsProducts" DatakeyNames="ForecastDetailID" OnItemDataBound="lvForecasts_OnItemDataBound">
            <AlternatingItemTemplate>
                <%# TestForEnterpriseNull(Eval("EnterpriseName"))%>
                    <td class="segment">
                        <%# SegmentLabel(Eval("EnterpriseName"))%>
                        <asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("TerritoryCode") %>' />
                    </td>
                    <td style="text-align: left;"><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /> </td>
                    <td><asp:Label ID="Two_Year_Ago_ActualLabel" runat="server" Text='<%# Eval("Two_Year_Ago_Actual","{0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_ActualLabel" runat="server" Text='<%# Eval("Last_Year_Actual","{0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted","{0:C0}") %>' /> </td>
                    <td><asp:Label ID="Current_Year_ActualLabel" runat="server" Text='<%# Eval("Current_Year_Actual","{0:C0}") %>' /> </td>
                    <td class="managerCol"><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget","{0:C0}") %>' /> </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <%# TestForEnterpriseNull(Eval("EnterpriseName"))%>
                     <td class="enterprise">
                        <%# SegmentLabel(Eval("EnterpriseName"))%>
                        <asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("TerritoryCode") %>' />
                    </td>
                    <td style="text-align: left;"class="customer" ><asp:Label ID="EnterpriseNameLabel1" runat="server" Text='<%# Eval("EnterpriseName") %>' /> </td>
                    <td><asp:Label ID="Two_Year_Ago_ActualLabel2" runat="server" Text='<%# Eval("Two_Year_Ago_Actual","{0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_ActualLabel2" runat="server" Text='<%# Eval("Last_Year_Actual","{0:C0}") %>' /> </td>
                    <td><asp:Label ID="Last_Year_BudgetLabel2" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel0" runat="server" Text='<%# Eval("Budgeted","{0:C0}") %>' /> </td>
                    <td><asp:Label ID="Current_Year_ActualLabel2" runat="server" Text='<%# Eval("Current_Year_Actual","{0:C0}") %>' /> </td>
                    <td class="managerCol"><asp:Label ID="Label2" runat="server" Text='<%# Eval("managerBudget","{0:C0}") %>' /> </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="segments" class="listviewtable">
                                <tr runat="server" class="listviewHeader">
                                    <th runat="server">TC</th>
                                    <th runat="server">EnterpriseName</th>
                                    <th runat="server">FY10 Actual</th>
                                    <th runat="server">FY11 Actual</th>
                                    <th runat="server">FY11 Budget</th>
                                    <th runat="server">FY12 Budget</th>
                                    <th runat="server">FY12 Actual</th>
                                    <th runat="server">Manager Budget</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                                <tfoot>
                                    <tr class="listviewFooter">
                                        <td colspan="2">Total </td>
                                        <td><asp:Literal ID="Two_Year_Ago_Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="Last_year_Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="Last_year_Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="Current_Year_Budget" runat="server" /> </td>
                                        <td><asp:Literal ID="Current_Year_Actual" runat="server" /> </td>
                                        <td><asp:Literal ID="ManagerBudget" runat="server" /> </td>
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
        <asp:ObjectDataSource ID="odsProducts" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"             
            TypeName="Forecaster.getForecastBySegments_MngTableAdapters.getForecastBySegments_MngTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="current_year" SessionField="current_year" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </p>
</asp:Content>
