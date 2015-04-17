<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="AccessDenied.aspx.vb" Inherits="Forecaster.AccessDenied" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style1
        {
            font-size: xx-large;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Employee Request Tool</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <br />
    <br />
    <span class="auto-style1">ACCESS DENIED</span>
</asp:Content>
