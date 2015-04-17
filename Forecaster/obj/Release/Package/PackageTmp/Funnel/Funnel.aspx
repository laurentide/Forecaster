<%@ Page Title="Segments and Customers" Language="vb" MasterPageFile="~/FunnelSite.Master" AutoEventWireup="false" CodeBehind="Funnel.aspx.vb" Inherits="Forecaster.Funnel" %>

<%@ Register Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" TagPrefix="RK" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>Funnel Management</h2>
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
        ExpandedText="Hide Insert Dialog (...)" 
        ImageControlID="Image1" 
        ExpandedImage="/Content/images/collapse_blue.jpg"
        CollapsedImage="/Content/images/expand_blue.jpg" 
        Collapsed="True" 
        SuppressPostBack="true">
    </asp:CollapsiblePanelExtender>
    <asp:Panel ID="insertHeadPane" runat="server" CssClass="collapsePanelHeader">
        <asp:Image ID="Image1" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
        <asp:Label ID="Label1" runat="server" Text="Insert Dialog(...)"></asp:Label>
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
                                <asp:FormView ID="frmInsert" runat="server" DataKeyNames="OpportunityID" DataSourceID="sdsInsert" DefaultMode="Insert">
                                    <EditItemTemplate></EditItemTemplate>
                                    <InsertItemTemplate>
                                    <table>
                                        <tr><td>Originator: </td><td><asp:Label ID="OriginatorTextBox" runat="server" Text='<%# Me.User.Identity.Name.ToString %>' /></td></tr>
                                        <tr><td>Project Name(*): </td><td><asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' width="500" /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Insert" ErrorMessage="Name of opportunity required" ControlToValidate="NameTextBox"  /></td></tr>
                                        <%--<tr><td>Customer ID: </td><td><asp:DropDownList ID="CustomerIDDropDown"  OnSelectedIndexChanged="CustomerIDDropDown_OnSelectedIndexChanged" OnDataBound="CustomerIDDropDown_OnDataBound" runat="server" DataSourceID="sdsCustomers" DataValueField="CustomerID" DataTextField="CustomerName"  SelectedValue='<%# Bind("CustomerID") %>' /></td></tr>--%>
                                        <tr><td>Customer(*): </td><td><asp:TextBox ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' width="500" /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Insert" ErrorMessage="Customer required" ControlToValidate="CustomerTextBox"  /></td></tr>
                                        <tr><td>Customer Location(*): </td><td><asp:TextBox ID="CustomerLocationTextBox" runat="server" Text='<%# Bind("CustomerLocation") %>' /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Insert" ErrorMessage="Customer Location required" ControlToValidate="CustomerLocationTextBox"  /></td></tr>
                                        <tr><td>Sales Lead(*): </td><td><asp:DropDownList ID="SalesmanIDDropDown" OnDataBound="SalesmanIDDropDown_OnDataBound" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" selectedvalue='<%# Bind("SalesmanID") %>' runat="server" /></td><td><asp:RequiredFieldValidator ID="rfvSalesmen"  InitialValue = "0" runat="server" ValidationGroup="Insert" ErrorMessage="Sales Lead required" ControlToValidate="SalesmanIDDropDown"  /></td></tr>
                                        <tr><td>EPC/Consultant: </td><td><asp:TextBox ID="EPCConsultantTextBox" runat="server" Text='<%# Bind("EPCConsultant") %>' /></td></tr>                                        
                                        <tr><td>Closing Date: </td><td><asp:TextBox ID="ClosingDateTextBox" runat="server" Text='<%# Bind("ClosingDate") %>' />
                                            <asp:Image runat="server" id="Calendar_scheduleHS" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="ClosingDateTextBox" PopupButtonID="Calendar_scheduleHS" />
                                            <asp:maskededitextender id="meeStartDate" runat="server" masktype="Date" CultureName="en-US" mask="99/99/9999" targetcontrolid="ClosingDateTextBox" promptcharacter="_" />
                                            <asp:maskededitvalidator ID="Maskededitvalidator1" runat="server" controltovalidate="ClosingDateTextBox" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" />
                                        </td></tr>
                                        <%--<tr><td>Origin: </td><td><asp:TextBox ID="OriginTextBox" runat="server" Text='<%# Bind("Origin") %>' width="300"/></td></tr>--%>
                                        <tr><td>Funnel Position: </td><td><asp:DropDownList ID="FunnelPositionDropDown" runat="server" DatasourceID="sdsFunnelPositions" DataValueField="FunnelPositionID" DataTextField="FunnelPosition" SelectedValue='<%# Bind("FunnelPositionID") %>' /></td></tr>
                                        <tr><td>Industry Code: </td><td><asp:DropDownList ID="IndustryCodeDropDown" runat="server" DatasourceID="sdsIndustryCodes" DataValueField="IndustryCodeID" DataTextField="IndustryCode" SelectedValue='<%# Bind("IndustryCodeID") %>' /></td></tr>
                                        <tr><td>Exec Sponsor: </td><td><asp:DropDownList ID="ExecSponsorDropDown" runat="server" DatasourceID="sdsExecSponsor" DataValueField="ExecSponsorID" DataTextField="ExecSponsor" SelectedValue='<%# Bind("ExecSponsorID")%>' /></td></tr>
                                        <tr><td>Outage: </td><td><asp:Checkbox ID="OutageCheckBox" runat="server" Checked='<%# Bind("Outage")%>' /></td></tr>
                                        <tr><td>PATTID: </td><td><asp:TextBox ID="PATTIDTextBox" runat="server" Text='<%# Bind("PATTID") %>' /></td></tr>
                                        <tr><td>Percentage of project happening: </td><td><asp:TextBox ID="PercentageTextBox" runat="server" Text='<%# Bind("Percentage") %>' /></td>
                                        <td><asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Number between 0 and 100" Type="Integer" MinimumValue="0" MaximumValue="100" ControlToValidate="PercentageTextBox" ValidationGroup="Insert"  /></td></tr>
                                        <%--<% If (User.IsInRole("LCLMTL\LCL_SELT")) Then%>--%>
                                            <tr><td>Top 25:</td><td><asp:CheckBox ID="chkTop25" Checked='<%# Bind("Top25") %>' runat="server" /></td></tr>
                                        <%--<% End If%>--%>
                                        <tr><td>Opportunity/Cust Pain(*)</td><td><asp:TextBox ID="DescriptionTextbox" TextMode="MultiLine"  Height="100" Width="500" runat="server" Text='<%# Bind("Description") %>' /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Insert" ErrorMessage="Description required" ControlToValidate="DescriptionTextbox"  /></td></tr>
                                        <tr><td>Solution/Action Plan</td><td><asp:TextBox ID="LaurentideSolutionTextbox" TextMode="MultiLine"  Height="100" Width="500" runat="server" Text='<%# Bind("LaurentideSolution") %>' /></td></tr>
                                        <tr><td>Other Salesmen/Teams</td>
                                        <td>
                                            <asp:GridView ID="gvMyGrid" runat="server"
                                                AutoGenerateColumns="False" ShowFooter="True"
                                                OnRowCommand="gvMyGrid_RowCommand" 
                                                onRowDeleting="gvMyGrid_RowDeleting"> 
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <EditItemTemplate>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:LinkButton ID="linkAdd" runat="server" CommandName="ADD">Add</asp:LinkButton>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Teams" SortExpression="Teams">
                                                            <EditItemTemplate>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="OtherContributorsDropDown" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" runat="server" SelectedValue='<%# Container.DataItem %>' />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:DropDownList ID="OtherContributorsDropDown_Foot" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" runat="server" AppendDataBoundItems="true" >
                                                                    <asp:ListItem Text="Please Select One..." Value="0"></asp:ListItem>
                                                                 </asp:DropDownList>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <EmptyDataTemplate>
                                                        <asp:LinkButton ID="linkAddEmptyTemplate" runat="server" CommandName="ADD_FROMEMPTY">Add</asp:LinkButton></td><td><asp:DropDownList ID="NewContributor" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" runat="server" AppendDataBoundItems="true" >
                                                            <asp:ListItem Text="Please Select One..." Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EmptyDataTemplate>
                                                </asp:GridView>
                                        </td></tr>
                                    </table>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                    </ItemTemplate>
                                    </asp:FormView>    
                                    </Content>
                            </asp:AccordionPane>
                            <asp:AccordionPane runat="server" ID="Pane4" >
                                <Header>
                                    Product Forecast
                                </Header>
                                <Content>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                    <%-- Gridview that contains product details and forecast, needs to link to header --%>
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                        DataKeyNames="OpportunityDetailID,FunnelProductID1" datasourceid="sdsEmptyOpportunityDetails" ShowFooter="true"
                                        OnRowDataBound="Gridview1_OnRowDataBound">
                                    <Columns>
                                    <asp:BoundField DataField="ProductCategory" HeaderText="Product Category" SortExpression="ProductCategory" ItemStyle-Font-Bold="true" FooterText="Total" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true"  />
                                    <asp:TemplateField HeaderText="Total k$">
                                        <ItemTemplate>
                                               <asp:TextBox ID="txtTotal" runat="server" Text='<%# Eval("Total") %>' DataFormatString="{0:c0}" width="100" AutoPostBack="false" ValidationGroup="Insert" />
                                               <%--<asp:RangeValidator Display="None" ID="TotalValidator" visible="true" runat="server" ErrorMessage="Number greater or equal to 0" Type="Double" MinimumValue="0" ControlToValidate="txtTotal" ValidationGroup="Insert"  />
                                               <asp:ValidatorCalloutExtender runat="Server" ID="VCEInsert1" TargetControlID="TotalValidator" Width="350px"  />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="%" HeaderStyle-Width="30">
                                        <ItemTemplate>
                                                <asp:TextBox ID="txtPercentage" runat="server" Text='<%# Eval("Percentage") %>' width="30" AutoPostBack="false" ValidationGroup="Insert"  />
                                                <%--<asp:RangeValidator Display="None" ID="PercentValidator" runat="server" ErrorMessage="Number between 0 and 100" visible="true" Type="Integer" MinimumValue="0" MaximumValue="100" ControlToValidate="txtPercentage" ValidationGroup="Insert"  />
                                                <asp:ValidatorCalloutExtender runat="Server" ID="VCEInsert2" TargetControlID="PercentValidator" Width="350px"  />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Booking Date" HeaderStyle-Width="120">
                                        <HeaderTemplate>
                                            Booking Date <asp:ImageButton ID="ibInsertClosingDate" AlternateText="Set the date to the closing date" ToolTip="Set the date to the closing date" runat="server" ImageUrl="~/_assets/img/icon_update.png" OnClick="ibInsertClosingDate_OnClick" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtBookingDate" runat="server" Text='<%# Eval("BookingDate","") %>' width="80" ValidationGroup="Insert" />
                                            <asp:Image runat="server" id="Calendar_scheduleHS1" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtBookingDate" PopupButtonID="Calendar_scheduleHS1" format="MM/dd/yyyy" ClearTime="true" />
                                            <asp:maskededitextender id="meeStartDate" runat="server" masktype="Date" mask="99/99/9999" CultureName="en-US" targetcontrolid="txtBookingDate" promptcharacter="_" />
                                            <asp:maskededitvalidator runat="server" controltovalidate="txtBookingDate" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" />
                                            <%--<asp:CompareValidator Display="None" ID="DateValidator" runat="server" ErrorMessage="Valid date in the future" visible="true" Type="Date" EnableClientScript="true" ControlToValidate="txtBookingDate" ValidationGroup="Insert" />--%>
                                            <%--<asp:CompareValidator ID="DateValidator" runat="server" ControlToValidate="txtBookingDate" Operator="GreaterThan" Display="None"  ValueToCompare = '<%= DateTime.Today %>' type="Date"  text="Valid date in the future"/>
                                            <asp:ValidatorCalloutExtender runat="Server" ID="VCE3" TargetControlID="DateValidator" Width="350px"  />--%>
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
                                            SuppressPostBack="true">
                                        </asp:CollapsiblePanelExtender>
                                        <asp:Panel ID="Panel7" runat="server" CssClass="collapsePanelHeader">
                                            <asp:Image ID="Image2" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                            <asp:Label ID="Label2" runat="server" Text="BM"></asp:Label>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel8" runat="server" CssClass="collapsePanel">
                                            <table>
                                                <tr><td>Expected RFQ Rec'd Date</td><td><asp:TextBox ID="ExpectedRFQDate" Text='<%# DataBinder.Eval(Container.DataItem, "ExpectedRFQDate") %>' runat="server" /></td></tr>
                                                <tr><td>Date Rec'd In House</td><td><asp:TextBox ID="DateRecInHouse" Text='<%# DataBinder.Eval(Container.DataItem, "DateRecInHouse") %>' runat="server" /></td></tr>
                                                <tr><td>Due Date</td><td><asp:TextBox ID="DueDate" Text='<%# DataBinder.Eval(Container.DataItem, "DueDate") %>' runat="server" /></td></tr>
                                                <tr><td>Proposal Eng Lead</td><td><asp:TextBox ID="ProposalEngLead" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalEngLead") %>' runat="server" /></td></tr>
                                                <tr><td>Proposal Coordinator</td><td><asp:TextBox ID="ProposalCoordinator" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalCoordinator") %>' runat="server" />  </td>  </tr>  
                                                <tr><td>Exec Sponsor</td><td><asp:TextBox ID="ExecSponsor" Text='<%# DataBinder.Eval(Container.DataItem, "ExecSponsor") %>' runat="server" /></td></tr>
                                                <tr><td>Product Sales Lead/Sol'n Architect</td><td><asp:TextBox ID="ProductSalesLead" Text='<%# DataBinder.Eval(Container.DataItem, "ProductSalesLead") %>' runat="server" /></td></tr>
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
                                                SuppressPostBack="true"                                                >
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel9" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image3" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label3" runat="server" Text="PSS"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel10" runat="server" CssClass="collapsePanel" Visible = "false">
                                            <table>
                                                    <tr><td>CompetitiveMigration</td><td><asp:TextBox ID="CompetitiveMigration" Text='<%# DataBinder.Eval(Container.DataItem, "CompetitiveMigration") %>' runat="server" /></td></tr>
                                                    <tr><td>MigrationUpgrade</td><td><asp:TextBox ID="MigrationUpgrade" Text='<%# DataBinder.Eval(Container.DataItem, "MigrationUpgrade") %>' runat="server" /></td></tr>
                                                    <tr><td>TechLead</td><td><asp:TextBox ID="TechLead" Text='<%# DataBinder.Eval(Container.DataItem, "TechLead") %>' runat="server" /></td></tr>
                                                    <tr><td>Project</td><td><asp:TextBox ID="Project" Text='<%# DataBinder.Eval(Container.DataItem, "Project") %>' runat="server" /></td></tr>
                                                    <tr><td>SARenewal</td><td><asp:TextBox ID="SARenewal" Text='<%# DataBinder.Eval(Container.DataItem, "SARenewal") %>' runat="server" /></td></tr>        
                                                    <tr><td>HW</td><td><asp:TextBox ID="HW" Text='<%# DataBinder.Eval(Container.DataItem, "HW") %>' runat="server" /></td></tr>
                                                    <tr><td>SW</td><td><asp:TextBox ID="SW" Text='<%# DataBinder.Eval(Container.DataItem, "SW") %>' runat="server" /></td></tr>
                                                    <tr><td>Buyouts</td><td><asp:TextBox ID="Buyouts" Text='<%# DataBinder.Eval(Container.DataItem, "Buyouts") %>' runat="server" /></td></tr>
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
                                                SuppressPostBack="true"/>
                                           
                                            <asp:Panel ID="Panel11" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image4" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label4" runat="server" Text="Serv"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel12" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>Automation</td><td><asp:TextBox ID="Automation" Text='<%# DataBinder.Eval(Container.DataItem, "Automation") %>' runat="server" /></td></tr>
                                                    <tr><td>Engineering</td><td><asp:TextBox ID="Engineering" Text='<%# DataBinder.Eval(Container.DataItem, "Engineering") %>' runat="server" /></td></tr>
                                                    <tr><td>Instrumentation</td><td><asp:TextBox ID="Instrumentation" Text='<%# DataBinder.Eval(Container.DataItem, "Instrumentation") %>' runat="server" /></td></tr>
                                                    <tr><td>Reliability</td><td><asp:TextBox ID="Reliability" Text='<%# DataBinder.Eval(Container.DataItem, "Reliability") %>' runat="server" /></td></tr>
                                                    <tr><td>Site Services</td><td><asp:TextBox ID="SiteServices" Text='<%# DataBinder.Eval(Container.DataItem, "SiteServices") %>' runat="server" /> </td></tr>       
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
                                                SuppressPostBack="true">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel13" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image10" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label10" runat="server" Text="Wireless"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel14" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>New</td><td><asp:TextBox ID="New" Text='<%# DataBinder.Eval(Container.DataItem, "New") %>' runat="server" /></td></tr>
                                                    <tr><td>Fill Gateway</td><td><asp:TextBox ID="FillGateway" Text='<%# DataBinder.Eval(Container.DataItem, "FillGateway") %>' runat="server" /></td></tr>
                                                    <tr><td>Fill Plant</td><td><asp:TextBox ID="FillPlant" Text='<%# DataBinder.Eval(Container.DataItem, "FillPlant") %>' runat="server" /></td></tr>
                                                    <tr><td>Projects</td><td><asp:TextBox ID="Projects" Text='<%# DataBinder.Eval(Container.DataItem, "Projects") %>' runat="server" /></td></tr>
                                                    <tr><td>Sales Support</td><td><asp:TextBox ID="SalesSupport" Text='<%# DataBinder.Eval(Container.DataItem, "SalesSupport") %>' runat="server" />  </td></tr>
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
                                                SuppressPostBack="true">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel15" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image11" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label11" runat="server" Text="PTL"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel16" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>Pressure </td><td><asp:TextBox ID="Pressure" Text='<%# DataBinder.Eval(Container.DataItem, "Pressure") %>' runat="server" /></td></tr>
                                                    <tr><td>Temperature</td><td><asp:TextBox ID="Temperature" Text='<%# DataBinder.Eval(Container.DataItem, "Temperature") %>' runat="server" /></td></tr>
                                                    <tr><td>Level</td><td><asp:TextBox ID="Level" Text='<%# DataBinder.Eval(Container.DataItem, "Level") %>' runat="server" /></td></tr>
                                                </table>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        </Columns>
                                        </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </Content>
                                </asp:AccordionPane>
                        </Panes>
                </asp:Accordion>
                <asp:Button ID="btnInsert" runat="server" Text="Done" OnClick="Insert" ValidationGroup="Insert" />         
                <asp:ValidationSummary ID="InsertValidationSummary" ValidationGroup="Insert" runat="server"  DisplayMode="BulletList" CssClass="errors" />
    </asp:Panel>
    <br />

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
    </asp:Panel>
    <asp:Panel ID="PanFilters" runat="server" CssClass="collapsePanelFilter">
    <table>
        <tr><td>Products: </td><td><asp:Listbox ID="cblProducts" SelectionMode="Multiple" runat="server" Height="150" DataSourceID="sdsFunnelProducts" DataTextField="ProductCategory" DataValueField="FunnelProductID" font-size="10px" /></td>
            <td>Funnel Position:</td><td><asp:Listbox ID="cblFunnelPositions" SelectionMode="Multiple" runat="server" Height="150"  DataSourceID="sdsFunnelPositions" DataTextField="FunnelPosition" DataValueField="FunnelPositionID" font-size="10px" /></td></tr>
        <tr><td>Industry Codes: </td><td><asp:Listbox ID="lbIndustryCodes" SelectionMode="Multiple" runat="server" Height="150" DataSourceID="sdsIndustryCodes" DataTextField="IndustryCode" DataValueField="IndustryCodeID" font-size="10px" /></td></tr>
        <tr><td>Exec Sponsors: </td><td> <asp:DropDownList ID="ddlExecSponsors" DataSourceID="sdsExecSponsor" AppendDataBoundItems="true" DataValueField="ExecSponsorID" DataTextField="ExecSponsor" runat="server">
            </asp:DropDownList></td><td></td><td></td></tr>        
        <tr><td>Outage </td><td><asp:DropDownList ID="ddlOutage" runat="server">
            <asp:ListItem Value ="2" Text="Any"></asp:ListItem>    
            <asp:ListItem Value ="0" Text="No"></asp:ListItem>
            <asp:ListItem Value ="1" Text="Yes"></asp:ListItem>                  
            </asp:DropDownList></td></tr> 
        <tr><td>Team: </td><td> <asp:DropDownList ID="ddlSalesmen" DataSourceID="sdsTeamFilter" DataValueField="TeamID" DataTextField="TeamName" runat="server" /></td><td></td><td></td></tr>        
        <tr><td>Product Lead: </td><td> <asp:textbox ID="txtProductLead" runat="server" /></td><td></td><td></td></tr>        
        <tr><td>Customer: </td><td> <asp:TextBox ID="txtCustomerFilter" runat="server" /></td><td></td><td></td></tr>        
        <tr><td>EPC: </td><td> <asp:TextBox ID="txtEPCFilter" runat="server" /></td><td></td><td></td></tr>        
        <tr><td>ID: </td><td> <asp:TextBox ID="txtID" runat="server" /></td><td></td><td></td></tr>        

        <tr><td>Closing Date: </td>
                <td>Start Date  </td><td><asp:TextBox ID="ClosingStartDateTextBox" runat="server" /><asp:Image runat="server" id="Calendar_scheduleHS" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="ClosingStartDateTextBox" PopupButtonID="Calendar_scheduleHS" />
                                        <asp:maskededitextender id="meeStartDate" runat="server" masktype="Date" CultureName="en-US" mask="99/99/9999" targetcontrolid="ClosingStartDateTextBox" promptcharacter="_" />
                                        <asp:maskededitvalidator ID="Maskededitvalidator1" runat="server" controltovalidate="ClosingStartDateTextBox" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" /></td>
                <td>End Date </td><td><asp:TextBox ID="ClosingEndDateTextBox" runat="server"  /><asp:Image runat="server" id="Image13" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="ClosingEndDateTextBox" PopupButtonID="Image13" />
                                        <asp:maskededitextender id="Maskededitextender1" runat="server" masktype="Date" CultureName="en-US" mask="99/99/9999" targetcontrolid="ClosingEndDateTextBox" promptcharacter="_" />
                                        <asp:maskededitvalidator ID="Maskededitvalidator4" runat="server" controltovalidate="ClosingEndDateTextBox" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" /></td>
                <td></td>
        </tr>
        <tr><td>Created Date: </td>
                <td>Start Date  </td><td><asp:TextBox ID="CreatedStartDateTextBox" runat="server" /><asp:Image runat="server" id="Image14" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                        <asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="CreatedStartDateTextBox" PopupButtonID="Image14" />
                                        <asp:maskededitextender id="Maskededitextender2" runat="server" masktype="Date" CultureName="en-US" mask="99/99/9999" targetcontrolid="CreatedStartDateTextBox" promptcharacter="_" />
                                        <asp:maskededitvalidator ID="Maskededitvalidator5" runat="server" controltovalidate="CreatedStartDateTextBox" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" /></td>
                <td>End Date </td><td><asp:TextBox ID="CreatedEndDateTextBox" runat="server"  /><asp:Image runat="server" id="Image15" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                        <asp:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="CreatedEndDateTextBox" PopupButtonID="Image15" />
                                        <asp:maskededitextender id="Maskededitextender3" runat="server" masktype="Date" CultureName="en-US" mask="99/99/9999" targetcontrolid="CreatedEndDateTextBox" promptcharacter="_" />
                                        <asp:maskededitvalidator ID="Maskededitvalidator6" runat="server" controltovalidate="CreatedEndDateTextBox" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" /></td>
                <td></td>
        </tr>
        <tr><td>Top 25:</td><td><%--<asp:CheckBox ID="chkTop25Filter" runat="server" />--%>
            <asp:RadioButtonList ID="rblTop25Filter" runat="server"  >
                <asp:ListItem Value="1">Top 25 only</asp:ListItem>
                <asp:ListItem Value="2">Exclude top 25</asp:ListItem>
                <asp:ListItem Value="3" Selected="true">No filter</asp:ListItem>
            </asp:RadioButtonList></td></tr>        
        <tr><td><asp:Button ID="btnFilter" runat="server" onclick="btnFilter_onClick" Text="Filter" /><asp:Button ID="btnClear" runat="server" onclick="btnClear_onClick" Text="Clear Filters" /></td><td></td><td></td><td></td></tr>
    </table>
    </asp:Panel>

    <br />
    <asp:UpdatePanel runat="server" ID="updGrid">
    <ContentTemplate>
        <asp:Gridview ID="Gridview4"
                    DataSourceID="sdsGetOpportunities"
                    runat="server"
                    AutoGenerateColumns="False"
                    OnDataBound="GridView4_Databound"
                    HeaderStyle-CssClass="grid_Header"
                    RowStyle-Cssclass="grid_RowStyle" 
                    DataKeyNames="OpportunityID"
                    onrowcommand="Gridview4_RowCommand" CellPadding="4" ForeColor="#333333"
                    AllowSorting="True"
                    Font-Size="10px" AllowPaging="True" PageSize="50">
                    <EmptyDataTemplate> 
                    <asp:Label runat="server" Id="EmptyLabel" Text="No Results Found, or no opportunity exist. Please clear the filters or revise them." />                    
                    </EmptyDataTemplate>
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:ButtonField Text="Edit" CommandName="Select" />
                    <asp:BoundField DataField="OpportunityID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="OpportunityID" />
                    <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
                    <asp:BoundField DataField="EPC Consultant" HeaderText="EPC/Consult" SortExpression="EPC Consultant" />
                    <asp:BoundField DataField="Salesman" HeaderText="Sales Lead" SortExpression="Salesman" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Last Modified Date" HeaderText="Last Mod" dataformatstring="{0:MM/dd/yyyy}" SortExpression="Last Modified Date" />
                    <asp:BoundField DataField="Closing Date" HeaderText="Closing" dataformatstring="{0:MM/dd/yyyy}" SortExpression="Closing Date" />
                    <asp:BoundField DataField="Funnel Pos'n" HeaderText="Funnel Pos'n" SortExpression="Funnel Pos'n" />
                    <asp:BoundField DataField="PATTID" HeaderText="PATTID" SortExpression="PATTID"  />
                    <asp:BoundField DataField="Prob happening" DataFormatString="{0:P0}" HeaderText="Prob" ItemStyle-Width="35" SortExpression="Prob happening" >
                    <ItemStyle Width="35px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="factored_total" HeaderText="Fact. Total k$" DataFormatString="{0:0}" SortExpression="factored_total" ItemStyle-HorizontalAlign="Right" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Total" HeaderText="Total k$" DataFormatString="{0:0}" SortExpression="Total" ItemStyle-HorizontalAlign="Right" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Exec Sponsor" HeaderText="Exec Sponsor" SortExpression="Exec Sponsor" />
                    <asp:BoundField DataField="Outage" HeaderText="Outage" SortExpression="Outage" />
                    <asp:BoundField DataField="AMS" HeaderText="AMS" ItemStyle-HorizontalAlign="Center" ReadOnly="True" SortExpression="AMS">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CSI" HeaderText="CSI" ReadOnly="True" SortExpression="CSI"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Det-Tronics" HeaderText="Dtnics" ReadOnly="True" SortExpression="Det-Tronics"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Farris" HeaderText="Farris" ReadOnly="True" SortExpression="Farris"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FisherRegs" HeaderText="Regs" ReadOnly="True" SortExpression="FisherRegs"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FisherValves" HeaderText="Valves" ReadOnly="True" SortExpression="FisherValves"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="IVS" HeaderText="IVS" ReadOnly="True" SortExpression="IVS"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MMI" HeaderText="MMI" ReadOnly="True" SortExpression="MMI"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PSS" HeaderText="PSS" ReadOnly="True" SortExpression="PSS"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RSMT Flow" HeaderText="Flow" ReadOnly="True" SortExpression="RSMT Flow"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RSMT PTL" HeaderText="PTL" ReadOnly="True" SortExpression="RSMT PTL"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RSMT Analytical-Gas" HeaderText="Gas" ReadOnly="True"
                        SortExpression="RSMT Analytical-Gas" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RSMT Analytical-Liquid" HeaderText="Liquid" ReadOnly="True"
                        SortExpression="RSMT Analytical-Liquid" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Services" HeaderText="Serv" ReadOnly="True" SortExpression="Services"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="VAD" HeaderText="VAD" ReadOnly="True" SortExpression="VAD"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Wireless" HeaderText="Wireless" ReadOnly="True" SortExpression="Wireless"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="8px"/>
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:Gridview>
    </ContentTemplate>
    </asp:UpdatePanel>

    <%--Modal Popup for updating --%>
    <asp:ModalPopupExtender ID="modalpopupextender1" runat="server" TargetControlID="FakeTarget" PopupControlID="panEdit" PopupDragHandleControlID="panEdit" BackgroundCssClass="modalBackground" />
    <asp:Panel ID="panEdit" runat="server" CssClass="ModalWindow">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Accordion ID="Accordion2" 
                CssClass="subaccordion" 
                HeaderCssClass="subaccordionHeader"
                HeaderSelectedCssClass="subaccordionHeaderSelected" 
                ContentCssClass="subaccordionContent"
                runat="server" 
                FadeTransitions="true" 
                TransitionDuration="100"
                SuppressHeaderPostbacks="true"
                RequireOpenedPane="true">
                <Panes>
                    <asp:AccordionPane runat="server" ID="Pane1">
                        <Header>
                            General Info
                        </Header>
                        <Content>
                            <asp:FormView ID="frmUpdate" runat="server" DataKeyNames="OpportunityID" DefaultMode="Edit" DataSourceID="sdsInsert" OnDataBound="frmUpdate_DataBound">
                                <EditItemTemplate>
                                    <table>
                                        <tr><td>Opportunity ID: </td><td><asp:Label ID="OpportunityIDLabel" runat="server" Text='<%# Bind("OpportunityID") %>' /></td></tr>
                                        <tr><td>Originator: </td><td><asp:Label ID="OriginatorTextBox" runat="server" Text='<%# Bind("Originator") %>' /></td></tr>
                                        <tr><td>Project Name(*): </td><td><asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' width="500" /></td></tr>
                                        <%--<tr><td>Customer ID: </td><td><asp:DropDownList ID="CustomerIDDropDown" runat="server" DataSourceID="sdsCustomers" DataValueField="CustomerID" DataTextField="CustomerName"  SelectedValue='<%# Bind("CustomerID") %>' /></td></tr>--%>
                                        <tr><td>Customer(*): </td><td><asp:TextBox ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' width="500" /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ErrorMessage="Customer required" ControlToValidate="CustomerTextBox"  /></td></tr>
                                        <tr><td>Customer Location(*): </td><td><asp:TextBox ID="CustomerLocationTextBox" runat="server" Text='<%# Bind("CustomerLocation") %>' /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ErrorMessage="Customer Location required" ControlToValidate="CustomerLocationTextBox"  /></td></tr>
                                        <tr><td>EPC/Consultant: </td><td><asp:TextBox ID="EPCConsultantTextBox" runat="server" Text='<%# Bind("EPCConsultant") %>' /></td></tr>
                                        <tr><td>Sales Lead: </td><td><asp:DropDownList ID="SalesmanIDDropDown" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" selectedvalue='<%# Bind("SalesmanID") %>' runat="server" /></td></tr>
                                        <tr><td>Created Date: </td><td><asp:Label ID="CreateDateTextBox" runat="server" Text='<%# Bind("CreateDate") %>' /></td></tr>
                                        <tr><td>Last Modified Date: </td><td><asp:Label ID="LastModifiedDateTextBox" runat="server" Text='<%# Bind("LastModifiedDate") %>' /></td></tr>
                                        <tr><td>Last Modified By: </td><td><asp:Label ID="LastModifiedByTextBox" runat="server" Text='<%# Bind("LastModifiedBy") %>' /></td></tr>
                                        <tr><td>Closing Date: </td><td><asp:TextBox ID="ClosingDateTextBox" runat="server" Text='<%# Bind("ClosingDate","") %>' /><asp:Image runat="server" id="Calendar_scheduleHS" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" /><asp:CalendarExtender
                                            ID="CalendarExtender1" runat="server" TargetControlID="ClosingDateTextBox" PopupButtonID="Calendar_scheduleHS" />
                                            <asp:maskededitextender id="meeStartDate" runat="server" masktype="Date" mask="99/99/9999" CultureName="en-US" targetcontrolid="ClosingDateTextBox" promptcharacter="_" />
                                            <asp:maskededitvalidator ID="Maskededitvalidator3" runat="server" controltovalidate="ClosingDateTextBox" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" />
                                        </td></tr>
                                        <tr><td>Funnel Position: </td><td><asp:DropDownList ID="FunnelPositionDropDown" runat="server" DatasourceID="sdsFunnelPositions" DataValueField="FunnelPositionID" DataTextField="FunnelPosition" SelectedValue='<%# Bind("FunnelPositionID") %>' /></td></tr>
                                        <tr><td>Industry Code: </td><td><asp:DropDownList ID="IndustryCodeDropDown" runat="server" DatasourceID="sdsIndustryCodes" DataValueField="IndustryCodeID" DataTextField="IndustryCode" SelectedValue='<%# Bind("IndustryCodeID")%>' /></td></tr>
                                        <tr><td>Exec Sponsor: </td><td><asp:DropDownList ID="ExecSponsorDropDown" runat="server" DatasourceID="sdsExecSponsor" DataValueField="ExecSponsorID" DataTextField="ExecSponsor" SelectedValue='<%# Bind("ExecSponsorID")%>' /></td></tr>
                                        <tr><td>Outage: </td><td><asp:Checkbox ID="OutageCheckBox" runat="server" Checked='<%# Bind("Outage")%>' /></td></tr>
                                        <tr><td>PATTID: </td><td><asp:TextBox ID="PATTIDTextBox" runat="server" Text='<%# Bind("PATTID") %>' /></td></tr>
                                        <tr><td>Total k$: </td><td><asp:Label ID="TotalTextBox" runat="server" Text='<%# Bind("Total","{0:c0}k") %>' /></td></tr>
                                        <tr><td>Percentage: </td><td><asp:TextBox ID="PercentageTextBox" runat="server" Text='<%# Bind("Percentage") %>' /></td></tr>
                                        <%--<% If (User.IsInRole("LCLMTL\LCL_SELT")) Then%>--%>
                                        <tr><td>Top 25:</td><td><asp:CheckBox ID="chkTop25" Checked='<%# Bind("Top25") %>' runat="server" /></td></tr>
                                        <%--<% End If%>--%>
                                        <tr><td>Opportunity/Cust Pain(*)</td><td><asp:TextBox ID="DescriptionTextbox" TextMode="MultiLine"  Height="100" Width="500" runat="server" Text='<%# Bind("Description") %>' /></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Update" ErrorMessage="Description required" ControlToValidate="DescriptionTextbox"  /></td></tr>
                                        <tr><td>Solution/Action Plan</td><td><asp:TextBox ID="LaurentideSolutionTextbox" TextMode="MultiLine"  Height="100" Width="500" runat="server" Text='<%# Bind("LaurentideSolution") %>' /></td></tr>
                                        <tr><td>Other Salesmen/Teams</td><td><asp:GridView ID="gvAssignments" runat="server"
                                                AutoGenerateColumns="False" ShowFooter="True"
                                                OnRowCommand="gvAssignments_RowCommand" 
                                                onRowDeleting="gvAssignments_RowDeleting"
                                                DataSourceID="sdsOpportunityAssignments"
                                                DataKeyNames="OpportunityAssignmentID"
                                                OnRowDeleted="gvAssignments_RowDeleted"> 
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <EditItemTemplate>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:LinkButton ID="linkAdd" runat="server" CommandName="ADD">Add</asp:LinkButton>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="OpportunityAssignmentID" SortExpression="SomeID" Visible = "false">
                                                            <EditItemTemplate>
                                                                <asp:Label ID="OpportunityAssignmentID" runat="server" Text='<%# Bind("OpportunityAssignmentID") %>'></asp:Label>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="OpportunityAssignmentID" runat="server" Text='<%# Bind("OpportunityAssignmentID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Teams" SortExpression="Teams">
                                                            <EditItemTemplate>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="OtherContributorsDropDown" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" runat="server" SelectedValue='<%# eval("salesmanID") %>' />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:DropDownList ID="OtherContributorsDropDown_Foot" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" runat="server" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select One..." Value="0"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <EmptyDataTemplate>
                                                        <asp:LinkButton ID="linkAddEmptyTemplate" runat="server" CommandName="ADD_FROMEMPTY">Add</asp:LinkButton></td><td>
                                                        <asp:DropDownList ID="NewContributor" DataSourceID="sdsTeams" DataValueField="TeamID" DataTextField="TeamName" runat="server" AppendDataBoundItems="true" >
                                                            <asp:ListItem Text="Please Select One..." Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EmptyDataTemplate>
                                                </asp:GridView></td></tr>
                                    </table>
                                    <%--<asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />--%>
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
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="OpportunityDetailID" DataSourceID="sdsUpdate" OnRowDataBound="Gridview2_OnRowDataBound" ShowFooter="true">
                                <Columns>
                                    <asp:BoundField DataField="ProductCategory" HeaderText="Product Category" SortExpression="ProductCategory" ItemStyle-Font-Bold="true"  />
<%--                                    <asp:BoundField DataField="Total" HeaderText="Total $" SortExpression="Total" 
                                        DataFormatString="{0:c}"/>--%>
                                    <asp:TemplateField HeaderText="Total k$">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTotal" runat="server" Text='<%# Eval("Total") %>' DataFormatString="{0:c0}" width="100" />
                                            <asp:RangeValidator Display="None" ID="TotalValidator" visible="true" runat="server" ErrorMessage="Number greater or equal to 0" Type="Double" MinimumValue="0" ControlToValidate="txtTotal" ValidationGroup="Update"  />
                                            <asp:ValidatorCalloutExtender runat="Server" ID="VCE1" TargetControlID="TotalValidator" Width="350px"  />
                                        </ItemTemplate>
                                    </asp:TemplateField>
<%--                                    <asp:BoundField DataField="Percentage" HeaderText="% Probability" 
                                        SortExpression="Percentage" DataFormatString="{0:p0}" />--%>
                                    <asp:TemplateField HeaderText="%" HeaderStyle-Width="30">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPercentage" runat="server" Text='<%# Eval("Percentage") %>' DataFormatString="{0:p0}" width="30"  />
                                            <asp:RangeValidator Display="None" ID="PercentValidator" runat="server" ErrorMessage="Number between 0 and 100" visible="true" Type="Integer" MinimumValue="0" MaximumValue="100" ControlToValidate="txtPercentage" ValidationGroup="Update"  />
                                            <asp:ValidatorCalloutExtender runat="Server" ID="VCE2" TargetControlID="PercentValidator" Width="350px"  />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Product Lead">
                                        <HeaderTemplate>
                                            Product Lead <asp:ImageButton ID="ibProductLead"  ToolTip="Set the product lead to the sales lead" AlternateText="Set the product lead to the sales lead" runat="server" ImageUrl="~/_assets/img/icon_update.png" OnClick="ibProductLead_Click" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="ProductSalesLead" runat="server" Text='<%# Eval("ProductSalesLead")%>' width="100"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Booking Date" HeaderStyle-Width="120">
                                        <HeaderTemplate>
                                            Booking Date <asp:ImageButton ID="ibClosingDate"  ToolTip="Set the date to the closing date" AlternateText="Set the date to the closing date" runat="server" ImageUrl="~/_assets/img/icon_update.png" OnClick="ibClosingDate_OnClick" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtBookingDate" runat="server" Text='<%# Eval("BookingDate","") %>' width="80" />
                                            <asp:Image runat="server" id="Calendar_scheduleHS1" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtBookingDate" PopupButtonID="Calendar_scheduleHS1" />
                                            <asp:maskededitextender id="meeStartDate" runat="server" masktype="Date" mask="99/99/9999" CultureName="en-US" targetcontrolid="txtBookingDate" promptcharacter="_" />
                                            <asp:maskededitvalidator ID="Maskededitvalidator2" runat="server" controltovalidate="txtBookingDate" controlextender="meeStartDate" invalidvaluemessage="Date is Invalid" IsValidEmpty="True" />
                                            <%--<asp:ImageButton ID="ibClosingDate" runat="server" ImageUrl="~/_assets/img/icon_update.png" OnClick="ibClosingDate_OnClick" />--%>
                                            <%--<asp:RangeValidator Display="None" ID="DateValidator" runat="server" ErrorMessage="Valid date in the future" visible="true" Type="Date" EnableClientScript="true" ControlToValidate="txtBookingDate" ValidationGroup="Update"  />--%>
<%--                                            <asp:CompareValidator ID="DateValidator" runat="server" Controltovalidate="txtBookingDate"  Operator="GreaterThan" Display="None" ValueToCompare = '<%= DateTime.Today %>' type="Date" text="Valid date in the future"/>
                                            <asp:ValidatorCalloutExtender runat="Server" ID="VCE3" TargetControlID="DateValidator" Width="350px"  />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>         
                                            <asp:Panel ID="Panel7" runat="server" CssClass="collapsePanelHeader">
                                                <asp:Image ID="Image5" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label5" runat="server" Text="BM"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel8" runat="server" CssClass="collapsePanel">
                                                <table>
                                                    <tr><td>Expected RFQ Rec'd Date</td> <td><asp:TextBox ID="ExpectedRFQDate" Text='<%# DataBinder.Eval(Container.DataItem, "ExpectedRFQDate") %>' runat="server" /></td></tr>
                                                    <tr><td>Date Rec'd In House</td><td><asp:TextBox ID="DateRecInHouse" Text='<%# DataBinder.Eval(Container.DataItem, "DateRecInHouse") %>' runat="server" /></td></tr>
                                                    <tr><td>Due Date</td><td><asp:TextBox ID="DueDate" Text='<%# DataBinder.Eval(Container.DataItem, "DueDate") %>' runat="server" /></td></tr>
                                                    <tr><td>Proposal Eng Lead</td><td><asp:TextBox ID="ProposalEngLead" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalEngLead") %>' runat="server" /></td></tr>
                                                    <tr><td>Proposal Coordinator</td><td><asp:TextBox ID="ProposalCoordinator" Text='<%# DataBinder.Eval(Container.DataItem, "ProposalCoordinator") %>' runat="server" />  </td>  </tr>  
                                                    <tr><td>Exec Sponsor</td><td><asp:TextBox ID="ExecSponsor" Text='<%# DataBinder.Eval(Container.DataItem, "ExecSponsor") %>' runat="server" /></td></tr>
                                                    <%--<tr><td>Product Sales Lead/Sol'n Architect</td><td><asp:TextBox ID="ProductSalesLead" Text='<%# DataBinder.Eval(Container.DataItem, "ProductSalesLead") %>' runat="server" /></td></tr>--%>
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
                                                SuppressPostBack="true">
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
                                                AutoExpand ="false">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel9" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image6" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label6" runat="server" Text="PSS"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel10" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>CompetitiveMigration</td><td><asp:TextBox ID="CompetitiveMigration" Text='<%# DataBinder.Eval(Container.DataItem, "CompetitiveMigration") %>' runat="server" /></td></tr>
                                                    <tr><td>MigrationUpgrade</td><td><asp:TextBox ID="MigrationUpgrade" Text='<%# DataBinder.Eval(Container.DataItem, "MigrationUpgrade") %>' runat="server" /></td></tr>
                                                    <tr><td>TechLead</td><td><asp:TextBox ID="TechLead" Text='<%# DataBinder.Eval(Container.DataItem, "TechLead") %>' runat="server" /></td></tr>
                                                    <tr><td>Project</td><td><asp:TextBox ID="Project" Text='<%# DataBinder.Eval(Container.DataItem, "Project") %>' runat="server" /></td></tr>
                                                    <tr><td>SARenewal</td><td><asp:TextBox ID="SARenewal" Text='<%# DataBinder.Eval(Container.DataItem, "SARenewal") %>' runat="server" /></td></tr>        
                                                    <tr><td>HW</td><td><asp:TextBox ID="HW" Text='<%# DataBinder.Eval(Container.DataItem, "HW") %>' runat="server" /></td></tr>
                                                    <tr><td>SW</td><td><asp:TextBox ID="SW" Text='<%# DataBinder.Eval(Container.DataItem, "SW") %>' runat="server" /></td></tr>
                                                    <tr><td>Buyouts</td><td><asp:TextBox ID="Buyouts" Text='<%# DataBinder.Eval(Container.DataItem, "Buyouts") %>' runat="server" /></td></tr>
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
                                                    AutoExpand ="false">
                                                </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel11" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                        <asp:Image ID="Image7" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                        <asp:Label ID="Label7" runat="server" Text="Serv"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel12" runat="server" CssClass="collapsePanel" Visible = "false">
                                                        <table>
                                                            <tr><td>Automation</td><td><asp:TextBox ID="Automation" Text='<%# DataBinder.Eval(Container.DataItem, "Automation") %>' runat="server" /></td></tr>
                                                            <tr><td>Engineering</td><td><asp:TextBox ID="Engineering" Text='<%# DataBinder.Eval(Container.DataItem, "Engineering") %>' runat="server" /></td></tr>
                                                            <tr><td>Instrumentation</td><td><asp:TextBox ID="Instrumentation" Text='<%# DataBinder.Eval(Container.DataItem, "Instrumentation") %>' runat="server" /></td></tr>
                                                            <tr><td>Reliability</td><td><asp:TextBox ID="Reliability" Text='<%# DataBinder.Eval(Container.DataItem, "Reliability") %>' runat="server" /></td></tr>
                                                            <tr><td>Site Services</td><td><asp:TextBox ID="SiteServices" Text='<%# DataBinder.Eval(Container.DataItem, "SiteServices") %>' runat="server" /> </td></tr>       
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
                                                    AutoExpand ="false">
                                                </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel13" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                            <asp:Image ID="Image8" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                            <asp:Label ID="Label8" runat="server" Text="Wireless"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel14" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>New</td><td><asp:TextBox ID="New" Text='<%# DataBinder.Eval(Container.DataItem, "New") %>' runat="server" /></td></tr>
                                                    <tr><td>Fill Gateway</td><td><asp:TextBox ID="FillGateway" Text='<%# DataBinder.Eval(Container.DataItem, "FillGateway") %>' runat="server" /></td></tr>
                                                    <tr><td>Fill Plant</td><td><asp:TextBox ID="FillPlant" Text='<%# DataBinder.Eval(Container.DataItem, "FillPlant") %>' runat="server" /></td></tr>
                                                    <tr><td>Projects</td><td><asp:TextBox ID="Projects" Text='<%# DataBinder.Eval(Container.DataItem, "Projects") %>' runat="server" /></td></tr>
                                                    <tr><td>Sales Support</td><td><asp:TextBox ID="SalesSupport" Text='<%# DataBinder.Eval(Container.DataItem, "SalesSupport") %>' runat="server" />  </td></tr>
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
                                                AutoExpand ="false">
                                            </asp:CollapsiblePanelExtender>
                                            <asp:Panel ID="Panel15" runat="server" CssClass="collapsePanelHeader" Visible = "false">
                                                <asp:Image ID="Image9" runat="server" ImageUrl="/Content/images/expand_blue.jpg"></asp:Image> 
                                                <asp:Label ID="Label9" runat="server" Text="PTL"></asp:Label>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel16" runat="server" CssClass="collapsePanel" Visible = "false">
                                                <table>
                                                    <tr><td>Pressure </td><td><asp:TextBox ID="Pressure" Text='<%# DataBinder.Eval(Container.DataItem, "Pressure") %>' runat="server" /></td></tr>
                                                    <tr><td>Temperature</td><td><asp:TextBox ID="Temperature" Text='<%# DataBinder.Eval(Container.DataItem, "Temperature") %>' runat="server" /></td></tr>
                                                    <tr><td>Level</td><td><asp:TextBox ID="Level" Text='<%# DataBinder.Eval(Container.DataItem, "Level") %>' runat="server" /></td></tr>
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
            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="Update" ValidationGroup="Update"/> 
            <asp:Button ID="btnDone" runat="server" Text="Done" OnClick="refreshListView" ValidationGroup="Update" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="Cancel" CausesValidation="false" ValidationGroup="Update" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="Delete" OnClientClick="return confirm('Are you sure you want to delete this opportunity?');" />
            <asp:Label ID="lblnotification" runat="server" /><br />
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="Update" runat="server"  DisplayMode="BulletList" CssClass="errors" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

    <%-- Gridview that contains product details and forecast, needs to link to header --%>
    <asp:ObjectDataSource ID="odsGetOpportunities" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" 
    
    TypeName="Forecaster.getOpportunitiesTableAdapters.getOpportunitiesTableAdapter">
        <SelectParameters>
        <asp:ControlParameter ControlID="cblProducts" DefaultValue="" 
            Name="funnelproductid" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="ddlSalesmen" DefaultValue="" Name="teamid" 
            PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="cblFunnelPositions" DefaultValue="" 
            Name="funnelpositionid" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>


    <asp:SqlDataSource ID="sdsInsert" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>"       
    SelectCommand="SELECT * FROM [tblOpportunities] where opportunityid = @opportunityID">     
        <SelectParameters>
        <asp:SessionParameter Name="opportunityID" SessionField="OpportunityID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>"
        SelectCommand="select * from tblopportunitydetails a inner join tblFunnelCategories b on a.funnelproductid = b.funnelproductid where opportunityid = @opportunityID">
        <SelectParameters>
        <asp:SessionParameter Name="opportunityID" SessionField="OpportunityID" />
        </SelectParameters></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTeams" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from tblteams order by teamname"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCustomers" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from tblFunnelcustomers order by customername"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFunnelPositions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="SELECT * FROM [tblFunnelPositions] where funnelpositionid <> 9"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsEmptyOpportunityDetails" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from tblopportunitydetails a inner join tblFunnelCategories b on a.funnelproductid = b.funnelproductid where opportunityid = 0"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFunnelProducts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select * from tblFunnelCategories"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTeamFilter" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select teamid,teamname from tblteams union select 0,'All' order by teamname"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsIndustryCodes" runat="server"   
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select industrycodeid,industrycode from tblFunnelIndustryCodes order by industrycode"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsExecSponsor" runat="server"   
        ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
        SelectCommand="select ExecSponsorID,ExecSponsor from tblExecSponsor union select 0,'(None)' order by ExecSponsor"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsGetOpportunities" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
    SelectCommand="select a.OpportunityID,  
	   Customer as [Customer], 
	   EPCConsultant as [EPC Consultant], 
	   TeamName as [Salesman], 
	   Name, 
	   LastModifiedDate as [Last Modified Date], 
	   ClosingDate as [Closing Date], 
	   FunnelPosition as [Funnel Pos'n], 
	   a.Percentage/100 as [Prob happening], 
	   PATTID, 
	   a.Total as [factored_total],
       i.ExecSponsor as [Exec Sponsor],
       Outage,
       sum(b.total) / case when count (distinct username) = 0 then 1 else count(distinct username) end  as [total]
	    ,cast(round(MAX(case when productcategory = 'AMS'                       and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [AMS]
	    ,cast(round(MAX(case when productcategory = 'CSI'                       and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [CSI]
	    ,cast(round(MAX(case when productcategory = 'Det-Tronics'               and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [Det-Tronics]
	    ,cast(round(MAX(case when productcategory = 'Farris'                    and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [Farris]
	    ,cast(round(MAX(case when productcategory = 'Fisher Regs'               and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [FisherRegs]
	    ,cast(round(MAX(case when productcategory = 'Fisher Valves'             and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [FisherValves]
	    ,cast(round(MAX(case when productcategory = 'IVS'                       and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [IVS]
	    ,cast(round(MAX(case when productcategory = 'MMI'                       and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [MMI]
        ,cast(round(MAX(case when productcategory = 'PSS'                       and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [PSS]
	    ,cast(round(MAX(case when productcategory = 'RSMT Flow'                 and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [RSMT Flow]
	    ,cast(round(MAX(case when productcategory = 'RSMT PTL'                  and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [RSMT PTL]
	    ,cast(round(MAX(case when productcategory = 'RSMT Analytical - Gas'     and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [RSMT Analytical-Gas]
	    ,cast(round(MAX(case when productcategory = 'RSMT Analytical - Liquid'  and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [RSMT Analytical-Liquid]
	    ,cast(round(MAX(case when productcategory = 'Services'                  and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [Services]
	    ,cast(round(MAX(case when productcategory = 'VAD'                       and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [VAD]
	    ,cast(round(MAX(case when productcategory = 'Wireless'                  and b.total &gt; 0  then case when b.percentage= 0 then 1 else (b.percentage / 100) end  * B.TOTAL else 0 end ),0) as int) as [Wireless]             
from tblOpportunities a
 inner join tblopportunitydetails b
on a.opportunityid = b.opportunityid
inner join tblfunnelcategories c 
on b.funnelproductid = c.funnelproductid
left join tblteams e
on a.salesmanid = e.teamid
left join tblpermissions g
on e.teamid = g.teamid
inner join dbo.tblFunnelPositions f
on a.FunnelPositionID = f.FunnelPositionID
left join dbo.tblfunnelindustrycodes h
on a.industrycodeid = h.industrycodeid
left join dbo.tblExecSponsor i
on a.ExecSponsorID = i.ExecSponsorID
where a.opportunityid in (select distinct opportunityid
                            from tblopportunitydetails 
                           where (funnelproductid in (SELECT item from fnSplit(@funnelproductid,',')) and total &gt; 0) or @funnelproductid = '0')
and a.opportunityid in (select opportunityid from tblopportunities where 
								        (f.funnelpositionid in  (SELECT item from fnSplit(@funnelpositionid,',')) or 
								        @funnelpositionid = '0'))
and a.opportunityid in (select opportunityid from tblopportunities where 
								        (industrycodeid  in (SELECT item from fnSplit(@industrycodes,',')) or 
								        @industrycodes = '0'))
and (a.salesmanid in (@teamid) or @teamid = 0 or a.opportunityid in (select distinct opportunityid from tblOpportunityAssignments OA where salesmanid = @teamid))
and (upper(g.username) = upper(@username) or upper(@username) in (select upper(username) from tblfunneladmins) or
     a.opportunityid in (select opportunityid from tblopportunitydetails a inner join tblProductPermissions b
                          on a.funnelproductid = b.funnelproductid
                          where username = @username
                          group by opportunityid
                          having sum(total) &gt; 0)
     or a.opportunityid in (select opportunityid from tblopportunityassignments e inner join tblpermissions g on e.salesmanid = g.teamid where upper(g.username) = upper(@username)))
and (closingdate between @startdate and @enddate or closingdate is null)
and (createdate between @createdstartdate and @createdenddate or createdate is null)
and upper(Customer) like '%' + upper(@CustomerFilter) +'%'
and (a.funnelpositionid &lt;&gt; 9 or a.funnelpositionid is null)
and ((Top25 = 1 and @Top25Filter = 1) or (Top25 = 0 and @Top25Filter = 2) or @Top25Filter = 3)
and (a.execsponsorid = @ExecSponsorID or @ExecSponsorID = 0)
and upper(EPCConsultant) like '%' + upper(@EPCFilter) + '%'
and (a.opportunityID = @ID or @ID = 0)
and (a.opportunityid in (select distinct opportunityid
                              from tblopportunitydetails 
                           where (productsaleslead like '%' + upper(@ProductLead) + '%')))
and (outage = @Outage or @Outage = 2)
group by a.OpportunityID, Originator, Customer, CustomerLocation, EPCConsultant, TeamName, Name, CreateDate, LastModifiedDate, ClosingDate,f.FunnelPosition, a.Percentage, PATTID, a.Total, Description,i.ExecSponsor,outage
Order by a.OpportunityID desc">
        <SelectParameters>
            <asp:SessionParameter sessionfield="funnelproductid" Name="funnelproductid" DefaultValue="0" Type="String" />
            <asp:SessionParameter SessionField="funnelpositionid" Name="funnelpositionid" DefaultValue="0" type="String" />
            <asp:ControlParameter ControlID="ddlSalesmen" Name="teamid"  DefaultValue="0"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ClosingStartDateTextBox" Name="startdate"  DefaultValue="1/1/2008"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ClosingEndDateTextBox" Name="enddate"  DefaultValue="1/1/2050"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="CreatedStartDateTextBox" Name="createdstartdate"  DefaultValue="1/1/2008"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="CreatedEndDateTextBox" Name="createdenddate"  DefaultValue="1/1/2050"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtCustomerFilter" Name="CustomerFilter" DefaultValue = "%"
                PropertyName="Text" />            
            <asp:ControlParameter ControlID="txtEPCFilter" Name="EPCFilter" DefaultValue = "%"
                PropertyName="Text" />            
            <asp:ControlParameter ControlID="txtProductLead" Name="ProductLead" DefaultValue = "%"
                PropertyName="Text" />            
            <asp:SessionParameter Name="Username" SessionField="Username" />
            <%--<asp:ControlParameter ControlID="chkTop25Filter" Name="Top25Filter" DefaultValue = "0"
                PropertyName="Checked" />     --%>
            <asp:ControlParameter ControlID="rblTop25Filter" Name="Top25Filter" DefaultValue = "3"/> 
            <asp:SessionParameter SessionField="industrycodes" Name="industrycodes" DefaultValue="0" type="String" />                       
            <asp:ControlParameter ControlID="ddlExecSponsors" Name="ExecSponsorID"  DefaultValue="0"
                PropertyName="SelectedValue" />                  
            <asp:ControlParameter ControlID="txtID" Name="ID" DefaultValue="0" />           
            <asp:ControlParameter ControlID="ddlOutage" Name="Outage" DefaultValue="2" />           
        </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsOpportunityAssignments" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
    SelectCommand="select * from tblOpportunityAssignments where opportunityID = @OpportunityID"
    DeleteCommand="delete from tblOpportunityAssignments Where OpportunityAssignmentid = @OpportunityAssignmentID">
    <SelectParameters>
        <asp:Parameter Name="OpportunityID" />
    </SelectParameters>
    <DeleteParameters >
        <asp:Parameter Name="OpportunityAssignmentID" />
    </DeleteParameters>
</asp:SqlDataSource>
<asp:Button ID="FakeTarget" runat="server" Style="display: none;" />
<RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" Charset="utf-8" ContentEncoding="windows-1250"
EnableHyperLinks="True" ExportFileName="Funnel.xls" IncludeTimeStamp="True" PageSize="All" 
Text="Export To Excel" GridViewID="Gridview4" />
<!--Author: Rajesh K, Copyright 2007 All rights reserved. Use this control at your own risk.  Author is not responsible for any defects or damages to your code.-->
</asp:Content>
