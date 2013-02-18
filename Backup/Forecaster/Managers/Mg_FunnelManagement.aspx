<%@ Page Title="Funnel Management" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="Mg_FunnelManagement.aspx.vb" Inherits="Forecaster.Mg_FunnelManagement" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:ScriptManager runat="server" ID="sm" />
    <h3>Enter everything as LCLMTL followed by the person's Windows Username (for example: Ann Shea would be LCLMTL\AnnS)</h3>
    <h2>
        Team Members
    </h2>
    
            <asp:DropDownList ID="ddlTeams" runat="server" AutoPostBack="true" DataSourceID="SqlDataSource2" DataTextField="TeamName" DataValueField="TeamID"            />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
                SelectCommand="SELECT * FROM [tblTeams]"></asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"  DataKeyNames="PermissionID" EmptyDataText="There are no data records to display.">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            </Columns>
            </asp:GridView>
            <br />
            <asp:Textbox id="txtInsert" runat="server"/><asp:Button id ="btnInsert" runat="server" onclick ="btnInsert_onClick" Text="Insert" autopostback="false" />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
                DeleteCommand="DELETE FROM [tblPermissions] WHERE [PermissionID] = @PermissionID" 
                InsertCommand="INSERT INTO [tblPermissions] ([TeamID], [UserName]) VALUES (@TeamID, @UserName)" 
                ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
                SelectCommand="SELECT PermissionID,tblPermissions.UserName FROM tblPermissions INNER JOIN tblTeams ON tblPermissions.TeamID = tblTeams.TeamID WHERE (tblTeams.TeamID = @teamid) OR (@teamid = 0)" 
                UpdateCommand="UPDATE [tblPermissions] Set [UserName] = @UserName WHERE [PermissionID] = @PermissionID">
                <DeleteParameters>
                <asp:Parameter Name="PermissionID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                <asp:Parameter Name="TeamID" Type="Int32" />
                <asp:Parameter Name="UserName" Type="String" />
                </InsertParameters>
                <SelectParameters>
                <asp:ControlParameter ControlID="ddlTeams" Name="teamid" 
                    PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                <asp:Parameter Name="TeamID" Type="Int32" />
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="PermissionID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        <h2>Admins</h2>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="AdminID" DataSourceID="SqlDataSource3" 
            EmptyDataText="There are no data records to display.">
        <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="AdminID" HeaderText="AdminID" ReadOnly="True" 
            SortExpression="AdminID" Visible="False" />
        <asp:BoundField DataField="Username" HeaderText="Username" 
            SortExpression="Username" />
        </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
            DeleteCommand="DELETE FROM [tblFunnelAdmins] WHERE [AdminID] = @AdminID" 
            InsertCommand="INSERT INTO [tblFunnelAdmins] ([Username]) VALUES (@Username)" 
            ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
            SelectCommand="SELECT [AdminID], [Username] FROM [tblFunnelAdmins]" 
            UpdateCommand="UPDATE [tblFunnelAdmins] SET [Username] = @Username WHERE [AdminID] = @AdminID">
            <DeleteParameters>
            <asp:Parameter Name="AdminID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
            <asp:Parameter Name="Username" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            <asp:Parameter Name="Username" Type="String" />
            <asp:Parameter Name="AdminID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    <br />
<asp:Textbox id="txtAdmin" runat="server"/><asp:Button id ="btnInsertAdmin" runat="server" onclick ="btnInsertAdmin_onClick" Text="Insert" autopostback="false" />
<br />
<br />
<h2>Product Specialists</h2>
<asp:DropDownList ID="ddlFunnelProducts" runat="server" AutoPostBack="true" DataSourceID="SqlDataSource5" DataTextField="ProductCategory" DataValueField="FunnelProductID"            />
<asp:SqlDataSource ID="SqlDataSource5" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
    SelectCommand="SELECT * FROM [tblFunnelCategories]"></asp:SqlDataSource>
<asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="CatPermissionID" DataSourceID="SqlDataSource4" EmptyDataText="There are no data records to display.">
<Columns>
<asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
<asp:BoundField DataField="UserName" HeaderText="UserName" 
    SortExpression="UserName" />
</Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                DeleteCommand="DELETE FROM [tblProductPermissions] WHERE [CatPermissionID] = @CatPermissionID" 
                InsertCommand="INSERT INTO [tblProductPermissions] ([FunnelProductID], [UserName]) VALUES (@FunnelProductID, @UserName)" 
                ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
                ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
                SelectCommand="SELECT CatPermissionID,tblProductPermissions.UserName FROM tblProductPermissions INNER JOIN tblFunnelCategories ON tblProductPermissions.FunnelProductID = tblFunnelCategories.FunnelProductID WHERE (tblFunnelCategories.FunnelProductID = @FunnelProductID) OR (@FunnelProductID = 0)" 
                UpdateCommand="UPDATE [tblProductPermissions] Set [UserName] = @UserName WHERE [CatPermissionID] = @CatPermissionID">
                 <DeleteParameters>
                    <asp:Parameter Name="CatPermissionID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="FunnelProductID" Type="Int32" />
                    <asp:Parameter Name="UserName" Type="String" />
                </InsertParameters>
                <SelectParameters>
                <asp:ControlParameter ControlID="ddlFunnelProducts" Name="FunnelProductID" 
                    PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="CatPermissionID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
<br />
<asp:Textbox id="txtSpecialist" runat="server"/><asp:Button id ="btnInsertSpecialist" runat="server" onclick ="btnInsertSpecialist_onClick" Text="Insert" autopostback="false" />
</asp:Content>
