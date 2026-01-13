using QLBanSach.Models;
using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLBanSach
{
    public partial class ThemSach : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChuDe();
            }
        }

        private void BindChuDe()
        {
            var dao = new ChuDeDAO();
            ddlChuDe.DataSource = dao.getAll();
            ddlChuDe.DataTextField = "TenCD";
            ddlChuDe.DataValueField = "MaCD";
            ddlChuDe.DataBind();
        }

        protected void cvHinh_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = FHinh != null && FHinh.HasFile;
        }

        protected void btXuLy_Click(object sender, EventArgs e)
        {
            lblThongBao.Text = string.Empty;

            if (!Page.IsValid)
            {
                return;
            }

            if (FHinh == null || !FHinh.HasFile)
            {
                lblThongBao.Text = "<div class='alert alert-danger'>Ảnh bìa không được bỏ trống</div>";
                return;
            }

            var tenSach = (txtTen.Text ?? string.Empty).Trim();

            int donGia;
            if (!int.TryParse((txtDonGia.Text ?? string.Empty).Trim().Replace(",", "").Replace(".", ""), out donGia) || donGia <= 0)
            {
                lblThongBao.Text = "<div class='alert alert-danger'>Đơn giá phải là kiểu số > 0</div>";
                return;
            }

            int maCD;
            if (!int.TryParse(Convert.ToString(ddlChuDe.SelectedValue ?? "0"), out maCD)) maCD = 0;

            var fileName = Path.GetFileName(FHinh.FileName);
            if (string.IsNullOrWhiteSpace(fileName))
            {
                lblThongBao.Text = "<div class='alert alert-danger'>Ảnh bìa không được bỏ trống</div>";
                return;
            }

            var saveFolder = Server.MapPath("~/Bia_sach/");
            if (!Directory.Exists(saveFolder)) Directory.CreateDirectory(saveFolder);

            var savePath = Path.Combine(saveFolder, fileName);
            if (File.Exists(savePath))
            {
                var baseName = Path.GetFileNameWithoutExtension(fileName);
                var ext = Path.GetExtension(fileName);
                fileName = baseName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
                savePath = Path.Combine(saveFolder, fileName);
            }

            try
            {
                FHinh.SaveAs(savePath);

                var dao = new SachDAO();
                var ok = dao.Insert(new Sach
                {
                    TenSach = tenSach,
                    Dongia = donGia,
                    MaCD = maCD,
                    Hinh = fileName,
                    KhuyenMai = chkKhuyenMai != null && chkKhuyenMai.Checked,
                    NgayCapNhat = DateTime.Now
                });

                if (ok > 0)
                {
                    lblThongBao.Text = "<div class='alert alert-success'>Thêm mới thành công</div>";
                    txtTen.Text = string.Empty;
                    txtDonGia.Text = string.Empty;
                    if (chkKhuyenMai != null) chkKhuyenMai.Checked = true;
                }
                else
                {
                    lblThongBao.Text = "<div class='alert alert-danger'>Thêm mới thất bại</div>";
                }
            }
            catch
            {
                lblThongBao.Text = "<div class='alert alert-danger'>Thêm mới thất bại</div>";
            }
        }
    }
}