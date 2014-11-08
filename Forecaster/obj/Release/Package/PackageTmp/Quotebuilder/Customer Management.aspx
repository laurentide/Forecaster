<%@ Page Language="vb" MasterPageFile="~/FunnelSite.Master" AutoEventWireup="false" CodeBehind="Customer Management.aspx.vb" Inherits="Forecaster.Customer_Management" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:GridView ID="gvQB" runat="server" AutoGenerateColumns="False" PageSize="100" DataKeyNames="customerid" DataSourceID="sdsQuotebuilder" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowUpdating="gvQB_RowUpdating">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="customerid" HeaderText="QB Cust ID" ReadOnly="True" SortExpression="customerid" />
            <asp:BoundField DataField="NomisCustomerID" HeaderText="Nomis Cust ID" SortExpression="NomisCustomerID" ReadOnly="True" />
            <asp:BoundField DataField="Name" HeaderText="name" SortExpression="name" ReadOnly="True" />
            <asp:BoundField DataField="ShortName" HeaderText="ShortName" SortExpression="ShortName" ReadOnly="True" />
            <asp:BoundField DataField="Address1" HeaderText="Address1" SortExpression="Address1" ReadOnly="True" />
            <asp:BoundField DataField="Address2" HeaderText="Address2" SortExpression="Address2" ReadOnly="True" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" ReadOnly="True" />
            <asp:BoundField DataField="ProvinceID" HeaderText="Pr" SortExpression="ProvinceID" ReadOnly="True" />
            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" ReadOnly="True" />
            <asp:BoundField DataField="Territory_Code" HeaderText="TC" SortExpression="Territory_Code" ReadOnly="True" />
            <asp:TemplateField HeaderText="AE1">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlAE1" runat="server" DataSourceID="sdsAE" DataTextField="fullname" DataValueField="fullname" AppendDataBoundItems="true" SelectedValue='<%# Bind("AE1") %>'>
                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="AE1Label" Text='<%# Bind("AE1")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="AE2">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlAE2" runat="server" DataSourceID="sdsAE" DataTextField="fullname" DataValueField="fullname" AppendDataBoundItems="true" SelectedValue='<%# Bind("AE2")%>'>
                         <asp:ListItem Value="" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="AE2Label" Text='<%# Bind("AE2")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR1">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSR1" runat="server" DataSourceID="sdsCSR" DataTextField="fullname" DataValueField="fullname" AppendDataBoundItems="true" SelectedValue='<%# Bind("CSR1")%>'>
                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="CSR1Label" Text='<%# Bind("CSR1")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR2">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSR2" runat="server" DataSourceID="sdsCSR" DataTextField="fullname" DataValueField="fullname" AppendDataBoundItems="true" SelectedValue='<%# Bind("CSR2")%>'>
                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="CSR2Label" Text='<%# Bind("CSR2")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="OS1">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlOS1" runat="server" DataSourceID="sdsOS" DataTextField="fullname" DataValueField="fullname" AppendDataBoundItems="true" SelectedValue='<%# Bind("OS1")%>'>
                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="OS1Label" Text='<%# Bind("OS1")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="OS2">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlOS2" runat="server" DataSourceID="sdsOS" DataTextField="fullname" DataValueField="fullname" AppendDataBoundItems="true" SelectedValue='<%# Bind("OS2")%>'>
                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="OS2Label" Text='<%# Bind("OS2")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <%--            <asp:BoundField DataField="AE1" HeaderText="AE1" SortExpression="AE1"  />
            <asp:BoundField DataField="AE2" HeaderText="AE2" SortExpression="AE2"  />
            <asp:BoundField DataField="CSR1" HeaderText="CSR1" SortExpression="CSR1"  />
            <asp:BoundField DataField="CSR2" HeaderText="CSR2" SortExpression="CSR2"  />
            <asp:BoundField DataField="OS1" HeaderText="OS1" SortExpression="OS1"  />
            <asp:BoundField DataField="OS2" HeaderText="OS2" SortExpression="OS2"  />
            --%>
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
    <asp:SqlDataSource ID="sdsQuotebuilder" runat="server" ConnectionString="<%$ ConnectionStrings:QBConnectionString %>" SelectCommand="select 
cus.customerid,
cus.NomisCustomerID,
cus.name,
cus.ShortName,
cus.Address1,
cus.Address2,
City,
cus.ProvinceID,
Country,
caducd as Territory_Code,
ae1.fullname as AE1,
ae2.fullname as AE2,
sa1.fullname as CSR1,
sa2.fullname as CSR2,
sls1.fullname as OS1,
sls2.fullname as OS2
from quotebuilder.dbo.tblcustomers cus
left join tblemployees ae1
on ae1 = ae1.employeeid 
left join tblemployees ae2
on ae2 = ae2.employeeid 
left join tblemployees sa1
on sa1 = sa1.employeeid 
left join tblemployees sa2
on sa2 = sa2.employeeid 
left join tblemployees sls1
on sls1 = sls1.employeeid 
left join tblemployees sls2
on sls2 = sls2.employeeid 
left join tblcities c
on cus.cityid = c.cityid
left join tblcountries d
on cus.countryid = d.countryid
left join Nomis.S1018252.NOMDBF95.CUSPHY01
on NomisCustomerID = CAZXNB
and caaqnb = '1'
order by name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAE" runat="server" ConnectionString="<%$ ConnectionStrings:QBConnectionString %>"
        SelectCommand="select fullname,employeeid from tblemployees where departmentid = 1 order by fullname"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCSR" runat="server" ConnectionString="<%$ ConnectionStrings:QBConnectionString %>"
        SelectCommand="select fullname,employeeid from tblemployees where departmentid = 2 order by fullname"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOS" runat="server" ConnectionString="<%$ ConnectionStrings:QBConnectionString %>"
        SelectCommand="select fullname,employeeid from tblemployees where departmentid = 3 order by fullname"></asp:SqlDataSource>

</asp:Content>
