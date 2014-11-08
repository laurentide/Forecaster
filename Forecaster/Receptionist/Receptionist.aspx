<%@ Page Title="Receptionist Tool" Language="vb" MasterPageFile="~/FunnelSite.Master" AutoEventWireup="false" CodeBehind="Receptionist.aspx.vb" Inherits="Forecaster.Receptionist" %>

<%@ Register Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" TagPrefix="RK" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>Receptionist Tool</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:Panel ID="PanFilters" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table>
            <tr>
                <td>Customer Name:</td>
                <td><asp:TextBox ID="txtCustName" runat="server" Height="22px" Width="180px" /></td>
            </tr>
            <tr>
                <td>Territory Code:</td>
                <td><asp:TextBox ID="txtTC" runat="server" Height="22px" Width="180px" /></td>
            </tr>
            <tr>
                <td>Customer #:</td>
                <td><asp:TextBox ID="txtCustNumber" runat="server" Height="22px" Width="180px" /></td>
            </tr>
            <tr>
                <td>City:</td>
                <td><asp:TextBox ID="txtCity" runat="server" Height="22px" Width="180px" /></td>
            </tr>
        </table>
    </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Button ID="btnFilter" runat="server" onclick="btnFilter_onClick" 
        Text="Search" /><asp:Button ID="btnClear" runat="server" 
        onclick="btnClear_onClick" Text="Clear Filters" />
    </asp:Panel>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" 
    AllowPaging="True" PageSize="50" AllowSorting="True" 
    Font-Size="7pt">
<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
<Columns>
<asp:BoundField DataField="Cust #" HeaderText="Cust #" 
    SortExpression="Cust #" />
<asp:BoundField DataField="Cust Name" HeaderText="Cust Name" 
    SortExpression="Cust Name" />
<asp:BoundField DataField="Address 1" HeaderText="Address 1" SortExpression="Address 1" />
<asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
<asp:BoundField DataField="Province" HeaderText="Province" SortExpression="Province" />
<asp:BoundField DataField="TC" HeaderText="TC" SortExpression="TC" />
<asp:BoundField DataField="OS" HeaderText="OS" SortExpression="OS" />
<asp:BoundField DataField="OS Cell" HeaderText="OS Cell" SortExpression="OS Cell" />
<asp:BoundField DataField="OS Ext" HeaderText="OS Ext" SortExpression="OS Ext" />
<asp:BoundField DataField="Valve AE" HeaderText="Valve AE" SortExpression="Valve AE" />
<asp:BoundField DataField="Valve AE Ext" HeaderText="Valve AE Ext" SortExpression="Valve AE Ext" />
<asp:BoundField DataField="InstrumentAE" HeaderText="InstrumentAE" SortExpression="InstrumentAE" />
<asp:BoundField DataField="Instrument AE Ext" HeaderText="Instrument AE Ext" SortExpression="Instrument AE Ext" />

<asp:BoundField DataField="VAD AE" HeaderText="VAD AE" SortExpression="VAD AE" />
<asp:BoundField DataField="VAD AE Ext" HeaderText="VAD AE Ext" SortExpression="VAD AE Ext" />

<asp:BoundField DataField="CSR" HeaderText="CSR" SortExpression="CSR" />
<asp:BoundField DataField="CSR Ext" HeaderText="CSR Ext" SortExpression="CSR Ext" />
<asp:BoundField DataField="Valve AE Backup" HeaderText="Valve AE Backup" SortExpression="Valve AE Backup" />
<asp:BoundField DataField="Valve AE Bak Ext" HeaderText="Valve AE Bak Ext" SortExpression="Valve AE Bak Ext" />
<asp:BoundField DataField="Instrument AE Backup" HeaderText="Instrument AE Backup" SortExpression="Instrument AE Backup" />
<asp:BoundField DataField="Instr Bak Ext" HeaderText="Instr Bak Ext" SortExpression="Instr Bak Ext" />

<asp:BoundField DataField="VAD AE Backup" HeaderText="VAD AE Backup" SortExpression="VAD AE Backup" />
<asp:BoundField DataField="VAD AE Bak Ext" HeaderText="VAD AE Bak Ext" SortExpression="VAD AE Bak Ext" />

<asp:BoundField DataField="CSR Backup" HeaderText="CSR Backup" SortExpression="CSR Backup" />
<asp:BoundField DataField="CSR Bak Ext" HeaderText="CSR Bak Ext" SortExpression="CSR Bak Ext" />
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
    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="
    select cazxnb as [Cust #],
       case when ex.ValveAE is null         then cacstx             else ex.CustomerNAme    end as [Cust Name],
	   cacptx as [Address 1],
	   cacttx as [City],
	   cat4st as [Province],
	   caducd as [TC],
	   OSName as [OS],
	   os.Cell as [OS Cell],
	   os.Extension as [OS Ext],
	   case when ex.ValveAE is null         then os.ValveAE         else ex.ValveAE         end as [Valve AE], 
	   case when ex.ValveAE is null         then A.Extension        else g.Extension        end as [Valve AE Ext],
	   case when ex.InstrumentAE is null    then os.InstrumentAE    else ex.InstrumentAE    end as [InstrumentAE], 
	   case when ex.InstrumentAE is null    then B.Extension        else h.Extension        end as [Instrument AE Ext],

       case when ex.VADAE is null           then os.VADAE           else ex.VADAE           end as [VAD AE], 
	   case when ex.VADAE is null           then m.Extension        else o.Extension        end as [VAD AE Ext],

	   case when ex.CSR is null             then os.CSR             else ex.CSR             end as [CSR],
	   case when ex.CSR is null             then E.Extension        else k.Extension        end as [CSR Ext],
	   case when ex.ValveAEBAK is null      then os.ValveAEBAK      else ex.ValveAEBAK      end as [Valve AE Backup], 
	   case when ex.ValveAEBAK is null      then C.Extension        else i.Extension        end as [Valve AE Bak Ext],
	   case when ex.InstrumentAEBAK is null then os.InstrumentAEBAK else ex.InstrumentAEBAK end as [Instrument AE Backup], 
	   case when ex.InstrumentAEBAK is null then D.Extension        else J.Extension        end as [Instr Bak Ext],

       case when ex.VADAEBAK is null        then os.VADAEBAK        else ex.VADAEBAK        end as [VAD AE Backup], 
	   case when ex.VADAEBAK is null        then n.Extension        else p.Extension        end as [VAD AE Bak Ext],

	   case when ex.CSRBAK is null          then os.CSRBAK          else ex.CSRBAK          end as [CSR Backup],
	   case when ex.CSRBAK is null          then F.Extension        else l.Extension        end as [CSR Bak Ext]
from Nomis.S1018252.NOMDBF95.CUSPHY01 inner join
		( Receptionist_web.dbo.tblos os
		left join Receptionist_web.dbo.tblemployee a
		on os.valveAE = a.employeename
		left join Receptionist_web.dbo.tblemployee b
		on os.InstrumentAE = b.employeename
		left join Receptionist_web.dbo.tblemployee c
		on os.valveAEBAK = c.employeename
		left join Receptionist_web.dbo.tblemployee d
		on os.InstrumentAEBAK = d.employeename
		left join Receptionist_web.dbo.tblemployee e
		on os.CSR = e.employeename
		left join Receptionist_web.dbo.tblemployee f
		on os.CSRBAK = f.employeename
        left join Receptionist_web.dbo.tblemployee m
		on os.VADAE = m.employeename
        left join Receptionist_web.dbo.tblemployee n
		on os.VADAEBAK = n.employeename)
	on cardcd = osno 
	left join
		(Receptionist_web.dbo.tblExceptions ex
		left join Receptionist_web.dbo.tblemployee g
		on ex.valveAE = g.employeename
		left join Receptionist_web.dbo.tblemployee h
		on ex.InstrumentAE = h.employeename
		left join Receptionist_web.dbo.tblemployee i
		on ex.valveAEBAK = i.employeename
		left join Receptionist_web.dbo.tblemployee j
		on ex.InstrumentAEBAK = j.employeename
		left join Receptionist_web.dbo.tblemployee k
		on ex.CSR = k.employeename
		left join Receptionist_web.dbo.tblemployee l
		on ex.CSRBAK = l.employeename
    	left join Receptionist_web.dbo.tblemployee o
		on ex.VADAE = o.employeename
		left join Receptionist_web.dbo.tblemployee p
		on ex.VADAEBAK = p.employeename)
	on cazxnb = customerno
where cafesu = 'A'
and cacstx like '%' + upper(@Search) +'%'
and caducd like '%' + upper(@TC) + '%'
and (convert(char(5),cazxnb) = @CustNumber or @CustNumber = '%')
and cacttx like '%' + upper(@City) + '%'">
<SelectParameters>
            <asp:ControlParameter ControlID="txtCustName" Name="Search" DefaultValue = "%" PropertyName="Text" /> 
            <asp:ControlParameter ControlID="txtTC" Name="TC" DefaultValue = "%" PropertyName="Text" /> 
            <asp:ControlParameter ControlID="txtCustNumber" Name="CustNumber" DefaultValue = "%" PropertyName="Text" /> 
            <asp:ControlParameter ControlID="txtCity" Name="City" DefaultValue = "%" PropertyName="Text" /> 
</SelectParameters>
</asp:SqlDataSource>
 
<RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" Charset="utf-8" ContentEncoding="windows-1250"
    EnableHyperLinks="True" ExportFileName="Receptionist_Export.xls" IncludeTimeStamp="True" PageSize="All" 
    Text="Export To Excel" GridViewID="Gridview1" />
<!--Author: Rajesh K, Copyright 2007 All rights reserved. Use this control at your own risk.  Author is not responsible for any defects or damages to your code.-->
</asp:Content>
