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
using DocumentFormat.OpenXml.Office.Word;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
using DocumentFormat.OpenXml.Math;
using DocumentFormat.OpenXml.Office2010.Excel;

public partial class aspx_calendar_rondines : System.Web.UI.Page
{
    DataTable dt1,dt2;
    funciones obj;
    string error;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            try
            {
                if (cmd.Value == "guardar") guardar();
            }
            catch (Exception er)
            {
                Response.Write(er.ToString());
            }
        }
        else
        {
            //Response.Write(Request.QueryString["iduser"]);
            if ((Request.QueryString["iduser"] != null) || (Request.QueryString["iduser"] != ""))
            {
                iduser.Value = Request.QueryString["iduser"];
            }
        }

        llena_datos();
    }


    protected void llena_datos()
    {
        obj = new funciones();
        try
        {
            if (show_facebook())
            {
                gv.DataSource = dt1;
                dt1.Dispose();
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
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
        }
    }



    private bool show_facebook()
    {
        try
        {
            if (obj.conexion("cons", "select id,iduser,marc,agen,horarondin from Trondines with (nolock) order by marc,agen,id"))
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
                    elquery.Value = "select id,iduser,marc,agen,horarondin from Trondines with (nolock) order by marc,agen,id";

                    if (obj.conexion("cons", "select * from Tcalendariorondines"))
                    {
                        dt2 = obj.dt.Copy();
                        obj.dt.Dispose();                        
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
                    gv.HeaderRow.Cells[2].Text = "Marca";
                    gv.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[3].Text = "Agencia";
                    gv.HeaderRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[4].Text = "Hora Rondin";
                    gv.HeaderRow.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                    /*gv.HeaderRow.Cells[5].Text = "Fecha";
                    gv.HeaderRow.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[6].Text = "Hora";
                    gv.HeaderRow.Cells[6].HorizontalAlign = HorizontalAlign.Left;*/
                    System.Web.UI.WebControls.TableCell celda = new System.Web.UI.WebControls.TableCell();
                    celda.Controls.Add(new LiteralControl("Calendario"));
                    gv.HeaderRow.Cells.Add(celda);
                }

                int j;
                string[] pedazos;
                string calendario="", diario_checked, lunesavirnes_checked, otro_checked;
                string lunes_checked="", martes_checked = "", miercoles_checked = "", jueves_checked = "";
                string viernes_checked = "", sabado_checked = "", domingo_checked = "";

                Panel div = new Panel();
                String ids = e.Row.Cells[0].Text.ToString().Trim();
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


                calendario = buscar_rondin(ids);

                if (calendario == "")
                {
                    diario_checked = "";
                    lunesavirnes_checked = "";
                    otro_checked = "";
                }
                else if (calendario == "Diario")
                {
                    diario_checked = "checked";
                    lunesavirnes_checked = "";
                    otro_checked = "";
                }
                else if (calendario == "Lunes a Viernes")
                {
                    diario_checked = "";
                    lunesavirnes_checked = "checked";
                    otro_checked = "";
                }
                else
                {
                    diario_checked = "";
                    lunesavirnes_checked = "";
                    otro_checked = "checked";
                    pedazos = Regex.Split(calendario, "\\,");

                    for (j = 0; j < pedazos.Length; j++)
                    {
                        switch (pedazos[j].ToString())
                        {
                            case "Lunes": lunes_checked="checked"; break;
                            case "Martes": martes_checked = "checked"; break;
                            case "Miercoles": miercoles_checked = "checked"; break;
                            case "Jueves": jueves_checked = "checked"; break;
                            case "Viernes": viernes_checked = "checked"; break;
                            case "Sabado": sabado_checked = "checked"; break;
                            case "Domingo": domingo_checked = "checked"; break;
                        }
                    }
                }

                div = new Panel();
                div.ID = "nek5_" + ids;
                string cad = "<div style='display:inline-block;'>";
                cad += "<input type='radio' id='diario" + ids + "' name='name" + ids + "' class='rbutton' value='Diario' " + diario_checked + "><label for='diario" + ids + "'>Diario</label> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\n";
                cad += "<input type='radio' id='lunesaviernes" + ids + "' name='name" + ids + "' class='rbutton' value='Lunes a Viernes' " + lunesavirnes_checked + "><label for='lunesaviernes" + ids + "'>Lunes a Viernes</label> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\n";
                cad += "<input type='radio' id='otro" + ids + "' name='name" + ids + "' class='rbutton' value='Otro' " + otro_checked + "><label for='otro" + ids + "'>Otro</label>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div>\n";
                cad += "<div id='cajitas" + ids + "' style='display:inline-block;vertical-align: top;'><br/><br/>\n";
                cad += "<input type='checkbox' id='lunes" + ids + "' name='lunes" + ids + "' value='Lunes' " + lunes_checked + "><label for='lunes" + ids + "'> Lunes</label><br/><br/>\n";
                cad += "<input type='checkbox' id='martes" + ids + "' name='martes" + ids + "' value='Martes' " + martes_checked + "><label for='martes" + ids + "'> Martes</label><br/><br/>\n";
                cad += "<input type='checkbox' id='miercoles" + ids + "' name='miercoles" + ids + "' value='Miercoles' " + miercoles_checked + "><label for='miercoles" + ids + "'> Miercoles</label><br/><br/>\n";
                cad += "<input type='checkbox' id='jueves" + ids + "' name='jueves" + ids + "' value='Jueves' " + jueves_checked + "><label for='jueves" + ids + "'> Jueves</label><br/><br/>\n";
                cad += "<input type='checkbox' id='viernes" + ids + "' name='viernes" + ids + "' value='Viernes' " + viernes_checked + "><label for='viernes" + ids + "'> Viernes</label><br/><br/>\n";
                cad += "<input type='checkbox' id='sabado" + ids + "' name='sabado" + ids + "' value='Sabado' " + sabado_checked + "><label for='sabado" + ids + "'> Sabado</label><br/><br/>\n";
                cad += "<input type='checkbox' id='domingo" + ids + "' name='domingo" + ids + "' value='Domingo' " + domingo_checked + "><label for='domingo" + ids + "'> Domingo</label><br/><br/></div>\n";
                div.Controls.Add(new LiteralControl(cad));
                System.Web.UI.WebControls.TableCell celda2 = new System.Web.UI.WebControls.TableCell();
                celda2.Controls.Add(div);
                e.Row.Cells.Add(celda2);
                div = null;
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }

    string buscar_rondin(string ids)
    {
        try
        {
            if (dt2.Rows.Count < 1) return "";

            int i;

            for (i = 0; i < dt2.Rows.Count; i++)
            {
                if (ids == dt2.Rows[i][2].ToString().Trim()) return dt2.Rows[i][3].ToString().Trim();
            }

            return "";
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            return "";
        }
    }

    private void guardar()
    {
        int i;
        string eldato = "";
        string[] pedazos1, pedazos2;

        try
        {
            eldato = losdatos.Value.Trim();
            if (eldato == "") return;
            pedazos1 = Regex.Split(eldato, "\\%\\&");
            obj = new funciones();

            if (obj.conexion("cons", "select * from Tcalendariorondines"))
            {
                dt2 = obj.dt.Copy();
                obj.dt.Dispose();

                for (i = 0; i < pedazos1.Length; i++)
                {
                    if (pedazos1[i].ToString() != "")
                    {
                        pedazos2 = Regex.Split(pedazos1[i].ToString(), "\\%\\+");
                        buscar_rondin2(pedazos2[0].ToString(), pedazos2[1].ToString());
                    }
                }
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }
    }


    void buscar_rondin2(string idrondin,string calendario)
    {
        int j;

        try
        {
            if (dt2.Rows.Count < 1)
            {
                insertar_calendario(idrondin,calendario);
                return;
            }
            else
            {
                for (j = 0; j < dt2.Rows.Count; j++)
                {
                    if (idrondin == dt2.Rows[j][2].ToString().Trim())
                    {
                        update_calendario(calendario, dt2.Rows[j][0].ToString().Trim());
                        return;
                    }
                }

                insertar_calendario(idrondin,calendario);
                return;
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
        }        
    }


    private void insertar_calendario(string idrondin,string calendario)
    {        
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

        if (calendario.Substring(0, 5) == "Otro:")
        {
            /////////pedazos3= Regex.Split(calendario.Substring(6), "\\,");
            if (calendario.Length > 5) calendario = calendario.Substring(5);
            else calendario = "";
        }

        if (obj.conexion("mod", "insert into Tcalendariorondines values(" + iduser.Value + "," + idrondin + ",'" + calendario + "','" + fecha + "','" + hora + "')"))
        {
            return;
        }
        else
        {
            Response.Write("Error insertar Tcalendariorondines: " + obj.error);
            return;
        }
    }

    private String adecuar3(int valor)
    {
        if (valor.ToString().Length < 2) return "0" + valor.ToString();
        else return valor.ToString();
    }

    private void update_calendario(string calendario, string ids)
    {
        if (calendario.Substring(0, 5) == "Otro:")
        {
            if (calendario.Length > 5) calendario = calendario.Substring(5);
            else calendario = "";
        }

        if (obj.conexion("mod", "update Tcalendariorondines set calendario='" + calendario + "' where id=" + ids))
        {
            return;
        }
        else
        {
            Response.Write("Error editar Trondines: " + obj.error);
            return;
        }
    }




    }