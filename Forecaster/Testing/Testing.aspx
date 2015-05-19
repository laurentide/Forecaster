<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Testing.aspx.vb" Inherits="Forecaster.Testing" MasterPageFile="~/FunnelSite.Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Testing</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
          <Triggers>
           <asp:PostBackTrigger ControlID="testInsert" />
          </Triggers>
        <ContentTemplate>
        <asp:FormView ID="testInsert" runat="server" DefaultMode="Insert" DataSourceID="sdsInsert" OnDataBound="testInsert_DataBound">            
        <EditItemTemplate>
        <Table>
                        <tr>
                            <td>Testing ID:
                            </td>
                            <td>
                                <asp:TextBox ID="TestingID" runat="server" Text='<%# Eval("TestingID") %>' />
                            </td>
                        </tr>
        </Table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>Test:</td>
                    <td>
                        <asp:TextBox ID="TestTextBox" runat="server" Text='<%# Bind("Test")%>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" ValidationGroup="Insert" />
                    </td>
                </tr>  
            </table>
        </InsertItemTemplate>
        </asp:FormView>
        <asp:GridView ID="testEdit" runat="server" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"
                HeaderStyle-CssClass="grid_Header"
                RowStyle-CssClass="grid_RowStyle" DefaultMode="Edit" DataKeyNames="TestingID" DataSourceID="sdsEdit"
                CellPadding="4" ForeColor="#333333"
                Font-Size="10px" PageSize="50" OnSelectedIndexChanged="testEdit_SelectedIndexChanged">
            <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this request?');" />
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:CommandField ShowSelectButton="True" SelectText="Edit"/>
                    <asp:BoundField DataField="TestingID" HeaderText="TestingID" InsertVisible="False" ReadOnly="True" SortExpression="TestingID" />
            </Columns>
        </asp:GridView>
        </ContentTemplate>
        </asp:UpdatePanel>
    <asp:SqlDataSource ID="sdsInsert" runat="server" ConnectionString='<%$ ConnectionStrings:TestingConnectionString %>'
        SelectCommand="SELECT TestingID FROM tblTesting WHERE TestingID = @ID"
        InsertCommand="INSERT INTO [tblTesting]
        ([Test])
        VALUES
        (@Test)">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="testEdit" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="Test" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsEdit" runat="server" ConnectionString='<%$ ConnectionStrings:TestingConnectionString %>'
        SelectCommand="SELECT * FROM tblTesting"></asp:SqlDataSource>
</asp:Content>