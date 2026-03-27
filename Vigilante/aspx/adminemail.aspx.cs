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

public partial class aspx_adminemail : System.Web.UI.Page
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
                if (cmd.Value == "nuevo") nuevo();
                else if (cmd.Value == "update") updateadminsemails();
                else if (cmd.Value == "editar") editar();
                else if (cmd.Value == "borrar") borrar();
                else if (cmd.Value == "filtrar")
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

            if (show_info2())
            {
                correosadmin.Text = dt1.Rows[0][0].ToString();
                dt1.Dispose();
            }
            else
            {
                if (obj.error != "Sin Datos")
                {
                    Response.Write(obj.error);
                }
            }

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


    protected void nuevo()
    {
        obj = new funciones();
        try
        {
            laberror.Text = "";
            laberror.Visible = false;
            if (!insert_facebook())
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


    protected void editar()
    {
        obj = new funciones();
        try
        {
            laberror.Visible = false;
            if (!editar_facebook())
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

    protected void updateadminsemails()
    {
        obj = new funciones();
        try
        {
            laberror.Visible = false;
            if (!update_facebook())
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
                    gv.HeaderRow.Cells[1].Text = "Marca";
                    gv.HeaderRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[2].Text = "Agencia";
                    gv.HeaderRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[3].Text = "Gerente General";
                    gv.HeaderRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[4].Text = "Extra1";
                    gv.HeaderRow.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                    gv.HeaderRow.Cells[5].Text = "Extra2";
                    gv.HeaderRow.Cells[5].HorizontalAlign = HorizontalAlign.Left;
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

            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
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
    }

    private bool show_info()
    {
        try
        {
            if (obj.conexion("cons", "select id,marca,lugaragen from tagenandroid with (nolock) order by id"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    Response.Write("<center>Sin Datos en agencias.</center><br/>");
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
                Response.Write("<center>" + obj.error + "</center><br/>");
                return false;
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            return false;
        }
    }


    private bool show_info2()
    {
        try
        {
            if (obj.conexion("cons", "select * from Emailadministradores"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    Response.Write("<center>Sin Datos en emails de administradores.</center><br/>");
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
                Response.Write("<center>" + obj.error + "</center><br/>");
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
            if (obj.conexion("cons", "select * from Emailadmin with (nolock) order by id desc"))
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

                    elquery.Value = "select * from Emailadmin with (nolock) order by id desc";

                    if (cmd.Value == "exportar")
                    {
                        cmd.Value = "";
                        var wb = new XLWorkbook();
                        wb.Worksheets.Add(dt1, "Emails Admin");
                        Response.Clear();
                        Response.ClearHeaders();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename=Emailsasmins.xlsx");
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


    private bool insert_facebook()
    {
        if (obj.conexion("mod", "insert into Emailadmin values('" + t1.Text.Trim() + "','" + t2.Text.Trim() + "','" + t3.Text.Trim() + "','" + t4.Text.Trim() + "','" + t5.Text.Trim() + "')"))
        {
            return true;
        }
        else
        {
            error = "Error insertar Emailadmin: " + obj.error;
            obj.error = null;
            return false;
        }
    }


    private bool editar_facebook()
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "update Emailadmin set marca='" + t1.Text.Trim() + "', agencia='" + t2.Text.Trim() + "',gerentegeneral='" + t3.Text.Trim() + "', extra1='" + t4.Text.Trim() + "', extra2='" + t5.Text.Trim() + "' where id=" + ids.Value))
        {
            return true;
        }
        else
        {
            error = "Error editar Emailadmin: " + obj.error;
            obj.error = null;
            return false;
        }
    }

    private bool update_facebook()
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "update Emailadministradores set correos='" + correosadmin.Text.Trim() + "'"))
        {
            return true;
        }
        else
        {
            error = "Error editar Emailadministradores: " + obj.error;
            obj.error = null;
            return false;
        }
    }

    private bool borrar_facebook(int ids)
    {
        funciones obj = new funciones();
        if (obj.conexion("mod", "delete from Emailadministradores where id=" + ids))
        {
            return true;
        }
        else
        {
            error = "Error borrar Emailadministradores: " + obj.error;
            obj.error = null;
            return false;
        }
    }




}
