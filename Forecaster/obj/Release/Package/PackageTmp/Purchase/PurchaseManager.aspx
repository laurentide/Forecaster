<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="PurchaseManager.aspx.vb" Inherits="Forecaster.PurchaseManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Purchase Request Approval</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:FormView ID="frmView" runat="server" DataSourceID="sdsUpdate" DefaultMode="Edit" DataKeyNames="PurchaseRequestID" OnItemUpdated="frmView_ItemUpdated" OnDataBound="frmView_DataBound">
        <EditItemTemplate>
            <table border="1px">
                <tr>
                    <td>ID:</td>
                    <td><asp:Label ID="PurchaseRequestIDLabel1" runat="server" ReadOnly="True" Text='<%# Eval("PurchaseRequestID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Requester Name:
                    </td>
                    <td>
                        <asp:Label ID="RequesterNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("RequesterName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Requester Username:
                    </td>
                    <td>
                        <asp:Label ID="RequesterUsernameTextBox" runat="server" Text='<%# Bind("RequesterUsername") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Requester Email:
                    </td>
                    <td>
                        <asp:Label ID="RequesterEmailTextBox" runat="server" Text='<%# Bind("RequesterEmail") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Department:
                    </td>
                    <td>
                        <asp:Label ID="DepartmentIDTextBox" runat="server" ReadOnly="True" Text='<%# Bind("DepartmentName")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Date Requested:
                    </td>
                    <td>
                        <asp:Label ID="DateRequestedTextBox" runat="server" ReadOnly="True" Text='<%# Bind("DateRequested", "{0:MM/dd/yyyy}")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Date Required:
                    </td>
                    <td>
                        <asp:Label ID="DateRequiredTextBox" runat="server" ReadOnly="True" Text='<%# Bind("DateRequired", "{0:MM/dd/yyyy}")%>' />
                    </td>
                </tr>
                <tr>
                    <td>Item Name:
                    </td>
                    <td>
                        <asp:Label ID="ItemNameTextBox"  Width="500" runat="server" ReadOnly="True" Text='<%# Bind("ItemName") %>' />
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Description:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server"  TextMode="MultiLine" Rows="5" Width="500" Text='<%# Bind("Description") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Link:
                    </td>
                    <td>
                        <asp:Hyperlink ID="LinkTextbox" Width="500" runat="server"  NavigateUrl='<%# Bind("Link")%>' Text='<%# Bind("Link")%>' />
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Reason:
                    </td>
                    <td>
                        <asp:TextBox ID="ReasonTextBox" runat="server"  TextMode="MultiLine" Rows="5" Width="500" Text='<%# Bind("Reason") %>'  />
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Quantity:
                    </td>
                    <td>
                        <asp:Textbox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ValidationGroup="Update" ErrorMessage="Quantity required" ControlToValidate="QuantityTextBox" />
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ForeColor="Red" ErrorMessage="Numbers only" Type="double" MinimumValue="0" MaximumValue="1000000" ControlToValidate="QuantityTextBox" ValidationGroup="Update" />
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Total Price:
                    </td>
                    <td>
                        <asp:Textbox ID="TotalPriceTextBox" runat="server"  Text='<%# Bind("TotalPrice")%>' />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" ValidationGroup="Update" ErrorMessage="Price required" ControlToValidate="TotalPriceTextBox" />
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar sign" Type="double" MinimumValue="0" MaximumValue="1000000" ControlToValidate="TotalPriceTextBox" ValidationGroup="Update" />
                    </td>
                </tr>
<%--                <tr>
                    <td>Approval Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="ApprovalDropDown" runat="server" DataSourceID="sdsApprovalTypes" AppendDataBoundItems="true" DataValueField="ApprovalTypeID" DataTextField="ApprovalType" SelectedValue='<%# Bind("ApprovalType")%>'>
                            <asp:ListItem Text="(Select the purpose of the purchase)" Value="" />
                        </asp:DropDownList>
                        <asp:Label ID="ApprovalTypeTextBox" runat="server" Text='<%# Bind("Approval")%>' />
                    </td>
                </tr>--%>
<%--                <tr>
                    <td>Customer (If Resell):
                    </td>
                    <td>
                        <asp:Label ID="CustomerTextBox" runat="server" Text='<%# Bind("Customer") %>' />
                    </td>
                </tr>--%>
 <%--               <tr>
                    <td>Project Code (If Project):
                    </td>
                    <td>
                        <asp:Label ID="ProjectCodeTextBox" runat="server" Text='<%# Bind("ProjectCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>PM Initials
                    </td>
                    <td>
                        <asp:Label ID="PMInitialsTextBox" runat="server" Text='<%# Bind("PMInitials") %>' />
                    </td>
                </tr>
                <tr>
                    <td>Change Order Notice:
                    </td>
                    <td>
                        <asp:Label ID="ChangeOrderNoticeTextBox" runat="server" Text='<%# Bind("ChangeOrderNotice") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td>FileName:</td>
                    <td>
                        <asp:Label ID="FilenameTextbox" runat="server" Text='<%# Bind("Filename")%>' /></td>
                </tr>
                <tr>
                    <td>Path:
                    </td>
                    <td><asp:HyperLink ID="PathTextbox" runat="server" NavigateUrl='<%# Page.ResolveUrl(IIf(IsDBNull(Eval("Path")),"",Eval("Path")))%>' Text='<%# IIf(IsDBNull(Eval("Path")),"",Eval("Path"))%>' Target="_blank" /></td>
                </tr>
                <td style="background-color:#E6E6E6">Approver:
                    </td>
                    <td>
                        <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                            <asp:ListItem Text="(Select the approver)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your approver" ControlToValidate="ManagerDropDown" />
                        <asp:CustomValidator ID="ManagerDropDownCustomValidator" Forecolor="Red" validationgroup="Update" runat="server" ErrorMessage="The approver chosen has not a limit high enough to approve this request, please choose another approver" ControlToValidate="ManagerDropDown" OnServerValidate="ManagerDropDownCustomValidator_ServerValidate"></asp:CustomValidator>
                        <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                    </td>                
                </tr>
                <%--<tr><td>Approval limit sheet:</td><td><a href="../Content/Excel/Authorizationlist.xls" target="_blank" title="Excel Test">Limit Sheet</a></td></tr>--%>
                <tr>
                    <td>Approval Date:
                    </td>
                    <td>
                        <asp:Label ID="ManagerApprovalDateTextBox" runat="server" readonly="true" Text='<%# Bind("ManagerApprovalDate") %>' />
                    </td>
                </tr>
<%--                <tr>
                    <td>Approved:
                    </td>
                    <td>
                        <asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td style="background-color:#E6E6E6">Status:
                    </td>
                    <td>
                        <asp:DropDownList ID="StatusDropDown" runat="server" DataSourceID="sdsStatuses" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" SelectedValue='<%# Bind("StatusID")%>'>
                        </asp:DropDownList>
                        <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Please approve or deny this request" Type="Integer" MinimumValue="2" MaximumValue="4" ControlToValidate="StatusDropDown" ValidationGroup="Update" />
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Purchase Category:
                    </td>
                    <td>
                        <asp:DropDownList ID="PurchaseCategoryDropDown" runat="server" DataSourceID="sdsPurchaseCategories"  AppendDataBoundItems="true" DataValueField="PurchaseCategoryID" DataTextField="DescString" SelectedValue='<%# Bind("PurchaseCategoryID")%>' >
                            <asp:ListItem Text="(Select the purchasing category)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select a category" ControlToValidate="PurchaseCategoryDropDown" />
                    </td>
                </tr>
<%--                <tr>
                    <td style="background-color:#E6E6E6">BOLT Sponsor:
                    </td>
                    <td>
                        <asp:Label ID="BoltSponsorLabel" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Purchasing Agent:
                    </td>
                    <td>
                        <asp:Label ID="PurchaseAgentLabel" runat="server" />
                    </td>
                </tr>--%>
<%--                <tr>
                    <td>Is this an IT item? <br /><span style="font-weight:bold">(If yes, the buyer needs to be Johanne Legault)</span> 
                    </td>
                    <td>
                        <asp:CheckBox ID="ITReviewCheckBox" runat="server" Checked='<%# Bind("ITReview")%>' OnCheckedChanged="ITReviewCheckBox_CheckedChanged" AutoPostBack="true" />
                    </td>
                </tr>--%>
                <tr>
                    <td style="background-color:#E6E6E6">Message to IT:
                    </td>
                    <td>
                        <asp:TextBox ID="ITMessageTextBox" runat="server" TextMode="MultiLine" Height="100" Width="500" Text='<%# Bind("ITMessage")%>' />
                    </td>
                </tr>

                <%--<tr>
                    <td>LCL Purchase Order:
                    </td>
                    <td>
                        <asp:TextBox ID="LCLPurchaseOrderTextBox" runat="server" Text='<%# Bind("LCLPurchaseOrder") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td style="background-color:#E6E6E6">Order Entry/Buyer:
                    </td>
                    <td>
                        <asp:DropDownList ID="BuyerDropDown" runat="server" DataSourceID="sdsBuyers" AppendDataBoundItems="true" DataValueField="BuyerID" DataTextField="BuyerName" SelectedValue='<%# Bind("BuyerID")%>'>
                            <asp:ListItem Text="(Select your order entry person)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your buyer" ControlToValidate="BuyerDropDown" />
                        <%--<asp:TextBox ID="BuyerIDTextBox" runat="server" Text='<%# Bind("BuyerID") %>' />--%>
                    </td>
                </tr>
                <tr>
                    <td style="background-color:#E6E6E6">Backup Order Entry/Buyer:
                    </td>
                    <td>
                        <asp:DropDownList ID="BackupBuyerDropDown" runat="server" DataSourceID="sdsBuyers" AppendDataBoundItems="true" DataValueField="BuyerID" DataTextField="BuyerName" SelectedValue='<%# Bind("BackupBuyerID")%>'>
                            <asp:ListItem Text="(Select your backup order entry person)" Value="" />
                        </asp:DropDownList>
                        <%--<asp:TextBox ID="BuyerIDTextBox" runat="server" Text='<%# Bind("BuyerID") %>' />--%>
                    </td>
                </tr>
                <%-- %><tr>
                    <td>OrderEntryByID:
                    </td>
                    <td>
                        <asp:TextBox ID="OrderEntryByIDTextBox" runat="server" Text='<%# Bind("OrderEntryByID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>DateOrderEntry:
                    </td>
                    <td>
                        <asp:TextBox ID="DateOrderEntryTextBox" runat="server" Text='<%# Bind("DateOrderEntry") %>' />
                    </td>
                </tr>--%>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="Update" CommandName="Update" Text="Update" />
                        <%--&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                    </td>
                </tr>
                        <asp:Panel ID="InvestmentSheetPanel" runat="server" Visible="false">
                        <tr><td><br /></td></tr>
                        <tr><td><asp:Label Text="Investment" runat="server" ID="InvestmentSheetHeader" style="font-size:200%;" /></td></tr>
                        <tr>
                            <td>Investment Owner: </td>
                            <td>
                                <asp:TextBox ID="InvestmentOwnerID" runat="server" Text='<%# Bind("InvestmentOwner")%>' Width="500" ReadOnly="true" /></td>
                        </tr>                        
                        <tr>
                            <td>Investment Start Date:</td>
                            <td>
                                <asp:TextBox ID="ISD_TextBox" runat="server" Text='<%# Bind("InvestmentStartDate")%>' ReadOnly="true" />
<%--                                <asp:Image runat="server" ID="ISD_Image" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                <asp:CalendarExtender ID="ISD_CalendarExtender" runat="server" TargetControlID="ISD_TextBox" PopupButtonID="ISD_Image" />
                                <asp:MaskedEditExtender ID="ISD_MaskedEditExtender" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ISD_TextBox" PromptCharacter="_" />
                                <asp:MaskedEditValidator ID="ISD_Maskededitvalidator" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="ISD_TextBox" ControlExtender="ISD_MaskedEditExtender" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Definition of Investment (What is the investment that is proposed?):</td>
                            <td>
                                <asp:TextBox ID="DOF_ID" runat="server" Text='<%# Bind("InvestmentDefinition") %>' TextMode="MultiLine" Rows="5" Width="500" ReadOnly="true"/></td>
                        </tr>
                        <tr>
                            <td>Benefit to Laurentide (Why should we consider doing this? - both hard and soft benefits):</td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("InvestmentLaurentideBenefit")%>' TextMode="MultiLine" Rows="5" Width="500" ReadOnly="true"/></td>
                        </tr>    
<%--                        <tr>
                            <td>Projected ROI (if applicable):</td>
                            <td>
                                <asp:Button ID="AddPROIButton" runat="server" CausesValidation="True" Text="Add new Projected ROI" OnClick="AddPROIButton_Click"/>
                            </td>
                       </tr>  --%>
                       <tr>
                           <td></td>
                           <td>
                           <asp:Panel ID="proi_panel" runat="server" Visible="false">
                                <asp:FormView runat="server" ID="proiDetails" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" OnItemInserting="proiDetails_ItemInserting">   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Benefit (description):</td><td>
                                    <asp:TextBox ID="BenefitsTextBox" runat="server" Width="300" Text='<%# Bind("Benefit") %>' />
                                </td></tr>
                                    <tr><td>Year 0:</td><td><asp:TextBox ID="year0" runat="server" Width="300" Text='<%# Bind("PROI_Year0")%>'/></td></tr>
                                    <tr><td>Year 1:</td><td><asp:TextBox ID="year1" runat="server" Width="300" Text='<%# Bind("PROI_Year1")%>'/></td></tr>
                                    <tr><td>Year 2:</td><td><asp:TextBox ID="year2" runat="server" Width="300" Text='<%# Bind("PROI_Year2")%>'/></td></tr>
                                    <tr><td>Year 3:</td><td><asp:TextBox ID="year3" runat="server" Width="300" Text='<%# Bind("PROI_Year3")%>'/></td></tr>
                                    <tr><td>Year 4:</td><td><asp:TextBox ID="year4" runat="server" Width="300" Text='<%# Bind("PROI_Year4")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Projected ROI" CommandName="Insert" ID="InsertButton" CausesValidation="True" ValidationGroup="InsertDetails" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelPROIButton" CausesValidation="true" OnClick="CancelPROIButton_Click" /></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                       </tr>
                       <tr>
                           <td>Projected ROI list:</td>
                           <td>
                           <asp:GridView ID="gvPROIDetails" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnRowDataBound="gvPROIDetails_RowDataBound"
                            CellPadding="4" ForeColor="#333333" OnDataBinding="gvPROIDetails_DataBinding"
                            Font-Size="10px" OnRowDeleting="gvPROIDetails_RowDeleting" OnSelectedIndexChanged="gvPROIDetails_SelectedIndexChanged">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="Benefit" HeaderText="Benefit" SortExpression="Benefit" />
                                <asp:BoundField DataField="PROI_Year0" HeaderText="Year 0" SortExpression="PROI_Year0" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PROI_Year1" HeaderText="Year 1" SortExpression="PROI_Year1" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PROI_Year2" HeaderText="Year 2" SortExpression="PROI_Year2" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PROI_Year3" HeaderText="Year 3" SortExpression="PROI_Year3" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PROI_Year4" HeaderText="Year 4" SortExpression="PROI_Year4" DataFormatString="{0:c}" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Projected ROI entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                           </td>
                       </tr>
<%--                        <tr>
                            <td>Program Costs:</td>
                            <td>
                               <asp:Button ID="AddProgramCostButton" runat="server" Text="Add new Program Cost" CausesValidation="true" OnClick="AddProgramCostButton_Click" />
                            </td>
                        </tr>--%>
                       <tr>
                           <td></td>
                           <td>
                           <asp:Panel ID="ProgramCostsPanel" runat="server" Visible="false">
                                <asp:FormView runat="server" ID="frmProgramCosts" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="frmProgramCosts_ItemInserting" >   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Program Cost (description):</td><td>
                                    <asp:TextBox ID="ProgramCostTextBox" runat="server" Width="300" Text='<%# Bind("ProgramCostDetail")%>'/>
                                </td></tr>
                                    <tr><td>Year 0:</td><td><asp:TextBox ID="PCYear0" runat="server" Width="300" Text='<%# Bind("PC_Year0")%>' /></td></tr>
                                    <tr><td>Year 1:</td><td><asp:TextBox ID="PCYear1" runat="server" Width="300" Text='<%# Bind("PC_Year1")%>'/></td></tr>
                                    <tr><td>Year 2:</td><td><asp:TextBox ID="PCYear2" runat="server" Width="300" Text='<%# Bind("PC_Year2")%>'/></td></tr>
                                    <tr><td>Year 3:</td><td><asp:TextBox ID="PCYear3" runat="server" Width="300" Text='<%# Bind("PC_Year3")%>'/></td></tr>
                                    <tr><td>Year 4:</td><td><asp:TextBox ID="PCYear4" runat="server" Width="300" Text='<%# Bind("PC_Year4")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Program Cost" CommandName="Insert" ID="InsertButton" CausesValidation="True" ValidationGroup="InsertDetails" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelProgramCostButton" CausesValidation="true" OnClick="CancelProgramCostButton_Click" /></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                        <tr>
                           <td>Program Costs List:</td>
                           <td>
                           <asp:GridView ID="gvProgramCostsDetails" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnRowDeleting="gvProgramCostsDetails_RowDeleting" OnDataBinding="gvProgramCostsDetails_DataBinding"
                            CellPadding="4" ForeColor="#333333" OnRowDataBound="gvProgramCostsDetails_RowDataBound" OnSelectedIndexChanged="gvProgramCostsDetails_SelectedIndexChanged"
                            Font-Size="10px">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="ProgramCostDetail" HeaderText="Program Cost" SortExpression="ProgramCostDetail" />
                                <asp:BoundField DataField="PC_Year0" HeaderText="Year 0" SortExpression="PC_Year0" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PC_Year1" HeaderText="Year 1" SortExpression="PC_Year1" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PC_Year2" HeaderText="Year 2" SortExpression="PC_Year2" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PC_Year3" HeaderText="Year 3" SortExpression="PC_Year3" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="PC_Year4" HeaderText="Year 4" SortExpression="PC_Year4" DataFormatString="{0:c}" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Program Costs entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                           </td>
                        </tr>
                      </tr>
                       <asp:Panel ID="NCFPanel" runat="server">
                       <tr>
                           <td><asp:Label Text="Net Cash Flow:" ID="NetCashFlowID" runat="server" /></td>
                           <td>
                               <table border="solid" width="100%" style="background-color:#F7F6F3;">
                                   <tr style="background:#c1ddff;"><td></td><td><b>Year 0</b></td><td><b>Year 1</b></td><td><b>Year 2</b></td><td><b>Year 3</b></td><td><b>Year 4</b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Net Cash Flow:</b></td><td><b><asp:Label ID="NCFYear0" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear1" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear2" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear3" runat="server" /></b></td>
                                       <td><b><asp:Label ID="NCFYear4" runat="server" /></b></td>
                                   </tr>
                                   <tr style="background:#c1ddff;"><td><b>Discount Rate:</b></td><td><b>10%</b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Discount Factor:</b></td><td><b>100%</b></td><td><b>91%</b></td><td><b>83%</b></td><td><b>75%</b></td><td><b>68%</b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Discounted Net Cash Flow:</b></td>
                                       <td><b><asp:Label ID="DNCFYear0" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear1" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear2" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear3" runat="server" /></b></td>
                                       <td><b><asp:Label ID="DNCFYear4" runat="server" /></b></td></tr>
                                   <tr style="background:#c1ddff;"><td><b>Five Year Net Present Value (NPV):</b></td><td><b><asp:Label ID="NPVLabel" runat="server" /></b></td></tr>
                               </table>
                           </td>
                       </tr>
                       </asp:Panel>
<%--                        <tr>
                            <td>Success Criteria (ie. how will we measure success/progress quarterly?)</td>
                            <td>
                                <asp:Button ID="SuccessCriteriaButton" runat="server" CausesValidation="true" Text="Add new Success Criteria" OnClick="SuccessCriteriaButton_Click" />
                            </td>
                        </tr>--%>
                        <tr><td></td>
                            <td>
                           <asp:Panel ID="SuccessCriteriaPanel" runat="server" Visible="False">
                                <asp:FormView runat="server" ID="frmSuccessCriteria" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="frmSuccessCriteria_ItemInserting" >   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Success Criteria:</td><td>
                                    <asp:TextBox ID="SuccessCriteriaTextbox" runat="server" Width="500" Text='<%# Bind("SuccessCriteriaDetail")%>'/>
                                </td></tr>
                                    <tr><td>Baseline:</td><td><asp:TextBox ID="BaselineID" runat="server" Width="500" Text='<%# Bind("Baseline")%>' /></td></tr>
                                    <tr><td>P1:</td><td><asp:TextBox ID="Q1" runat="server" Width="500" Text='<%# Bind("Q1")%>'/></td></tr>
                                    <tr><td>P2:</td><td><asp:TextBox ID="Q2" runat="server" Width="500" Text='<%# Bind("Q2")%>'/></td></tr>
                                    <tr><td>P3:</td><td><asp:TextBox ID="Q3" runat="server" Width="500" Text='<%# Bind("Q3")%>'/></td></tr>
                                    <tr><td>P4:</td><td><asp:TextBox ID="Q4" runat="server" Width="500" Text='<%# Bind("Q4")%>'/></td></tr>
                                    <tr><td>P5:</td><td><asp:TextBox ID="Q5" runat="server" Width="500" Text='<%# Bind("Q5")%>'/></td></tr>
                                    <tr><td>P6:</td><td><asp:TextBox ID="Q6" runat="server" Width="500" Text='<%# Bind("Q6")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Success Criteria" CommandName="Insert" ID="InsertSuccessCriteriaButton" CausesValidation="True" ValidationGroup="InsertDetails" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelSuccessCriteriaButton" CausesValidation="true" OnClick="CancelSuccessCriteriaButton_Click" /></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>Success Criteria List:</td>
                            <td>
                           <asp:GridView ID="gvSuccessCriteria" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnRowDeleting="gvSuccessCriteria_RowDeleting"
                            CellPadding="4" ForeColor="#333333" OnSelectedIndexChanged="gvSuccessCriteria_SelectedIndexChanged"
                            Font-Size="10px">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="SuccessCriteriaDetail" HeaderText="Success Criteria" SortExpression="SuccessCriteriaDetail" />
                                <asp:BoundField DataField="Baseline" HeaderText="Baseline" SortExpression="Baseline" />
                                <asp:BoundField DataField="Q1" HeaderText="P1" SortExpression="Q1" />
                                <asp:BoundField DataField="Q2" HeaderText="P2" SortExpression="Q2" />
                                <asp:BoundField DataField="Q3" HeaderText="P3" SortExpression="Q3" />
                                <asp:BoundField DataField="Q4" HeaderText="P4" SortExpression="Q4" />
                                <asp:BoundField DataField="Q5" HeaderText="P5" SortExpression="Q5" />
                                <asp:BoundField DataField="Q6" HeaderText="P6" SortExpression="Q6" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Success Criteria entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                            </td>
                        </tr>
<%--                        <tr>
                            <td>Implementation & Follow-Up Plan (ie. what will be done to ensure success?)</td>
                            <td><asp:Button ID="AddImplementationButton" runat="server" CausesValidation="true" Text="Add new Implementation/Follow-Up Plan" OnClick="AddImplementationButton_Click" /></td>
                        </tr>--%>
                        <tr><td></td>
                            <td>
                           <asp:Panel ID="ImplementationPanel" runat="server" Visible="False">
                                <asp:FormView runat="server" ID="frmImplementation" BackColor="#c1ddff" BorderStyle="Solid" BorderWidth="1px" DefaultMode="Insert" 
                                    OnItemInserting="frmImplementation_ItemInserting">   
                                <InsertItemTemplate>                         
                                <table>
                                <tr><td>Event:</td><td>
                                    <asp:TextBox ID="EventTextbox" runat="server" Width="500" Text='<%# Bind("Event")%>'/>
                                </td></tr>
                                    <tr><td>When:</td><td><asp:TextBox ID="WhenID" runat="server" Width="500" Text='<%# Bind("When")%>'/></td></tr>
                                    <tr><td>% Compl.:</td><td><asp:TextBox ID="ComplID" runat="server" Width="500" Text='<%# Bind("Compl")%>' /></td></tr>
                                    <tr><td>Resp.:</td><td><asp:TextBox ID="RespID" runat="server" Width="500" Text='<%# Bind("Resp")%>'/></td></tr>
                                    <tr><td>Notes:</td><td><asp:TextBox ID="NotesID" runat="server" Width="500" Text='<%# Bind("Notes")%>'/></td></tr>
                                    <tr><td><asp:Button runat="server" Text="Save Implementation/Follow-Up Plan" CommandName="Insert" ID="InsertImplementationButton" CausesValidation="True" /></td>
                                        <td><asp:Button runat="server" Text="Cancel" ID="CancelImplementationButton" CausesValidation="true" OnClick="CancelImplementationButton_Click" /></td></tr>
                                </table>
                                </InsertItemTemplate>    
                                </asp:FormView>
                           </td>
                           </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>Implementation/Follow-Up Plan list:</td>
                            <td>
                           <asp:GridView ID="gvImplementation" runat="server" AutoGenerateColumns="False" ShowFooter="true" HeaderStyle-CssClass="grid_Header"
                            RowStyle-CssClass="grid_RowStyle" OnRowDeleting="gvImplementation_RowDeleting"
                            CellPadding="4" ForeColor="#333333" OnSelectedIndexChanged="gvImplementation_SelectedIndexChanged"
                            Font-Size="10px">
                             <Columns>
                              <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this expense?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                                <asp:BoundField DataField="Event" HeaderText="Event" SortExpression="Event" />
                                <asp:BoundField DataField="FUPWhen" HeaderText="When" SortExpression="FUPWhen" />
                                <asp:BoundField DataField="Compl" HeaderText="Compl" SortExpression="Compl" />
                                <asp:BoundField DataField="Resp" HeaderText="Resp" SortExpression="Resp" />
                                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                               </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                                No Implementation/Follow-Up Plan entered.
                            </EmptyDataTemplate>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="10px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                           </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>Contingency Plan (ie. what will you do if it does not meet objectives?)</td>
                            <td><asp:TextBox ID="ContingencyPlanTextbox" runat="server" Text='<%# Bind("ContingencyPlan") %>' TextMode="MultiLine" Rows="5" Width="500" ReadOnly="true"></asp:TextBox></td>
                        </tr></asp:Panel>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvPurchaseRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="PurchaseRequestID" DataSourceID="sdsPurchaseRequestsGrid" AllowPaging="True" AllowSorting="True"
        HeaderStyle-CssClass="grid_Header"
        RowStyle-CssClass="grid_RowStyle"
        CellPadding="4" ForeColor="#333333"
        Font-Size="10px" PageSize="50">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="PurchaseRequestID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="PurchaseRequestID" />
            <asp:BoundField DataField="RequesterName" HeaderText="Requester" SortExpression="RequesterName" />
            <%--<asp:BoundField DataField="RequesterUsername" HeaderText="RequesterUsername" SortExpression="RequesterUsername" />--%>
            <asp:BoundField DataField="RequesterEmail" HeaderText="Email" SortExpression="RequesterEmail" />
            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName" />
            <asp:BoundField DataField="DateRequested" HeaderText="Date Requested" dataformatstring="{0:MM/dd/yyyy}" SortExpression="DateRequested" />
            <asp:BoundField DataField="DateRequired" HeaderText="Date Required" dataformatstring="{0:MM/dd/yyyy}" SortExpression="DateRequired" />
            <asp:BoundField DataField="ItemName" HeaderText="Item Name" SortExpression="ItemName" />
            <%--<asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />--%>
            <%--<asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />--%>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
            <asp:BoundField DataField="TotalPrice" HeaderText="Total"  dataformatstring="{0:c2}" SortExpression="TotalPrice" />
            <%--<asp:BoundField DataField="ManagerID" HeaderText="ManagerID" SortExpression="ManagerID" />--%>
            <asp:BoundField DataField="ManagerApprovalDate" HeaderText="Approval Date" SortExpression="ManagerApprovalDate" />
            <%--<asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />--%>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <%--<asp:BoundField DataField="Approval" HeaderText="Approval Type" SortExpression="Approval" />--%>
            <%--<asp:CheckBoxField DataField="ITReview" HeaderText="IT Review" SortExpression="ITReview" />--%>
<%--        <asp:BoundField DataField="PMInitials" HeaderText="PMInitials" SortExpression="PMInitials" />
            <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
            <asp:BoundField DataField="ProjectCode" HeaderText="ProjectCode" SortExpression="ProjectCode" />
            <asp:BoundField DataField="ChangeOrderNotice" HeaderText="Change Order Notice" SortExpression="ChangeOrderNotice" />--%>
            <%--<asp:BoundField DataField="LCLPurchaseOrder" HeaderText="LCLPurchaseOrder" SortExpression="LCLPurchaseOrder" />--%>
            <asp:BoundField DataField="PurchaseCategory" HeaderText="Category" SortExpression="PurchaseCategory" />
            <asp:BoundField DataField="PurchasingAgent" HeaderText="Purchasing Agent" SortExpression="PurchasingAgent" />
            <asp:BoundField DataField="BuyerName" HeaderText="OE" SortExpression="BuyerName" />
            <asp:BoundField DataField="BackupBuyerName" HeaderText="BckOE" SortExpression="BackupBuyerName" />
            <%--<asp:BoundField DataField="OrderEntryByID" HeaderText="OrderEntryByID" SortExpression="OrderEntryByID" />
            <asp:BoundField DataField="DateOrderEntry" HeaderText="DateOrderEntry" SortExpression="DateOrderEntry" />--%>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#646D7E" Font-Bold="True" ForeColor="White" Font-Size="8px" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" CssClass="grid_RowStyle" ForeColor="#333333" Font-Size="10px" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsUpdate" runat="server"
        ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT *, ManagerName
                       FROM  [tblPurchaseRequests] a 
                       INNER JOIN [tblDepartments] c
                       ON a.DepartmentID = c.DepartmentID 
                       INNER JOIN tblManagers ON a.ManagerID = tblManagers.ManagerID
                       WHERE PurchaseRequestID = @ID"
        InsertCommand=""
        UpdateCommand="UPDATE [PurchaseRequest].[dbo].[tblPurchaseRequests]
                       SET [ManagerApprovalDate] = CASE WHEN @StatusID = '2' THEN @ManagerApprovalDate ELSE NULL END
                          ,[ITMessage]=@ITMessage
                          ,[BuyerID] = @BuyerID
                          ,[BackupBuyerID] = @BackupBuyerID
                          ,[Description] = @Description
                          ,[PurchaseCategoryID] = @PurchaseCategoryID
                          ,[Reason] = @Reason
                          ,[Quantity] = @Quantity
                          ,[TotalPrice] = @TotalPrice
                          ,[StatusID] = @StatusID
                          ,[ManagerID] = @ManagerID
                     WHERE PurchaseRequestID = @PurchaseRequestID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvPurchaseRequests" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter SessionField="DateApproved" Name="ManagerApprovalDate" />
            <asp:Parameter Name="ITReview" />
            <asp:Parameter Name="ITMessage" />
            <asp:Parameter Name="BuyerID" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Reason" />
            <asp:Parameter Name="Quantity" />
            <asp:Parameter Name="TotalPrice" />
            <asp:Parameter Name="StatusID" />
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="PurchaseCategoryID" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseRequestsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="SELECT     tblPurchaseRequests.*, tblManagers.ManagerName, tblDepartments.DepartmentName,tblbuyers.BuyerName, Status, tblpurchasingagents.purchasingAgent,tblpurchaseCategories.PurchaseCategory,backupbuyer.buyername as backupbuyername
                       FROM       tblPurchaseRequests 
                       INNER JOIN tblDepartments 
                       ON tblPurchaseRequests.DepartmentID = tblDepartments.DepartmentID 
                       INNER JOIN tblManagers 
                       ON tblPurchaseRequests.ManagerID = tblManagers.ManagerID
                       LEFT JOIN tblbuyers 
                       on tblPurchaseRequests.buyerid = tblbuyers.buyerid
                       LEFT JOIN tblbuyers backupbuyer
                       on tblPurchaseRequests.backupbuyerid = backupbuyer.buyerid
                       LEFT JOIN tblStatuses
                       on tblPurchaseRequests.statusid = tblstatuses.statusid
                       LEFT JOIN tblPurchaseCategories
                       on tblpurchaserequests.PurchaseCategoryID = tblpurchasecategories.PurchaseCategoryID
                       LEFT JOIN tblPurchasingAgents
                       on tblpurchasecategories.PurchasingAgentid = tblPurchasingAgents.PurchasingAgentid
                       where managerDomainUser=@Username 
                       and visible = 1 
                       Order by purchaserequestid desc">
        <SelectParameters>
            <asp:SessionParameter Name="Username" SessionField="Username" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblManagers"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblDepartments"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsApprovalTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblApprovalTypes"></asp:SqlDataSource>
    <%--
        buyerid 59 = daniel isabelle
        buyerid 28 = lyne bourgoin
        buyerid 60 = chris vatne
        buyerid 22 = nicole labillois
        AND buyerid <> 59 AND buyerid <> 28 AND buyerid <> 60 AND buyerid <> 22
        they are removed from buyer drop down list (sdsBuyers) at the request of Steve because they no longer work here
    --%>
    <asp:SqlDataSource ID="sdsBuyers" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblBuyers where buyerid <> 40  order by buyername"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select * from tblStatuses order by StatusID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPurchaseCategories" runat="server" ConnectionString="<%$ ConnectionStrings:PurchaseRequestConnectionString %>"
        SelectCommand="select *,left(purchaseCategory + replicate(' ',30),30) + ' | ' + Examples as DescString from tblPurchaseCategories order by PurchaseCategory"></asp:SqlDataSource>
</asp:Content>
