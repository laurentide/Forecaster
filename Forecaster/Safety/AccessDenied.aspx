<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AccessDenied.aspx.vb" MasterPageFile="~/FunnelSite.Master" Inherits="Forecaster.SafetyAccessDenied" %>

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
    <h2>Safety Case Tool</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <br />
    <br />
    <span class="auto-style1">ACCESS DENIED</span>
</asp:Content>
