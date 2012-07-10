<%@ Page Title="Segments and Customers" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Customers.aspx.vb" Inherits="Forecaster.Customers" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Segments and Customers Forecast
    </h2>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="odsProducts" DataKeyNames="ForecastDetailID" OnItemCommand="ListView1_OnItemCommand">
            <AlternatingItemTemplate>
                <%# AddGroupingRowIfTeamHasChanged() %>
                <%# TestForEnterpriseNull(Eval("EnterpriseName"), Eval("CustomerName"))%>
                    <td><asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> </td>
                    <td><asp:Button ID="SetMngr" runat="server" CommandName="setMngr" Text="Mngr" /> </td>
                    <%--<td><asp:Button ID="SetSpec" runat="server" CommandName="setSpec" Text="Spec" /> </td>--%>
                    <td class="segment"> <%# SegmentLabel(Eval("EnterpriseName"))%> <asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("segmentName") %>' /></td>
                    <td class="enterprise"> <%# EnterpriseLabel(Eval("EnterpriseName"), Eval("CustomerName"))%><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /></td>
                    <td class="customer"><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' /></td>
                    <td><asp:Label ID="FY09_ActualLabel" runat="server" Text='<%# Eval("FY09_Actual","{0:c0}") %>' /></td>
                    <td><asp:Label ID="FY10_ActualLabel" runat="server" Text='<%# Eval("FY10_Actual","{0:c0}") %>' /></td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted","{0:c0}") %>' /> </td>
                    <td><asp:Label ID="FY11_ActualLabel" runat="server" Text='<%# Eval("FY11_Actual","{0:c0}") %>' /> </td>
                    <td class="managerCol"><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget"," {0:C0}") %>' /> </td>
                    <%--<td class="specialistCol"><asp:Label ID="Label2" runat="server" Text='<%# Eval("SpecialistBudget"," {0:C0}") %>' /> </td>--%>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <%# AddGroupingRowIfTeamHasChanged() %>
                <tr class="editrow">                    
                    <td><asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" /> <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" /> </td>
                    <td />
                    <%--<td />--%>
                    <td style="text-align:left;"><asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("segmentName") %>' /></td>
                    <td style="text-align:left;"><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /></td>
                    <td style="text-align:left;"><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' /></td>
                    <td><asp:Label ID="FY09_ActualLabel" runat="server" Text='<%# Eval("FY09_Actual","{0:c0}") %>' /></td>
                    <td><asp:Label ID="FY10_ActualLabel" runat="server" Text='<%# Eval("FY10_Actual","{0:c0}") %>' /></td>
                    <td><asp:TextBox ID="BudgetedLabel" runat="server" Text='<%# Bind("Budgeted","{0:c0}") %>' /> </td>
                    <td><asp:Label ID="FY11_ActualLabel" runat="server" Text='<%# Eval("FY11_Actual","{0:c0}") %>' /> </td>
                    <td><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget"," {0:C0}") %>' /> </td>
                    <%--<td><asp:Label ID="Label2" runat="server" Text='<%# Eval("SpecialistBudget"," {0:C0}") %>' /> </td>--%>
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
                <%# TestForEnterpriseNull(Eval("EnterpriseName"), Eval("CustomerName"))%>
                    <td><asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> </td>
                    <td><asp:Button ID="SetMngr" runat="server" CommandName="setMngr" Text="Mngr" /> </td>
                    <%--<td><asp:Button ID="SetSpec" runat="server" CommandName="setSpec" Text="Spec" /> </td>--%>
                    <td class="segment"> <%# SegmentLabel(Eval("EnterpriseName"))%> <asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("segmentName") %>' /></td>
                    <td class="enterprise"> <%# EnterpriseLabel(Eval("EnterpriseName"), Eval("CustomerName"))%><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /></td>
                    <td class="customer"><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' /></td>
                    <td><asp:Label ID="FY09_ActualLabel" runat="server" Text='<%# Eval("FY09_Actual","{0:c0}") %>' /></td>
                    <td><asp:Label ID="FY10_ActualLabel" runat="server" Text='<%# Eval("FY10_Actual","{0:c0}") %>' /></td>
                    <td class="budgetCol"><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted","{0:c0}") %>' /> </td>
                    <td><asp:Label ID="FY11_ActualLabel" runat="server" Text='<%# Eval("FY11_Actual","{0:c0}") %>' /> </td>
                    <td class="managerCol"><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget"," {0:C0}") %>' /> </td>
                    <%--<td class="specialistCol"><asp:Label ID="Label2" runat="server" Text='<%# Eval("SpecialistBudget"," {0:C0}") %>' /> </td>--%>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table id="segments" class="listviewtable">
                    <tr class="listviewHeader">
                        <th colspan="2" />
                        <%--<th />--%>
                        <th>Segment</th>
                        <th>Enterprise</th>
                        <th>Customer Name</th>
                        <th>FY09 Actual</th>
                        <th>FY10 Actual</th>
                        <th>FY11 Budget</th>
                        <th>FY11 Actual</th>
                        <th>Manager Budget</th>
                        <%--<th>Specialist Budget</th>--%>
                    </tr>
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                    <tfoot>
                        <tr class="listviewFooter">
                            <td colspan="5">Total </td>
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
            </LayoutTemplate>
        </asp:ListView>
    </p>
    <asp:ObjectDataSource ID="odsProducts" runat="server" 
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
    TypeName="Forecaster.getSegmentForecastByUserTableAdapters.getSegmentForecastByUserTableAdapter" 
    UpdateMethod="updateForecast">
        <SelectParameters>
            <asp:SessionParameter Name="User" SessionField="User" Type="String" />
        </SelectParameters>
        <UpdateParameters>
        <asp:Parameter Name="budgeted" Type="Decimal" />
        <asp:Parameter Name="Original_ForecastDetailID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
<asp:ScriptManager ID="ScriptManager" runat="server" />
</asp:Content>
