<asp:UpdatePanel ID="updPathogen" runat="server" UpdateMode="Always">  
           <ContentTemplate>  
               <asp:GridView ID="gvPathogenMain" CssClass="grid" runat="server" AutoGenerateColumns="false"  
                   DataKeyNames="CodingSubCategoryID,CodingTypeID" ShowHeader="true"   
                   ShowFooter="true"   OnRowDataBound="gvPathogenMain_RowDataBound"   
                   Width="650px">  
                   <Columns>  
                        
                       <asp:TemplateField HeaderText="Pathogens">  
                           <HeaderTemplate>  
                               <div class="grid">  
                                   <h2>  
                                       Pathogens-<%=ViewState["SelectedMission"].ToString() %>  
                                       <asp:ImageButton ID="btnSort1" runat="server" ImageUrl="Images/sort_asc.gif" ImageAlign="AbsMiddle" /></h2>  
                                   <table cellpadding="0" cellspacing="0" id="tblProducts">  
                                       <tr class="head">  
                                           <th class="first">  
                                               Pathogens  
                                           </th>  
                                           <%-- <th class="first">  
                                               Percentage  
                                           </th>--%>  
                                       </tr>  
                                       <tr runat="server" id="itemPlaceholder" />  
                                   </table>  
                               </div>  
                           </HeaderTemplate>  
                           <ItemTemplate>  
                               
                               <!-- this row has the child grid-->  
                               <asp:Panel CssClass="group" ID="pnlCustomer" Width="820px" runat="server">  
                                   <asp:Image ID="imgCollapsible" CssClass="first" ImageUrl="Images/plus.png" Style="margin-right: 5px;"  
                                       runat="server" /><span class="header">  
                                           <%#DataBinder.Eval(Container.DataItem ,"CodingTypeName")%>  
                                       </span>  
                               </asp:Panel>  
                                 
                               <asp:Panel Style="margin-left: 20px; margin-right: 20px" ID="pnlOrders" runat="server"  
                                   Width="840px">  
                                   <asp:GridView ID="gvPathogen" CssClass="grid" runat="server" AutoGenerateColumns="false"  
                                       ShowHeader="true"  ShowFooter="false"   DataKeyNames="CodingDetailID"  >  
                                       <Columns>  
                                           <asp:TemplateField HeaderText="Pathogens">  
                                               <HeaderTemplate>  
                                                   <div class="grid">  
                                                       <%--  <h2>  
                                                                               Pathogens  
                                                                               <asp:ImageButton ID="btnSort1" runat="server" ImageUrl="Images/sort_asc.gif" ImageAlign="AbsMiddle" /></h2>--%>  
                                                       <table cellpadding="0" cellspacing="0" id="tblProducts">  
                                                           <tr class="head">  
                                                               <th class="first">  
                                                                   Pathogens  
                                                               </th>  
                                                               <th class="first">  
                                                                   Percentage  
                                                               </th>  
                                                           </tr>  
                                                           <tr runat="server" id="itemPlaceholder" />  
                                                       </table>  
                                                   </div>  
                                               </HeaderTemplate>  
                                               <ItemTemplate>  
                                                   <table>  
                                                       <tr>  
                                                           <td>  
                                                               <asp:Label ID="Label1" runat="server" Text='<%#Bind("Pathogen") %>'></asp:Label>  
                                                           </td>  
                                                           <td align="right">  
                                                               <asp:Label ID="lblPercentage" runat="server" Text='<%#Bind("Percentage") %>'></asp:Label>  
                                                           </td>  
                                                       </tr>  
                                                   </table>  
                                               </ItemTemplate>  
                                               <EditItemTemplate>  
                                                   <table>  
                                                       <tr>  
                                                           <td>  
                                                               <asp:Label ID="lblRA" Text="Pathogen:" runat="server" Visible="false"></asp:Label>  
                                                               <asp:Label ID="Label1" runat="server" Text='<%#Bind("Pathogen") %>'></asp:Label>  
                                                           </td>  
                                                           <td align="right">  
                                                               <asp:Label ID="lblEditTextBox2" runat="server" Text="Percentage:"></asp:Label>  
                                                               <asp:TextBox ID="txtPercentage" runat="server" Text='<%#Bind("Percentage") %>'></asp:TextBox>  
                                                           </td>  
                                                       </tr>  
                                                   </table>  
                                               </EditItemTemplate>  
                                               <FooterTemplate>  
                                                   <asp:Label ID="lblInsertddlPathogen" runat="server" Text="Pathogen:"></asp:Label>  
                                                   <asp:DropDownList ID="ddlPathogen" runat="server" AutoPostBack="true"   
                                                       DataTextField="CodingTypeName" DataValueField="CodingTypeID" OnSelectedIndexChanged="ddlPathogen_SelectedIndexChanged">  
                                                   </asp:DropDownList>  
                                                   <asp:DropDownList ID="ddlCodingDetail" runat="server" AutoPostBack="true"   
                                                       Visible="false" DataTextField="CodingDetailName" DataValueField="CodingDetailID"  
                                                       OnSelectedIndexChanged="ddlCodingDetail_SelectedIndexChanged">  
                                                   </asp:DropDownList>  
                                               </FooterTemplate>  
                                           </asp:TemplateField>  
                                           <asp:TemplateField ShowHeader="False">  
                                               <ItemTemplate>  
                                                   <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" CausesValidation="False"  
                                                       Text="Edit"></asp:LinkButton>  
                                                    <asp:LinkButton ID="lbtnDelete" runat="server" CausesValidation="False" CommandName="Delete"  
                                                       CommandArgument='<%#Eval("CodingDetailID") %>' Text="Delete"></asp:LinkButton>  
                                               </ItemTemplate>  
                                               <EditItemTemplate>  
                                                   <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Update"  
                                                       Text="Update" CommandArgument='<%#Eval("CodingDetailID") %>'></asp:LinkButton>  
                                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"  
                                                       Text="Cancel"></asp:LinkButton>  
                                               </EditItemTemplate>  
                                             
                                           </asp:TemplateField>  
                                       </Columns>  
                                       
                                   </asp:GridView>  
                               </asp:Panel>  
                               <ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server" TargetControlID="pnlOrders"  
                                   CollapsedSize="0" Collapsed="True" ExpandControlID="pnlCustomer" CollapseControlID="pnlCustomer"  
                                   AutoCollapse="False" AutoExpand="False" ScrollContents="false" ImageControlID="imgCollapsible"  
                                   ExpandedImage="Images/minus.png" CollapsedImage="Images/plus.png" ExpandDirection="Vertical" />  
                           </ItemTemplate>  
                           <FooterTemplate>  
                               <table>  
                                   <tr>  
                                       <td>  
                                           <asp:Label ID="lblInsertddlPathogen" runat="server" Text="Pathogen:"></asp:Label>  
                                           <asp:DropDownList ID="ddlPathogen" runat="server" AutoPostBack="true"   
                                               DataTextField="CodingTypeName" DataValueField="CodingTypeID" OnSelectedIndexChanged="ddlPathogen_SelectedIndexChanged">  
                                           </asp:DropDownList>  
                                           <asp:DropDownList ID="ddlCodingDetail" runat="server" AutoPostBack="true"  
                                               Visible="false" DataTextField="CodingDetailName" DataValueField="CodingDetailID"  
                                               OnSelectedIndexChanged="ddlCodingDetail_SelectedIndexChanged">  
                                           </asp:DropDownList>  
                                            
                                       </td>  
                                       <td>  
                                           <asp:TextBox ID="txtPercentage" runat="server"></asp:TextBox>  
                                       </td>  
                                   </tr>  
                               </table>  
                           </FooterTemplate>  
                       </asp:TemplateField>  
                       <asp:TemplateField ShowHeader="false">  
                           <FooterTemplate>  
                               <asp:LinkButton Text="Add" CommandName="Insert" runat="server" CausesValidation="true"  
                                   ID="btInsert" />   
                               <asp:LinkButton Text="Cancel" CommandName="Cancel" CausesValidation="false" runat="server"  
                                   ID="btCancel" />  
                           </FooterTemplate>  
                       </asp:TemplateField>  
                   </Columns>  
                   <EmptyDataTemplate>  
                       <asp:Label ID="lblPathogenEntry" Text="Pathogen:" runat="server"></asp:Label>  
                       <asp:DropDownList ID="ddlPathogen" runat="server" AutoPostBack="true"   
                           DataTextField="CodingTypeName" DataValueField="CodingTypeID" OnSelectedIndexChanged="ddlPathogen_SelectedIndexChanged">  
                       </asp:DropDownList>  
                       <asp:DropDownList ID="ddlCodingDetail" runat="server" AutoPostBack="true"   
                           Visible="false" DataTextField="CodingDetailName" DataValueField="CodingDetailID"  
                           OnSelectedIndexChanged="ddlCodingDetail_SelectedIndexChanged">  
                       </asp:DropDownList>  
                         
                       <asp:TextBox ID="txtPercentage" runat="server"></asp:TextBox>  
                       <asp:Button ID="btSend" Text="Add" runat="server" CommandName="EmptyInsert" UseSubmitBehavior="False" />  
                   </EmptyDataTemplate>  
               </asp:GridView>  
           </ContentTemplate>  
       </asp:UpdatePanel>  