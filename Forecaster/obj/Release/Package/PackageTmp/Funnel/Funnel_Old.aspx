<%@ Page Title="Segments and Customers" Language="vb" MasterPageFile="~/Site.Master"
    AutoEventWireup="false" CodeBehind="Funnel.aspx.vb" Inherits="Forecaster.Funnel_Old" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>
        Funnel Management
    </h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
        
    <%--Insert pane--%>
    <asp:CollapsiblePanelExtender 
        ID="CollapsiblePanelExtender10" 
        runat="server" 
        TargetControlID="insertPane"
        ExpandControlID="insertHeadPane" 
        CollapseControlID="insertHeadPane" 
        TextLabelID="Label1" 
        CollapsedText="Insert New Opportunity(...)"
        ExpandedText="Hide Dialog (...)" 
        ImageControlID="Image1" 
        ExpandedImage="/Content/images/collapse_blue.jpg"
        CollapsedImage="/Content/images/expand_blue.jpg" 
        Collapsed="True" 
        SuppressPostBack="true">
    </asp:CollapsiblePanelExtender>
    <asp:Panel ID="insertHeadPane" runat="server" CssClass="collapsePanelHeader">
        <asp:Image ID="Image1" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
        <asp:Label ID="Label1" runat="server" Text="Wireless Details(...)"></asp:Label>
    </asp:Panel>
    <asp:Panel ID="insertPane" runat="server" CssClass="collapsePanel">
                <asp:Accordion ID="Accordion3" 
                        CssClass="subaccordion" 
                        HeaderCssClass="subaccordionHeader"
                        HeaderSelectedCssClass="subaccordionHeaderSelected" 
                        ContentCssClass="subaccordionContent"
                        runat="server" 
                        FadeTransitions="true" 
                        TransitionDuration="100"
                        SuppressHeaderPostbacks="true">
                        <Panes>
                            <asp:AccordionPane runat="server" ID="Pane3">
                                <Header>
                                    General Info
                                </Header>
                                <Content>
                                <asp:FormView ID="FormView2" runat="server" DataKeyNames="OpportunityID" DataSourceID="SqlDataSource1" DefaultMode="Insert" OnItemInserted="Formview2_ItemInserted">
                                    <EditItemTemplate></EditItemTemplate>
                                    <InsertItemTemplate>
                                    <table>
                                        <%--<tr><td>OpportunityID: </td><td><asp:Label ID="OpportunityIDLabel1" runat="server" Text='<%# Bind("OpportunityID") %>' /></td>--%>
                                        <tr><td>Name: </td><td><asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Name") %>' /></td></tr>
                                        <tr><td>Originator: </td><td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Originator") %>' /></td></tr>
                                        <tr><td>Customer ID: </td><td><asp:dropdownlist ID="DropDownList1" runat="server" Text='<%# Bind("CustomerID") %>' /></td></tr>
                                        <tr><td>Customer Location: </td><td><asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("CustomerLocation") %>' /></td></tr>
                                        <tr><td>EPC/Consultant: </td><td><asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("EPCConsultant") %>' /></td></tr>
                                        <tr><td>Salesman: </td><td><asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("SalesmanID") %>' /></td></tr>
                                        <%--<tr><td>Created Date: </td><td><asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("CreateDate") %>' /></td></tr>--%>
                                        <%--<tr><td>Last Modified Date: </td><td><asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("LastModifiedDate") %>' /></td></tr>--%>
                                        <tr><td>Closing Date: </td><td><asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("ClosingDate") %>' /></td></tr>
                                        <tr><td>Origin: </td><td><asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("Origin") %>' /></td></tr>
                                        <tr><td>Funnel Position: </td><td><asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("FunnelPositionID") %>' /></td></tr>
                                        <tr><td>Percentage: </td><td><asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("Percentage") %>' /></td></tr>
                                        <tr><td>PATTID: </td><td><asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("PATTID") %>' /></td></tr>
                                        <tr><td>Description </td><td><asp:TextBox ID="TextBox1" TextMode="MultiLine" runat="server" Text='<%# Bind("Description") %>' /></td></tr>
                                        <tr><td>Total: </td><td><asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("Total") %>' /></td></tr>
                                        <tr><td>Factored Total: </td><td><asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("FactoredTotal") %>' /></td></tr>
                                        </table>
                                        <asp:linkbutton id="InsertButton" text="Insert" commandname="Insert" runat="server" />
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                    </ItemTemplate>
                                    </asp:FormView>    
                                    </Content>
                            </asp:AccordionPane>
                            <asp:AccordionPane runat="server" ID="Pane4" Visible = "true">
                                <Header>
                                    Product Forecast
                                </Header>
                                <Content>
                                    <%-- Gridview that contains product details and forecast, needs to link to header --%>
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                        DataKeyNames="OpportunityDetailID,FunnelProductID1" datasourceid="SqlDataSource2">
                                    <Columns>
                                    <asp:BoundField DataField="ProductCategory" HeaderText="Product Category" 
                                        SortExpression="ProductCategory"  />
<%--                                    <asp:BoundField DataField="Total" HeaderText="Total $" SortExpression="Total" 
                                        DataFormatString="{0:c}"/>--%>
                                    <asp:TemplateField HeaderText="Total $">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTotal" runat="server" Text='<%# Eval("Total") %>' DataFormatString="{0:c0}"  />
                                        </ItemTemplate>
                                    </asp:TemplateField>
<%--                                    <asp:BoundField DataField="Percentage" HeaderText="% Probability" 
                                        SortExpression="Percentage" DataFormatString="{0:p0}" />--%>
                                    <asp:TemplateField HeaderText="Percentage">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPercentage" runat="server" Text='<%# Eval("Percentage") %>' DataFormatString="{0:c0}"  />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                        <asp:CollapsiblePanelExtender 
                                            ID="CollapsiblePanelExtender1" 
                                            runat="server" 
                                            TargetControlID="Panel8"
                                            ExpandControlID="Panel7" 
                                            CollapseControlID="Panel7" 
                                            TextLabelID="Label2" 
                                            CollapsedText="BM Extra Info"
                                            ExpandedText="Hide Dialog" 
                                            ImageControlID="Image2" 
                                            ExpandedImage="/Content/images/collapse_blue.jpg"
                                            CollapsedImage="/Content/images/expand_blue.jpg" 
                                            Collapsed="True" 
                                            SuppressPostBack="true"
                                            ExpandDirection="Horizontal">
                                        </asp:CollapsiblePanelExtender>
                                        <asp:Panel ID="Panel7" runat="server" CssClass="collapsePanelHeader">
                                            <asp:Image ID="Image2" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                            <asp:Label ID="Label2" runat="server" Text="BM"></asp:Label>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel8" runat="server" CssClass="collapsePanel">
                                            <table>
                                                <tr><td>Expected RFQ Rec'd Date</td>    <td><asp:TextBox ID="TextBox78" Text='<%# DataBinder.Eval(Container.DataItem, "ExpectedRFQDate") %>' runat="server" /></td></tr>
                                                <tr><td>Date Rec'd In House</td><td><asp:TextBox ID="TextBox74" Text='<%# DataBinder.Eval(Container.DataItem, "DateRecInHouse") %>' runat="server" /></td></tr>
                                                <tr><td>Due Date</td><td><asp:TextBox ID="TextBox75" Text='<%# DataBinder.Eval(Container.DataItem, "DueDate") %>' runat="server" /></td></tr>
                                                <tr><td>Proposal Eng Lead</td><td><asp:TextBox ID="TextBox76" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalEngLead") %>' runat="server" /></td></tr>
                                                <tr><td>Proposal Coordinator</td><td><asp:TextBox ID="TextBox80" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalCoordinator") %>' runat="server" />  </td>  </tr>  
                                                <tr><td>Exec Sponsor</td><td><asp:TextBox ID="TextBox77" Text='<%# DataBinder.Eval(Container.DataItem, "ExecSponsor") %>' runat="server" /></td></tr>
                                                <tr><td>Product Sales Lead/Sol'n Architect</td><td><asp:TextBox ID="TextBox79" Text='<%# DataBinder.Eval(Container.DataItem, "ProductSalesLead") %>' runat="server" /></td></tr>
                                            </table>        
                                        </asp:Panel>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CollapsiblePanelExtender 
                                                ID="CollapsiblePanelExtender2" 
                                                runat="server" 
                                                TargetControlID="Panel10"
                                                ExpandControlID="Panel9" 
                                                CollapseControlID="Panel9" 
                                                TextLabelID="Label3" 
                                                CollapsedText="PSS"
                                                ExpandedText="Hide" 
                                                ImageControlID="Image3" 
                                                ExpandedImage="/Content/images/collapse_blue.jpg"
                                                CollapsedImage="/Content/images/expand_blue.jpg" 
                                                Collapsed="True" 
                                                SuppressPostBack="true"
                                                ExpandDirection="Horizontal">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel9" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image3" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label3" runat="server" Text="PSS"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel10" runat="server" CssClass="collapsePanel" Visible = "false">
                                            <table>
                                                    <tr><td>CompetitiveMigration</td><td><asp:TextBox ID="TextBox82" Text='<%# DataBinder.Eval(Container.DataItem, "CompetitiveMigration") %>' runat="server" /></td></tr>
                                                    <tr><td>MigrationUpgrade</td><td><asp:TextBox ID="TextBox83" Text='<%# DataBinder.Eval(Container.DataItem, "MigrationUpgrade") %>' runat="server" /></td></tr>
                                                    <tr><td>TechLead</td><td><asp:TextBox ID="TextBox84" Text='<%# DataBinder.Eval(Container.DataItem, "TechLead") %>' runat="server" /></td></tr>
                                                    <tr><td>Project</td><td><asp:TextBox ID="TextBox85" Text='<%# DataBinder.Eval(Container.DataItem, "Project") %>' runat="server" /></td></tr>
                                                    <tr><td>SARenewal</td><td><asp:TextBox ID="TextBox86" Text='<%# DataBinder.Eval(Container.DataItem, "SARenewal") %>' runat="server" /></td></tr>        
                                                    <tr><td>HW</td><td><asp:TextBox ID="TextBox87" Text='<%# DataBinder.Eval(Container.DataItem, "HW") %>' runat="server" /></td></tr>
                                                    <tr><td>SW</td><td><asp:TextBox ID="TextBox88" Text='<%# DataBinder.Eval(Container.DataItem, "SW") %>' runat="server" /></td></tr>
                                                    <tr><td>Buyouts</td><td><asp:TextBox ID="TextBox89" Text='<%# DataBinder.Eval(Container.DataItem, "Buyouts") %>' runat="server" /></td></tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:CollapsiblePanelExtender 
                                                ID="CollapsiblePanelExtender3" 
                                                runat="server" 
                                                TargetControlID="Panel12"
                                                ExpandControlID="Panel11" 
                                                CollapseControlID="Panel11" 
                                                TextLabelID="Label4" 
                                                CollapsedText="Serv"
                                                ExpandedText="Hide" 
                                                ImageControlID="Image4" 
                                                ExpandedImage="/Content/images/collapse_blue.jpg"
                                                CollapsedImage="/Content/images/expand_blue.jpg" 
                                                Collapsed="True" 
                                                SuppressPostBack="true"
                                                ExpandDirection="Horizontal">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel11" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image4" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label4" runat="server" Text="Serv"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel12" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>Automation</td><td><asp:TextBox ID="TextBox90" Text='<%# DataBinder.Eval(Container.DataItem, "Automation") %>' runat="server" /></td></tr>
                                                    <tr><td>Engineering</td><td><asp:TextBox ID="TextBox91" Text='<%# DataBinder.Eval(Container.DataItem, "Engineering") %>' runat="server" /></td></tr>
                                                    <tr><td>Instrumentation</td><td><asp:TextBox ID="TextBox92" Text='<%# DataBinder.Eval(Container.DataItem, "Instrumentation") %>' runat="server" /></td></tr>
                                                    <tr><td>Reliability</td><td><asp:TextBox ID="TextBox93" Text='<%# DataBinder.Eval(Container.DataItem, "Reliability") %>' runat="server" /></td></tr>
                                                    <tr><td>Site Services</td><td><asp:TextBox ID="TextBox94" Text='<%# DataBinder.Eval(Container.DataItem, "SiteServices") %>' runat="server" /> </td></tr>       
                                                </table>
                                            </asp:Panel>
                                            <asp:CollapsiblePanelExtender 
                                                ID="CollapsiblePanelExtender4" 
                                                runat="server" 
                                                TargetControlID="Panel14"
                                                ExpandControlID="Panel13" 
                                                CollapseControlID="Panel13" 
                                                TextLabelID="Label10" 
                                                CollapsedText="Wireless"
                                                ExpandedText="Hide" 
                                                ImageControlID="Image10" 
                                                ExpandedImage="/Content/images/collapse_blue.jpg"
                                                CollapsedImage="/Content/images/expand_blue.jpg" 
                                                Collapsed="True" 
                                                SuppressPostBack="true"
                                                ExpandDirection="Horizontal">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel13" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image10" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label10" runat="server" Text="Wireless"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel14" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>New</td><td><asp:TextBox ID="TextBox95" Text='<%# DataBinder.Eval(Container.DataItem, "New") %>' runat="server" /></td></tr>
                                                    <tr><td>Fill Gateway</td><td><asp:TextBox ID="TextBox96" Text='<%# DataBinder.Eval(Container.DataItem, "FillGateway") %>' runat="server" /></td></tr>
                                                    <tr><td>Fill Plant</td><td><asp:TextBox ID="TextBox97" Text='<%# DataBinder.Eval(Container.DataItem, "FillPlant") %>' runat="server" /></td></tr>
                                                    <tr><td>Projects</td><td><asp:TextBox ID="TextBox98" Text='<%# DataBinder.Eval(Container.DataItem, "Projects") %>' runat="server" /></td></tr>
                                                    <tr><td>Sales Support</td><td><asp:TextBox ID="TextBox99" Text='<%# DataBinder.Eval(Container.DataItem, "SalesSupport") %>' runat="server" />  </td></tr>
                                                </table>   
                                            </asp:Panel>
                                            <asp:CollapsiblePanelExtender 
                                                ID="CollapsiblePanelExtender5" 
                                                runat="server" 
                                                TargetControlID="Panel16"
                                                ExpandControlID="Panel15" 
                                                CollapseControlID="Panel15" 
                                                TextLabelID="Label11" 
                                                CollapsedText="PTL"
                                                ExpandedText="Hide" 
                                                ImageControlID="Image11" 
                                                ExpandedImage="/Content/images/collapse_blue.jpg"
                                                CollapsedImage="/Content/images/expand_blue.jpg" 
                                                Collapsed="True" 
                                                SuppressPostBack="true"
                                                ExpandDirection="Horizontal">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel15" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image11" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label11" runat="server" Text="PTL"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel16" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>Pressure </td><td><asp:TextBox ID="TextBox100" Text='<%# DataBinder.Eval(Container.DataItem, "Pressure") %>' runat="server" /></td></tr>
                                                    <tr><td>Temperature</td><td><asp:TextBox ID="TextBox101" Text='<%# DataBinder.Eval(Container.DataItem, "Temperature") %>' runat="server" /></td></tr>
                                                    <tr><td>Level</td><td><asp:TextBox ID="TextBox102" Text='<%# DataBinder.Eval(Container.DataItem, "Level") %>' runat="server" /></td></tr>
                                                </table>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        </Columns>
                                        </asp:GridView>
                                </Content>
                                </asp:AccordionPane>
                        </Panes>
                </asp:Accordion>        
    </asp:Panel>
    
    <%-- Databound accordion showing opportunities  --%>

    <pre><asp:Label runat="server" CssClass="accordionHeader" Text="ID |           Name                |    LMD   |  Closing  |   Total  |" /></pre>
    <asp:UpdatePanel ID="upd" runat="server" UpdateMode="Always">  
        <ContentTemplate>
            <asp:Accordion ID="Accordion1" 
            CssClass="accordion" 
            HeaderCssClass="accordionHeader"
            HeaderSelectedCssClass="accordionHeaderSelected" 
            ContentCssClass="accordionContent"
            runat="server" 
            DataSourceID="ObjectDataSource1" 
            FadeTransitions="true" 
            TransitionDuration="100"
            OnItemDataBound="Accordion1_ItemDatabound" 
            SuppressHeaderPostbacks="true"
            RequireOpenedPane="false"
            SelectedIndex= "-1">
            <HeaderTemplate>
                <table>
                    <tr>
                        <td><%# Replace(DataBinder.Eval(Container.DataItem, "OpportunityID").ToString.PadRight(3), " ", "&nbsp")%>  </td>
                        <td><%# Replace(DataBinder.Eval(Container.DataItem, "Name").ToString.PadRight(30), " ", "&nbsp")%> </td>
                        <td><%# FormatDateTime(DataBinder.Eval(Container.DataItem, "LastModifiedDate"),DateFormat.ShortDate) %> </td>
                        <td><%# FormatDateTime(DataBinder.Eval(Container.DataItem, "ClosingDate"),DateFormat.ShortDate) %> </td>
                        <td><%# Replace(FormatCurrency(DataBinder.Eval(Container.DataItem, "Total"), 0).ToString.PadLeft(10), " ", "&nbsp")%></td>
                    </tr>
                </table>
            </HeaderTemplate>
            <ContentTemplate>
                <asp:HiddenField ID="txt_OpportunityID" runat="server" Value='<%#DataBinder.Eval(Container.DataItem,"OpportunityID") %>' />
                <asp:Accordion ID="Accordion2" 
                    CssClass="subaccordion" 
                    HeaderCssClass="subaccordionHeader"
                    HeaderSelectedCssClass="subaccordionHeaderSelected" 
                    ContentCssClass="subaccordionContent"
                    runat="server" 
                    FadeTransitions="true" 
                    TransitionDuration="100"
                    SuppressHeaderPostbacks="true"
                    RequireOpenedPane="false">
                    <Panes>
                        <asp:AccordionPane runat="server" ID="Pane1">
                            <Header>
                                General Info
                            </Header>
                            <Content>
                                <asp:FormView ID="FormView1" runat="server" DataKeyNames="OpportunityID" DefaultMode="Edit">
                                    <EditItemTemplate>
                                        <table>
                                            <tr><td>Originator: </td><td><asp:TextBox ID="OriginatorTextBox" runat="server" Text='<%# Bind("Originator") %>' /></td></tr>
                                            <tr><td>Customer ID: </td><td><asp:TextBox ID="CustomerIDTextBox" runat="server" Text='<%# Bind("CustomerID") %>' /></td></tr>
                                            <tr><td>Customer Location: </td><td><asp:TextBox ID="CustomerLocationTextBox" runat="server" Text='<%# Bind("CustomerLocation") %>' /></td></tr>
                                            <tr><td>EPC/Consultant: </td><td><asp:TextBox ID="EPCConsultantTextBox" runat="server" Text='<%# Bind("EPCConsultant") %>' /></td></tr>
                                            <tr><td>Salesman: </td><td><asp:TextBox ID="SalesmanIDTextBox" runat="server" Text='<%# Bind("SalesmanID") %>' /></td></tr>
                                            <tr><td>Name: </td><td><asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' /></td></tr>
                                            <tr><td>Created Date: </td><td><asp:TextBox ID="CreateDateTextBox" runat="server" Text='<%# Bind("CreateDate") %>' /></td></tr>
                                            <tr><td>Last Modified Date: </td><td><asp:TextBox ID="LastModifiedDateTextBox" runat="server" Text='<%# Bind("LastModifiedDate") %>' /></td></tr>
                                            <tr><td>Closing Date: </td><td><asp:TextBox ID="ClosingDateTextBox" runat="server" Text='<%# Bind("ClosingDate") %>' /></td></tr>
                                            <tr><td>Origin: </td><td><asp:TextBox ID="OriginTextBox" runat="server" Text='<%# Bind("Origin") %>' /></td></tr>
                                            <tr><td>Funnel Position: </td><td><asp:TextBox ID="FunnelPositionIDTextBox" runat="server" Text='<%# Bind("FunnelPositionID") %>' /></td></tr>
                                            <tr><td>Percentage: </td><td><asp:TextBox ID="PercentageTextBox" runat="server" Text='<%# Bind("Percentage") %>' /></td></tr>
                                            <tr><td>PATTID: </td><td><asp:TextBox ID="PATTIDTextBox" runat="server" Text='<%# Bind("PATTID") %>' /></td></tr>
                                            <tr><td>Total: </td><td><asp:TextBox ID="TotalTextBox" runat="server" Text='<%# Bind("Total") %>' /></td></tr>
                                            <tr><td>Factored Total: </td><td><asp:TextBox ID="FactoredTotalTextBox" runat="server" Text='<%# Bind("FactoredTotal") %>' /></td></tr>
                                        </table>
                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate />
                                    <ItemTemplate />
                                </asp:FormView>
                            </Content>
                        </asp:AccordionPane>
                        <asp:AccordionPane runat="server" ID="Pane2">
                            <Header>
                                Product Forecast
                            </Header>
                            <Content>                          
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="OpportunityDetailID,FunnelProductID1">
                                    <Columns>
                                        <asp:BoundField DataField="ProductCategory" HeaderText="Product Category" 
                                            SortExpression="ProductCategory"  />
                                        <asp:BoundField DataField="Total" HeaderText="Total $" SortExpression="Total" 
                                            DataFormatString="{0:c}"/>
                                        <asp:BoundField DataField="Percentage" HeaderText="% Probability" 
                                            SortExpression="Percentage" DataFormatString="{0:p0}" />
                                        <asp:TemplateField>
                                            <ItemTemplate>         
                                                <asp:Panel ID="Panel7" runat="server" CssClass="collapsePanelHeader">
                                                    <asp:Image ID="Image5" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                    <asp:Label ID="Label5" runat="server" Text="BM"></asp:Label>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel8" runat="server" CssClass="collapsePanel">
                                                    <table>
                                                        <tr><td>Expected RFQ Rec'd Date</td>    <td><asp:TextBox ID="TextBox78" Text='<%# DataBinder.Eval(Container.DataItem, "ExpectedRFQDate") %>' runat="server" /></td></tr>
                                                        <tr><td>Date Rec'd In House</td><td><asp:TextBox ID="TextBox74" Text='<%# DataBinder.Eval(Container.DataItem, "DateRecInHouse") %>' runat="server" /></td></tr>
                                                        <tr><td>Due Date</td><td><asp:TextBox ID="TextBox75" Text='<%# DataBinder.Eval(Container.DataItem, "DueDate") %>' runat="server" /></td></tr>
                                                        <tr><td>Proposal Eng Lead</td><td><asp:TextBox ID="TextBox76" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalEngLead") %>' runat="server" /></td></tr>
                                                        <tr><td>Proposal Coordinator</td><td><asp:TextBox ID="TextBox80" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalCoordinator") %>' runat="server" />  </td>  </tr>  
                                                        <tr><td>Exec Sponsor</td><td><asp:TextBox ID="TextBox77" Text='<%# DataBinder.Eval(Container.DataItem, "ExecSponsor") %>' runat="server" /></td></tr>
                                                        <tr><td>Product Sales Lead/Sol'n Architect</td><td><asp:TextBox ID="TextBox79" Text='<%# DataBinder.Eval(Container.DataItem, "ProductSalesLead") %>' runat="server" /></td></tr>
                                                    </table>        
                                                </asp:Panel>
                                                <asp:CollapsiblePanelExtender 
                                                    ID="cpe" 
                                                    runat="server" 
                                                    TargetControlID="Panel8"
                                                    ExpandControlID="Panel7" 
                                                    CollapseControlID="Panel7" 
                                                    TextLabelID="Label5" 
                                                    CollapsedText="BM Extra Info"
                                                    ExpandedText="Hide Dialog" 
                                                    ImageControlID="Image5" 
                                                    ExpandedImage="/Content/images/collapse_blue.jpg"
                                                    CollapsedImage="/Content/images/expand_blue.jpg" 
                                                    Collapsed="True" 
                                                    SuppressPostBack="true"
                                                    ExpandDirection="Horizontal">
                                                </asp:CollapsiblePanelExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CollapsiblePanelExtender 
                                                    ID="CollapsiblePanelExtender6" 
                                                    runat="server" 
                                                    TargetControlID="Panel10"
                                                    ExpandControlID="Panel9" 
                                                    CollapseControlID="Panel9" 
                                                    TextLabelID="Label6" 
                                                    CollapsedText="PSS"
                                                    ExpandedText="Hide" 
                                                    ImageControlID="Image6" 
                                                    ExpandedImage="/Content/images/collapse_blue.jpg"
                                                    CollapsedImage="/Content/images/expand_blue.jpg" 
                                                    Collapsed="True" 
                                                    SuppressPostBack="true"
                                                    ExpandDirection="Horizontal"
                                                    AutoExpand ="false">
                                                </asp:CollapsiblePanelExtender>
                                                <asp:Panel ID="Panel9" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                    <asp:Image ID="Image6" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                    <asp:Label ID="Label6" runat="server" Text="PSS"></asp:Label>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel10" runat="server" CssClass="collapsePanel" Visible = "false">
                                                    <table>
                                                        <tr><td>CompetitiveMigration</td><td><asp:TextBox ID="TextBox82" Text='<%# DataBinder.Eval(Container.DataItem, "CompetitiveMigration") %>' runat="server" /></td></tr>
                                                        <tr><td>MigrationUpgrade</td><td><asp:TextBox ID="TextBox83" Text='<%# DataBinder.Eval(Container.DataItem, "MigrationUpgrade") %>' runat="server" /></td></tr>
                                                        <tr><td>TechLead</td><td><asp:TextBox ID="TextBox84" Text='<%# DataBinder.Eval(Container.DataItem, "TechLead") %>' runat="server" /></td></tr>
                                                        <tr><td>Project</td><td><asp:TextBox ID="TextBox85" Text='<%# DataBinder.Eval(Container.DataItem, "Project") %>' runat="server" /></td></tr>
                                                        <tr><td>SARenewal</td><td><asp:TextBox ID="TextBox86" Text='<%# DataBinder.Eval(Container.DataItem, "SARenewal") %>' runat="server" /></td></tr>        
                                                        <tr><td>HW</td><td><asp:TextBox ID="TextBox87" Text='<%# DataBinder.Eval(Container.DataItem, "HW") %>' runat="server" /></td></tr>
                                                        <tr><td>SW</td><td><asp:TextBox ID="TextBox88" Text='<%# DataBinder.Eval(Container.DataItem, "SW") %>' runat="server" /></td></tr>
                                                        <tr><td>Buyouts</td><td><asp:TextBox ID="TextBox89" Text='<%# DataBinder.Eval(Container.DataItem, "Buyouts") %>' runat="server" /></td></tr>
                                                    </table>
                                                </asp:Panel>
                                                <asp:CollapsiblePanelExtender 
                                                        ID="CollapsiblePanelExtender7" 
                                                        runat="server" 
                                                        TargetControlID="Panel12"
                                                        ExpandControlID="Panel11" 
                                                        CollapseControlID="Panel11" 
                                                        TextLabelID="Label7" 
                                                        CollapsedText="Serv"
                                                        ExpandedText="Hide" 
                                                        ImageControlID="Image7" 
                                                        ExpandedImage="/Content/images/collapse_blue.jpg"
                                                        CollapsedImage="/Content/images/expand_blue.jpg" 
                                                        Collapsed="True" 
                                                        SuppressPostBack="true"
                                                        ExpandDirection="Horizontal"
                                                        AutoExpand ="false">
                                                    </asp:CollapsiblePanelExtender>
                                                <asp:Panel ID="Panel11" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                            <asp:Image ID="Image7" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                            <asp:Label ID="Label7" runat="server" Text="Serv"></asp:Label>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel12" runat="server" CssClass="collapsePanel" Visible = "false">
                                                            <table>
                                                                <tr><td>Automation</td><td><asp:TextBox ID="TextBox90" Text='<%# DataBinder.Eval(Container.DataItem, "Automation") %>' runat="server" /></td></tr>
                                                                <tr><td>Engineering</td><td><asp:TextBox ID="TextBox91" Text='<%# DataBinder.Eval(Container.DataItem, "Engineering") %>' runat="server" /></td></tr>
                                                                <tr><td>Instrumentation</td><td><asp:TextBox ID="TextBox92" Text='<%# DataBinder.Eval(Container.DataItem, "Instrumentation") %>' runat="server" /></td></tr>
                                                                <tr><td>Reliability</td><td><asp:TextBox ID="TextBox93" Text='<%# DataBinder.Eval(Container.DataItem, "Reliability") %>' runat="server" /></td></tr>
                                                                <tr><td>Site Services</td><td><asp:TextBox ID="TextBox94" Text='<%# DataBinder.Eval(Container.DataItem, "SiteServices") %>' runat="server" /> </td></tr>       
                                                            </table>
                                                         </asp:Panel>
                                                <asp:CollapsiblePanelExtender 
                                                        ID="CollapsiblePanelExtender8" 
                                                        runat="server" 
                                                        TargetControlID="Panel14"
                                                        ExpandControlID="Panel13" 
                                                        CollapseControlID="Panel13" 
                                                        TextLabelID="Label8" 
                                                        CollapsedText="Wireless"
                                                        ExpandedText="Hide" 
                                                        ImageControlID="Image8" 
                                                        ExpandedImage="/Content/images/collapse_blue.jpg"
                                                        CollapsedImage="/Content/images/expand_blue.jpg" 
                                                        Collapsed="True" 
                                                        SuppressPostBack="true"
                                                        ExpandDirection="Horizontal"
                                                        AutoExpand ="false">
                                                    </asp:CollapsiblePanelExtender>
                                                <asp:Panel ID="Panel13" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image8" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label8" runat="server" Text="Wireless"></asp:Label>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel14" runat="server" CssClass="collapsePanel" Visible = "false">
                                                    <table>
                                                        <tr><td>New</td><td><asp:TextBox ID="TextBox95" Text='<%# DataBinder.Eval(Container.DataItem, "New") %>' runat="server" /></td></tr>
                                                        <tr><td>Fill Gateway</td><td><asp:TextBox ID="TextBox96" Text='<%# DataBinder.Eval(Container.DataItem, "FillGateway") %>' runat="server" /></td></tr>
                                                        <tr><td>Fill Plant</td><td><asp:TextBox ID="TextBox97" Text='<%# DataBinder.Eval(Container.DataItem, "FillPlant") %>' runat="server" /></td></tr>
                                                        <tr><td>Projects</td><td><asp:TextBox ID="TextBox98" Text='<%# DataBinder.Eval(Container.DataItem, "Projects") %>' runat="server" /></td></tr>
                                                        <tr><td>Sales Support</td><td><asp:TextBox ID="TextBox99" Text='<%# DataBinder.Eval(Container.DataItem, "SalesSupport") %>' runat="server" />  </td></tr>
                                                    </table>   
                                                </asp:Panel>
                                                <asp:CollapsiblePanelExtender 
                                                    ID="CollapsiblePanelExtender9" 
                                                    runat="server" 
                                                    TargetControlID="Panel16"
                                                    ExpandControlID="Panel15" 
                                                    CollapseControlID="Panel15" 
                                                    TextLabelID="Label9" 
                                                    CollapsedText="PTL"
                                                    ExpandedText="Hide" 
                                                    ImageControlID="Image9" 
                                                    ExpandedImage="/Content/images/collapse_blue.jpg"
                                                    CollapsedImage="/Content/images/expand_blue.jpg" 
                                                    Collapsed="True" 
                                                    SuppressPostBack="true"
                                                    ExpandDirection="Horizontal"
                                                    AutoExpand ="false">
                                                </asp:CollapsiblePanelExtender>
                                                <asp:Panel ID="Panel15" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                    <asp:Image ID="Image9" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                    <asp:Label ID="Label9" runat="server" Text="PTL"></asp:Label>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel16" runat="server" CssClass="collapsePanel" Visible = "false">
                                                    <table>
                                                        <tr><td>Pressure </td><td><asp:TextBox ID="TextBox100" Text='<%# DataBinder.Eval(Container.DataItem, "Pressure") %>' runat="server" /></td></tr>
                                                        <tr><td>Temperature</td><td><asp:TextBox ID="TextBox101" Text='<%# DataBinder.Eval(Container.DataItem, "Temperature") %>' runat="server" /></td></tr>
                                                        <tr><td>Level</td><td><asp:TextBox ID="TextBox102" Text='<%# DataBinder.Eval(Container.DataItem, "Level") %>' runat="server" /></td></tr>
                                                    </table>
                                                </asp:Panel>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>                              
                            </Content>
                        </asp:AccordionPane>
                    </Panes>
                </asp:Accordion>
            </ContentTemplate>
        </asp:Accordion>
        </ContentTemplate>    
    </asp:UpdatePanel>

    <%--Datasources--%>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="Forecaster.getOpportunitiesTableAdapters.getOpportunitiesTableAdapter">
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>"
        
    SelectCommand="SELECT * FROM [tblOpportunities] where opportunityid = 1" 
    
    InsertCommand="INSERT INTO tblOpportunities(Originator, CustomerID, CustomerLocation, EPCConsultant, SalesmanID, Name, LastModifiedDate, CreateDate, ClosingDate, Origin, FunnelPositionID, Percentage, PATTID, Total, FactoredTotal, Description) VALUES (@Originator, @CustomerID, @CustomerLocation, @EPCConsultant, @SalesmanID, @Name, GETDATE(), GETDATE(), @ClosingDate, @Origin, @FunnelPositionID, @Percentage, @PATTID, @Total, @FactoredTotal, @Description)">
        <InsertParameters>
        <asp:Parameter Name="Originator" />
        <asp:Parameter Name="CustomerID" />
        <asp:Parameter Name="CustomerLocation" />
        <asp:Parameter Name="EPCConsultant" />
        <asp:Parameter Name="SalesmanID" />
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="ClosingDate" />
        <asp:Parameter Name="Origin" />
        <asp:Parameter Name="FunnelPositionID" />
        <asp:Parameter Name="Percentage" />
        <asp:Parameter Name="PATTID" />
        <asp:Parameter Name="Total" />
        <asp:Parameter Name="FactoredTotal" />
        <asp:Parameter Name="Description" />
        </InsertParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>"
        SelectCommand="select * from tblopportunitydetails a inner join tblFunnelCategories b on a.funnelproductid = b.funnelproductid where opportunityid = 1"></asp:SqlDataSource>
</asp:Content>
