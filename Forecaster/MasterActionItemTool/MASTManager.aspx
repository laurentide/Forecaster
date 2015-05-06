<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="MASTManager.aspx.vb" Inherits="Forecaster.MASTManager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Master Action Item Tool</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
        <ContentTemplate>
            <asp:GridView ID="MASTGridView" runat="server" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" DataSourceID="sdsMAST"
                HeaderStyle-CssClass="grid_Header"
                RowStyle-CssClass="grid_RowStyle"
                CellPadding="4" ForeColor="#333333"
                Font-Size="10px" PageSize="50">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this request?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                    <asp:BoundField DataField="MAST_ID" HeaderText="MASTID" InsertVisible="False" ReadOnly="True" SortExpression="MAST_ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Topic" HeaderText="Topic" SortExpression="Topic" />
                    <asp:BoundField DataField="SubTopic" HeaderText="Sub Topic" SortExpression="SubTopic" />
                    <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
                    <asp:BoundField DataField="Responsable" HeaderText="Responsable" SortExpression="Responsable" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
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
<asp:SqlDataSource ID="sdsMAST" runat="server" ConnectionString="<%$ ConnectionStrings:MASTConnectionString %>"
    SelectCommand="SELECT * FROM tblMasterActionItemTool"></asp:SqlDataSource>
</asp:Content>