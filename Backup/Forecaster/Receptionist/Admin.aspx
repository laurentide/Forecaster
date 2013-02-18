<%@ Page Title="Receptionist Tool" Language="vb" MasterPageFile="~/FunnelSite.Master" AutoEventWireup="false" CodeBehind="Admin.aspx.vb" Inherits="Forecaster.Admin" %>

<%@ Register Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" TagPrefix="RK" %><%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Receptionist Tool Administration</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <%--------------------------------------------------------------------------%> 
    <%--                     Employee Management                              --%> 
    <%--------------------------------------------------------------------------%> 
    <h2>Employee management</h2>
    <p>
        <asp:FormView ID="FormView1" runat="server" CellPadding="3" DataKeyNames="EmployeeID" DataSourceID="SqlDataSource2" DefaultMode="Insert" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" GridLines="Both">
            <EditItemTemplate>
                EmployeeID: <asp:Label ID="EmployeeIDLabel1" runat="server" Text='<%# Eval("EmployeeID") %>' /><br />EmployeeName: <asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' /><br />Cell: <asp:TextBox ID="CellTextBox" runat="server" Text='<%# Bind("Cell") %>' /><br />Extension: <asp:TextBox ID="ExtensionTextBox" runat="server"
                    Text='<%# Bind("Extension") %>' /><br />ValveAE: <asp:CheckBox ID="ValveAECheckBox" runat="server" Checked='<%# Bind("ValveAE") %>' /> <br />InstrumentAE: <asp:CheckBox ID="InstrumentAECheckBox" runat="server" Checked='<%# Bind("InstrumentAE") %>' /> <br />CSR: <asp:CheckBox ID="CSRCheckBox" runat="server" Checked='<%# Bind("CSR") %>' /> <br />
                Active: <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' /> <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <InsertItemTemplate>
                EmployeeName: <asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' /><br />
                Cell: <asp:TextBox ID="CellTextBox" runat="server" Text='<%# Bind("Cell") %>' /><br />
                Extension: <asp:TextBox ID="ExtensionTextBox" runat="server" Text='<%# Bind("Extension") %>' /><br />
                ValveAE: <asp:CheckBox ID="ValveAECheckBox" runat="server" Checked='<%# Bind("ValveAE") %>' /> <br />
                InstrumentAE: <asp:CheckBox ID="InstrumentAECheckBox" runat="server" Checked='<%# Bind("InstrumentAE") %>' /> <br />
                CSR: <asp:CheckBox ID="CSRCheckBox" runat="server" Checked='<%# Bind("CSR") %>' /> <br />
                Active: <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' /> <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                <%--&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
            </InsertItemTemplate>
            <ItemTemplate>
                EmployeeID: <asp:Label ID="EmployeeIDLabel" runat="server" Text='<%# Eval("EmployeeID") %>' /><br />EmployeeName: <asp:Label ID="EmployeeNameLabel" runat="server" Text='<%# Bind("EmployeeName") %>' /><br />Cell: <asp:Label ID="CellLabel" runat="server" Text='<%# Bind("Cell") %>' /><br />Extension: <asp:Label ID="ExtensionLabel" runat="server" Text='<%# Bind("Extension") %>' /><br />
                ValveAE: <asp:CheckBox ID="ValveAECheckBox" runat="server" Checked='<%# Bind("ValveAE") %>' Enabled="false" /> <br />InstrumentAE: <asp:CheckBox ID="InstrumentAECheckBox" runat="server" Checked='<%# Bind("InstrumentAE") %>' Enabled="false" /> <br />CSR: <asp:CheckBox ID="CSRCheckBox" runat="server" Checked='<%# Bind("CSR") %>' Enabled="false" /> <br />
                Active: <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' Enabled="false" /> <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            </ItemTemplate>
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
        </asp:FormView>
    </p>
    <asp:GridView ID="GridView4" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="EmployeeID" DataSourceID="SqlDataSource2" ShowFooter="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <%--<asp:BoundField DataField="EmployeeID" HeaderText="EmployeeID" InsertVisible="False" ReadOnly="True" SortExpression="EmployeeID" />--%>
            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Cell" HeaderText="Cell" SortExpression="Cell" />
            <asp:BoundField DataField="Extension" HeaderText="Extension" SortExpression="Extension" />
            <asp:CheckBoxField DataField="ValveAE" HeaderText="ValveAE" SortExpression="ValveAE" />
            <asp:CheckBoxField DataField="InstrumentAE" HeaderText="InstrumentAE" SortExpression="InstrumentAE" />
            <asp:CheckBoxField DataField="CSR" HeaderText="CSR" SortExpression="CSR" />
            <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" /><SortedAscendingHeaderStyle BackColor="#506C8C" /><SortedDescendingCellStyle BackColor="#FFFDF8" /><SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <%--------------------------------------------------------------------------%> 
    <%--                     Team Management                                  --%> 
    <%--------------------------------------------------------------------------%> 
    <br /><h2>Team Management</h2>
    <asp:FormView ID="FormView2" runat="server" CellPadding="3" DataKeyNames="OSID" DataSourceID="SqlDataSource1" DefaultMode="Insert" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" GridLines="Both">
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
        <InsertItemTemplate>
            OSNo: <asp:TextBox ID="OSNoTextBox" runat="server" Text='<%# Bind("OSNo") %>' /><br />
            OSName: <asp:TextBox ID="OSNameTextBox" runat="server" Text='<%# Bind("OSName") %>' /><br />
            ValveAE: <asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>' /><br />
            InstrumentAE: <asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' /><br />
            ValveAEBAK: <asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' /><br />
            InstrumentAEBAK: <asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' /><br />
            CSR: <asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' /><br />
            CSRBAK: <asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' /><br />
            Cell: <asp:TextBox ID="CellTextBox" runat="server" Text='<%# Bind("Cell") %>' /><br />
            Extension: <asp:TextBox ID="ExtensionTextBox" runat="server" Text='<%# Bind("Extension") %>' /><br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            <%--<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
        </InsertItemTemplate>
        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    </asp:FormView>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OSID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <%--<asp:BoundField DataField="OSID" HeaderText="OSID" InsertVisible="False" ReadOnly="True" SortExpression="OSID" />--%>
            <asp:BoundField DataField="OSNo" HeaderText="OSNo" SortExpression="OSNo" />
            <asp:BoundField DataField="OSName" HeaderText="OSName" SortExpression="OSName" />
            <asp:TemplateField HeaderText="Valve AE" SortExpression="ValveAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAE" runat="server" Text='<%# Bind("ValveAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE" SortExpression="InstrumentAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAE" runat="server" Text='<%# Bind("InstrumentAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR" SortExpression="CSR">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSR" runat="server" Text='<%# Bind("CSR","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Valve AE BAK" SortExpression="ValveAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAEBAK" runat="server" Text='<%# Bind("ValveAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE BAK" SortExpression="InstrumentAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAEBAK" runat="server" Text='<%# Bind("InstrumentAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR BAK" SortExpression="CSRBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSRBAK" runat="server" Text='<%# Bind("CSRBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%--        <asp:BoundField DataField="InstrumentAE" HeaderText="InstrumentAE" SortExpression="InstrumentAE" />
            <asp:BoundField DataField="ValveAEBAK" HeaderText="ValveAEBAK" SortExpression="ValveAEBAK" />
            <asp:BoundField DataField="InstrumentAEBAK" HeaderText="InstrumentAEBAK" SortExpression="InstrumentAEBAK" />
            <asp:BoundField DataField="CSR" HeaderText="CSR" SortExpression="CSR" />
            <asp:BoundField DataField="CSRBAK" HeaderText="CSRBAK" SortExpression="CSRBAK" /> --%>
            <asp:BoundField DataField="Cell" HeaderText="Cell" SortExpression="Cell" />
            <asp:BoundField DataField="Extension" HeaderText="Extension" SortExpression="Extension" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" /><SortedAscendingHeaderStyle BackColor="#506C8C" /><SortedDescendingCellStyle BackColor="#FFFDF8" /><SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <%--------------------------------------------------------------------------%> 
    <%--                     Exceptions Management                            --%> 
    <%--------------------------------------------------------------------------%> 
    <h2>Exceptions management</h2>
    <asp:FormView ID="FormView3" runat="server" CellPadding="3" DataKeyNames="id" DataSourceID="SqlDataSource3" DefaultMode="Insert" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" GridLines="Both">
        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
        <InsertItemTemplate>
            CustomerNo: <asp:TextBox ID="CustomerNoTextBox" runat="server" Text='<%# Bind("CustomerNo") %>' /><br />
            CustomerName: <asp:TextBox ID="CustomerNameTextBox" runat="server" Text='<%# Bind("CustomerName") %>' /><br />
            City: <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' /><br />
            ValveAE: <asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>' /><br />
            InstrumentAE: <asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' /><br />
            ValveAEBAK: <asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' /><br />
            InstrumentAEBAK: <asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' /><br />
            CSR: <asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' /><br />
            CSRBAK: <asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' /><br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            <%--&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
        </InsertItemTemplate>
        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    </asp:FormView>
    <asp:GridView ID="GridView3" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource3">
        <Columns>
            <%--<asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />--%>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="CustomerNo" HeaderText="CustomerNo" SortExpression="CustomerNo" />
            <asp:BoundField DataField="CustomerName" HeaderText="CustomerName" SortExpression="CustomerName" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:TemplateField HeaderText="Valve AE" SortExpression="ValveAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAE" runat="server" Text='<%# Bind("ValveAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE" SortExpression="InstrumentAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAE" runat="server" Text='<%# Bind("InstrumentAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR" SortExpression="CSR">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSR" runat="server" Text='<%# Bind("CSR","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Valve AE BAK" SortExpression="ValveAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAEBAK" runat="server" Text='<%# Bind("ValveAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE BAK" SortExpression="InstrumentAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAEBAK" runat="server" Text='<%# Bind("InstrumentAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR BAK" SortExpression="CSRBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSRBAK" runat="server" Text='<%# Bind("CSRBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%--            <asp:BoundField DataField="ValveAE" HeaderText="ValveAE" SortExpression="ValveAE" />
            <asp:BoundField DataField="InstrumentAE" HeaderText="InstrumentAE" SortExpression="InstrumentAE" />
            <asp:BoundField DataField="ValveAEBAK" HeaderText="ValveAEBAK" SortExpression="ValveAEBAK" />
            <asp:BoundField DataField="InstrumentAEBAK" HeaderText="InstrumentAEBAK" SortExpression="InstrumentAEBAK" />
            <asp:BoundField DataField="CSR" HeaderText="CSR" SortExpression="CSR" />
            <asp:BoundField DataField="CSRBAK" HeaderText="CSRBAK" SortExpression="CSRBAK" />--%>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" /><SortedAscendingHeaderStyle BackColor="#506C8C" /><SortedDescendingCellStyle BackColor="#FFFDF8" /><SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_web.dbo.tblOS" UpdateCommand="UPDATE [Receptionist_Web].[dbo].[tblOS]
                   SET [OSNo] = @OSNo
                      ,[OSName] = @OSName
                      ,[ValveAE] = @ValveAE
                      ,[InstrumentAE] = @InstrumentAE
                      ,[ValveAEBAK] = @ValveAEBAK
                      ,[InstrumentAEBAK] = @InstrumentAEBAK
                      ,[CSR] = @CSR
                      ,[CSRBAK] = @CSRBAK
                      ,[Cell] = @Cell
                      ,[Extension] = @Extension Where OSID = @OSID" InsertCommand="INSERT INTO [Receptionist_Web].[dbo].[tblOS]
           ([OSNo]
           ,[OSName]
           ,[ValveAE]
           ,[InstrumentAE]
           ,[ValveAEBAK]
           ,[InstrumentAEBAK]
           ,[CSR]
           ,[CSRBAK]
           ,[Cell]
           ,[Extension])
     VALUES
           (@OSNo
           ,@OSName
           ,@ValveAE
           ,@InstrumentAE
           ,@ValveAEBAK
           ,@InstrumentAEBAK
           ,@CSR
           ,@CSRBAK
           ,@Cell
           ,@Extension)">
        <UpdateParameters>
            <asp:Parameter Name="OsNo" />
            <asp:Parameter Name="OSName" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="CSRBAK" />
            <asp:Parameter Name="OSID" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="OsNo" />
            <asp:Parameter Name="OSName" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="CSRBAK" />
            <asp:Parameter Name="OSID" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblEmployee" UpdateCommand="UPDATE [Receptionist_Web].[dbo].[tblEmployee]
   SET [EmployeeName] = @EmployeeName
      ,[Cell] = @Cell
      ,[Extension] = @Extension
      ,[ValveAE] = @ValveAE
      ,[InstrumentAE] = @InstrumentAE
      ,[CSR] = @CSR
      ,[Active] = @Active
 WHERE EmployeeID=@EmployeeID" InsertCommand="INSERT INTO [Receptionist_Web].[dbo].[tblEmployee]
           ([EmployeeName]
           ,[Cell]
           ,[Extension]
           ,[ValveAE]
           ,[InstrumentAE]
           ,[CSR]
           ,[Active])
     VALUES
           (@EmployeeName
           ,@Cell
           ,@Extension
           ,@ValveAE
           ,@InstrumentAE
           ,@CSR
           ,@Active)">
        <UpdateParameters>
            <asp:Parameter Name="EmployeeName" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="Active" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="EmployeeName" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="Active" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblExceptions" UpdateCommand="UPDATE [Receptionist_Web].[dbo].[tblExceptions]
   SET [CustomerNo] = @CustomerNo
      ,[CustomerName] = @CustomerName
      ,[City] = @City
      ,[ValveAE] = @ValveAE
      ,[InstrumentAE] = @InstrumentAE
      ,[ValveAEBAK] = @ValveAEBAK
      ,[InstrumentAEBAK] = @InstrumentAEBAK
      ,[CSR] = @CSR
      ,[CSRBAK] = @CSRBAK
    WHERE id=@id" InsertCommand="INSERT INTO [Receptionist_Web].[dbo].[tblExceptions]
           ([CustomerNo]
           ,[CustomerName]
           ,[City]
           ,[ValveAE]
           ,[InstrumentAE]
           ,[ValveAEBAK]
           ,[InstrumentAEBAK]
           ,[CSR]
           ,[CSRBAK])
     VALUES
           (@CustomerNo
           ,@CustomerName
           ,@City
           ,@ValveAE
           ,@InstrumentAE
           ,@ValveAEBAK
           ,@InstrumentAEBAK
           ,@CSR
           ,@CSRBAK)">
        <UpdateParameters>
            <asp:Parameter Name="CustomerNo" />
            <asp:Parameter Name="CustomerName" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="CSRBAK" />
            <asp:Parameter Name="id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerNo" />
            <asp:Parameter Name="CustomerName" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="CSRBAK" />
            <asp:Parameter Name="id" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValveAE" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where valveae = 1 and active = 1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsInstrumentAE" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where instrumentAE = 1 and active = 1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCSR" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where csr = 1 and active = 1"></asp:SqlDataSource>
</asp:Content>
