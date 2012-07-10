<%@ Page Title="Funnel Management" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="FunnelManagement.aspx.vb" Inherits="Forecaster.FunnelManagement" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2>
        Manage your funnel here
    </h2>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="OpportunityID" DataSourceID="SqlDataSource1" 
            EmptyDataText="There are no data records to display." AllowPaging="True" 
            AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
            ShowSelectButton="True" />
        <asp:BoundField DataField="OpportunityID" HeaderText="OpportunityID" 
            ReadOnly="True" SortExpression="OpportunityID" InsertVisible="False" />
        <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" 
            SortExpression="CustomerID" />
        <asp:BoundField DataField="SalesmanID" HeaderText="SalesmanID" 
            SortExpression="SalesmanID" />
        <asp:BoundField DataField="CreateDate" HeaderText="CreateDate" 
            SortExpression="CreateDate" />
        <asp:BoundField DataField="Origin" HeaderText="Origin" 
            SortExpression="Origin" />
        <asp:BoundField DataField="FunnelPositionID" HeaderText="FunnelPositionID" 
            SortExpression="FunnelPositionID" />
        <asp:BoundField DataField="Percentage" HeaderText="Percentage" 
            SortExpression="Percentage" />
        <asp:BoundField DataField="ClosingDate" HeaderText="ClosingDate" 
            SortExpression="ClosingDate" />
        <asp:BoundField DataField="PATTID" HeaderText="PATTID" 
            SortExpression="PATTID" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>

</p>
<p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="OpportunityID" 
            DataSourceID="SqlDataSource1">
        <EditItemTemplate>
        <table style="width: 50%;">
            <tr>
                <td class="style1">OpportunityID: </td>
                <td><asp:Label ID="OpportunityIDLabel1" runat="server" 
                        Text='<%# Eval("OpportunityID") %>' /></td>
            </tr>
            <tr>
                <td class="style1">Customer:</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="CustomerName" 
                        DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>' />
                </td>
            </tr>
            <tr>
                <td class="style1">Salesman:</td>
                <td>
                    <asp:DropDownList ID="DropDownList2" runat="server" 
                        DataSourceID="SqlDataSource3" DataTextField="TeamName" DataValueField="TeamID" 
                        SelectedValue='<%# Bind("SalesmanID") %>' />
                </td>
            </tr>
            <tr>
                <td class="style1">CreateDate: </td>
                <td>
                    <asp:Calendar ID="Calendar1" runat="server" 
                        SelectedDate='<%# Bind("CreateDate") %>'></asp:Calendar>
                </td>
            </tr>
            <tr>
                <td class="style1">Origin:</td>
                <td>
                    <asp:DropDownList ID="DropDownList3" runat="server" 
                        selectedvalue='<%# Bind("Origin") %>'>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">FunnelPositionID:</td>
                <td><%--<asp:TextBox ID="FunnelPositionIDTextBox" runat="server" 
                        Text='<%# Eval("FunnelPositionID") %>' />--%>
                    <asp:DropDownList ID="ddlFunnelEdit" runat="server" 
                        DataSourceID="SqlDataSource4" DataTextField="FunnelPosition" 
                        DataValueField="FunnelPositionID" 
                        SelectedValue='<%# Eval("FunnelPositionID") %>' />
                </td>
            </tr>
            <tr>
                <td class="style1">Percentage:</td>
                <td><asp:TextBox ID="PercentageTextBox" runat="server" 
                        Text='<%# Eval("Percentage") %>' /></td>
            </tr>
            <tr>
                <td class="style1">ClosingDate:</td>
                <td>
                    <asp:Calendar ID="Calendar2" runat="server" 
                        SelectedDate='<%# Bind("CloseoutDate") %>'></asp:Calendar>
                </td>
            </tr>
            <tr>
                <td class="style1">PATTID: </td>
                <td><asp:TextBox ID="PATTIDTextBox" runat="server" Text='<%# Bind("PATTID") %>' />
                </td>
            </tr>
        </table>
        <table border="1" cellpadding="1" cellspacing="1" class="listviewtable" 
            style="width:100%;">
            <tr class="listviewHeader">
                <td>&nbsp;</td>
                <td>Evaluate Client&#39;s Business &amp; Develop Plan</td>
                <td>Establish Vision and Qualify (Sponsor)</td>
                <td>Establish Vision and Qualify (Power Sponsor)</td>
                <td>Develop Solution</td>
                <td>Close Sale</td>
                <td>Monitor Implementation</td>
            </tr>
            <tr>
                <td class="bold">Pain</td>
                <td>Potential Pain Identified:
                    <asp:CheckBox ID="PotentialPainCheckBox0" runat="server" 
                        Checked='<%# Bind("PotentialPain") %>' />
                </td>
                <td>Sponsor Admits Pain:
                    <asp:CheckBox ID="SponsorAdmitsPainCheckBox0" runat="server" 
                        Checked='<%# Bind("SponsorAdmitsPain") %>' />
                    <br />
                    Sponsor&#39;s Pain Documented &amp; Validated:
                    <asp:CheckBox ID="SponsorPainDocumentedCheckBox0" runat="server" 
                        Checked='<%# Bind("SponsorPainDocumented") %>' />
                </td>
                <td>Power Admits Pain:
                    <asp:CheckBox ID="PowerAdmitsPainCheckBox" runat="server" 
                        Checked='<%# Bind("PowerAdmitsPain") %>' />
                    <br />
                    Power&#39;s Pain Documented &amp; Validated:
                    <asp:CheckBox ID="PowerPainDocumentedCheckBox" runat="server" 
                        Checked='<%# Bind("PowerPainDocumented") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Power</td>
                <td>Potential Sponsor Identified:
                    <asp:CheckBox ID="PotentialSponsorCheckBox0" runat="server" 
                        Checked='<%# Bind("PotentialSponsor") %>' />
                </td>
                <td>Sponsor Agrees to Explore:
                    <asp:CheckBox ID="SponsorExploreCheckBox0" runat="server" 
                        Checked='<%# Bind("SponsorExplore") %>' />
                    <br />
                    Access to Power Negotiated:
                    <asp:CheckBox ID="AccessPowerNegotiatedCheckBox" runat="server" 
                        Checked='<%# Bind("AccessPowerNegotiated") %>' />
                    <br />
                </td>
                <td>Access to Power Achieved:
                    <asp:CheckBox ID="AccessPowerAchievedCheckBox" runat="server" 
                        Checked='<%# Bind("AccessPowerAchieved") %>' />
                    <br />
                    Power Agrees to Explore:
                    <asp:CheckBox ID="PowerExploreCheckBox" runat="server" 
                        Checked='<%# Bind("PowerExplore") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Vision</td>
                <td>&nbsp;</td>
                <td>Sponsor Articulates Differentiated Buying Vision:
                    <asp:CheckBox ID="SponsorBuyingVisionCheckBox" runat="server" 
                        Checked='<%# Bind("SponsorBuyingVision") %>' />
                </td>
                <td>Power Articulates Differentiated Buying Vision:
                    <asp:CheckBox ID="PowerBuyingVisionCheckBox" runat="server" 
                        Checked='<%# Bind("PowerBuyingVision") %>' />
                </td>
                <td>Power Articulates preference for an EMR Solution:
                    <asp:CheckBox ID="PowerEMRSolutionCheckBox" runat="server" 
                        Checked='<%# Bind("PowerEMRSolution") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Value</td>
                <td>&nbsp;</td>
                <td>Sponsor Articulates Required Value:
                    <asp:CheckBox ID="SponsorRequiredValueCheckBox" runat="server" 
                        Checked='<%# Bind("SponsorRequiredValue") %>' />
                </td>
                <td>Power Articulates Required Value:
                    <asp:CheckBox ID="PowerRequiredValueCheckBox" runat="server" 
                        Checked='<%# Bind("PowerRequiredValue") %>' />
                </td>
                <td>Value Proposition Developed and Proved:
                    <asp:CheckBox ID="ValuePropositionCheckBox" runat="server" 
                        Checked='<%# Bind("ValueProposition") %>' />
                </td>
                <td>&nbsp;</td>
                <td>Success Criteria Reviewed and Achieved:
                    <asp:CheckBox ID="SuccessCriteriaReviewCheckBox" runat="server" 
                        Checked='<%# Bind("SuccessCriteriaReview") %>' />
                </td>
            </tr>
            <tr>
                <td class="bold">Control</td>
                <td>Territory Plan:
                    <asp:CheckBox ID="TerritoryPlanCheckBox0" runat="server" 
                        Checked='<%# Bind("TerritoryPlan") %>' />
                    <br />
                    Appointment Calendared with Potential Sponsor:
                    <asp:CheckBox ID="AppointmentCalendaredCheckBox0" runat="server" 
                        Checked='<%# Bind("AppointmentCalendared") %>' />
                </td>
                <td>Sponsor Confirms Specifics of discussion:
                    <asp:CheckBox ID="SponsorConfirmsSpecificsCheckBox" runat="server" 
                        Checked='<%# Bind("SponsorConfirmsSpecifics") %>' />
                </td>
                <td>Evaluation Plan Agreed Upon:
                    <asp:CheckBox ID="EvaluationPlanCheckBox" runat="server" 
                        Checked='<%# Bind("EvaluationPlan") %>' />
                </td>
                <td>Preliminary Solution Agreed Upon &amp; Verbal Approval Reception:
                    <asp:CheckBox ID="PreliminarySolutionCheckBox" runat="server" 
                        Checked='<%# Bind("PreliminarySolution") %>' />
                </td>
                <td>Signed Documents:
                    <asp:CheckBox ID="SignedDocumentsCheckBox" runat="server" 
                        Checked='<%# Bind("SignedDocuments") %>' />
                </td>
                <td>Power Agrees to Reference Story:
                    <asp:CheckBox ID="PowerReferenceStoryCheckBox" runat="server" 
                        Checked='<%# Bind("PowerReferenceStory") %>' />
                    <br />
                </td>
            </tr>
            <tr class="opportunityfooter">
                <td class="bold">Probability (When all boxes are checked off)</td>
                <td>Universe / 10%</td>
                <td>Above / 25%</td>
                <td>In the Funnel / 50%</td>
                <td>Best Few / 75%</td>
                <td>Won / 90%</td>
                <td>QBR / 100%</td>
            </tr>
        </table>
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
            CommandName="Update" Text="Update" />
        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
            CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
        <%--CustomerID: <asp:TextBox ID="CustomerIDTextBox" runat="server" 
            Text='<%# Bind("CustomerID") %>' /><br />--%>
        <table style="width: 50%;">
            <tr>
                <td class="style1">Customer:</td>
                <td>
                    <asp:DropDownList ID="DropDownList4" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="CustomerName" 
                        DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>' />
                </td>
            </tr>
            <tr>
                <td class="style1">Salesman:</td>
                <td>
                    <asp:DropDownList ID="DropDownList5" runat="server" 
                        DataSourceID="SqlDataSource3" DataTextField="TeamName" DataValueField="TeamID" 
                        SelectedValue='<%# Bind("SalesmanID") %>' />
                </td>
            </tr>
            <tr>
                <td class="style1">CreateDate: </td>
                <td>
                    <asp:Calendar ID="Calendar3" runat="server" 
                        SelectedDate='<%# Bind("CreateDate") %>'></asp:Calendar>
                </td>
            </tr>
            <tr>
                <td class="style1">Origin:</td>
                <td>
                    <asp:DropDownList ID="DropDownList6" runat="server" 
                        selectedvalue='<%# Bind("Origin") %>'>
                    <asp:ListItem Value="L">Latent</asp:ListItem>
                    <asp:ListItem Value="A">Active Pain</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">FunnelPositionID:</td>
                <td><%--<asp:TextBox ID="FunnelPositionIDTextBox" runat="server" 
                        Text='<%# Eval("FunnelPositionID") %>' />--%>
                    <asp:DropDownList ID="ddlFunnelInsert" runat="server" 
                        DataSourceID="SqlDataSource4" DataTextField="FunnelPosition" 
                        DataValueField="FunnelPositionID" 
                        SelectedValue='<%# Bind("FunnelPositionID") %>' />
                </td>
            </tr>
            <tr>
                <td class="style1">Percentage:</td>
                <td><asp:TextBox ID="PercentageTextBox0" runat="server" 
                        Text='<%# Bind("Percentage") %>' /></td>
            </tr>
            <tr>
                <td class="style1">ClosingDate:</td>
                <td>
                    <asp:Calendar ID="Calendar4" runat="server" 
                        SelectedDate='<%# Bind("CloseoutDate") %>'></asp:Calendar>
                </td>
            </tr>
            <tr>
                <td class="style1">PATTID: </td>
                <td><asp:TextBox ID="PATTIDTextBox0" runat="server" Text='<%# Bind("PATTID") %>' />
                </td>
            </tr>
        </table>
        <br />
        <table border="1" cellpadding="1" cellspacing="1" class="listviewtable" 
            style="width:100%;">
            <tr class="listviewHeader">
                <td>&nbsp;</td>
                <td>Evaluate Client&#39;s Business &amp; Develop Plan</td>
                <td>Establish Vision and Qualify (Sponsor)</td>
                <td>Establish Vision and Qualify (Power Sponsor)</td>
                <td>Develop Solution</td>
                <td>Close Sale</td>
                <td>Monitor Implementation</td>
            </tr>
            <tr>
                <td class="bold">Pain</td>
                <td>Potential Pain Identified:
                    <asp:CheckBox ID="PotentialPainCheckBox1" runat="server" 
                        Checked='<%# Bind("PotentialPain") %>' />
                </td>
                <td>Sponsor Admits Pain:
                    <asp:CheckBox ID="SponsorAdmitsPainCheckBox1" runat="server" 
                        Checked='<%# Bind("SponsorAdmitsPain") %>' />
                    <br />
                    Sponsor&#39;s Pain Documented &amp; Validated:
                    <asp:CheckBox ID="SponsorPainDocumentedCheckBox1" runat="server" 
                        Checked='<%# Bind("SponsorPainDocumented") %>' />
                </td>
                <td>Power Admits Pain:
                    <asp:CheckBox ID="PowerAdmitsPainCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerAdmitsPain") %>' />
                    <br />
                    Power&#39;s Pain Documented &amp; Validated:
                    <asp:CheckBox ID="PowerPainDocumentedCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerPainDocumented") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Power</td>
                <td>Potential Sponsor Identified:
                    <asp:CheckBox ID="PotentialSponsorCheckBox1" runat="server" 
                        Checked='<%# Bind("PotentialSponsor") %>' />
                </td>
                <td>Sponsor Agrees to Explore:
                    <asp:CheckBox ID="SponsorExploreCheckBox1" runat="server" 
                        Checked='<%# Bind("SponsorExplore") %>' />
                    <br />
                    Access to Power Negotiated:
                    <asp:CheckBox ID="AccessPowerNegotiatedCheckBox0" runat="server" 
                        Checked='<%# Bind("AccessPowerNegotiated") %>' />
                    <br />
                </td>
                <td>Access to Power Achieved:
                    <asp:CheckBox ID="AccessPowerAchievedCheckBox0" runat="server" 
                        Checked='<%# Bind("AccessPowerAchieved") %>' />
                    <br />
                    Power Agrees to Explore:
                    <asp:CheckBox ID="PowerExploreCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerExplore") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Vision</td>
                <td>&nbsp;</td>
                <td>Sponsor Articulates Differentiated Buying Vision:
                    <asp:CheckBox ID="SponsorBuyingVisionCheckBox0" runat="server" 
                        Checked='<%# Bind("SponsorBuyingVision") %>' />
                </td>
                <td>Power Articulates Differentiated Buying Vision:
                    <asp:CheckBox ID="PowerBuyingVisionCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerBuyingVision") %>' />
                </td>
                <td>Power Articulates preference for an EMR Solution:
                    <asp:CheckBox ID="PowerEMRSolutionCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerEMRSolution") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Value</td>
                <td>&nbsp;</td>
                <td>Sponsor Articulates Required Value:
                    <asp:CheckBox ID="SponsorRequiredValueCheckBox0" runat="server" 
                        Checked='<%# Bind("SponsorRequiredValue") %>' />
                </td>
                <td>Power Articulates Required Value:
                    <asp:CheckBox ID="PowerRequiredValueCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerRequiredValue") %>' />
                </td>
                <td>Value Proposition Developed and Proved:
                    <asp:CheckBox ID="ValuePropositionCheckBox0" runat="server" 
                        Checked='<%# Bind("ValueProposition") %>' />
                </td>
                <td>&nbsp;</td>
                <td>Success Criteria Reviewed and Achieved:
                    <asp:CheckBox ID="SuccessCriteriaReviewCheckBox0" runat="server" 
                        Checked='<%# Bind("SuccessCriteriaReview") %>' />
                </td>
            </tr>
            <tr>
                <td class="bold">Control</td>
                <td>Territory Plan:
                    <asp:CheckBox ID="TerritoryPlanCheckBox1" runat="server" 
                        Checked='<%# Bind("TerritoryPlan") %>' />
                    <br />
                    Appointment Calendared with Potential Sponsor:
                    <asp:CheckBox ID="AppointmentCalendaredCheckBox1" runat="server" 
                        Checked='<%# Bind("AppointmentCalendared") %>' />
                </td>
                <td>Sponsor Confirms Specifics of discussion:
                    <asp:CheckBox ID="SponsorConfirmsSpecificsCheckBox0" runat="server" 
                        Checked='<%# Bind("SponsorConfirmsSpecifics") %>' />
                </td>
                <td>Evaluation Plan Agreed Upon:
                    <asp:CheckBox ID="EvaluationPlanCheckBox0" runat="server" 
                        Checked='<%# Bind("EvaluationPlan") %>' />
                </td>
                <td>Preliminary Solution Agreed Upon &amp; Verbal Approval Reception:
                    <asp:CheckBox ID="PreliminarySolutionCheckBox0" runat="server" 
                        Checked='<%# Bind("PreliminarySolution") %>' />
                </td>
                <td>Signed Documents:
                    <asp:CheckBox ID="SignedDocumentsCheckBox0" runat="server" 
                        Checked='<%# Bind("SignedDocuments") %>' />
                </td>
                <td>Power Agrees to Reference Story:
                    <asp:CheckBox ID="PowerReferenceStoryCheckBox0" runat="server" 
                        Checked='<%# Bind("PowerReferenceStory") %>' />
                    <br />
                </td>
            </tr>
            <tr class="opportunityfooter">
                <td class="bold">Probability (When all boxes are checked off)</td>
                <td>Universe / 10%</td>
                <td>Above / 25%</td>
                <td>In the Funnel / 50%</td>
                <td>Best Few / 75%</td>
                <td>Won / 90%</td>
                <td>QBR / 100%</td>
            </tr>
        </table>
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
            CommandName="Insert" Text="Create Opportunity" />
        &nbsp;
        <%--<asp:LinkButton ID="InsertCancelButton" runat="server" 
            CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
        </InsertItemTemplate>
        <ItemTemplate>
        OpportunityID: <asp:Label ID="OpportunityIDLabel" runat="server" 
            Text='<%# Eval("OpportunityID") %>' /><br />
        CustomerID: <asp:Label ID="CustomerIDLabel" runat="server" 
            Text='<%# Bind("CustomerID") %>' /><br />
        SalesmanID: <asp:Label ID="SalesmanIDLabel" runat="server" 
            Text='<%# Bind("SalesmanID") %>' /><br />
        CreateDate: <asp:Label ID="CreateDateLabel" runat="server" 
            Text='<%# Bind("CreateDate") %>' /><br />
        Origin: <asp:Label ID="OriginLabel" runat="server" 
            Text='<%# Bind("Origin") %>' /><br />
        FunnelPositionID: <asp:Label ID="FunnelPositionIDLabel" runat="server" 
            Text='<%# Bind("FunnelPositionID") %>' /><br />
        Percentage: <asp:Label ID="PercentageLabel" runat="server" 
            Text='<%# Bind("Percentage") %>' /><br />
        ClosingDate: <asp:Label ID="ClosingDateLabel" runat="server" 
            Text='<%# Bind("ClosingDate") %>' /><br />
        PATTID: <asp:Label ID="PATTIDLabel" runat="server" 
            Text='<%# Bind("PATTID") %>' />
        <table border="1" cellpadding="1" cellspacing="1" class="listviewtable" 
            style="width:100%;">
            <tr class="listviewHeader">
                <td>&nbsp;</td>
                <td>Evaluate Client&#39;s Business &amp; Develop Plan</td>
                <td>Establish Vision and Qualify (Sponsor)</td>
                <td>Establish Vision and Qualify (Power Sponsor)</td>
                <td>Develop Solution</td>
                <td>Close Sale</td>
                <td>Monitor Implementation</td>
            </tr>
            <tr>
                <td class="bold">Pain</td>
                <td>Potential Pain Identified:
                    <asp:CheckBox ID="PotentialPainCheckBox2" runat="server" 
                        Checked='<%# Bind("PotentialPain") %>' />
                </td>
                <td>Sponsor Admits Pain:
                    <asp:CheckBox ID="SponsorAdmitsPainCheckBox2" runat="server" 
                        Checked='<%# Bind("SponsorAdmitsPain") %>' />
                    <br />
                    Sponsor&#39;s Pain Documented &amp; Validated:
                    <asp:CheckBox ID="SponsorPainDocumentedCheckBox2" runat="server" 
                        Checked='<%# Bind("SponsorPainDocumented") %>' />
                </td>
                <td>Power Admits Pain:
                    <asp:CheckBox ID="PowerAdmitsPainCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerAdmitsPain") %>' />
                    <br />
                    Power&#39;s Pain Documented &amp; Validated:
                    <asp:CheckBox ID="PowerPainDocumentedCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerPainDocumented") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Power</td>
                <td>Potential Sponsor Identified:
                    <asp:CheckBox ID="PotentialSponsorCheckBox2" runat="server" 
                        Checked='<%# Bind("PotentialSponsor") %>' />
                </td>
                <td>Sponsor Agrees to Explore:
                    <asp:CheckBox ID="SponsorExploreCheckBox2" runat="server" 
                        Checked='<%# Bind("SponsorExplore") %>' />
                    <br />
                    Access to Power Negotiated:
                    <asp:CheckBox ID="AccessPowerNegotiatedCheckBox1" runat="server" 
                        Checked='<%# Bind("AccessPowerNegotiated") %>' />
                    <br />
                </td>
                <td>Access to Power Achieved:
                    <asp:CheckBox ID="AccessPowerAchievedCheckBox1" runat="server" 
                        Checked='<%# Bind("AccessPowerAchieved") %>' />
                    <br />
                    Power Agrees to Explore:
                    <asp:CheckBox ID="PowerExploreCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerExplore") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Vision</td>
                <td>&nbsp;</td>
                <td>Sponsor Articulates Differentiated Buying Vision:
                    <asp:CheckBox ID="SponsorBuyingVisionCheckBox1" runat="server" 
                        Checked='<%# Bind("SponsorBuyingVision") %>' />
                </td>
                <td>Power Articulates Differentiated Buying Vision:
                    <asp:CheckBox ID="PowerBuyingVisionCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerBuyingVision") %>' />
                </td>
                <td>Power Articulates preference for an EMR Solution:
                    <asp:CheckBox ID="PowerEMRSolutionCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerEMRSolution") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Value</td>
                <td>&nbsp;</td>
                <td>Sponsor Articulates Required Value:
                    <asp:CheckBox ID="SponsorRequiredValueCheckBox1" runat="server" 
                        Checked='<%# Bind("SponsorRequiredValue") %>' />
                </td>
                <td>Power Articulates Required Value:
                    <asp:CheckBox ID="PowerRequiredValueCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerRequiredValue") %>' />
                </td>
                <td>Value Proposition Developed and Proved:
                    <asp:CheckBox ID="ValuePropositionCheckBox1" runat="server" 
                        Checked='<%# Bind("ValueProposition") %>' />
                </td>
                <td>&nbsp;</td>
                <td>Success Criteria Reviewed and Achieved:
                    <asp:CheckBox ID="SuccessCriteriaReviewCheckBox1" runat="server" 
                        Checked='<%# Bind("SuccessCriteriaReview") %>' />
                </td>
            </tr>
            <tr>
                <td class="bold">Control</td>
                <td>Territory Plan:
                    <asp:CheckBox ID="TerritoryPlanCheckBox2" runat="server" 
                        Checked='<%# Bind("TerritoryPlan") %>' />
                    <br />
                    Appointment Calendared with Potential Sponsor:
                    <asp:CheckBox ID="AppointmentCalendaredCheckBox2" runat="server" 
                        Checked='<%# Bind("AppointmentCalendared") %>' />
                </td>
                <td>Sponsor Confirms Specifics of discussion:
                    <asp:CheckBox ID="SponsorConfirmsSpecificsCheckBox1" runat="server" 
                        Checked='<%# Bind("SponsorConfirmsSpecifics") %>' />
                </td>
                <td>Evaluation Plan Agreed Upon:
                    <asp:CheckBox ID="EvaluationPlanCheckBox1" runat="server" 
                        Checked='<%# Bind("EvaluationPlan") %>' />
                </td>
                <td>Preliminary Solution Agreed Upon &amp; Verbal Approval Reception:
                    <asp:CheckBox ID="PreliminarySolutionCheckBox1" runat="server" 
                        Checked='<%# Bind("PreliminarySolution") %>' />
                </td>
                <td>Signed Documents:
                    <asp:CheckBox ID="SignedDocumentsCheckBox1" runat="server" 
                        Checked='<%# Bind("SignedDocuments") %>' />
                </td>
                <td>Power Agrees to Reference Story:
                    <asp:CheckBox ID="PowerReferenceStoryCheckBox1" runat="server" 
                        Checked='<%# Bind("PowerReferenceStory") %>' />
                    <br />
                </td>
            </tr>
            <tr class="opportunityfooter">
                <td class="bold">Probability (When all boxes are checked off)</td>
                <td>Universe / 10%</td>
                <td>Above / 25%</td>
                <td>In the Funnel / 50%</td>
                <td>Best Few / 75%</td>
                <td>Won / 90%</td>
                <td>QBR / 100%</td>
            </tr>
        </table>
        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
            CommandName="Edit" Text="Edit" />
&nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
            CommandName="Delete" Text="Delete" />
&nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
            CommandName="New" Text="New" />
        </ItemTemplate>
        </asp:FormView>

</p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
            DeleteCommand="DELETE FROM [tblOpportunities] WHERE [OpportunityID] = @OpportunityID" 
            InsertCommand="INSERT INTO [tblOpportunities] ([CustomerID], [SalesmanID], [CreateDate], [Origin], [FunnelPositionID], [Percentage], [ClosingDate], [PATTID], [PotentialPain], [PotentialSponsor], [TerritoryPlan], [AppointmentCalendared], [SponsorAdmitsPain], [SponsorPainDocumented], [SponsorExplore], [AccessPowerNegotiated], [SponsorBuyingVision], [SponsorRequiredValue], [SponsorConfirmsSpecifics], [PowerAdmitsPain], [PowerPainDocumented], [AccessPowerAchieved], [PowerExplore], [PowerBuyingVision], [PowerRequiredValue], [EvaluationPlan], [PowerEMRSolution], [ValueProposition], [PreliminarySolution], [SignedDocuments], [SuccessCriteriaReview], [PowerReferenceStory]) VALUES (@CustomerID, @SalesmanID, @CreateDate, @Origin, @FunnelPositionID, @Percentage, @ClosingDate, @PATTID, @PotentialPain, @PotentialSponsor, @TerritoryPlan, @AppointmentCalendared, @SponsorAdmitsPain, @SponsorPainDocumented, @SponsorExplore, @AccessPowerNegotiated, @SponsorBuyingVision, @SponsorRequiredValue, @SponsorConfirmsSpecifics, @PowerAdmitsPain, @PowerPainDocumented, @AccessPowerAchieved, @PowerExplore, @PowerBuyingVision, @PowerRequiredValue, @EvaluationPlan, @PowerEMRSolution, @ValueProposition, @PreliminarySolution, @SignedDocuments, @SuccessCriteriaReview, @PowerReferenceStory)" 
            ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
            SelectCommand="SELECT [OpportunityID], [CustomerID], [SalesmanID], [CreateDate], [Origin], [FunnelPositionID], [Percentage], [ClosingDate], [PATTID], [PotentialPain], [PotentialSponsor], [TerritoryPlan], [AppointmentCalendared], [SponsorAdmitsPain], [SponsorPainDocumented], [SponsorExplore], [AccessPowerNegotiated], [SponsorBuyingVision], [SponsorRequiredValue], [SponsorConfirmsSpecifics], [PowerAdmitsPain], [PowerPainDocumented], [AccessPowerAchieved], [PowerExplore], [PowerBuyingVision], [PowerRequiredValue], [EvaluationPlan], [PowerEMRSolution], [ValueProposition], [PreliminarySolution], [SignedDocuments], [SuccessCriteriaReview], [PowerReferenceStory] FROM [tblOpportunities]" 
            UpdateCommand="UPDATE [tblOpportunities] SET [CustomerID] = @CustomerID, [SalesmanID] = @SalesmanID, [CreateDate] = @CreateDate, [Origin] = @Origin, [FunnelPositionID] = @FunnelPositionID, [Percentage] = @Percentage, [ClosingDate] = @ClosingDate, [PATTID] = @PATTID, [PotentialPain] = @PotentialPain, [PotentialSponsor] = @PotentialSponsor, [TerritoryPlan] = @TerritoryPlan, [AppointmentCalendared] = @AppointmentCalendared, [SponsorAdmitsPain] = @SponsorAdmitsPain, [SponsorPainDocumented] = @SponsorPainDocumented, [SponsorExplore] = @SponsorExplore, [AccessPowerNegotiated] = @AccessPowerNegotiated, [SponsorBuyingVision] = @SponsorBuyingVision, [SponsorRequiredValue] = @SponsorRequiredValue, [SponsorConfirmsSpecifics] = @SponsorConfirmsSpecifics, [PowerAdmitsPain] = @PowerAdmitsPain, [PowerPainDocumented] = @PowerPainDocumented, [AccessPowerAchieved] = @AccessPowerAchieved, [PowerExplore] = @PowerExplore, [PowerBuyingVision] = @PowerBuyingVision, [PowerRequiredValue] = @PowerRequiredValue, [EvaluationPlan] = @EvaluationPlan, [PowerEMRSolution] = @PowerEMRSolution, [ValueProposition] = @ValueProposition, [PreliminarySolution] = @PreliminarySolution, [SignedDocuments] = @SignedDocuments, [SuccessCriteriaReview] = @SuccessCriteriaReview, [PowerReferenceStory] = @PowerReferenceStory WHERE [OpportunityID] = @OpportunityID">
            <DeleteParameters>
            <asp:Parameter Name="OpportunityID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
            <asp:Parameter Name="SalesmanID" Type="Int32" />
            <asp:Parameter Name="CreateDate" Type="DateTime" />
            <asp:Parameter Name="Origin" Type="String" />
            <asp:Parameter Name="FunnelPositionID" Type="Int32" />
            <asp:Parameter Name="Percentage" Type="Decimal" />
            <asp:Parameter Name="ClosingDate" Type="DateTime" />
            <asp:Parameter Name="PATTID" Type="Int32" />
            <asp:Parameter Name="PotentialPain" Type="Boolean" />
            <asp:Parameter Name="PotentialSponsor" Type="Boolean" />
            <asp:Parameter Name="TerritoryPlan" Type="Boolean" />
            <asp:Parameter Name="AppointmentCalendared" Type="Boolean" />
            <asp:Parameter Name="SponsorAdmitsPain" Type="Boolean" />
            <asp:Parameter Name="SponsorPainDocumented" Type="Boolean" />
            <asp:Parameter Name="SponsorExplore" Type="Boolean" />
            <asp:Parameter Name="AccessPowerNegotiated" Type="Boolean" />
            <asp:Parameter Name="SponsorBuyingVision" Type="Boolean" />
            <asp:Parameter Name="SponsorRequiredValue" Type="Boolean" />
            <asp:Parameter Name="SponsorConfirmsSpecifics" Type="Boolean" />
            <asp:Parameter Name="PowerAdmitsPain" Type="Boolean" />
            <asp:Parameter Name="PowerPainDocumented" Type="Boolean" />
            <asp:Parameter Name="AccessPowerAchieved" Type="Boolean" />
            <asp:Parameter Name="PowerExplore" Type="Boolean" />
            <asp:Parameter Name="PowerBuyingVision" Type="Boolean" />
            <asp:Parameter Name="PowerRequiredValue" Type="Boolean" />
            <asp:Parameter Name="EvaluationPlan" Type="Boolean" />
            <asp:Parameter Name="PowerEMRSolution" Type="Boolean" />
            <asp:Parameter Name="ValueProposition" Type="Boolean" />
            <asp:Parameter Name="PreliminarySolution" Type="Boolean" />
            <asp:Parameter Name="SignedDocuments" Type="Boolean" />
            <asp:Parameter Name="SuccessCriteriaReview" Type="Boolean" />
            <asp:Parameter Name="PowerReferenceStory" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
            <asp:Parameter Name="SalesmanID" Type="Int32" />
            <asp:Parameter Name="CreateDate" Type="DateTime" />
            <asp:Parameter Name="Origin" Type="String" />
            <asp:Parameter Name="FunnelPositionID" Type="Int32" />
            <asp:Parameter Name="Percentage" Type="Decimal" />
            <asp:Parameter Name="ClosingDate" Type="DateTime" />
            <asp:Parameter Name="PATTID" Type="Int32" />
            <asp:Parameter Name="PotentialPain" Type="Boolean" />
            <asp:Parameter Name="PotentialSponsor" Type="Boolean" />
            <asp:Parameter Name="TerritoryPlan" Type="Boolean" />
            <asp:Parameter Name="AppointmentCalendared" Type="Boolean" />
            <asp:Parameter Name="SponsorAdmitsPain" Type="Boolean" />
            <asp:Parameter Name="SponsorPainDocumented" Type="Boolean" />
            <asp:Parameter Name="SponsorExplore" Type="Boolean" />
            <asp:Parameter Name="AccessPowerNegotiated" Type="Boolean" />
            <asp:Parameter Name="SponsorBuyingVision" Type="Boolean" />
            <asp:Parameter Name="SponsorRequiredValue" Type="Boolean" />
            <asp:Parameter Name="SponsorConfirmsSpecifics" Type="Boolean" />
            <asp:Parameter Name="PowerAdmitsPain" Type="Boolean" />
            <asp:Parameter Name="PowerPainDocumented" Type="Boolean" />
            <asp:Parameter Name="AccessPowerAchieved" Type="Boolean" />
            <asp:Parameter Name="PowerExplore" Type="Boolean" />
            <asp:Parameter Name="PowerBuyingVision" Type="Boolean" />
            <asp:Parameter Name="PowerRequiredValue" Type="Boolean" />
            <asp:Parameter Name="EvaluationPlan" Type="Boolean" />
            <asp:Parameter Name="PowerEMRSolution" Type="Boolean" />
            <asp:Parameter Name="ValueProposition" Type="Boolean" />
            <asp:Parameter Name="PreliminarySolution" Type="Boolean" />
            <asp:Parameter Name="SignedDocuments" Type="Boolean" />
            <asp:Parameter Name="SuccessCriteriaReview" Type="Boolean" />
            <asp:Parameter Name="PowerReferenceStory" Type="Boolean" />
            <asp:Parameter Name="OpportunityID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
            DeleteCommand="DELETE FROM [tblCustomers] WHERE [CustomerID] = @CustomerID" 
            InsertCommand="INSERT INTO [tblCustomers] ([EnterpriseID], [NomisCustomerNum], [CustomerName], [TeamID]) VALUES (@EnterpriseID, @NomisCustomerNum, @CustomerName, @TeamID)" 
            ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
            SelectCommand="SELECT [CustomerID], [EnterpriseID], [NomisCustomerNum], [CustomerName], [TeamID] FROM [tblCustomers]" 
            UpdateCommand="UPDATE [tblCustomers] SET [EnterpriseID] = @EnterpriseID, [NomisCustomerNum] = @NomisCustomerNum, [CustomerName] = @CustomerName, [TeamID] = @TeamID WHERE [CustomerID] = @CustomerID">
            <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
            <asp:Parameter Name="EnterpriseID" Type="Int32" />
            <asp:Parameter Name="NomisCustomerNum" Type="Int32" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="TeamID" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
            <asp:Parameter Name="EnterpriseID" Type="Int32" />
            <asp:Parameter Name="NomisCustomerNum" Type="Int32" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="TeamID" Type="Int32" />
            <asp:Parameter Name="CustomerID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
            DeleteCommand="DELETE FROM [tblTeams] WHERE [TeamID] = @TeamID" 
            InsertCommand="INSERT INTO [tblTeams] ([TeamName], [SLS]) VALUES (@TeamName, @SLS)" 
            ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
            SelectCommand="SELECT [TeamID], [TeamName], [SLS] FROM [tblTeams]" 
            UpdateCommand="UPDATE [tblTeams] SET [TeamName] = @TeamName, [SLS] = @SLS WHERE [TeamID] = @TeamID">
            <DeleteParameters>
            <asp:Parameter Name="TeamID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
            <asp:Parameter Name="TeamName" Type="String" />
            <asp:Parameter Name="SLS" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            <asp:Parameter Name="TeamName" Type="String" />
            <asp:Parameter Name="SLS" Type="String" />
            <asp:Parameter Name="TeamID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ForecasterConnectionString %>" 
            DeleteCommand="DELETE FROM [tblFunnelPositions] WHERE [FunnelPositionID] = @FunnelPositionID" 
            InsertCommand="INSERT INTO [tblFunnelPositions] ([FunnelPosition]) VALUES (@FunnelPosition)" 
            ProviderName="<%$ ConnectionStrings:ForecasterConnectionString.ProviderName %>" 
            SelectCommand="SELECT [FunnelPositionID], [FunnelPosition] FROM [tblFunnelPositions]" 
            UpdateCommand="UPDATE [tblFunnelPositions] SET [FunnelPosition] = @FunnelPosition WHERE [FunnelPositionID] = @FunnelPositionID">
            <DeleteParameters>
            <asp:Parameter Name="FunnelPositionID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
            <asp:Parameter Name="FunnelPosition" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            <asp:Parameter Name="FunnelPosition" Type="String" />
            <asp:Parameter Name="FunnelPositionID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>


</asp:Content>
