using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using intra_library;
using ClosedXML.Excel;
using System.IO;

public partial class aspx_altatarjetasNFC : System.Web.UI.Page
{
    DataTable dt1;
    funciones obj;
    string error;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            try
            {
                if (cmd.Value == "env_pass")
                {
                    if (get_pass())
                    {
                        pan5.Visible = true;
                        tablon.Visible = false;
                    }
                    else
                    {
                        Response.Write("<center>" + error + "</center>");
                    }
                }
                else if (cmd.Value == "exportar")
                {
                    get_info();
                }
                else if (cmd.Value == "borrar")
                {
                    borrar();
                    get_info();
                }
            }
            catch (Exception er)
            {
                Response.Write("<center>" + er.ToString() + "</center>");
            }
        }
        else
        {
            pan5.Visible = false;
            tablon.Visible = true;
        }
    }


    private bool get_pass()
    {
        try
        {
            obj = new funciones();

            if (obj.conexion("cons", "select * from psw_tarjetas_nfc where password='" + t1.Text.Trim() + "'"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    error = "Sin Datos";
                    obj.dt.Dispose();
                    return false;
                }
                else
                {
                    obj = null;
                    return get_info();
                }
            }
            else
            {
                error = obj.error;
                obj.dt.Dispose();
                return false;
            }
        }
        catch (Exception er)
        {
            error = er.ToString();
            return false;
        }
    }

    protected bool get_info()
    {
        obj = new funciones();

        if (obj.conexion("cons", "select * from Tregistro_tarjetasNFC order by id desc,iduser"))
        {
            if (obj.dt.Rows.Count < 1)
            {
                error = "Sin Datos";
                obj.dt.Dispose();
                return false;
            }
            else
            {
                gv.DataSource = obj.dt;                
                gv.DataBind();

                elquery.Value = "select * from Tregistro_tarjetasNFC order by id desc,iduser";

                if (cmd.Value == "exportar")
                {
                    cmd.Value = "";
                    var wb = new XLWorkbook();
                    wb.Worksheets.Add(obj.dt, "Alta Tarjetas NFC");
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=TarjetasNFC.xlsx");
                    //Response.ContentEncoding = Encoding.UTF8;
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        memoryStream.Capacity = (int)memoryStream.Length;
                        wb.SaveAs(memoryStream);
                        memoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        //Response.End();
                        Response.SuppressContent = true;
                    }
                }

                obj.dt.Dispose();

                return true;
            }
        }
        else
        {
            error = obj.error;
            obj.dt.Dispose();
            return false;
        }
    }


    protected void borrar()
    {
        obj = new funciones();
        try
        {
            laberror.Visible = false;
            if (!borrar_facebook(int.Parse(ids.Value)))
            {
                Response.Write(error);
            }

            pan3.Visible = true;
            obj = null;

        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
        }
    }


    private bool borrar_facebook(int ids)
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "delete from Tregistro_tarjetasNFC where id=" + ids))
        {
            return true;
        }
        else
        {
            error = "Error borrar Tregistro_tarjetasNFC: " + obj.error;
            obj.error = null;
            return false;
        }
    }



    protected void data_enlace(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.DataItemIndex > -1)
            {
                if (e.Row.DataItemIndex == 0)
                {
                    gv.HeaderRow.Cells[0].Text = "Id";
                    gv.HeaderRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[1].Text = "IdUser";
                    gv.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[2].Text = "Serial";
                    gv.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[3].Text = "RegistroNFC";
                    gv.HeaderRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[4].Text = "Asignada";
                    gv.HeaderRow.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[5].Text = "Fecha";
                    gv.HeaderRow.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[6].Text = "Hora";
                    gv.HeaderRow.Cells[6].HorizontalAlign = HorizontalAlign.Left;
                }

                Panel div = new Panel();
                String ids = e.Row.Cells[0].Text.ToString();
                div.ID = "nek0_" + ids;
                div.Controls.Add(new LiteralControl(ids));
                e.Row.Cells[0].Text = "";
                e.Row.Cells[0].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek1_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[1].Text.Trim()));
                e.Row.Cells[1].Text = "";
                e.Row.Cells[1].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek2_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[2].Text.Trim()));
                e.Row.Cells[2].Text = "";
                e.Row.Cells[2].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek3_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[3].Text.Trim()));
                e.Row.Cells[3].Text = "";
                e.Row.Cells[3].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek4_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[4].Text.Trim()));
                e.Row.Cells[4].Text = "";
                e.Row.Cells[4].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek5_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[5].Text.Trim()));
                e.Row.Cells[5].Text = "";
                e.Row.Cells[5].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek6_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[6].Text.Trim()));
                e.Row.Cells[6].Text = "";
                e.Row.Cells[6].Controls.Add(div);
                div = null;


            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }










}