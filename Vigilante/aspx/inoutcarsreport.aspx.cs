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

public partial class aspx_inoutcarsreport : System.Web.UI.Page
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
                //if (cmd.Value == "nuevo") nuevo();
                if (cmd.Value == "editar")
                {
                    editar();
                    if (!laberror.Visible) cmd.Value = "";
                }
                if (cmd.Value == "borrar")
                {
                    borrar();
                    if (!laberror.Visible) cmd.Value = "";
                }
                if (cmd.Value == "cargar") cmd.Value = "";
                if (cmd.Value == "filtrar")
                {

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
            //llena_datos();
            pan3.Visible = false;
        }

        llena_combos();

    }


    protected void llena_datos()
    {
        obj = new funciones();
        try
        {
            ddl1.Items.Clear();
            ddl1.Items.Add("entrada de auto");
            ddl1.Items.Add("salida de auto");

            ddl2.Items.Clear();
            ddl2.Items.Add("autos nuevos");
            ddl2.Items.Add("seminuevos");
            ddl2.Items.Add("taller");
            ddl2.Items.Add("hyp");
            ddl2.Items.Add("transferencia");

            if (show_facebook())
            {
                gv.DataSource = dt1;
                obj.dt.Dispose();
                gv.DataBind();

                if (cmd.Value == "exportar")
                {
                    cmd.Value = "";
                    var wb = new XLWorkbook();
                    wb.Worksheets.Add(dt1, "Entrada-Salida de Autos");
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=inoutcars.xlsx");
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

                obj = null;
                pan3.Visible = true;
            }
            else
            {
                if (error == "Sin Datos")
                {
                    pan3.Visible = false;
                    ///////Response.Write("<br/><br/><br/><center><input id='boton' type='button' value='Nuevo' onclick='nuevo();' /></center>");
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


    private void llena_combos()
    {
        try
        {
            obj = new funciones();
            int j;

            if (obj.conexion("cons", "select distinct marc from Tioautos order by marc"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    Response.Write("Sin Datos");
                    obj.dt.Dispose();
                }
                else
                {
                    dt1 = obj.dt.Copy();
                    obj.dt.Dispose();
                    ddlmarca.Items.Clear();
                    ddlmarca.Items.Add("TODAS");
                    for (j = 0; j < dt1.Rows.Count; j++) ddlmarca.Items.Add(dt1.Rows[j][0].ToString());
                }
            }
            else
            {
                Response.Write(obj.error);
                obj.dt.Dispose();
            }

            if (obj.conexion("cons", "select distinct agen from Tioautos order by agen"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    Response.Write("Sin Datos");
                    obj.dt.Dispose();
                }
                else
                {
                    dt1 = obj.dt.Copy();
                    obj.dt.Dispose();
                    ddlagencia.Items.Clear();
                    ddlagencia.Items.Add("TODAS");
                    for (j = 0; j < dt1.Rows.Count; j++) ddlagencia.Items.Add(dt1.Rows[j][0].ToString());
                }
            }
            else
            {
                Response.Write(obj.error);
                obj.dt.Dispose();
            }

            obj = null;
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
            return;
        }
    }

    /*protected void nuevo()
    {
        obj = new funciones();
        try
        {
            laberror.Text = "";
            laberror.Visible = false;
            if (!insert_facebook(t1.Text.Trim(), t2.Text.Trim(), int.Parse(t3.Text.Trim()), t4.Text.Trim(), t5.Text.Trim(), t6.Text.Trim(), t7.Text.Trim(), marca.Value, agencia.Value))
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
    }*/

    protected void editar()
    {
        obj = new funciones();
        try
        {
            laberror.Visible = false;
            if (!editar_facebook(int.Parse(ids.Value),ddl1.Text,ddl2.Text, t1.Text.Trim(), t2.Text.Trim(), t3.Text.Trim()))
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
                    gv.HeaderRow.Cells[1].Text = "IdVig.";
                    gv.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[2].Text = "Marca";
                    gv.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[3].Text = "Agencia";
                    gv.HeaderRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[4].Text = "Entrada/Salida";
                    gv.HeaderRow.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[5].Text = "Departamento";
                    gv.HeaderRow.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                    //gv.HeaderRow.Cells[6].Text = "Repuve";
                    gv.HeaderRow.Cells[6].Text = "";
                    gv.HeaderRow.Cells[6].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[7].Text = "Placa";
                    gv.HeaderRow.Cells[7].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[8].Text = "VIN";
                    gv.HeaderRow.Cells[8].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[9].Text = "Folio/Factura";
                    gv.HeaderRow.Cells[9].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[10].Text = "Foto";
                    gv.HeaderRow.Cells[10].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[11].Text = "Fecha";
                    gv.HeaderRow.Cells[11].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[12].Text = "Hora";
                    gv.HeaderRow.Cells[12].HorizontalAlign = HorizontalAlign.Left;
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

                div = new Panel();
                div.ID = "nek8_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[8].Text.Trim()));
                e.Row.Cells[8].Text = "";
                e.Row.Cells[8].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek9_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[9].Text.Trim()));
                e.Row.Cells[9].Text = "";
                e.Row.Cells[9].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek10_" + ids;
                div.Controls.Add(new LiteralControl("<img width='300' src='http://prospectos.carone.com.mx:8880/ws2/ceo/" + e.Row.Cells[10].Text.Trim() + "' />"));
                e.Row.Cells[10].Text = "";
                e.Row.Cells[10].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek11_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[11].Text.Trim()));
                e.Row.Cells[11].Text = "";
                e.Row.Cells[11].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "nek12_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[12].Text.Trim()));
                e.Row.Cells[12].Text = "";
                e.Row.Cells[12].Controls.Add(div);
                div = null;

            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }

    /*protected void data_enlace3(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.DataItemIndex > -1)
            {
                if (e.Row.DataItemIndex == 0)
                {
                    gv3.HeaderRow.Cells[0].Text = "Id";
                    gv3.HeaderRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[1].Text = "Marca";
                    gv3.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[2].Text = "Agencia";
                    gv3.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                }

                Panel div = new Panel();
                String ids = e.Row.Cells[0].Text.ToString();
                div.ID = "wa0_" + ids;
                div.Controls.Add(new LiteralControl(ids));
                e.Row.Cells[0].Text = "";
                e.Row.Cells[0].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "wa1_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[1].Text.Trim()));
                e.Row.Cells[1].Text = "";
                e.Row.Cells[1].Controls.Add(div);
                div = null;

                div = new Panel();
                div.ID = "wa2_" + ids;
                div.Controls.Add(new LiteralControl(e.Row.Cells[2].Text.Trim()));
                e.Row.Cells[2].Text = "";
                e.Row.Cells[2].Controls.Add(div);
                div = null;

            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }*/


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
            String query,pedacito="";

            if ((ddlmarca.Text == "TODAS") && (ddlagencia.Text == "TODAS")) pedacito = "";
            else if ((ddlmarca.Text == "TODAS") && (ddlagencia.Text != "TODAS")) pedacito = "";
            else if ((ddlmarca.Text != "TODAS") && (ddlagencia.Text == "TODAS")) pedacito = "marc='" + ddlmarca.Text + "' and";
            else if ((ddlmarca.Text != "TODAS") && (ddlagencia.Text != "TODAS")) pedacito = "marc='" + ddlmarca.Text + "' and agen='" + ddlagencia.Text + "' and";

            query = "select * from Tioautos with (nolock) where " + pedacito + " CONVERT(SmallDateTime, fecha, 103) between CONVERT(SmallDateTime, '" + lafecha1.Value + "', 103) and CONVERT(SmallDateTime, '" + lafecha2.Value + "', 103) order by marc,agen,id";

            if (obj.conexion("cons", query))
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
                    elquery.Value = query;
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

    /*private bool insert_facebook(String nombres, String apellidos, int agencia, String email, String tel, String login, String pass, String marc, String agen)
    {
        if (obj.conexion("mod", "insert into Tvigilantecatalogo values('" + nombres + "','" + apellidos + "'," + agencia + ",'" + marc + "','" + agen + "','" + email + "','" + tel + "','" + login + "','" + pass + "')"))
        {
            return true;
        }
        else
        {
            error = "Error insertar Tvigilantecatalogo: " + obj.error;
            obj.error = null;
            return false;
        }
    }*/

    private bool editar_facebook(int ids, String entradasalida, String depto, String repuve, String placa, String vin)
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "update Tioautos set io='" + entradasalida + "', depto='" + depto + "',repuve='" + repuve + "', placa='" + placa + "', vin='" + vin + "' where id=" + ids))
        {
            return true;
        }
        else
        {
            error = "Error editar Tioautos: " + obj.error;
            obj.error = null;
            return false;
        }
    }

    private bool borrar_facebook(int ids)
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "delete from Tioautos where id=" + ids))
        {
            return true;
        }
        else
        {
            error = "Error borrar Tioautos: " + obj.error;
            obj.error = null;
            return false;
        }
    }




}
