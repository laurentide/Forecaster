<%@ Page Title="Segments and Customers" Language="vb" MasterPageFile="~/FunnelSite.Master" AutoEventWireup="false" CodeBehind="InventorySearch.aspx.vb" Inherits="Forecaster.InventorySearch" %>

<%@ Register Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" TagPrefix="RK" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>Inventory search</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:Panel ID="PanFilters" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table>
            <tr><td>Search Inv. # and Descriptions fields:</td><td><asp:TextBox ID="txtSearch" 
                    runat="server" Height="22px" Width="180px" />&nbsp;Use % for a wildcard search 
                (i.e ES%Valve will return ES 1-1/2&quot; Globe Valve)</td></tr>

            <tr><td>Product Code Family:</td><td>
                <asp:DropDownList ID="ddlProductCodeFamily" runat="server" 
                    DataSourceID="SqlDataSource2" DataTextField="A1FXTU" DataValueField="A1FXTU" OnSelectedIndexChanged="ddlProductCodeFamily_SelectedIndexChanged" AutoPostBack="true" />
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
                    SelectCommand="select distinct a1fxtu from Nomis.S1018252.NOMDBF95.FRA1REL4 WHERE A1FXTU <> '                         ' UNION SELECT '_ALL' order by a1fxtu">
                </asp:SqlDataSource>
                </td></tr>

            <tr><td>Product Code:</td><td>
                <asp:DropDownList ID="ddlProductCode" runat="server" 
                    DataSourceID="SqlDataSource3" DataTextField="PC" DataValueField="AQC5AA" />
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
                    SelectCommand="SELECT AQC5AA, AQC5AA + ' - ' + AQC6AA as PC FROM NOMIS.S1018252.NOMDBF95.PCDPHY01 AS PCDPHY01_1 INNER JOIN NOMIS.S1018252.NOMDBF95.FRA1REL4 AS FRA1REL4_1 ON a1c5aa = aqc5aa WHERE (aqaqnb = 1) AND (a1aqnb = 1) And (A1FXTU = @PCFamily or @PCFamily ='_All') UNION select '_ALL','_ALL' ORDER BY AQC5AA ">
                    <SelectParameters>
                           <asp:ControlParameter Name = "PCFamily" ControlID="ddlProductCodeFamily" DefaultValue = "_All" PropertyName ="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td></tr>
        </table>
    </ContentTemplate>
    </asp:UpdatePanel>
    <tr><td><asp:Button ID="btnFilter" runat="server" onclick="btnFilter_onClick" 
        Text="Search" /><asp:Button ID="btnClear" runat="server" 
        onclick="btnClear_onClick" Text="Clear Filters" /></td></tr>
    </asp:Panel>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" 
    AllowPaging="true" PageSize="50" AllowSorting="true" 
    Font-Size="8pt" Visible = "false">
<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
<Columns>
<asp:BoundField DataField="Inventory Number" HeaderText="Inventory Number" 
    SortExpression="Inventory Number" />
<asp:BoundField DataField="Warehouse Number" HeaderText="Warehouse Number" 
    SortExpression="Warehouse Number" />
<asp:BoundField DataField="Warehouse Name" HeaderText="Warehouse Name" 
    SortExpression="Warehouse Name" />
<asp:BoundField DataField="Description 1" HeaderText="Description 1" 
    SortExpression="Description 1" />
<asp:BoundField DataField="Description 2" HeaderText="Description 2" 
    SortExpression="Description 2" />
<%--<asp:BoundField DataField="Product Code Category" 
    HeaderText="Product Code Category" SortExpression="Product Code Category" />
<asp:BoundField DataField="Product Code Sub Category" 
    HeaderText="Product Code Sub Category" 
    SortExpression="Product Code Sub Category" />--%>
<asp:BoundField DataField="Product Code" HeaderText="Product Code" 
    SortExpression="Product Code" />
<%--<asp:BoundField DataField="Product Code Description" 
    HeaderText="Product Code Description" 
    SortExpression="Product Code Description" />--%>
<asp:BoundField DataField="Quantity on Hand" HeaderText="Quantity on Hand" 
    SortExpression="Quantity on Hand" />
<asp:BoundField DataField="Quantity on Order" HeaderText="Quantity on Order" 
    SortExpression="Quantity on Order" />
<asp:BoundField DataField="Quantity Back Ordered" 
    HeaderText="Quantity Back Ordered" SortExpression="Quantity Back Ordered" />
<asp:BoundField DataField="Quantity on Reserve" 
    HeaderText="Quantity on Reserve" SortExpression="Quantity on Reserve" />
<asp:BoundField DataField="Avg Cost" HeaderText="Avg Cost" 
    SortExpression="Avg Cost" DataFormatString="{0:c}" />
<asp:BoundField DataField="Long Description" HeaderText="Long Description" 
    ReadOnly="True" SortExpression="Long Description" />
<%--<asp:BoundField DataField="Dogs" HeaderText="Dogs" 
    ReadOnly="True" SortExpression="Dogs" />--%>
</Columns>
<EditRowStyle BackColor="#999999" />
<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
<SortedAscendingCellStyle BackColor="#E9E7E2" />
<SortedAscendingHeaderStyle BackColor="#506C8C" />
<SortedDescendingCellStyle BackColor="#FFFDF8" />
<SortedDescendingHeaderStyle BackColor="#6F8DAE" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * 
from tblInventory
where (upper([Inventory Number]) like '%' + upper(@Search) +'%' or upper([Description 1]) like '%' + upper(@Search) +'%' or upper([Description 2]) like '%' + upper(@Search) +'%' or upper([Long Description]) like '%' + upper(@Search) +'%')
and ([Product Code Category] = @PCFamily or @PCFamily = '_ALL')
and ([Product Code] = @PC or @PC = '_ALL')
order by [Product Code Category],[Product Code Sub Category],[product code]">
<SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" Name="Search" DefaultValue = "%" PropertyName="Text" /> 
<%--            <asp:SessionParameter sessionfield="dogs" Name="dogs" DefaultValue="nothing" Type="String" />--%>
            <asp:ControlParameter ControlID="ddlProductCodeFamily" Name="PCFamily" DefaultValue = "_ALL" PropertyName="SelectedValue" /> 
            <asp:ControlParameter ControlID="ddlProductCode" Name="PC" DefaultValue = "_ALL" PropertyName="SelectedValue" /> 
</SelectParameters>
</asp:SqlDataSource>
    


<%--    <asp:SqlDataSource ID="sdsDogs" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
    SelectCommand="select * From Nomis.dbo.tblDogsType"></asp:SqlDataSource>--%>
    


    <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" Charset="utf-8" ContentEncoding="windows-1250"
    EnableHyperLinks="True" ExportFileName="InventorySearch.xls" IncludeTimeStamp="True" PageSize="All" 
    Text="Export To Excel" GridViewID="Gridview1" />
<!--Author: Rajesh K, Copyright 2007 All rights reserved. Use this control at your own risk.  Author is not responsible for any defects or damages to your code.-->
</asp:Content>
