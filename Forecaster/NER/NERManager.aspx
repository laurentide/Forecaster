<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/FunnelSite.Master" CodeBehind="NERManager.aspx.vb" Inherits="Forecaster.NERManager" %>
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
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your manager" ControlToValidate="ManagerDropDown" />
                            </td>
                        </tr>



                        <tr>
                            <td>Employee Type:</td>
                            <td>
                                <%--<asp:TextBox ID="EmployeeTypeIDTextBox" runat="server" Text='<%# Bind("EmployeeTypeID") %>' />--%>
                                <asp:DropDownList ID="EmployeeTypeDropDown" runat="server" DataSourceID="sdsEmployeeTypes" AppendDataBoundItems="true" DataValueField="EmployeeTypeID" DataTextField="EmployeeType" SelectedValue='<%# Bind("EmployeeTypeID")%>'>
                                    <asp:ListItem Text="(Select the employee type)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your employee type" ControlToValidate="EmployeeTypeDropDown" />
                            </td>
                        </tr>

                        <tr>
                            <td>Employment Form:</td>
                            <td>
                                <%--<asp:TextBox ID="EmployeeTypeIDTextBox" runat="server" Text='<%# Bind("EmployeeTypeID") %>' />--%>
                                <asp:DropDownList ID="EmploymentFormDropDown" runat="server" DataSourceID="sdsEmploymentForms" AppendDataBoundItems="true" DataValueField="EmploymentFormID" DataTextField="EmploymentForm" SelectedValue='<%# Bind("EmploymentFormID")%>'>
                                    <asp:ListItem Text="(Select the employment form)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select your employment form" ControlToValidate="EmploymentFormDropDown" />
                            </td>
                        </tr>

             <tr>
                    <td>Source of Recruitment :</td>
                    <td>
                        <asp:DropDownList ID="RecruitmentDropDown" runat="server" DataSourceID="sdsRecruitmentSource" AppendDataBoundItems="True" DataValueField="RecruitmentSourceID" 
                            DataTextField="RecruitmentSource" SelectedValue='<%# Eval("RecruitmentSourceID")%>' OnSelectedIndexChanged="RecruitmentDropDown_SelectedIndexChanged" 
                            AutoPostBack="true">
                            <asp:ListItem Text="(Select the source)" Selected="True" Value="" />
                        </asp:DropDownList>
                    </td>       
            </tr><tr>        
                        <asp:Panel ID="SORDetailPanel" runat="server" Visible="false">                        
                        <td><asp:Label ID="SORDetailLabel" runat="server" /></td>
                            <td>
                                <asp:TextBox ID="SORDetailTextbox" runat="server" Text='<%# Bind("RecruitmentSourceDetail")%>' Width="500" />
                            </td>
                        </asp:Panel>
                  </tr> 
                        <tr>
                            <td>Job Name:</td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="500" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a job description" ControlToValidate="NameTextBox" />
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
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Enter a date needed for" ControlToValidate="DateNeededTextbox" />
                            </td>
                        </tr>

                        <%--                <tr>
                    <td>Cost Of Recruitment:</td>
                    <td>
                        <asp:TextBox ID="CostOfRecruitmentTextBox" runat="server" Text='<%# Bind("CostOfRecruitment") %>' /></td>
                    <asp:RangeValidator ID="RangeValidator3" runat="server" ForeColor="Red" ErrorMessage="Number between 0 and $2000000 without dollar signs" Type="double" MinimumValue="0" MaximumValue="2000000" ControlToValidate="CostOfRecruitmentTextBox" ValidationGroup="Update" />
                </tr>--%>

                        <tr>
                            <td>Job Description Link:</td>
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
                            <td>Investment sheet</td>
                            <td>
                                <a href="file://lcl-fil1/Directory_2000/Managers/Forms/Investment%20Decision%20Analysis.xlsx">Investment decision analysis form</a><br />
                                <asp:FileUpload ID="fuDialog" runat="server" />
                                <br />
                                Path:<asp:HyperLink ID="PathTextbox" runat="server" NavigateUrl='<%# Bind("AttachmentSheetLink")%>' Text='<%# Eval("AttachmentSheetLink")%>'></asp:HyperLink>
                            </td>

                        </tr>

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
                                <asp:DropDownList ID="StatusDropDown" runat="server" AutoPostBack="true" DataSourceID="sdsStatus" AppendDataBoundItems="true" DataValueField="StatusID" DataTextField="Status" 
                                    SelectedValue='<%# Bind("StatusID")%>' OnSelectedIndexChanged="StatusDropDown_SelectedIndexChanged">
                                    <asp:ListItem Text="(Select the status)" Value="" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Update" ForeColor="Red" ErrorMessage="Select the source" ControlToValidate="StatusDropDown" />
                                <asp:Label ID="StatusReasonLabel" runat="server" Visible="false" Text="" /><asp:TextBox ID="StatusReasonTextbox" Text='<%# Bind("StatusReason")%>' runat="server" Visible="False" Width="500" />
                            </td>
                            
                        </tr>
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
                    <asp:BoundField DataField="DateHired" HeaderText="Date Hired" SortExpression="DateHired" />
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
      ,[EmployeeTypeID] = @EmployeeTypeID
	  ,[EmploymentFormID] = @EmploymentFormID
      ,[RecruitmentSourceID] = @RecruitmentSourceID
      ,[RecruitmentSourceDetail] = @RecruitmentSourceDetail
      ,[Name] = @Name
      ,[Position] = @Position
      ,[Budgeted] = @Budgeted
      ,[Billable] = @Billable
      ,[Replacement] = @Replacement
      ,[ReplacementCheck] = @ReplacementCheck
      ,[Return] = @Return
      ,[DateCreated] = @DateCreated
      ,[DateApproved] = @DateApproved
      ,[DateHired] = @DateHired
      ,[DateNeeded] = @DateNeeded
      ,[CostOfRecruitment] = @CostOfRecruitment
      ,[JobDescriptionLink] = @JobDescriptionLink
      ,[LeadershipTeamReview] = @LeadershipTeamReview
      ,[AttachmentSheetLink] = @AttachmentSheetLink
      ,[StatusReason] = @StatusReason
 WHERE Nerid = @NERID">
        <SelectParameters>
            <asp:ControlParameter Name="ID" ControlID="gvNewEmployeeRequests" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="ManagerID" />
            <asp:Parameter Name="StatusID" DefaultValue="1" />
            <asp:Parameter Name="EmployeeTypeID" />
            <asp:Parameter Name="EmploymentFormID" />
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
            <asp:Parameter Name="AttachmentSheetLink" />
            <asp:Parameter Name="StatusReason" />
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
        SelectCommand="select * from tblRecruitmentSource order by RecruitmentSourceID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:NERConnectionString %>"
        SelectCommand="select * from tblManagers order by managername"></asp:SqlDataSource>
</asp:Content>

