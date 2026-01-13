using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QLBanSach.Models;

namespace QLBanSach
{
    public partial class QTSach : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            lblThongBao.Text = string.Empty;

            var dao = new SachDAO();
            var keyword = (txtTen.Text ?? string.Empty).Trim();

            List<Sach> data;
            if (!string.IsNullOrWhiteSpace(keyword))
            {
                data = dao.laySachTheoTen(keyword);
            }
            else
            {
                data = dao.getAll();
            }

            gvSach.DataSource = data;
            gvSach.DataBind();

            if (data == null || data.Count == 0)
            {
                lblThongBao.Text = "Tìm kiếm không có kết quả nào";
            }
        }

        protected void btTraCuu_Click(object sender, EventArgs e)
        {
            gvSach.PageIndex = 0;
            gvSach.EditIndex = -1;
            BindGrid();
        }

        protected void gvSach_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSach.PageIndex = e.NewPageIndex;
            gvSach.EditIndex = -1;
            BindGrid();
        }

        protected void gvSach_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSach.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvSach_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSach.EditIndex = -1;
            BindGrid();
        }

        protected void gvSach_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            lblThongBao.Text = string.Empty;

            var maSach = Convert.ToInt32(gvSach.DataKeys[e.RowIndex].Value);
            var row = gvSach.Rows[e.RowIndex];

            var txtTenSach = row.FindControl("txtTenSach") as TextBox;
            var txtDonGia = row.FindControl("txtDonGia") as TextBox;
            var chkKhuyenMai = row.FindControl("chkKhuyenMai") as CheckBox;

            var tenSach = txtTenSach != null ? (txtTenSach.Text ?? string.Empty).Trim() : string.Empty;
            var donGiaText = txtDonGia != null ? (txtDonGia.Text ?? string.Empty).Trim() : "";
            int donGia;
            if (!int.TryParse(donGiaText.Replace(",", "").Replace(".", ""), out donGia))
            {
                lblThongBao.Text = "Đơn giá không hợp lệ";
                return;
            }

            var khuyenMai = chkKhuyenMai != null && chkKhuyenMai.Checked;

            var dao = new SachDAO();
            var ok = dao.Update(new Sach
            {
                MaSach = maSach,
                TenSach = tenSach,
                Dongia = donGia,
                KhuyenMai = khuyenMai
            });

            if (ok <= 0)
            {
                lblThongBao.Text = "Cập nhật thất bại";
                return;
            }

            gvSach.EditIndex = -1;
            BindGrid();
        }

        protected void gvSach_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            lblThongBao.Text = string.Empty;

            var maSach = Convert.ToInt32(gvSach.DataKeys[e.RowIndex].Value);
            var dao = new SachDAO();
            var ok = dao.Delete(new Sach { MaSach = maSach });

            if (ok <= 0)
            {
                lblThongBao.Text = "Xóa thất bại";
            }

            gvSach.EditIndex = -1;
            BindGrid();
        }
    }
}