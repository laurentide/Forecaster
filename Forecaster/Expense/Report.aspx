<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="Report.aspx.vb" Inherits="Forecaster.Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat ="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="900px" ProcessingMode="Local" Height="700px">
        <%--<LocalReport ReportEmbeddedResource="Forecaster.ExpenseReport.rdlc">
        </LocalReport>--%>
        <LocalReport ReportPath="Expense\ExpenseReport.rdlc">
               <DataSources>
                   <rsweb:ReportDataSource DataSourceId="ExpenseReport" Name="ExpenseReport" />
               </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ExpenseReport" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Forecaster.ExpenseReportTableAdapters.vwExpenseReportPrintoutTableAdapter"></asp:ObjectDataSource>
</asp:Content>
