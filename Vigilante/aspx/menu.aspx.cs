using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class aspx_menu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(Request.QueryString["ident"] + "  " + Request.QueryString["marc"] + "  " + Request.QueryString["agen"]);
        if ((Request.QueryString["ident"] != null) || (Request.QueryString["ident"] != "") || (Request.QueryString["marc"] != null) || (Request.QueryString["marc"] != "") || (Request.QueryString["agen"] != null) || (Request.QueryString["agen"] != ""))
        {
            iduser.Value = Request.QueryString["ident"];
            marca.Value = Request.QueryString["marc"];
            agencia.Value = Request.QueryString["agen"];
        }
    }
}