using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using intra_library;
using System.Web.Security;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            try
            {
                if (cmd.Value == "login") entrar();                
            }
            catch (Exception er)
            {
                Response.Write(er.ToString());
            }
        }
        else
        {
            //llena_datos();
        }
    }



    protected void entrar()
    {
        DataTable dt1;

        funciones obj = new funciones();
        try
        {           
            if (obj.conexion("cons", "select * from Tvigilantelogin with (nolock) where login='" + tblogin.Text.Trim() + "' and pass='" + tbpass.Text.Trim() + "'"))
            {
                if (obj.dt.Rows.Count < 1)
                {
                    Response.Write("<center>Sin Datos</center>");
                    obj.dt.Dispose();
                    obj.dt = null;
                    obj = null;
                }
                else
                {
                    dt1 = obj.dt.Copy();
                    obj.dt.Dispose();

                    if ((tblogin.Text.Trim() == dt1.Rows[0][8].ToString()) && (tbpass.Text.Trim()== dt1.Rows[0][9].ToString()))
                    {                        
                        FormsAuthentication.RedirectFromLoginPage(tblogin.Text, false);
                        //if (obj.ident == 1) Response.Redirect("~/aspx/" + obj.url);
                        //else if (obj.url == "reporte.aspx") Response.Redirect("~/aspx/" + obj.url);
                        //else if (obj.url == "manualjuntas.aspx") Response.Redirect("~/html/manualjuntas/html/manualjuntas.html");
                        Response.Redirect("~/aspx/" + dt1.Rows[0][10] + "?ident=" + dt1.Rows[0][0] + "&marc=" + dt1.Rows[0][4] + "&agen=" + dt1.Rows[0][5]);
                       //Response.Redirect("~/aspx/menu4.html");
                    }
                    else
                    {

                    }
                }
            }
            else
            {
                Response.Write("<center>" + obj.error + "</center>");
                obj.error = null;
                obj = null;
            }
        }
        catch (Exception er)
        {
            Response.Write(er.ToString());
            obj = null;
        }

    }


}