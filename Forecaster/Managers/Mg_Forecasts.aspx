<%@ Page Title="Segments and Customers" Language="vb" MasterPageFile="~/Site.Master"
    AutoEventWireup="false" CodeBehind="Mg_Forecasts.aspx.vb" Inherits="Forecaster.Mg_Forecasts" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <h2>Forecast by Territory codes</h2>
    <p>Team
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
            DataTextField="TeamName" DataValueField="TeamID" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>"
            SelectCommand="SELECT * FROM [tblTeams] union select 0,'All',0"></asp:SqlDataSource>
    </p>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ListView ID="lvForecasts" runat="server" DataSourceID="odsgetForecastByTCS_Mng" DataKeyNames="EnterpriseID"
                OnItemDataBound="lvForecasts_OnItemDataBound">
                <AlternatingItemTemplate>
                    <%# AddGroupingRowIfTeamHasChanged() %> <%# TestForEnterpriseNull(Eval("EnterpriseName"), Eval("CustomerName"))%>
                    <%# EditButton(Eval("CustomerName")) %>
                    <asp:Button ID="CommandButton" runat="server" Text="Edit Forecast" CommandName="Select" CommandArgument='<%# Eval("EnterpriseID").tostring() + "," + Eval("TeamID").tostring() %>' OnCommand="CommandButton_OnSelect" /> </td>
                    <td class="segment"><%# SegmentLabel(Eval("EnterpriseName"))%><asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("TerritoryCode") %>' /> </td>
                    <td class="enterprise"><%# EnterpriseLabel(Eval("EnterpriseName"), Eval("CustomerName"))%><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /></td>
                    <td class="customer"><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' />
                    <td class="customer"><asp:Label ID="Label2" runat="server" Text='<%# Eval("NomisCustomerNum") %>' /></td>
                    <td><asp:Label ID="Two_Year_Ago_ActualLabel" runat="server" Text='<%# Eval("Two_Year_Ago_Actual","{0:c0}") %>' /></td>
                    <td><asp:Label ID="Last_Year_ActualLabel" runat="server" Text='<%# Eval("Last_Year_Actual","{0:c0}") %>' /></td>
                    <%# BudgetCol(Eval("CustomerName"))%><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                    <%# BudgetCol(Eval("CustomerName"))%><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted","{0:c0}") %>' /> </td>
                    <td><asp:Label ID="Current_Year_ActualLabel" runat="server" Text='<%# Eval("Current_Year_Actual","{0:c0}") %>' /></td>
                    <%# MngCol(Eval("CustomerName"))%><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget"," {0:C0}") %>' /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <%# AddGroupingRowIfTeamHasChanged() %>
                    <tr class="editrow">
                        <td><asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td />
                        <%--<td />--%>
                        <td style="text-align: left;"><asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("TerritoryCode") %>' /></td>
                        <td style="text-align: left;"><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /></td>
                        <td style="text-align: left;"><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' /></td>
                        <td style="text-align: left;"><asp:Label ID="Label3" runat="server" Text='<%# Eval("NomisCustomerNum") %>' /></td>
                        <td><asp:Label ID="Two_Year_Ago_ActualLabel" runat="server" Text='<%# Eval("Two_Year_Ago_Actual","{0:c0}") %>' /></td>
                        <td><asp:Label ID="Last_Year_ActualLabel" runat="server" Text='<%# Eval("Last_Year_Actual","{0:c0}") %>' /></td>
                        <td><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                        <td><asp:TextBox ID="BudgetedLabel" runat="server" Text='<%# Bind("Budgeted","{0:c0}") %>' /></td>
                        <td><asp:Label ID="Current_Year_ActualLabel" runat="server" Text='<%# Eval("Current_Year_Actual","{0:c0}") %>' /></td>
                        <td><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget"," {0:C0}") %>' /></td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table id="Table1" runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <%# AddGroupingRowIfTeamHasChanged() %> <%# TestForEnterpriseNull(Eval("EnterpriseName"), Eval("CustomerName"))%>
                    <%# EditButton(Eval("CustomerName")) %><%--<asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />--%>
                    <asp:Button ID="CommandButton" runat="server" Text="Edit Forecast" CommandName="Select" CommandArgument='<%# Eval("EnterpriseID").tostring() + "," + Eval("TeamID").tostring() %>' OnCommand="CommandButton_OnSelect" /> </td> 
                    <td class="segment"><%# SegmentLabel(Eval("EnterpriseName"))%><asp:Label ID="segmentNameLabel" runat="server" Text='<%# Eval("TerritoryCode") %>' /> </td>
                    <td class="enterprise"><%# EnterpriseLabel(Eval("EnterpriseName"), Eval("CustomerName"))%><asp:Label ID="EnterpriseNameLabel" runat="server" Text='<%# Eval("EnterpriseName") %>' /></td>
                    <td class="customer"><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' /></td>
                    <td class="customer"><asp:Label ID="Label2" runat="server" Text='<%# Eval("NomisCustomerNum") %>' />
                    <td><asp:Label ID="Two_Year_Ago_ActualLabel" runat="server" Text='<%# Eval("Two_Year_Ago_Actual","{0:c0}") %>' /></td>
                    <td><asp:Label ID="Last_Year_ActualLabel" runat="server" Text='<%# Eval("Last_Year_Actual","{0:c0}") %>' /></td>
                    <%# BudgetCol(Eval("CustomerName"))%><asp:Label ID="Last_Year_BudgetLabel" runat="server" Text='<%# Eval("Last_Year_Budget","{0:C0}") %>' /> </td>
                    <%# BudgetCol(Eval("CustomerName"))%><asp:Label ID="BudgetedLabel" runat="server" Text='<%# Eval("Budgeted","{0:c0}") %>' /> </td>
                    <td><asp:Label ID="Current_Year_ActualLabel" runat="server" Text='<%# Eval("Current_Year_Actual","{0:c0}") %>' /> </td>
                    <%# MngCol(Eval("CustomerName"))%><asp:Label ID="Label1" runat="server" Text='<%# Eval("managerBudget"," {0:C0}") %>' /></td> 
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table id="segments" class="listviewtable">
                        <tr class="listviewHeader">
                            <th />
                            <th>Territory Code</th>
                            <th>Customer Grouping</th>
                            <th>Customer Name</th>
                            <th>Cust#</th>
                            <th>FY10 Actual</th>
                            <th>FY11 Actual</th>
                            <th>FY11 Budget</th>
                            <th>FY12 Budget</th>
                            <th>FY12 Actual</th>
                            <th>Manager Budget</th>
                        </tr>
                        <tr id="itemPlaceholder" runat="server"></tr>
                        <tfoot>
                            <tr class="listviewFooter">
                                <td colspan="5">Total </td>
                                <td><asp:Literal ID="Two_Year_Ago_Actual" runat="server" /> </td>
                                <td><asp:Literal ID="Last_year_Actual" runat="server" /> </td>
                                <td><asp:Literal ID="Last_year_Budget" runat="server" /> </td>
                                <td><asp:Literal ID="Current_Year_Budget" runat="server" /> </td>
                                <td><asp:Literal ID="Current_Year_Actual" runat="server" /> </td>
                                <td><asp:Literal ID="ManagerBudget" runat="server" /> </td>
                        </tfoot>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:ObjectDataSource ID="odsGetPCGroupingByEnterprise" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="Forecaster.getPCGroupingByEnterprise_MngTableAdapters.getPCGroupingByEnterprise_MngTableAdapter"
        UpdateMethod="updateManagerForecast">
        <SelectParameters>
            <asp:SessionParameter Name="Current_year" SessionField="Current_Year" Type="Int32"
                DefaultValue="2011" />
            <asp:SessionParameter DefaultValue="" Name="enterpriseid" SessionField="EnterpriseID"
                Type="Int32" />
            <asp:SessionParameter DefaultValue="" Name="teamid" SessionField="TeamID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="original_forecastdetailid" Type="Int32" />
            <asp:Parameter Name="managerbudget" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsgetForecastByTCS_Mng" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="Forecaster.getForecastByTCS_MngTableAdapters.getforecastbyTCs_MngTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="Current_year" SessionField="Current_Year" Type="Int32"
                DefaultValue="2011" />
            <asp:ControlParameter ControlID="DropDownList1" Name="teamid" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%-- AJAX Stuff --%>
    <asp:ModalPopupExtender ID="modalpopupextender1" runat="server" TargetControlID="FakeTarget"
        PopupControlID="panEdit" PopupDragHandleControlID="panEdit" BackgroundCssClass="modalBackground" />
    <asp:Panel ID="panEdit" runat="server" CssClass="ModalWindow">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:GridView ID="EnterpriseDetails" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    DataKeyNames="forecastdetailid" DataSourceID="odsGetPCGroupingByEnterprise" ForeColor="#333333"
                    GridLines="None" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Style="text-align: left"
                    ShowFooter="True" OnRowDataBound="EnterpriseDetails_OnRowDataBound">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" BorderColor="Black" BorderStyle="Solid"
                        BorderWidth="1px" />
                    <Columns>
                        <asp:TemplateField HeaderText="Customer Grouping">
                            <ItemTemplate>
                                <asp:Label ID="lblEnterprise" runat="server" Text='<%#CheckIfEnterpriseExists(Eval("EnterpriseName").ToString())%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:CommandField ShowEditButton="True" />--%>
                        <asp:BoundField DataField="forecastdetailid" HeaderText="forecastdetailid" InsertVisible="False"
                            ReadOnly="True" SortExpression="forecastdetailid" Visible="False" />
                        <%--<asp:BoundField DataField="EnterpriseName" HeaderText="Customer Grouping" SortExpression="EnterpriseName" ReadOnly="True" />--%>
                        <asp:BoundField DataField="Productcategory" HeaderText="Product Categories" SortExpression="Productcategory"
                            ReadOnly="True" />
                        <asp:BoundField DataField="Two_Year_Ago_Actual" HeaderText="FY10 Actual" ReadOnly="True"
                            SortExpression="Two_Year_Ago_Actual" DataFormatString="{0:c0}" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="Last_Year_Actual" HeaderText="FY11 Actual" ReadOnly="True"
                            SortExpression="Last_Year_Actual" DataFormatString="{0:c0}" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="Last_Year_Budget" HeaderText="FY11 Budgeted" ReadOnly="True"
                            SortExpression="Last_Year_Budget" DataFormatString="{0:c0}" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="Budgeted" HeaderText="FY12 Budget" SortExpression="Budgeted"
                            ReadOnly="True" DataFormatString="{0:c0}" ItemStyle-HorizontalAlign="Right" />
                        <asp:TemplateField HeaderText="Manager Budget">
                            <ItemTemplate>
                                <asp:TextBox ID="txtManagerBudget" runat="server" Text='<%# Eval("ManagerBudget") %>'
                                    DataFormatString="{0:c0}" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" /><SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" /><SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="Update" /> <asp:Button
                    ID="btnCancel" runat="server" Text="Done" OnClick="refreshListView" /> <asp:Label
                        ID="lblnotification" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <asp:Button ID="FakeTarget" runat="server" Style="display: none;" />
</asp:Content>
