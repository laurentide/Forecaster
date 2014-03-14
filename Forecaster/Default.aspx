<%@ Page Title="Home Page" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Forecaster._Default" %>

<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to The New Forecast Tool 
    </h2>
    <p>
        This program has been designed to help you forecast your sales for the new 
        fiscal year 2011.
    </p>

<%--    <h2>
        Summary of your sales results
    </h2>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="ObjectDataSource1" CellPadding="4" ForeColor="#333333" 
            GridLines="None" ShowFooter="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="teamname" HeaderText="Team Name" 
                    SortExpression="teamname" />
                <asp:BoundField DataField="productCategory" HeaderText="Product Category" 
                    SortExpression="productCategory" />
                <asp:BoundField DataField="Forecast" DataFormatString="{0:c}" HeaderText="Forecast" 
                    SortExpression="Forecast" ReadOnly="True" />
                <asp:BoundField DataField="Actual" DataFormatString="{0:c}" HeaderText="Actual" 
                    SortExpression="Actual" ReadOnly="True" />
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
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetData" 
            TypeName="Forecaster._getSummaryTableAdapters.getSummaryTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="User" SessionField="User" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </p>--%>
</asp:Content>
