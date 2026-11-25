using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data;
using System.Data.SqlClient;
using intra_library;
using System.IO;
using ClosedXML.Excel;

public partial class aspx_registrosNFC : System.Web.UI.Page
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
                if (cmd.Value == "editar") editar();
                if (cmd.Value == "borrar") borrar();
                if (cmd.Value == "filtrar")
                {

                }
                
                if (!laberror.Visible)
                {   
                    cmd.Value = "";
                }

                llena_datos();
            }
            catch (Exception er)
            {
                Response.Write(er.ToString());
            }
        }
        else
        {
            llena_datos();
        }

    }


    protected void llena_datos()
    {
        obj = new funciones();
        try
        {            
            if (show_facebook())
            {
                gv.DataSource = dt1;
                obj.dt.Dispose();
                gv.DataBind();
                obj = null;
            }
            else
            {
                if (error == "Sin Datos")
                {
                    pan3.Visible = false;
                    Response.Write("<br/><br/><br/><center><input id='boton' type='button' value='Nuevo' onclick='nuevo();' /></center>");
                    obj = null;
                }
                else
                {
                    Response.Write(error);
                    obj.dt.Dispose();
                    obj = null;
                }
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
        }
    }

    protected void editar()
    {
        obj = new funciones();
        try
        {
            laberror.Visible = false;
            if (!editar_facebook(int.Parse(ids.Value), ddl1.Text, ddl2.Text, t1.Text.Trim(), t2.Text.Trim(), t3.Text.Trim()))
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
                    gv.HeaderRow.Cells[1].Text = "Iduser";
                    gv.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[2].Text = "Serial";
                    gv.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[3].Text = "registroNFC";
                    gv.HeaderRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;                   
                    gv.HeaderRow.Cells[4].Text = "Fecha";
                    gv.HeaderRow.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[5].Text = "Hora";
                    gv.HeaderRow.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[6].Text = "Fecha2";
                    gv.HeaderRow.Cells[6].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[7].Text = "Hora2";
                    gv.HeaderRow.Cells[7].HorizontalAlign = HorizontalAlign.Left;
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

                div = new Panel();
                div.ID = "nek7_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[7].Text.Trim()));
                e.Row.Cells[7].Text = "";
                e.Row.Cells[7].Controls.Add(div);
                div = null;

            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }

    private bool show_info()
    {
        try
        {
            if (obj.conexion("cons", "select id,marca,lugaragen from tagenandroid with (nolock) order by id"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    Response.Write("<center>Sin Datos</center>");
                    obj.dt.Dispose();
                    return false;
                }
                else
                {
                    dt1 = obj.dt.Copy();
                    obj.dt.Dispose();
                    return true;
                }
            }
            else
            {
                Response.Write("<center>" + obj.error + "</center>");
                return false;
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            return false;
        }
    }


    private bool show_facebook()
    {
        try
        {
            if (obj.conexion("cons", "select TOP 1000 * from Tnfc_scan with (nolock) order by id desc"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    error = "Sin Datos";
                    obj.dt.Dispose();
                    return false;
                }
                else
                {
                    dt1 = obj.dt.Copy();
                    obj.dt.Dispose();

                    elquery.Value = "select TOP 1000 * from Tnfc_scan with (nolock) order by id desc";

                    if (cmd.Value == "exportar")
                    {
                        cmd.Value = "";
                        var wb = new XLWorkbook();
                        wb.Worksheets.Add(dt1, "Registros NFC");
                        Response.Clear();
                        Response.ClearHeaders();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename=RegitrosNFC.xlsx");
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
        catch (Exception er)
        {
            error = er.ToString();
            return false;
        }
    }

    private bool editar_facebook(int ids, String entradasalida, String depto, String repuve, String placa, String vin)
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "update Tnfc_scan set io='" + entradasalida + "', depto='" + depto + "',repuve='" + repuve + "', placa='" + placa + "', vin='" + vin + "' where id=" + ids))
        {
            return true;
        }
        else
        {
            error = "Error editar Tnfc_scan: " + obj.error;
            obj.error = null;
            return false;
        }
    }

    private bool borrar_facebook(int ids)
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "delete from Tnfc_scan where id=" + ids))
        {
            return true;
        }
        else
        {
            error = "Error borrar Tnfc_scan: " + obj.error;
            obj.error = null;
            return false;
        }
    }




}
