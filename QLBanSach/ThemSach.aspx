<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ThemSach.aspx.cs" Inherits="QLBanSach.ThemSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="NoiDung" runat="server">
    <h2>THÊM SÁCH MỚI</h2>
    <hr />
    <div class="w-100">

        <asp:Label ID="lblThongBao" runat="server" EnableViewState="false" />

        <asp:ValidationSummary ID="vs1" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" />

        <div class="form-group">
            <label class="font-weight-bold">Tên sách</label>
            <asp:TextBox ID="txtTen" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvTen" runat="server" ControlToValidate="txtTen" ErrorMessage="Tên sách không được rỗng" CssClass="text-danger" Display="Dynamic" />
        </div>
        <div class="form-group">
            <label class="font-weight-bold">Đơn giá</label>
            <asp:TextBox ID="txtDonGia" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDonGia" runat="server" ControlToValidate="txtDonGia" ErrorMessage="Đơn giá không được rỗng" CssClass="text-danger" Display="Dynamic" />
            <asp:RangeValidator ID="rvDonGia" runat="server" ControlToValidate="txtDonGia" Type="Integer" MinimumValue="1" MaximumValue="2147483647" ErrorMessage="Đơn giá phải là kiểu số > 0" CssClass="text-danger" Display="Dynamic" />
        </div>
        <div class="form-group">
            <label class="font-weight-bold">Chủ đề</label>
            <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>
        <div class="form-group">
            <label class="font-weight-bold">Ảnh bìa sách</label>
            <asp:FileUpload ID="FHinh" runat="server" CssClass="form-control-file" />
            <asp:CustomValidator ID="cvHinh" runat="server" ErrorMessage="Ảnh bìa không được bỏ trống" CssClass="text-danger" Display="Dynamic" OnServerValidate="cvHinh_ServerValidate" />
        </div>
        <div class="form-group">
            <label class="font-weight-bold">Khuyến mãi</label>
            <asp:CheckBox ID="chkKhuyenMai" runat="server" Checked="true" CssClass="form-check" />
        </div>
        <asp:Button ID="btXuLy" runat="server" Text="Lưu" CssClass="btn btn-success" OnClick="btXuLy_Click" />

    </div>
    <br />
</asp:Content>
