using ClosedXML.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using intra_library;
using System;
using System.Collections.Generic;
using System.IO;
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

public partial class aspx_altapuntos : System.Web.UI.Page
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
                if (cmd.Value == "cancelar") cancelar();
                else if (cmd.Value == "nuevo") nuevo();
            }
            catch (Exception er)
            {
                Response.Write(er.ToString());
            }
        }
        else
        {
            //Response.Write(Request.QueryString["iduser"] + "<br/><br/>" + Request.QueryString["idrondin"]);
            if ((Request.QueryString["iduser"] != null) || (Request.QueryString["iduser"] != "") || (Request.QueryString["idrondin"] != null) || (Request.QueryString["idrondin"] != ""))
            {
                iduser.Value = Request.QueryString["iduser"];
                idrondin.Value = Request.QueryString["idrondin"];
                labhead.Text = "Iduser: " + iduser.Value + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Idrondin: " + idrondin.Value;
                cmd.Value = "nuevo";
            }
        }

        llena_datos();
    }


    protected void llena_datos()
    {
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

            /*if (show_facebook())
            {
                gv.DataSource = dt1;
                obj.dt.Dispose();
                gv.DataBind();
                obj = null;

                if (cmd.Value == "exportar")
                {
                    cmd.Value = "";
                    var wb = new XLWorkbook();
                    wb.Worksheets.Add(dt1, "Vigilantes");
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Lista_vigilantes.xlsx");
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
            }*/
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
        }
    }

    private bool show_info()
    {
        try
        {
            //"select id,serial,registroNFC,asignada from Tregistro_tarjetasNFC with (nolock) where asignada='No' order by id"

            if (obj.conexion("cons", "select id,serial,registroNFC,asignada from Tregistro_tarjetasNFC with (nolock) order by id"))
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


    protected void cancelar()
    {
        obj = new funciones();

        try
        {
            laberror.Text = "";
            laberror.Visible = false;
            if (!cancelar_function())
            {
                Response.Write(error);
                return;
            }

            //pan3.Visible = false;
            //snuevo.Visible = false;
            obj = null;
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
        }
    }

    private bool cancelar_function()
    {        
        if (obj.conexion("mod", "delete from Trondines where id=" + idrondin.Value))
        {            
            Response.Redirect("~/aspx/rondines.aspx?iduser=" + iduser.Value);
            return true;
        }
        else
        {
            error = "Error cancelar Trondines: " + obj.error;
            obj.error = null;
            return false;
        }
    }

    private void nuevo()
    {
        int i;
        string[] pedazo1, pedazo2;
        string fecha, hora;
        int minute, hour, day, month, sec, year;
        minute = DateTime.Now.Minute;
        hour = DateTime.Now.Hour;
        day = DateTime.Now.Day;
        month = DateTime.Now.Month;
        sec = DateTime.Now.Second;
        year = DateTime.Now.Year;
        fecha = adecuar3(day) + "/" + adecuar3(month) + "/" + year;
        hora = adecuar3(hour) + ":" + adecuar3(minute);
        lospuntos.Value = lospuntos.Value.Substring(0, (lospuntos.Value.Length-2));
        pedazo1 = Regex.Split(lospuntos.Value, "\\%\\&");
        error = "";

        try
        {
            obj = new funciones();
            
            for (i = 0; i < pedazo1.Length; i++)
            {
                if (pedazo1[i] != "")
                {
                    pedazo2 = Regex.Split(pedazo1[i], "\\%\\+");

                    if (obj.conexion("mod", "insert into Tpuntos values(" + iduser.Value + "," + idrondin.Value + "," + pedazo2[0] + ",'" + pedazo2[1] + "','" + pedazo2[2] + "','" + fecha + "','" + hora + "')"))
                    {
                        if (obj.conexion("mod", "update Tregistro_tarjetasNFC set asignada='Si' where id=" + pedazo2[0]))
                        {
                            //
                        }
                        else
                        {
                            error += "Error actualizar Tregistro_tarjetasNFC: " + obj.error + "<br/><br/>";
                        }
                    }
                    else
                    {
                        Response.Write("Error insertar Tpuntos: " + obj.error + "<br/><br/>");
                        obj.error = null;
                        return;
                    }
                }
            }

            obj = null;

            if (error != "") Response.Write(error);
            else Response.Redirect("~/aspx/rondines.aspx?iduser=" + iduser.Value);
        }
        catch (Exception e)
        {
            Response.Write(e.ToString());
        }
    }

    private String adecuar3(int valor)
    {
        if (valor.ToString().Length < 2) return "0" + valor.ToString();
        else return valor.ToString();
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
                    gv3.HeaderRow.Cells[1].Text = "Serial";
                    gv3.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[2].Text = "RegistroNFC";
                    gv3.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv3.HeaderRow.Cells[3].Text = "Asignada";
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





    /*
     drop table Trondines
    create table Trondines(
    id int identity,
    iduser int,
    marc varchar(50),
    agen varchar(50),
    horarondin varchar(5),
    fecha varchar(20),
    hora varchar(20)
    )
select * from Trondines



drop table Tpuntos   
create table Tpuntos(
id int identity,
iduser int,
idrondin int,
idtarjeta int,
serial varchar(60) unique,
ubicacion varchar(100),
fecha varchar(20),
hora varchar(20)
)
select * from Tpuntos



select * from Trondines
select * from Tpuntos
select * from Tregistro_tarjetasNFC


     */


}


