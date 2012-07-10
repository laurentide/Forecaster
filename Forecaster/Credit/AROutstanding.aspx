<%@ Page Title="AR Tool" Language="vb" MasterPageFile="~/FunnelSite.Master" AutoEventWireup="false" CodeBehind="AROutstanding.aspx.vb" Inherits="Forecaster.AROutstanding" %>
<%@ Register Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" TagPrefix="RK" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent"></asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>AR Outstanding</h2>
<%--   <asp:ScriptManager ID="ScriptManager" runat="server" />--%>

   <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
   <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <ClientEvents OnRequestStart="RequestStart" />
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <%--<telerik:AjaxUpdatedControl ControlID="panEdit" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="WebBlue" IsSticky="true" runat="server" Style="position: absolute; top: 0; left: 0; height: 100%; width: 100%;">
        <%--<asp:Label ID="Label2" runat="server" ForeColor="Red">Loading... </asp:Label><br />--%>
<%--        <asp:Image ID="Image1" runat="server" ImageUrl="../_assets/img/update_progress.gif">
        </asp:Image>--%>
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">

    // the following Javascript method takes care of expanding the RadAjaxLoadingPanel
    // to the full height of the page, if it is more than the browser window viewport

    function RequestStart(sender, args)
    {
	    if (document.documentElement.scrollHeight > document.documentElement.clientHeight)
	    {
		    $get("<%= RadAjaxLoadingPanel1.ClientID %>").style.height = document.documentElement.scrollHeight + "px";
	    }
    }
    </script>
    </telerik:RadCodeBlock>

    <asp:CollapsiblePanelExtender 
        ID="CollapsiblePanelExtender11" 
        runat="server" 
        TargetControlID="PanFilters"
        ExpandControlID="PanHeadFilters" 
        CollapseControlID="PanHeadFilters" 
        TextLabelID="Label12" 
        CollapsedText="Filters (...)"
        ExpandedText="Hide Filter Dialog (...)" 
        ImageControlID="Image12" 
        ExpandedImage="/Content/images/collapse_blue.jpg"
        CollapsedImage="/Content/images/expand_blue.jpg" 
        Collapsed="True" 
        SuppressPostBack="true">
    </asp:CollapsiblePanelExtender>
    <asp:Panel ID="PanHeadFilters" runat="server" CssClass="collapsePanelHeader">
        <asp:Image ID="Image12" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
        <asp:Label ID="Label12" runat="server" Text="Filters (...)"></asp:Label>
    <br />

    </asp:Panel>
    <asp:Panel ID="PanFilters" runat="server" CssClass="collapsePanelFilter">
    <table>
    </table>
    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Nomis.dbo.ArOutStanding_Grouped"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from nomis.dbo.AROutstanding Where CustNumber = @CustNumber">
            <SelectParameters>
                <asp:SessionParameter Name="CustNumber" SessionField="CustNumber" Type="string" DefaultValue="" />
            </SelectParameters>
    </asp:SqlDataSource>
    
 <%--   <asp:UpdatePanel runat="server" ID="updGrid">
    <ContentTemplate>--%>
        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" DataSourceID="SqlDataSource1" GridLines="None" ShowGroupPanel="False" AllowFilteringByColumn="True" AllowSorting="True" AutoGenerateColumns="False">
            <ClientSettings AllowDragToGroup="True" Resizing-AllowResizeToFit="false" Resizing-AllowColumnResize="true"></ClientSettings>
            <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="CustNumber">
                <DetailTables>
                    <telerik:GridTableView runat="server" DataSourceID="SqlDataSource2" DataKeyNames="INVOICE">
                        <ParentTableRelation>
                            <telerik:GridRelationFields DetailKeyField="CustNumber" MasterKeyField="CustNumber" />
                        </ParentTableRelation>
                        <Columns>
                            <%--<telerik:GridBoundColumn DataField="CustNumber" DataType="System.Decimal" FilterControlAltText="Filter CustNumber column" HeaderText="CustNumber" SortExpression="CustNumber" UniqueName="CustNumber" />
                            <telerik:GridBoundColumn DataField="CUSTNAME" FilterControlAltText="Filter CUSTNAME column" HeaderText="CUSTNAME" SortExpression="CUSTNAME" UniqueName="CUSTNAME" />--%>
                            <telerik:GridBoundColumn DataField="INVOICE" FilterControlAltText="Filter INVOICE column" HeaderText="INVOICE" SortExpression="INVOICE" UniqueName="INVOICE" />
                            <telerik:GridBoundColumn DataField="CURRENCY" FilterControlAltText="Filter CURRENCY column" HeaderText="CURRENCY" SortExpression="CURRENCY" UniqueName="CURRENCY" />
                            <telerik:GridBoundColumn DataField="DIV" FilterControlAltText="Filter DIV column" HeaderText="Division" SortExpression="Div" UniqueName="Div" />
                            <telerik:GridBoundColumn DataField="DATEDUE" DataType="System.DateTime" FilterControlAltText="Filter DATEDUE column" HeaderText="DATEDUE" SortExpression="DATEDUE" UniqueName="DATEDUE" DataFormatString="{0:d}" />
                            <telerik:GridBoundColumn DataField="DATEINV" DataType="System.DateTime" FilterControlAltText="Filter DATEINV column" HeaderText="DATEINV" SortExpression="DATEINV" UniqueName="DATEINV" DataFormatString="{0:d}" />
                            <telerik:GridBoundColumn DataField="INVAMOUNT" DataType="System.Decimal" FilterControlAltText="Filter INVAMOUNT column" HeaderText="INVAMOUNT" SortExpression="INVAMOUNT" UniqueName="INVAMOUNT" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="PAYMENTTD" DataType="System.Decimal" FilterControlAltText="Filter PAYMENTTD column" HeaderText="PAYMENTTD" SortExpression="PAYMENTTD" UniqueName="PAYMENTTD" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="FXRATE" DataType="System.Decimal" FilterControlAltText="Filter FXRATE column" HeaderText="FXRATE" SortExpression="FXRATE" UniqueName="FXRATE" />
                            <%--<telerik:GridBoundColumn DataField="SLS#" FilterControlAltText="Filter SLS# column" HeaderText="SLS#" SortExpression="SLS#" UniqueName="SLS#" />--%>
                            <telerik:GridBoundColumn DataField="CUST_PO" FilterControlAltText="Filter CUST_PO column" HeaderText="CUST_PO" SortExpression="CUST_PO" UniqueName="CUST_PO" />
                            <telerik:GridBoundColumn DataField="Current" DataType="System.Decimal" FilterControlAltText="Filter Current column" HeaderText="Current" SortExpression="Current" UniqueName="Current" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="Over 30" DataType="System.Decimal" FilterControlAltText="Filter Over 30 column" HeaderText="Over 30" SortExpression="Over 30" UniqueName="Over30" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="Over 45" DataType="System.Decimal" FilterControlAltText="Filter Over 45 column" HeaderText="Over 45" SortExpression="Over 45" UniqueName="Over45" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="Over 60" DataType="System.Decimal" FilterControlAltText="Filter Over 60 column" HeaderText="Over 60" SortExpression="Over 60" UniqueName="Over60" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="Over 90" DataType="System.Decimal" FilterControlAltText="Filter Over 90 column" HeaderText="Over 90" SortExpression="Over 90" UniqueName="Over90" DataFormatString="{0:c}" />
                            <telerik:GridBoundColumn DataField="Over 120" DataType="System.Decimal" FilterControlAltText="Filter Over 120 column" HeaderText="Over 120" SortExpression="Over 120" UniqueName="Over120" DataFormatString="{0:c}" />
                            <%--<telerik:GridBoundColumn DataField="Div" FilterControlAltText="Filter Div column" HeaderText="Div" SortExpression="Div" UniqueName="Div" />--%>
                        </Columns>
                    </telerik:GridTableView>
                </DetailTables>
                <Columns>
                    <telerik:GridButtonColumn Text="Select" CommandName="Select"></telerik:GridButtonColumn>               
                    <telerik:GridBoundColumn DataField="CustNumber" DataType="System.Decimal" FilterControlAltText="Filter CustNumber column" HeaderText="CustNumber" SortExpression="CustNumber" UniqueName="CustNumber" />
                    <telerik:GridBoundColumn DataField="Custname" FilterControlAltText="Filter Custname column" HeaderText="Cust Name" SortExpression="Custname" UniqueName="Custname" />
                    <%--<telerik:GridBoundColumn DataField="SLS#" FilterControlAltText="Filter SLS# column" HeaderText="SLS#" SortExpression="SLS#" UniqueName="SLS#" />--%>
                    <%--<telerik:GridBoundColumn DataField="Number of invoices" DataType="System.Int32" FilterControlAltText="Filter Number of invoices column" HeaderText="# Inv" ReadOnly="True" SortExpression="Number of invoices" UniqueName="Numberofinvoices" AllowFiltering="False" />--%>
                    <%--<telerik:GridBoundColumn DataField="closest due" DataType="System.DateTime" FilterControlAltText="Filter closest due column" HeaderText="Closest due" ReadOnly="True" SortExpression="Closest Due" UniqueName="closestdue" AllowFiltering="False" DataFormatString="{0:d}" />--%>
                    <%--<telerik:GridBoundColumn DataField="Oldest Invoice Date" DataType="System.DateTime" FilterControlAltText="Filter Oldest Invoice Date column" HeaderText="Oldest Inv Date" ReadOnly="True" SortExpression="Oldest Invoice Date" UniqueName="OldestInvoiceDate" AllowFiltering="False" DataFormatString="{0:d}" />--%>
                    <telerik:GridBoundColumn DataField="Total Invoiced" DataType="System.Decimal" FilterControlAltText="Filter Total Invoiced column" HeaderText="Total Invoiced" ReadOnly="True" SortExpression="Total Invoiced" UniqueName="TotalInvoiced" DataFormatString="{0:c}" AllowFiltering="False" />
                    <telerik:GridBoundColumn DataField="Sum of Payments to Date" DataType="System.Decimal" FilterControlAltText="Filter Sum of Payments to Date column" HeaderText="PTD" ReadOnly="True" SortExpression="Sum of Payments to Date" UniqueName="SumofPaymentstoDate" DataFormatString="{0:c}" AllowFiltering="False" />
                    <telerik:GridBoundColumn DataField="Current" DataType="System.Decimal" FilterControlAltText="Filter Current Outstanding column" HeaderText="Current Outstanding" ReadOnly="True" SortExpression="Current Outstanding" UniqueName="CurrentOutstanding" DataFormatString="{0:c}" />
                    <telerik:GridBoundColumn DataField="Over 30" DataType="System.Decimal" FilterControlAltText="Filter Over 30 column" HeaderText="Over 30" ReadOnly="True" SortExpression="Over 30" UniqueName="Over30" DataFormatString="{0:c}" />
                    <telerik:GridBoundColumn DataField="Over 45" DataType="System.Decimal" FilterControlAltText="Filter Over 45 column" HeaderText="Over 45" ReadOnly="True" SortExpression="Over 45" UniqueName="Over45" DataFormatString="{0:c}" />
                    <telerik:GridBoundColumn DataField="Over 60" DataType="System.Decimal" FilterControlAltText="Filter Over 60 column" HeaderText="Over 60" ReadOnly="True" SortExpression="Over 60" UniqueName="Over60" DataFormatString="{0:c}" />
                    <telerik:GridBoundColumn DataField="Over 90" DataType="System.Decimal" FilterControlAltText="Filter Over 90 column" HeaderText="Over 90" ReadOnly="True" SortExpression="Over 90" UniqueName="Over90" DataFormatString="{0:c}" />
                    <telerik:GridBoundColumn DataField="Over 120" DataType="System.Decimal" FilterControlAltText="Filter Over 120 column" HeaderText="Over 120" ReadOnly="True" SortExpression="Over 120" UniqueName="Over120" DataFormatString="{0:c}" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
<%--    </ContentTemplate>
    </asp:UpdatePanel>--%>

    <%--Modal Popup for updating --%>
    <asp:ModalPopupExtender ID="modalpopupextender1" runat="server" TargetControlID="FakeTarget" PopupControlID="panEdit" Drag="false" BackgroundCssClass="modalBackground" />
    <asp:Panel ID="panEdit" runat="server" CssClass="ModalWindowAR" ScrollBars="auto">
        <asp:UpdatePanel  ID="UpdatePanel1" runat="server">
          <ContentTemplate>
          <%--<elerik:RadAjaxPanel ID="pen" runat="server" CssClass="ModalWindow" ScrollBars="auto"> --%>
            <asp:FormView ID="frmUpdate" runat="server" DataKeyNames="CustNumber" DefaultMode="Edit" DataSourceID="sdsUpdate" OnDataBound="frmUpdate_DataBound">
                <EditItemTemplate>
                <asp:Label ID="CustNameLabel" style="font-size:large; font-weight:bold;" runat="server" Text='<%# Bind("CACSTX") %>' /> 
                <table>
                    <tr><td style="font-weight:bold;">ID: </td><td><asp:Label ID="CustIDLabel" runat="server" Text='<%# Bind("CustNumber") %>' />                                       </td><td style="font-weight:bold;">Current: </td><td><asp:Label ID="OutstandingLabel" runat="server" Text='<%# Bind("[Current Outstanding]","{0:c}") %>' />         <td style="font-weight:bold;">AR Contact: </td><td><asp:Textbox ID="ARContact" runat="server" Text='<%# Bind("[ARContact]") %>' />                                 </td></tr>                                                     
					<tr><td style="font-weight:bold;">TC: </td><td><asp:Label ID="CustTCLabel" runat="server" Text='<%# Bind("CADUCD") %>' />                                           </td><td style="font-weight:bold;">Over 30: </td><td><asp:Label ID="Over30Label" runat="server" Text='<%# Bind("[Over 30]","{0:c}") %>' />                          <td style="font-weight:bold;">AR Contact Tel: </td><td><asp:Textbox ID="ARContactTel" runat="server" Text='<%# Bind("[ARContactTel]") %>' />                       </td></tr>                       
					<tr><td style="font-weight:bold;">Payment Terms: </td><td><asp:Label ID="CustPayTermLabel" runat="server" Text='<%# Bind("GHPNCD") %>' />                           </td><td style="font-weight:bold;">Over 45: </td><td><asp:Label ID="Over45Label" runat="server" Text='<%# Bind("[Over 45]","{0:c}") %>' />                          <td style="font-weight:bold;">AR Contact Fax: </td><td><asp:Textbox ID="ARContactFax" runat="server" Text='<%# Bind("[ARContactFax]") %>' />                       </td></tr>                       
					<tr><td style="font-weight:bold;">Total Invoiced: </td><td><asp:Label ID="CurLabel" runat="server" Text='<%# Bind("[Total Invoiced]","{0:c}") %>' />                </td><td style="font-weight:bold;">Over 60: </td><td><asp:Label ID="Over60Label" runat="server" Text='<%# Bind("[Over 60]","{0:c}") %>' />                          <td style="font-weight:bold;">AR Contact Email: </td><td><asp:Textbox ID="ARContactEmail" runat="server" Text='<%# Bind("[ARContactEmail]") %>' />                 </td></tr>                 
					<tr><td style="font-weight:bold;">Payment To Date: </td><td><asp:Label ID="PaymentLabel" runat="server" Text='<%# Bind("[Sum of Payments to date]","{0:c}") %>' />  </td><td style="font-weight:bold;">Over 90: </td><td><asp:Label ID="Over90Label" runat="server" Text='<%# Bind("[Over 90]","{0:c}") %>' />                          <td style="font-weight:bold;">Financial Director: </td><td><asp:Textbox ID="FinDirContact" runat="server" Text='<%# Bind("[FinDirContact]") %>' />                 </td></tr>                 
					<tr><td style="font-weight:bold;">Credit Limit: </td><td><asp:Label ID="CreditLimitLabel" runat="server" Text='<%# Bind("GHUPVA","{0:c}") %>' />                    </td><td style="font-weight:bold;">Over 120: </td><td><asp:Label ID="Over120Label" runat="server" Text='<%# Bind("[Over 120]","{0:c}") %>' />                       <td style="font-weight:bold;">Financial Director Tel: </td><td><asp:Textbox ID="FinDirContactTel" runat="server" Text='<%# Bind("[FinDirContactTel]") %>' />       </td></tr>       
					<tr><td style="font-weight:bold;">Credit Limit (When not on hold):</td><td><asp:Textbox ID="OldCreditLimit" runat="server" Text='<%# Bind("[OldCreditLimit]") %>' /></td><td style="font-weight:bold;">Followup Date </td><td><asp:TextBox ID="Followup" runat="server" Text='<%# Bind("[Followup]","{0:d}") %>' /><asp:CalendarExtender ID="CalendarExtender1" runat="server"  TargetControlID="Followup" Format="MM/dd/yyyy"/></td><td style="font-weight:bold;">Financial Director Email: </td><td><asp:Textbox ID="FinDirContactEmail" runat="server" Text='<%# Bind("[FinDirContactEmail]") %>' /> </td></tr> 
                </table>
                <h2>Nomis Customer Notes</h2>
                <input type="button" name="type" value="Show notes" onclick="setVisibility('divNotes', 'inline');"><input type="button" name="type" value="Hide notes" onclick="setVisibility('divNotes', 'none');"> 
                <br />
                <div id="divNotes" style="display:none;">
                    <asp:Textbox ID="Notes" runat="server" Wrap="true" TextMode="MultiLine" width="100%" ReadOnly="true"  Text='<%# Bind("[Notes]") %>' />
                </div>
                </EditItemTemplate>
            </asp:FormView>            
            <h2>Comments</h2>
            <telerik:Radgrid id="Radgrid3" runat="server" Skin="WebBlue" AllowAutomaticInserts="True" AllowFilteringByColumn="False" AllowSorting="True" DataSourceID="sdsCustComments" OnInsertCommand="RadGrid3_InsertCommand">
                <MasterTableView CommandItemDisplay="Top"  AutoGenerateColumns="False"  DataKeyNames="CustNumber" DataSourceID="sdsCustComments">
                    <Columns>
                        <telerik:GridBoundColumn DataField="CommentDate"  HeaderStyle-Width="250px" DataType="System.DateTime" HeaderText="Date" ReadOnly="true" />
                        <telerik:GridBoundColumn DataField="Username" HeaderStyle-Width="250px" HeaderText="By" ReadOnly="true"/>
                        <telerik:GridBoundColumn DataField="Comment" HeaderStyle-Width="500px" HeaderText="Comment"/>
                    </Columns>
                </MasterTableView>                
            </telerik:Radgrid>
            <h2>Invoices</h2>
            <telerik:Radgrid id="Radgrid2" runat="server" OnInsertCommand="RadGrid2_InsertCommand" AllowFilteringByColumn="False" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="sdsInvoiceGrid" Skin="WebBlue">
                <MasterTableView DataKeyNames="INVOICE"  DataSourceID="sdsInvoiceGrid" HierarchyDefaultExpanded="false">
                    <DetailTables>
                        <telerik:GridTableView GroupsDefaultExpanded="true" runat="server" DataSourceID="sdsInvoiceComments" DataKeyNames="Invoice" AllowAutomaticInserts="true" CommandItemDisplay="Top">
                             <ParentTableRelation>
                                <telerik:GridRelationFields DetailKeyField="Invoice" MasterKeyField="INVOICE" />
                            </ParentTableRelation>
                            <Columns>
                                <%--<telerik:GridBoundColumn% DataField="Invoice" HeaderText="Invoice Number" readonly="true" />--%>
                                <telerik:GridBoundColumn DataField="CommentDate" HeaderStyle-Width="250px" DataType="System.DateTime" HeaderText="Date" readonly="true" />
                                <telerik:GridBoundColumn DataField="Username" HeaderStyle-Width="250px" HeaderText="By" readonly="true"/>
                                <telerik:GridBoundColumn DataField="Comment"  HeaderStyle-Width="500px" HeaderText="Comment" />
                            </Columns>
                        </telerik:GridTableView>
                    </DetailTables>
                    <Columns>
                        <%--<telerik:GridBoundColumn DataField="CustNumber" DataType="System.Decimal" FilterControlAltText="Filter CustNumber column" HeaderText="CustNumber" SortExpression="CustNumber" UniqueName="CustNumber" />
                        <telerik:GridBoundColumn DataField="CUSTNAME" FilterControlAltText="Filter CUSTNAME column" HeaderText="CUSTNAME" SortExpression="CUSTNAME" UniqueName="CUSTNAME" />--%>
                        <telerik:GridBoundColumn DataField="INVOICE" FilterControlAltText="Filter INVOICE column" HeaderText="INVOICE" SortExpression="INVOICE" UniqueName="INVOICE" />
                        <telerik:GridBoundColumn DataField="DIV" FilterControlAltText="Filter DIV column" HeaderText="Division" SortExpression="Div" UniqueName="Div" />
                        <telerik:GridBoundColumn DataField="CURRENCY" FilterControlAltText="Filter CURRENCY column" HeaderText="CURRENCY" SortExpression="CURRENCY" UniqueName="CURRENCY" />
                        <telerik:GridBoundColumn DataField="DATEDUE" DataType="System.DateTime" FilterControlAltText="Filter DATEDUE column" HeaderText="DATEDUE" SortExpression="DATEDUE" UniqueName="DATEDUE" DataFormatString="{0:d}" />
                        <telerik:GridBoundColumn DataField="DATEINV" DataType="System.DateTime" FilterControlAltText="Filter DATEINV column" HeaderText="DATEINV" SortExpression="DATEINV" UniqueName="DATEINV" DataFormatString="{0:d}" />
                        <telerik:GridBoundColumn DataField="INVAMOUNT" DataType="System.Decimal" FilterControlAltText="Filter INVAMOUNT column" HeaderText="INVAMOUNT" SortExpression="INVAMOUNT" UniqueName="INVAMOUNT" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="PAYMENTTD" DataType="System.Decimal" FilterControlAltText="Filter PAYMENTTD column" HeaderText="PAYMENTTD" SortExpression="PAYMENTTD" UniqueName="PAYMENTTD" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="FXRATE" DataType="System.Decimal" FilterControlAltText="Filter FXRATE column" HeaderText="FXRATE" SortExpression="FXRATE" UniqueName="FXRATE" />
                        <%--<telerik:GridBoundColumn DataField="SLS#" FilterControlAltText="Filter SLS# column" HeaderText="SLS#" SortExpression="SLS#" UniqueName="SLS#" />--%>
                        <telerik:GridBoundColumn DataField="CUST_PO" FilterControlAltText="Filter C5UST_PO column" HeaderText="CUST_PO" SortExpression="CUST_PO" UniqueName="CUST_PO" />
                        <telerik:GridBoundColumn DataField="Current" DataType="System.Decimal" FilterControlAltText="Filter Current column" HeaderText="Current" SortExpression="Current" UniqueName="Current" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="Over 30" DataType="System.Decimal" FilterControlAltText="Filter Over 30 column" HeaderText="Over 30" SortExpression="Over 30" UniqueName="Over30" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="Over 45" DataType="System.Decimal" FilterControlAltText="Filter Over 45 column" HeaderText="Over 45" SortExpression="Over 45" UniqueName="Over45" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="Over 60" DataType="System.Decimal" FilterControlAltText="Filter Over 60 column" HeaderText="Over 60" SortExpression="Over 60" UniqueName="Over60" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="Over 90" DataType="System.Decimal" FilterControlAltText="Filter Over 90 column" HeaderText="Over 90" SortExpression="Over 90" UniqueName="Over90" DataFormatString="{0:c}" />
                        <telerik:GridBoundColumn DataField="Over 120" DataType="System.Decimal" FilterControlAltText="Filter Over 120 column" HeaderText="Over 120" SortExpression="Over 120" UniqueName="Over120" DataFormatString="{0:c}" />
                        <%--<telerik:GridBoundColumn DataField="Div" FilterControlAltText="Filter Div column" HeaderText="Div" SortExpression="Div" UniqueName="Div" />--%>
                    </Columns>
                </MasterTableView>
            </telerik:Radgrid>
            <asp:button id="btnupdate" runat="server" text="Update" onclick="update" validationgroup="update"/> 
            <asp:Button id="btndone" runat="server" text="Done" onclick="refreshlistview" validationgroup="update"  />
            <asp:Button id="btncancel" runat="server" text="Cancel" onclick="cancel" causesvalidation="false" validationgroup="update" />
            <%--<asp:button id="btndelete" runat="server" text="delete" onclick="delete" onclientclick="return confirm('are you sure you want to delete this opportunity?');" />--%>
            <asp:label id="lblnotification" runat="server" /><br />
            <asp:validationsummary id="validationsummary1" validationgroup="update" runat="server"  displaymode="bulletlist" cssclass="errors" />
            </ContentTemplate>
        </asp:UpdatePanel> 
    </asp:Panel>   
<%--    </telerik:RadAjaxPanel>--%>
    <asp:Button ID="FakeTarget" runat="server" Style="display: none;" />
    <asp:SqlDataSource ID="sdsUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
    SelectCommand="select * 
                from Nomis.S1018252.NOMDBF95.CUSPHY01
                inner join Nomis.dbo.ArOutStanding_Grouped a on custnumber = cazxnb
                inner join Nomis.S1018252.NOMDBF95.UUGHREP on cazxnb = ghzxnb and ghaqnb = caaqnb
                left join Nomis.dbo.tblARCust b on b.custnumber = cazxnb
                left join Nomis.dbo.tblARCustNotes c on c.custnumber = cazxnb
                where caaqnb = '1'
                and a.CustNumber = @CustNumber">
        <SelectParameters>
            <asp:SessionParameter Name = "CustNumber" SessionField="CustNumber" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsInvoiceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" SelectCommand="select * from Nomis.dbo.ArOutStanding where custnumber = @custnumber">
        <SelectParameters>
            <asp:SessionParameter Name = "CustNumber" SessionField="CustNumber" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsInvoiceComments" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from Nomis.dbo.tblARInvoiceComments where Invoice = @Invoice"
        InsertCommand="INSERT INTO [Nomis].[dbo].[tblARInvoiceComments] ([CustNumber],[Invoice],[CommentDate],[Username],[Comment]) VALUES (@CustNumber,@Invoice,@CommentDate,@Username,@Comment)">
        <SelectParameters>
            <asp:Parameter Name ="Invoice" />
        </SelectParameters>
        <InsertParameters>
            <asp:SessionParameter Name = "CustNumber" SessionField="CustNumber" />
            <asp:Parameter Name="Invoice" />
            <asp:SessionParameter Name = "UserName" SessionField="USername" />
            <asp:Parameter Name="CommentDate" />
            <asp:Parameter Name="Comment" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCustComments" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from Nomis.dbo.tblARCustomersComments where custNumber = @CustNumber"
        InsertCommand="INSERT INTO [Nomis].[dbo].[tblARCustomersComments]([CustNumber],[CommentDate],[UserName],[Comment]) VALUES (@CustNumber,@CommentDate,@UserName,@Comment)">
        <SelectParameters>
            <asp:SessionParameter Name = "CustNumber" SessionField="CustNumber" />
        </SelectParameters>
        <InsertParameters>
            <asp:SessionParameter Name = "CustNumber" SessionField="CustNumber" />
            <asp:SessionParameter Name = "UserName" SessionField="Username" />
            <asp:Parameter Name="CommentDate" />
            <asp:Parameter Name="Comment" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
