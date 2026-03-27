using DocumentFormat.OpenXml.Office.Word;
using intra_library;
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
using DocumentFormat.OpenXml.Math;
using System.Activities.Expressions;

public partial class aspx_showtarjetas : System.Web.UI.Page
{

    DataTable dt1;
    funciones obj;
    string error;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            //
        }
        else
        {            
            if ((Request.QueryString["idrondin"] != null) || (Request.QueryString["idrondin"] != ""))
            {
                //Response.Write(Request.QueryString["idrondin"]);
                idrondin.Value = Request.QueryString["idrondin"];
                obj = new funciones();
                try
                {
                    if (show_info())
                    {
                        gv3.DataSource = dt1;
                        dt1.Dispose();
                        gv3.DataBind();
                    }
                    else
                    {
                        if (obj.error != "Sin Datos")
                        {
                            Response.Write(obj.error);
                        }
                    }
                }
                catch (Exception er)
                {
                    Response.Write(er.ToString());
                    obj = null;
                }
            }
        }
    }


    private bool show_info()
    {
        try
        {
            if (obj.conexion("cons", "select id,idtarjeta,serial,registroNFC from Tpuntos where idrondin=" + idrondin.Value))
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


    protected void data_enlace3(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.DataItemIndex > -1)
            {
                if (e.Row.DataItemIndex == 0)
                {
                    gv3.HeaderRow.Cells[0].Text = "Id";
                    gv3.HeaderRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[1].Text = "Idtarjeta";
                    gv3.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[2].Text = "Serial";
                    gv3.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[3].Text = "RegistroNFC";
                    gv3.HeaderRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;
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
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }











}