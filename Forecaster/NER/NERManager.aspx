﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="NERManager.aspx.vb" Inherits="Forecaster.NERManager" MaintainScrollPositionOnPostback="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>New Employee Request Tool</h2>
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
          <Triggers>
           <asp:PostBackTrigger ControlID="frmInsert" />
          </Triggers>
        <ContentTemplate>
            <asp:FormView ID="frmInsert" runat="server" DataSourceID="sdsInsert" OnDataBound="frmInsert_DataBound" DefaultMode="Edit" DataKeyNames="NERID" OnItemInserted="frmInsert_ItemInserted"
               OnItemUpdated="frmInsert_ItemUpdated">
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td>NERID:
                            </td>
                            <td>
                                <asp:Label ID="NERIDLabel1" runat="server" Text='<%# Eval("NERID") %>' />

                            </td>
                        </tr>
                        <tr>
                            <td>Manager:</td>
                            <td>
                                <%--<asp:TextBox ID="ManagerIDTextBox" runat="server" Text='<%# Bind("ManagerID") %>' />--%>
                                <asp:DropDownList ID="ManagerDropDown" runat="server" DataSourceID="sdsManagers" AppendDataBoundItems="true" DataValueField="ManagerID" DataTextField="ManagerName" SelectedValue='<%# Bind("ManagerID")%>'>
                                    <asp:ListItem Text="(Select the manager)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" SetFocusOnError="true" runat ="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                            </td>
                        </tr>



                        <tr>
                            <td>Employee Type:</td>
                            <td>
                                <%--<asp:TextBox ID="EmployeeTypeIDTextBox" runat="server" Text='<%# Bind("EmployeeTypeID") %>' />--%>
                                <asp:DropDownList ID="EmployeeTypeDropDown" runat="server" DataSourceID="sdsEmployeeTypes" AppendDataBoundItems="true" DataValueField="EmployeeTypeID" DataTextField="EmployeeType" SelectedValue='<%# Bind("EmployeeTypeID")%>'>
                                    <asp:ListItem Text="(Select the employee type)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your employee type" ControlToValidate="EmployeeTypeDropDown" />
                            </td>
                        </tr>

                        <tr>
                            <td>Employee Status:</td>
                            <td>
                                <%--<asp:TextBox ID="EmployeeTypeIDTextBox" runat="server" Text='<%# Bind("EmployeeTypeID") %>' />--%>
                                <asp:DropDownList ID="EmploymentFormDropDown" runat="server" DataSourceID="sdsEmploymentForms" AppendDataBoundItems="true" DataValueField="EmploymentFormID" DataTextField="EmploymentForm" SelectedValue='<%# Bind("EmploymentFormID")%>'>
                                    <asp:ListItem Text="(Select the employee status)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your employment form" ControlToValidate="EmploymentFormDropDown" />
                            </td>
                        </tr>
                        <tr>
                            <td>Job Title:</td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="500" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a job description" ControlToValidate="NameTextBox" />
                            </td>

                        </tr>

                        <tr>
                            <td>Description of position:</td>
                            <td>
                                <asp:TextBox ID="PositionTextBox" runat="server" Text='<%# Bind("Position") %>' TextMode="MultiLine" Rows="5" Width="500" /></td>
                        </tr>



                        <%--                <tr>
                    <td>Return:</td>
                    <td>
                        <asp:TextBox ID="ReturnTextBox" runat="server" Text='<%# Bind("Return") %>' /></td>
                </tr>--%>

                        <%--                <tr>
                    <td>Date Created:</td>
                    <td>
                        <asp:TextBox ID="DateCreatedTextBox" runat="server" Text='<%# Bind("DateCreated") %>' /></td>
                </tr>--%>

                        <%--                <tr>
                    <td>Date Approved:</td>
                    <td>
                        <asp:TextBox ID="DateApprovedTextBox" runat="server" Text='<%# Bind("DateApproved") %>' /></td>
                </tr>--%>

                        <%--                <tr>
                    <td>Date Hired:</td>
                    <td>
                        <asp:TextBox ID="DateHiredTextBox" runat="server" Text='<%# Bind("DateHired") %>' /></td>
                </tr>--%>
                        <tr>
                            <td>Date Needed:</td>
                            <td>
                                <asp:TextBox ID="DateNeededTextbox" runat="server" Text='<%# Bind("DateNeeded")%>' />
                                <asp:Image runat="server" ID="Calendar_scheduleDR" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DateNeededTextbox" PopupButtonID="Calendar_scheduleDR" />
                                <asp:MaskedEditExtender ID="meeDateNeeded" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="DateNeededTextbox" PromptCharacter="_" />
                                <asp:MaskedEditValidator ID="Maskededitvalidator2" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="DateNeededTextbox" ControlExtender="meeDateNeeded" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a date needed for" ControlToValidate="DateNeededTextbox" />
                            </td>
                        </tr>

                        <%--                <tr>
                    <td>Cost Of Recruitment:</td>
                    <td>
                        <asp:TextBox ID="CostOfRecruitmentTextBox" runat="server" Text='<%# Bind("CostOfRecruitment") %>' /></td>
                    <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="CostOfRecruitmentTextBox" ValidationGroup="Update" />
                </tr>--%>

                        <tr>
                            <td>Job Description Link (Copy URL into this field):</td>
                            <td>
                                <asp:TextBox ID="JobDescriptionLinkTextBox" runat="server" Text='<%# Bind("JobDescriptionLink") %>' Width="500" /></td>
                        </tr>

                        <tr>
                            <td>Replacement</td>
                            <td>
                                <asp:CheckBox ID="chkReplacement" runat="server" Checked='<%# Bind("ReplacementCheck")%>' OnCheckedChanged="chkReplacement_CheckedChanged" AutoPostBack="true" /><asp:Label ID="lblReplacement" runat="server" Text="Replacement for who: " Visible="false" /><asp:TextBox ID="ReplacementTextBox" runat="server" Text='<%# Bind("Replacement") %>' Visible="false" /></td>
                        </tr>

                        <tr>
                            <td>Budgeted:</td>
                            <td>
                                <asp:CheckBox ID="BudgetedCheckBox" runat="server" Checked='<%# Bind("Budgeted") %>' /></td>
                        </tr>

                        <tr>
                            <td>Billable:</td>
                            <td>
                                <asp:CheckBox ID="BillableCheckBox" runat="server" Checked='<%# Bind("Billable") %>' /></td>
                        </tr>

                        <tr>
                            <td>New Position:</td>
                            <td>
                                <asp:CheckBox ID="NewPositionCheckBox" runat="server" Checked='<%# Bind("NewPosition")%>' />
                            </td>
                        </tr>



<%--                        <tr>
                            <td>Investment sheet</td>
                            <td>
                                <a href="file://lcl-fil1/Directory_2000/Managers/Forms/Investment%20Decision%20Analysis.xlsx">Investment decision analysis form</a><br />
                                <asp:FileUpload ID="fuDialog" runat="server" />
                                <br />
                                Path:<asp:HyperLink ID="PathTextbox" runat="server" NavigateUrl='<%# Bind("AttachmentSheetLink")%>' Text='<%# Eval("AttachmentSheetLink")%>'></asp:HyperLink>
                            </td>

                        </tr>--%>

                        <%--                <tr>
                    <td>Visible:</td>
                    <td>
                        <asp:CheckBox ID="VisibleCheckBox" runat="server" Checked='<%# Bind("Visible") %>' /></td>
                </tr>--%>
                        <tr>
                            <td colspan="2">
                                <h2>Approval Section</h2>
                            </td>
                        </tr>
                        <tr>
                            <td>Leadership Team Review:</td>
                            <td>
                                <asp:CheckBox ID="LeadershipTeamReviewCheckBox" runat="server" Checked='<%# Bind("LeadershipTeamReview") %>' /></td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td>
                                <%--<asp:TextBox ID="StatusIDTextBox" runat="server" Text='<%# Bind("StatusID") %>' /></td>--%>
                                <asp:DropDownList ID="StatusDropDown" runat="server" AutoPostBack="true" DataSourceID="sdsStatus" AppendDataBoundItems="true" DataValueField="StatusID" 
                                    DataTextField="Status" SelectedValue='<%# Bind("StatusID")%>' OnSelectedIndexChanged="StatusDropDown_SelectedIndexChanged" CausesValidation="true">
                                    <asp:ListItem Text="(Select the status)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the status" ControlToValidate="StatusDropDown" Display="Dynamic" /></td></tr>
                                <tr><td><asp:Label ID="StatusReasonLabel" runat="server" Visible="false" Text="" /></td><td><asp:TextBox ID="StatusReasonTextbox" Text='<%# Bind("StatusReason")%>' runat="server" Visible="False" Width="500" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Field Required" ControlToValidate="StatusReasonTextbox" InitialValue="0" Display="Dynamic" />
                            </td>                            
                        </tr>
             <asp:Panel ID="SORPanel" runat="server" Visible="false">
             <tr>
                    <td><asp:Label ID="SORLabel" Text="Source of Recruitment:" runat="server" /></td>
                    <td>
                        <asp:DropDownList ID="RecruitmentDropDown" runat="server" DataSourceID="sdsRecruitmentSource" AppendDataBoundItems="True" DataValueField="RecruitmentSourceID" 
                            DataTextField="RecruitmentSource" SelectedValue='<%# Bind("RecruitmentSourceID")%>' OnSelectedIndexChanged="RecruitmentDropDown_SelectedIndexChanged" 
                            AutoPostBack="true">
                            <asp:ListItem Text="(Select the source)" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the source" ControlToValidate="RecruitmentDropDown" />
                    </td>       
            </tr></asp:Panel>
                        <asp:Panel ID="SORDetailPanel" runat="server" Visible="false">  
                        <tr>                                     
                        <td><asp:Label ID="SORDetailLabel" runat="server" /></td>
                            <td>
                                <asp:TextBox ID="SORDetailTextbox" runat="server" Text='<%# Bind("RecruitmentSourceDetail")%>' Width="500" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter the recruitment source" ControlToValidate="SORDetailTextbox" />
                            </td>                        
                  </tr> 
                        </asp:Panel>
                        <asp:Panel ID="SchoolDetailPanel" runat="server" Visible="false">
                        <tr>
                            <td><asp:Label ID="SchoolDetailLabel" runat="server" /></td>
                            <td>
                                <asp:DropDownList ID="SchoolDropDown" runat="server" DataSourceID="sdsSchools" AppendDataBoundItems="true" DataValueField="SchoolID"
                                    DataTextField="SchoolName" SelectedValue='<%# Bind("SchoolID")%>' OnSelectedIndexChanged="SchoolDropDown_SelectedIndexChanged"
                                    AutoPostBack="true">
                                    <asp:ListItem Text="(Select the school)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the school" ControlToValidate="SchoolDropDown" />
                            </td>
                        </tr>
                        <asp:Panel ID="OtherSchoolPanel" runat="server" Visible="false">
                            <tr>
                                <td><asp:Label ID="OtherSchoolLabel" runat="server" /></td>
                                <td>
                                    <asp:TextBox ID="OtherSchoolTextBox" runat="server" Text='<%# Bind("SchoolDetail")%>' Width="500" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" SetFocusOnError="true" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter the school name" ControlToValidate="OtherSchoolTextBox" />
                                </td>
                            </tr>
                        </asp:Panel>
                        </asp:Panel>
                        <asp:Panel ID="InvestmentSheetPanel" runat="server" Visible="true">
                        <tr><td><br /></td></tr>
                        <tr><td><asp:Label Text="Investment" runat="server" ID="InvestmentSheetHeader" style="font-size:200%;" /></td></tr>
                        <tr>
                            <td>Investment Owner: </td>
                            <td>
                                <asp:TextBox ID="InvestmentOwnerID" runat="server" Text='<%# Bind("InvestmentOwner")%>' Width="500" /></td>
                        </tr>                        
                        <tr>
                            <td>Investment Start Date:</td>
                            <td>
                                <asp:TextBox ID="ISD_TextBox" runat="server" Text='<%# Bind("InvestmentStartDate")%>' />
                                <asp:Image runat="server" ID="ISD_Image" ImageUrl="~/_assets/img/Calendar_scheduleHS.png" />
                                <asp:CalendarExtender ID="ISD_CalendarExtender" runat="server" TargetControlID="ISD_TextBox" PopupButtonID="ISD_Image" />
                                <asp:MaskedEditExtender ID="ISD_MaskedEditExtender" runat="server" MaskType="Date" CultureName="en-US" Mask="99/99/9999" TargetControlID="ISD_TextBox" PromptCharacter="_" />
                                <asp:MaskedEditValidator ID="ISD_Maskededitvalidator" ValidationGroup="Insert" runat="server" ForeColor="Red" ControlToValidate="ISD_TextBox" ControlExtender="ISD_MaskedEditExtender" InvalidValueMessage="Date is Invalid" IsValidEmpty="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>Definition of Investment (What is the investment that is proposed?):</td>
                            <td>
                                <asp:TextBox ID="DOF_ID" runat="server" Text='<%# Bind("InvestmentDefinition") %>' TextMode="MultiLine" Rows="5" Width="500" /></td>
                        </tr>
                        <tr>
                            <td>Benefit to Laurentide (Why should we consider doing this? - both hard and soft benefits):</td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("InvestmentLaurentideBenefit")%>' TextMode="MultiLine" Rows="5" Width="500" /></td>
                        </tr>    
                        <tr>
                            <td>Projected ROI (if applicable):</td>
                            <td>
                                <asp:Button ID="AddPROIButton" runat="server" CausesValidation="True" Text="Add new Projected ROI" OnClick="AddPROIButton_Click"/>
                            </td>
                       </tr>  
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
                        <tr>
                            <td>Program Costs:</td>
                            <td>
                               <asp:Button ID="AddProgramCostButton" runat="server" Text="Add new Program Cost" CausesValidation="true" OnClick="AddProgramCostButton_Click" />
                            </td>
                        </tr>
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
                        <tr>
                            <td>Success Criteria (ie. how will we measure success/progress quarterly?)</td>
                            <td>
                                <asp:Button ID="SuccessCriteriaButton" runat="server" CausesValidation="true" Text="Add new Success Criteria" OnClick="SuccessCriteriaButton_Click" />
                            </td>
                        </tr>
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
                        <tr>
                            <td>Implementation & Follow-Up Plan (ie. what will be done to ensure success?)</td>
                            <td><asp:Button ID="AddImplementationButton" runat="server" CausesValidation="true" Text="Add new Implementation/Follow-Up Plan" OnClick="AddImplementationButton_Click" /></td>
                        </tr>
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
                            <td><asp:TextBox ID="ContingencyPlanTextbox" runat="server" Text='<%# Bind("ContingencyPlan") %>' TextMode="MultiLine" Rows="5" Width="500"></asp:TextBox></td>
                        </tr></asp:Panel>
                        <tr>
                            <td>
                                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                                &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </td>
                        </tr>

                    </table>
                </EditItemTemplate>
            </asp:FormView>
            <asp:GridView ID="gvNewEmployeeRequests" runat="server" AutoGenerateColumns="False" DataSourceID="sdsNewEmployeeRequests" AllowPaging="True" AllowSorting="True" DataKeyNames="NerID"
                HeaderStyle-CssClass="grid_Header"
                RowStyle-CssClass="grid_RowStyle"
                CellPadding="4" ForeColor="#333333"
                Font-Size="10px" PageSize="50" OnSelectedIndexChanged="gvNewEmployeeRequests_OnSelectedIndexChanged">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteButton" ForeColor="Black" runat="server" CommandName="Delete" Text="Delete" 
                                OnClientClick="return confirm('Are you sure you want to delete this request?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                    <asp:BoundField DataField="NERID" HeaderText="NERID" InsertVisible="False" ReadOnly="True" SortExpression="NERID" />
                    <asp:BoundField DataField="Name" HeaderText="Job Title" SortExpression="Name" />
                    <asp:BoundField DataField="ShortPosition" HeaderText="Job Description" SortExpression="Position" />
                    <asp:CheckBoxField DataField="Budgeted" HeaderText="Budgeted" SortExpression="Budgeted" />
                    <asp:CheckBoxField DataField="Billable" HeaderText="Billable" SortExpression="Billable" />
                    <asp:BoundField DataField="Replacement" HeaderText="Replacement" SortExpression="Replacement" />
                    <%--<asp:BoundField DataField="Return" HeaderText="Return" SortExpression="Return" />--%>
                    <asp:BoundField DataField="DateCreated" HeaderText="Date Created" SortExpression="DateCreated" />
                    <asp:BoundField DataField="DateApproved" HeaderText="Date Approved" SortExpression="DateApproved" />
                    <asp:BoundField DataField="InvestmentStartDate" HeaderText="Start Date" SortExpression="InvestmentStartDate" />
                    <asp:BoundField DataField="DateNeeded" HeaderText="Date Needed" SortExpression="DateNeelded" />
                    <%--<asp:BoundField DataField="CostOfRecruitment" HeaderText="CostOfRecruitment" SortExpression="CostOfRecruitment" />
                    <asp:BoundField DataField="JobDescriptionLink" HeaderText="JobDescriptionLink" SortExpression="JobDescriptionLink" />--%>
                    <%--<asp:CheckBoxField DataField="LeadershipTeamReview" HeaderText="LeadershipTeamReview" SortExpression="LeadershipTeamReview" />--%>
                    <%--<asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />--%>
                    <asp:BoundField DataField="EmployeeType" HeaderText="Employee Type" SortExpression="EmployeeType" />
                    <asp:BoundField DataField="EmploymentForm" HeaderText="Employment Status" SortExpression="EmploymentForm" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="StatusReason" HeaderText="New Employee Name" SortExpression="StatusReason" />
                    <asp:BoundField DataField="ManagerName" HeaderText="Manager Name" SortExpression="ManagerName" />
                    <asp:BoundField DataField="RecruitmentSource" HeaderText="Recruitment Source" SortExpression="RecruitmentSource" />
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sdsInsert" runat="server" OnInserted="sdsInsert_Inserted"
        ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="SELECT * FROM [tblNewEmployeeRequest] where NERID=@ID"
        InsertCommand="INSERT INTO [tblNewEmployeeRequest]
           ([ManagerID]
           ,[StatusID]
           ,[EmployeeTypeID]
		   ,[EmploymentFormID]
           ,[RecruitmentSourceID]
           ,[RecruitmentSourceDetail]
           ,[SchoolID]
           ,[SchoolDetail]
           ,[Name]
           ,[Position]
           ,[Budgeted]
           ,[Billable]
           ,[Replacement]
           ,[ReplacementCheck]
           ,[Return]
           ,[DateCreated]
           ,[DateApproved]
           ,[DateHired]
           ,[DateNeeded]
           ,[CostOfRecruitment]
           ,[JobDescriptionLink]
           ,[LeadershipTeamReview]
           ,[Visible]
           ,[AttachmentSheetLink]
           ,[StatusReason])
     VALUES
           (@ManagerID
           ,@StatusID
           ,@EmployeeTypeID
		   ,@EmploymentFormID
           ,@RecruitmentSourceID
           ,@RecruitmentSourceDetail
           ,@SchoolID
           ,@SchoolDetail
           ,@Name
           ,@Position
           ,@Budgeted
           ,@Billable
           ,@Replacement
           ,@ReplacementCheck
           ,@Return
           ,@DateCreated
           ,@DateApproved
           ,@DateHired
           ,@DateNeeded
           ,@CostOfRecruitment
           ,@JobDescriptionLink
           ,@LeadershipTeamReview
           ,@Visible
           ,@AttachmentSheetLink
           ,@StatusReason)
        select @ID = @@IDENTITY"
        UpdateCommand="UPDATE [tblNewEmployeeRequest]
   SET [ManagerID] = @ManagerID
      ,[StatusID] = @StatusID
      ,[EmploymentFormID] = @EmploymentFormID
      ,[EmployeeTypeID] = @EmployeeTypeID
      ,[RecruitmentSourceID] = @RecruitmentSourceID
      ,[RecruitmentSourceDetail] = @RecruitmentSourceDetail
      ,[SchoolID] = @SchoolID
      ,[SchoolDetail] = @SchoolDetail
      ,[Name] = @Name
      ,[Position] = @Position
      ,[Budgeted] = @Budgeted
      ,[Billable] = @Billable
      ,[ReplacementCheck] = @ReplacementCheck
      ,[Replacement] = @Replacement    
      ,[NewPosition] = @NewPosition  
      ,[Return] = @Return
      ,[DateApproved] = CASE WHEN @StatusID = 2 THEN getDate() ELSE @DateApproved END
      ,[DateHired] = @DateHired
      ,[DateNeeded] = @DateNeeded
      ,[CostOfRecruitment] = @CostOfRecruitment
      ,[JobDescriptionLink] = @JobDescriptionLink
      ,[LeadershipTeamReview] = @LeadershipTeamReview
      ,[AttachmentSheetLink] = @AttachmentSheetLink
      ,[StatusReason] = @StatusReason
      ,[InvestmentOwner] = @InvestmentOwner
      ,[InvestmentStartDate] = @InvestmentStartDate
      ,[InvestmentDefinition] = @InvestmentDefinition
      ,[InvestmentLaurentideBenefit] = @InvestmentLaurentideBenefit
      ,[ContingencyPlan] = @ContingencyPlan
 WHERE Nerid = @NERID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvNewEmployeeRequests" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="EmployeeTypeID" />
            <asp:Parameter Name="EmploymentFormID" />
            <asp:Parameter Name="RecruitmentSourceID" />
            <asp:Parameter Name="RecruitmentSourceDetail" />
            <asp:Parameter Name="SchoolID" />
            <asp:Parameter Name="SchoolDetail" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Position" />
            <asp:Parameter Name="Budgeted" />
            <asp:Parameter Name="Billable" />
            <asp:Parameter Name="Replacement" />
            <asp:Parameter Name="ReplacementCheck" />
            <asp:Parameter Name="Return" />
            <asp:Parameter Name="DateCreated" />
            <asp:Parameter Name="DateApproved" />
            <asp:Parameter Name="DateHired" />
            <asp:Parameter Name="DateNeeded" />
            <asp:Parameter Name="CostOfRecruitment" />
            <asp:Parameter Name="JobDescriptionLink" />
            <asp:Parameter Name="LeadershipTeamReview" />
            <asp:Parameter Name="Visible" DefaultValue="true" />
            <asp:Parameter Name="AttachmentSheetLink" />
            <asp:Parameter Name="StatusReason" />
            <asp:Parameter Name="ID" Direction="Output" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="StatusID" />
            <asp:Parameter Name="EmployeeTypeID" />
            <asp:Parameter Name="EmploymentFormID" />
            <asp:Parameter Name="RecruitmentSourceID" />
            <asp:Parameter Name="RecruitmentSourceDetail" />
            <asp:Parameter Name="SchoolID" />
            <asp:Parameter Name="SchoolDetail" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Position" />
            <asp:Parameter Name="Budgeted" />
            <asp:Parameter Name="Billable" />
            <asp:Parameter Name="Replacement" />
            <asp:Parameter Name="ReplacementCheck" />
            <asp:Parameter Name="NewPosition" />
            <asp:Parameter Name="Return" />
            <asp:Parameter Name="DateCreated" />
            <asp:Parameter Name="DateApproved" />
            <asp:Parameter Name="DateHired" />
            <asp:Parameter Name="DateNeeded" />
            <asp:Parameter Name="CostOfRecruitment" />
            <asp:Parameter Name="JobDescriptionLink" />
            <asp:Parameter Name="LeadershipTeamReview" />
            <asp:Parameter Name="AttachmentSheetLink" />
            <asp:Parameter Name="StatusReason" />
            <asp:Parameter Name="InvestmentOwner" />
            <asp:Parameter Name="InvestmentStartDate" />
            <asp:Parameter Name="InvestmentDefinition" />
            <asp:Parameter Name="InvestmentLaurentideBenefit" />
            <asp:Parameter Name="ContingencyPlan" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsNewEmployeeRequests" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="SELECT *,left(position,150) as ShortPosition
                         FROM  tblNewEmployeeRequest 
                    LEFT JOIN  tblEmployeeTypes
                           ON  tblNewEmployeeRequest.EmployeeTypeID = tblEmployeeTypes.EmployeeTypeID
				    LEFT JOIN  tblEmploymentForms
                           ON  tblNewEmployeeRequest.EmploymentFormID = tblEmploymentForms.EmploymentFormID
                    LEFT JOIN  tblStatus
                           ON  tblNewEmployeeRequest.statusid = tblStatus.statusid
                    LEFT JOIN  tblManagers
                           ON  tblNewEmployeeRequest.ManagerID = tblManagers.ManagerID
                    LEFT JOIN  tblRecruitmentSource
                           ON  tblNewEmployeeRequest.RecruitmentSourceID = tblRecruitmentSource.RecruitmentSourceID
                       where visible = 1 and @ManagerDomainUser in (select teammemberusername from tblNERMembers)
        order by nerid desc"
        DeleteCommand="update tblNewEmployeeRequest set visible = 0 where NERID = @NERID">
        <SelectParameters>
            <asp:SessionParameter SessionField="Username" Name="ManagerDomainUser" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="select * from tblStatus order by Status"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsEmployeeTypes" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="select * from tblEmployeeTypes order by EmployeeType"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsEmploymentForms" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="select * from tblEmploymentForms order by EmploymentForm"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRecruitmentSource" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="select * from tblRecruitmentSource order by RecruitmentSource"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="select * from tblManagers where managerid <> 22 order by managername"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSchools" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="SELECT * FROM tblSchools"></asp:SqlDataSource>
<%--    <asp:SqlDataSource ID="sdsPROI" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="SELECT * FROM tblProjectedROI WHERE NERID = @NERID"></asp:SqlDataSource>--%>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
             ShowSummary="False" ValidationGroup="Update" />
</asp:Content>

