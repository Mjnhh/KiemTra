<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="QTSach.aspx.cs" Inherits="QLBanSach.QTSach" %>
<asp:Content ID="Content1" ContentPlaceHolderID="NoiDung" runat="server">
     <h2>TRANG QUẢN TRỊ SÁCH</h2>
     <hr />   
     <div class="row mb-2">
         <div class="col-md-6">
              <div class="form-inline">
                   Tựa sách <asp:TextBox ID="txtTen" runat="server" placeholder="Nhập tựa sách cần tìm" CssClass="form-control ml-2" Width="300"></asp:TextBox>
                   <asp:Button ID="btTraCuu" runat="server" Text="Tra cứu" CssClass="btn btn-info ml-2" OnClick="btTraCuu_Click" />                 
              </div>
         </div>
        <div class="col-md-6 text-right">
             <a href="ThemSach.aspx" class="btn btn-success">Thêm sách mới</a>
         </div>
     </div>

     <asp:Label ID="lblThongBao" runat="server" EnableViewState="false" CssClass="text-danger font-weight-bold" />

     <asp:GridView ID="gvSach" runat="server" AutoGenerateColumns="false"
         CssClass="table table-bordered table-hover w-100"
         HeaderStyle-CssClass="bg-danger text-white"
         DataKeyNames="MaSach"
         AllowPaging="true" PageSize="4"
         OnPageIndexChanging="gvSach_PageIndexChanging"
         OnRowEditing="gvSach_RowEditing"
         OnRowCancelingEdit="gvSach_RowCancelingEdit"
         OnRowUpdating="gvSach_RowUpdating"
         OnRowDeleting="gvSach_RowDeleting">
         <PagerSettings Mode="Numeric" Position="Bottom" />
         <Columns>
             <asp:TemplateField HeaderText="Tựa sách">
                 <ItemTemplate>
                     <span class="text-primary"><%# Eval("TenSach") %></span>
                 </ItemTemplate>
                 <EditItemTemplate>
                     <asp:TextBox ID="txtTenSach" runat="server" CssClass="form-control" Text='<%# Bind("TenSach") %>' />
                 </EditItemTemplate>
             </asp:TemplateField>

             <asp:TemplateField HeaderText="Ảnh bìa">
                 <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                 <ItemStyle Width="140px" HorizontalAlign="Center" Wrap="False" />
                 <ItemTemplate>
                     <img class="img-fluid" style="max-height:90px" src='<%# "Bia_sach/" + Eval("Hinh") %>' alt="Bìa" />
                 </ItemTemplate>
                 <EditItemTemplate>
                     <img class="img-fluid" style="max-height:90px" src='<%# "Bia_sach/" + Eval("Hinh") %>' alt="Bìa" />
                 </EditItemTemplate>
             </asp:TemplateField>

             <asp:TemplateField HeaderText="Đơn giá">
                 <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                 <ItemStyle Width="160px" HorizontalAlign="Center" Wrap="False" />
                 <ItemTemplate>
                     <%# string.Format("{0:N0} đồng", Eval("Dongia")) %>
                 </ItemTemplate>
                 <EditItemTemplate>
                     <asp:TextBox ID="txtDonGia" runat="server" CssClass="form-control" Text='<%# Bind("Dongia") %>' />
                 </EditItemTemplate>
             </asp:TemplateField>

             <asp:TemplateField HeaderText="Khuyến mãi">
                 <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                 <ItemStyle Width="110px" HorizontalAlign="Center" Wrap="False" />
                 <ItemTemplate>
                     <%# (Convert.ToBoolean(Eval("KhuyenMai")) ? "x" : "") %>
                 </ItemTemplate>
                 <EditItemTemplate>
                     <asp:CheckBox ID="chkKhuyenMai" runat="server" Checked='<%# Bind("KhuyenMai") %>' />
                 </EditItemTemplate>
             </asp:TemplateField>

             <asp:TemplateField HeaderText="Chọn thao tác">
                 <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                 <ItemStyle Width="200px" HorizontalAlign="Center" Wrap="False" />
                 <ItemTemplate>
                     <div class="text-nowrap">
                         <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-info btn-sm mr-1" CommandName="Edit" CausesValidation="false">Sửa</asp:LinkButton>
                         <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Bạn có chắc muốn xóa sách này?');">Xóa</asp:LinkButton>
                     </div>
                 </ItemTemplate>
                 <EditItemTemplate>
                     <div class="text-nowrap">
                         <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-sm mr-1" CommandName="Update">Ghi</asp:LinkButton>
                         <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning btn-sm" CommandName="Cancel" CausesValidation="false">Không</asp:LinkButton>
                     </div>
                 </EditItemTemplate>
             </asp:TemplateField>
         </Columns>
         <PagerStyle CssClass="text-center" HorizontalAlign="Center" />
     </asp:GridView>
</asp:Content>
