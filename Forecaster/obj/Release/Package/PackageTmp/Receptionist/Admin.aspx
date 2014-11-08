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
        <asp:FormView ID="FormView1" runat="server" CellPadding="3" DataKeyNames="EmployeeID" DataSourceID="SqlDataSource2" DefaultMode="Insert" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" GridLines="Both" >
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
                <table>
				<tr><td>Employee Name: </td><td><asp:TextBox ID="EmployeeNameTextBox" runat="server" Text='<%# Bind("EmployeeName") %>' /></td></tr>
                <tr><td>Employee Cell:         </td><td><asp:TextBox ID="CellTextBox" runat="server" Text='<%# Bind("Cell") %>' /></td></tr>
                <tr><td>Extension:    </td><td><asp:TextBox ID="ExtensionTextBox" runat="server" Text='<%# Bind("Extension") %>' /></td></tr>
                <tr><td>Valve AE:      </td><td><asp:CheckBox ID="ValveAECheckBox" runat="server" Checked='<%# Bind("ValveAE") %>' /> </td></tr>
                <tr><td>Instrument AE: </td><td><asp:CheckBox ID="InstrumentAECheckBox" runat="server" Checked='<%# Bind("InstrumentAE") %>' /> </td></tr>
                <tr><td>VAD AE:        </td><td><asp:CheckBox ID="VADAECheckBox" runat="server" Checked='<%# Bind("VADAE") %>' /> </td></tr>
                <tr><td>CSR:          </td><td><asp:CheckBox ID="CSRCheckBox" runat="server" Checked='<%# Bind("CSR") %>' /> </td></tr>
                <tr><td>Active:       </td><td><asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' /> </td></tr>
                <tr><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" /></td></tr>
               </table>
                <%--&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
            </InsertItemTemplate>
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
        </asp:FormView>
    </p>
    <asp:GridView ID="GridView4" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="EmployeeID" DataSourceID="SqlDataSource2" ShowFooter="True" Font-Size="10pt">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <%--<asp:BoundField DataField="EmployeeID" HeaderText="EmployeeID" InsertVisible="False" ReadOnly="True" SortExpression="EmployeeID" />--%>
            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Cell" HeaderText="Cell" SortExpression="Cell" />
            <asp:BoundField DataField="Extension" HeaderText="Extension" SortExpression="Extension" />
            <asp:CheckBoxField DataField="ValveAE" HeaderText="ValveAE" SortExpression="ValveAE" />
            <asp:CheckBoxField DataField="InstrumentAE" HeaderText="InstrumentAE" SortExpression="InstrumentAE" />
            <asp:CheckBoxField DataField="VADAE" HeaderText="VADAE" SortExpression="VADAE" />
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
            <table>
            <tr><td>OS No:            </td><td><asp:TextBox ID="OSNoTextBox" runat="server" Text='<%# Bind("OSNo") %>' /></td></tr>
            <tr><td>OS Name:          </td><td><asp:TextBox ID="OSNameTextBox" runat="server" Text='<%# Bind("OSName") %>' /></td></tr>
            <tr><td>OS Cell:            </td><td><asp:TextBox ID="CellTextBox" runat="server" Text='<%# Bind("Cell") %>' /></td></tr>
            <tr><td>OS Extension:       </td><td><asp:TextBox ID="ExtensionTextBox" runat="server" Text='<%# Bind("Extension") %>' /></td></tr>
            <tr><td>Valve AE:         </td><td><asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>' /></td></tr>
            <tr><td>Instrument AE:    </td><td><asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' /></td></tr>
            <tr><td>VAD AE:           </td><td><asp:DropDownList ID="ddlVADAE" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAE")%>' /></td></tr>
            <tr><td>Valve AE BAK:      </td><td><asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' /></td></tr>
            <tr><td>Instrument AE BAK: </td><td><asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' /></td></tr>
            <tr><td>VAD AE BAK:        </td><td><asp:DropDownList ID="ddlVADAEBak" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAEBak")%>' /></td></tr>
            <tr><td>CSR:             </td><td><asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' /></td></tr>
            <tr><td>CSR BAK:          </td><td><asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' /></td></tr>
            <tr><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" /></td></tr>
                </table>
            <%--<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
        </InsertItemTemplate>
        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    </asp:FormView>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OSID" DataSourceID="SqlDataSource1" Font-Size="8pt">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <%--<asp:BoundField DataField="OSID" HeaderText="OSID" InsertVisible="False" ReadOnly="True" SortExpression="OSID" />--%>
            <asp:BoundField DataField="OSNo" HeaderText="OSNo" SortExpression="OSNo" />
            <asp:BoundField DataField="OSName" HeaderText="OSName" SortExpression="OSName" />
            <asp:TemplateField HeaderText="Valve AE" SortExpression="ValveAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAE" runat="server" Text='<%# Bind("ValveAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE" SortExpression="InstrumentAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAE" runat="server" Text='<%# Bind("InstrumentAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="VAD AE" SortExpression="VADAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlVADAE" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAE") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtVADAE" runat="server" Text='<%# Bind("VADAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR" SortExpression="CSR">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSR" runat="server" Text='<%# Bind("CSR","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Valve AE BAK" SortExpression="ValveAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAEBAK" runat="server" Text='<%# Bind("ValveAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE BAK" SortExpression="InstrumentAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAEBAK" runat="server" Text='<%# Bind("InstrumentAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="VAD AE BAK" SortExpression="VADAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlVADAEBAK" runat="server" DataSourceID="sdsVADAE"  DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAEBAK") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtVADAEBAK" runat="server" Text='<%# Bind("VADAEBAK", "")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR BAK" SortExpression="CSRBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
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
            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" ReadOnly="true" />
            <asp:BoundField DataField="LastModified" HeaderText="LastModified" SortExpression="LastModified" ReadOnly="true" />
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
            <table>
            <tr><td>Customer No:     </td><td><asp:TextBox ID="CustomerNoTextBox" runat="server" Text='<%# Bind("CustomerNo") %>' /></td></tr>
            <tr><td>Customer Name:   </td><td><asp:TextBox ID="CustomerNameTextBox" runat="server" Text='<%# Bind("CustomerName") %>' /></td></tr>
            <tr><td>City:            </td><td><asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' /></td></tr>
            <tr><td>Valve AE:        </td><td><asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>' /></td></tr>
            <tr><td>Instrument AE:   </td><td><asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>' /></td></tr>
            <tr><td>VAD AE:          </td><td><asp:DropDownList ID="ddlVADAE" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAE") %>' /></td></tr>
            <tr><td>Valve AE BAK:    </td><td><asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' /></td></tr>
            <tr><td>Instrument AE BAK: </td><td><asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' /></td></tr>
            <tr><td>VAD AE BAK:      </td><td><asp:DropDownList ID="ddlVADAEBAK" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAEBAK") %>' /></td></tr>
            <tr><td>CSR:             </td><td><asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>' /></td></tr>
            <tr><td>CSR BAK:         </td><td><asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' /></td></tr>
            <tr><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" /></td></tr>
             </table>
            <%--&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
        </InsertItemTemplate>
        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    </asp:FormView>
    <asp:GridView ID="GridView3" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource3" Font-Size="8pt" >
        <Columns>
            <%--<asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />--%>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="CustomerNo" HeaderText="CustomerNo" SortExpression="CustomerNo" />
            <asp:BoundField DataField="CustomerName" HeaderText="CustomerName" SortExpression="CustomerName" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:TemplateField HeaderText="Valve AE" SortExpression="ValveAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAE" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAE") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAE" runat="server" Text='<%# Bind("ValveAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE" SortExpression="InstrumentAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAE" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAE") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAE" runat="server" Text='<%# Bind("InstrumentAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="VAD AE" SortExpression="VADAE">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlVADAE" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAE") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtVADAE" runat="server" Text='<%# Bind("VADAE","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR" SortExpression="CSR">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSR" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSR") %>'  AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSR" runat="server" Text='<%# Bind("CSR","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Valve AE BAK" SortExpression="ValveAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlValveAEBAK" runat="server" DataSourceID="sdsValveAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("ValveAEBAK") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtValveAEBAK" runat="server" Text='<%# Bind("ValveAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instrument AE BAK" SortExpression="InstrumentAEBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlInstrumentAEBAK" runat="server" DataSourceID="sdsInstrumentAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("InstrumentAEBAK") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtInstrumentAEBAK" runat="server" Text='<%# Bind("InstrumentAEBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="VAD AE BAK" SortExpression="VADAEBak">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlVADAEBak" runat="server" DataSourceID="sdsVADAE" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("VADAEBak") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtVADAEBAk" runat="server" Text='<%# Bind("VADAEBak","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CSR BAK" SortExpression="CSRBAK">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCSRBAK" runat="server" DataSourceID="sdsCSR" DataValueField="EmployeeName" DataTextField="EmployeeName" SelectedValue='<%# Bind("CSRBAK") %>' AppendDataBoundItems="true" >
                        <asp:ListItem Text="Select Value" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="txtCSRBAK" runat="server" Text='<%# Bind("CSRBAK","") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" ReadOnly="true" />
            <asp:BoundField DataField="LastModified" HeaderText="LastModified" SortExpression="LastModified" ReadOnly="true" />
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
                      ,[VADAE] = @VADAE
                      ,[VADAEBak] = @VADAEBak
                      ,[CSR] = @CSR
                      ,[CSRBAK] = @CSRBAK
                      ,[Cell] = @Cell
                      ,[Extension] = @Extension 
                      ,[Username] = @Username
                      ,[LastModified] = @LastModified
                       Where OSID = @OSID" 
        InsertCommand="INSERT INTO [Receptionist_Web].[dbo].[tblOS]
           ([OSNo]
           ,[OSName]
           ,[ValveAE]
           ,[InstrumentAE]
           ,[VADAE]
           ,[ValveAEBAK]
           ,[InstrumentAEBAK]
           ,[VADAEBak]
           ,[CSR]
           ,[CSRBAK]
           ,[Cell]
           ,[Extension]
           ,[Username]
           ,[LastModified])
     VALUES
           (@OSNo
           ,@OSName
           ,@ValveAE
           ,@InstrumentAE
           ,@VADAE
           ,@ValveAEBAK
           ,@InstrumentAEBAK
           ,@VADAEBak
           ,@CSR
           ,@CSRBAK
           ,@Cell
           ,@Extension 
           ,@Username
           ,@LastModified)">
        <UpdateParameters>
            <asp:Parameter Name="OsNo" />
            <asp:Parameter Name="OSName" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="VADAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="VADAEBak" />
            <asp:Parameter Name="CSRBAK" />
            <asp:Parameter Name="OSID" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
            <asp:SessionParameter SessionField="Username" Name="Username" />
            <asp:SessionParameter SessionField="LastModified"  Name="LastModified" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="OsNo" />
            <asp:Parameter Name="OSName" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="VADAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="VADAEBak" />
            <asp:Parameter Name="CSRBAK" />
            <asp:Parameter Name="OSID" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
            <asp:SessionParameter SessionField="Username" Name="Username" />
            <asp:SessionParameter SessionField="LastModified"  Name="LastModified" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblEmployee" UpdateCommand="UPDATE [Receptionist_Web].[dbo].[tblEmployee]
   SET [EmployeeName] = @EmployeeName
      ,[Cell] = @Cell
      ,[Extension] = @Extension
      ,[ValveAE] = @ValveAE
      ,[InstrumentAE] = @InstrumentAE
      ,[VADAE] = @VADAE
      ,[CSR] = @CSR
      ,[Active] = @Active
 WHERE EmployeeID=@EmployeeID" InsertCommand="INSERT INTO [Receptionist_Web].[dbo].[tblEmployee]
           ([EmployeeName]
           ,[Cell]
           ,[Extension]
           ,[ValveAE]
           ,[InstrumentAE]
           ,[VADAE]
           ,[CSR]
           ,[Active])
     VALUES
           (@EmployeeName
           ,@Cell
           ,@Extension
           ,@ValveAE
           ,@InstrumentAE
           ,@VADAE
           ,@CSR
           ,@Active)">
        <UpdateParameters>
            <asp:Parameter Name="EmployeeName" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="VADAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="Active" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="EmployeeName" />
            <asp:Parameter Name="Cell" />
            <asp:Parameter Name="Extension" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="VADAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="Active" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from Receptionist_Web.dbo.tblExceptions" 
        UpdateCommand="UPDATE [Receptionist_Web].[dbo].[tblExceptions]
   SET [CustomerNo] = @CustomerNo
      ,[CustomerName] = @CustomerName
      ,[City] = @City
      ,[ValveAE] = @ValveAE
      ,[InstrumentAE] = @InstrumentAE
      ,[VADAE] = @VADAE
      ,[ValveAEBAK] = @ValveAEBAK
      ,[InstrumentAEBAK] = @InstrumentAEBAK
      ,[VADAEBak] = @VADAEBak
      ,[CSR] = @CSR
      ,[CSRBAK] = @CSRBAK
      ,[Username] = @Username
      ,[LastModified] = @LastModified
    WHERE id=@id" 
        InsertCommand="INSERT INTO [Receptionist_Web].[dbo].[tblExceptions]
           ([CustomerNo]
           ,[CustomerName]
           ,[City]
           ,[ValveAE]
           ,[InstrumentAE]
           ,[VADAE]
           ,[ValveAEBak]
           ,[InstrumentAEBAK]
           ,[VADAEBak]
           ,[CSR]
           ,[CSRBAK]
           ,[Username]
           ,[LastModified])
     VALUES
           (@CustomerNo
           ,@CustomerName
           ,@City
           ,@ValveAE
           ,@InstrumentAE
           ,@VADAE
           ,@ValveAEBAK
           ,@InstrumentAEBAK
           ,@VADAEBAK
           ,@CSR
           ,@CSRBAK
           ,@Username
           ,@LastModified)">
        <UpdateParameters>
            <asp:Parameter Name="CustomerNo" />
            <asp:Parameter Name="CustomerName" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="VADAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="VADAEBak" />
            <asp:Parameter Name="CSRBAK" />
            <asp:SessionParameter SessionField="Username" Name="Username" />
            <asp:SessionParameter SessionField="LastModified"  Name="LastModified" />
            <asp:Parameter Name="id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerNo" />
            <asp:Parameter Name="CustomerName" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="ValveAE" />
            <asp:Parameter Name="InstrumentAE" />
            <asp:Parameter Name="VADAE" />
            <asp:Parameter Name="CSR" />
            <asp:Parameter Name="ValveAEBAK" />
            <asp:Parameter Name="InstrumentAEBAK" />
            <asp:Parameter Name="VADAEBak" />
            <asp:Parameter Name="CSRBAK" />
            <asp:SessionParameter SessionField="Username" Name="Username" />
            <asp:SessionParameter SessionField="LastModified"  Name="LastModified" />
            <asp:Parameter Name="id" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValveAE" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where valveae = 1 and active = 1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsInstrumentAE" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where instrumentAE = 1 and active = 1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsVADAE" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where VADAE = 1 and active = 1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCSR" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Receptionist_Web.dbo.tblemployee where csr = 1 and active = 1"></asp:SqlDataSource>
</asp:Content>

