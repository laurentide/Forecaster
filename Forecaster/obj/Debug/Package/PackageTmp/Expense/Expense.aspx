<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Expense.aspx.vb" Inherits="Forecaster.Expense" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Formview runat="server" id="frmExpense" DefaultMode="Edit" >
        <EditItemTemplate>
            Employee:<asp:DropDownList ID="ddlEmployee" runat="server" /> <br />
            <div>
                New Employee Name:<asp:TextBox ID="txtNewEmployee" runat="server" /> <br />
                Department: <asp:DropDownList ID="ddlDepartment" runat="server" /> <br />
                Car allowance program: <asp:CheckBox ID="chkcar" runat="server" /> 
            </div>
            <asp:TextBox ID="txtEvent" runat="server" /> <br />
            <asp:TextBox ID="txtCashAdvance" runat="server" /><br />
        </EditItemTemplate>
    </asp:Formview>
</asp:Content>
