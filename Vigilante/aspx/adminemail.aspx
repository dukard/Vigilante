<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminemail.aspx.cs" Inherits="aspx_adminemail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">    
    <link rel="stylesheet" href="../css/jquery-ui20.css" />
    <link rel='stylesheet' href='../css/estilon.css' />
    <style>

        


.tname{
    color:#FFFFFF;
    font-size:18px;
}

.ui-tooltip, .arrow:after {
    background: black;
    /*border: 2px solid white;*/
}

.ui-tooltip {
    background-color: rgba(0,0,0,0.1);
    color: white;
    border-radius: 20px;
    font: bold 12px arial;
    text-transform: uppercase;
    /*padding-left:30px;
            padding: 10px 20px;
            padding:10px;
            box-shadow: 0 0 7px black;*/
}


#correosadmin{
    width: 15vw;
    height: 10vh;
    resize: none;
    font-size:large;
}


/*#pan3{
    width: 98vw;
    height: 95vh;
    overflow: auto;
    border: 2px solid red;
}*/




    </style>
    <title></title>    
    <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
  <!--    <script type="text/javascript" src="../js/jquery.min.js"></script>   -->
    <script type="text/javascript" src="../js/filters.js"></script>
    <script type="text/javascript" src="../js/jquery-ui20.js"></script>
    <script type="text/javascript">
        var x,igual;
        x = $(document);
        x.ready(def_eventos);

        function def_eventos() {
            otravez();
            $("#gv").attr("style", "border-collapse:collapse;");
            $("[id^='gv_nek0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:50px;");
            $("[id^='gv_nek1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek3']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:300px;");
            $("[id^='gv_nek4']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:300px;");
            $("[id^='gv_nek5']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:300px;");

            otravez3();
            $("#gv3").attr("style", "border-collapse:collapse;");
            $("[id^='gv3_wa0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:50px;");
            $("[id^='gv3_wa1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:150px;");
            $("[id^='gv3_wa2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:150px;");
            $("#lacab").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;color:#FFFFFF");
            $("#lacab").attr("align", "left");
            $("[class^='cam']").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;");
            $("[class^='cam']").hover(estilo5, estilo6);
            ////$("[class^='cam']").click(function () { $("#t3").val($.trim($("#" + $(this).attr("id") + " td:first-child").text().toString())); });
            $("[class^='cam']").click(function () { $("#t1").val($.trim($("#" + $(this).attr("id") + " td:nth-child(2)").text().toString())); $("#t2").val($.trim($("#" + $(this).attr("id") + " td:nth-child(3)").text().toString())); });
           
            $("#larow").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");
            $("#larow2").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");
            $("#encab0").attr("style", "font-size:15px;background-color:#FFFFFF;color:#FFFFFF");
            $("[class^='hor']").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;");
            $("[class^='hor']").hover(estilo1, estilo2);
            $("[class^='hor']").click(memclick);
            ////$("#pan1").attr("style", "width:" + ($("#gv").width() + 25) + "px;height:" + (screen.height - 220).toString() + "px;overflow:auto;");
            $("#pan1").attr("width", (((screen.width) * 95) / 100));
            $("#pan1").attr("height", ((screen.height * 80) / 100));
            $("#boton3").attr("value", "Cancelar");

            if (($("#cmd").val() == "") || ($("#cmd").val() == "exportar")) $("#snuevo").hide();
            else {
                switch ($("#cmd").val()) {
                    case "nuevo": $("#boton2").attr("value", "Agregar"); break;
                    case "editar": $("#boton2").attr("value", "Editar"); break;
                }
            }

            $("#box").keyup(function () {
                $.uiTableFilter($('#gv'), this.value);
            });


            $("a").tooltip({
                //content: "que pedo?",
                //track: true, 
                show: {
                    effect: "slide",
                },
                /*hide: {
                    effect: "slide",
                },*/
                position: {
                    my: "left right",
                    at: "right center",
                    using: function (position, feedback) {
                        $(this).css(position);
                        /*$("<div>")
                            .addClass("arrow")
                            .addClass(feedback.vertical)
                            .addClass(feedback.horizontal)
                            .appendTo(this);*/
                    }
                }
            });

            $("a").click(radial);

        }


        function memclick() {

            actual = $(this).attr("id");

            $("[class^='hor']").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;");
            $("#" + actual).attr("style", "font-size:15px;font-weight: bold;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#DBBCF8;cursor:pointer;");

            if ($("#memoria").val() != "") {
                if ($("#memoria").val() == actual) {
                    //es igual
                    $("#" + actual).attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;");
                    $("#memoria").val("");
                    $("#ids").val("");
                    return;
                }
                else {
                    //no es igual
                    
                }
            }


            /////////$("#marca").val($.trim($("#" + $(this).attr("id") + " td:nth-child(4)").text().toString()));
            ////////$("#agencia").val($.trim($("#" + $(this).attr("id") + " td:nth-child(5)").text().toString()));
            $("#memoria").val(actual);
            $("#ids").val($.trim($("#" + actual + " td:nth-child(1)").text().toString()));
        }


        /*function memclick() {

            actual = $(this).attr("id");
            
            if ($("#memoria").val() == actual) {
                //es igual
                $(this).attr("style", "font-size:15px;border-bottom-style:groove;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;cursor:default;");
            }
            else {
                //no es igual
                memo = $("#memoria").val();
                if (memo!="") $("#" + memo).attr("style", "font-size:15px;border-bottom-style:groove;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;cursor:default;");
            }

            $("#memoria").val(actual);
            $("#ids").val($.trim($("#" + actual + " td:nth-child(1)").text().toString()));


        }*/

        function radial() {
            este = $("#memoria").val();

            switch ($(this).attr("id")) {
                case "E1": nuevo(); break;
                case "E2": if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); editar($.trim($("#" + este + " td:nth-child(2)").text().toString()), $.trim($("#" + este + " td:nth-child(3)").text().toString()), $.trim($("#" + este + " td:nth-child(4)").text().toString()), $.trim($("#" + este + " td:nth-child(5)").text().toString()), $.trim($("#" + este + " td:nth-child(6)").text().toString())); break;
                case "E6": if ($("#elquery").val() == "") { alert("Realice una Consulta"); return; } $("#cmd").val("exportar"); document.forms[0].submit(); break;
                case "E9": if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); $("#cmd").val("borrar"); document.forms[0].submit(); break;
            }
        }

        function nuevo() {
            $("#pan3").hide();
            $("#boton").hide();
            $("#snuevo").show();
            $("#boton2").attr("value", "Agregar");
            $("#t1").val("");
            $("#t2").val("");
            $("#t3").val("");
            $("#t4").val("");
            $("#t5").val("");
        }

        function editar(t1,t2,t3,t4,t5) {
            $("#pan3").hide();
            $("#snuevo").show();
            $("#boton2").attr("value", "Editar");
            
            /*$("#ddl1 option[value='" + entradasalida + "']").attr("selected", true);
            $("#ddl2 option[value='" + depto + "']").attr("selected", true);*/
            $("#t1").val($.trim(t1));
            $("#t2").val($.trim(t2));
            $("#t3").val($.trim(t3));
            $("#t4").val($.trim(t4));
            $("#t5").val($.trim(t5));
        }

        function act_boton() {
            switch ($("#boton2").attr("value")) {
                case "Agregar": if (chekeo(true)) { return; } $("#cmd").val("nuevo"); break;
                case "Editar": if (chekeo(false)) { return; } $("#cmd").val("editar"); break;
            }
            document.forms[0].submit();
        }

        function act_boton2() {
            $("#pan3").show();
            $("#boton").show();
            $("#snuevo").hide();
        }

        function act_boton4() {
            $("#cmd").val("update");
            document.forms[0].submit();
        }

        function chekeo(quien) {
            if (quien) {
                if ($.trim($("#t1").val()) == "" || $.trim($("#t2").val()) == "" || $.trim($("#t3").val()) == "") { alert("Algunos campos son requeridos."); return true; }
            }
            else {
                if ($.trim($("#t1").val()) == "" || $.trim($("#t2").val()) == "" || $.trim($("#t3").val()) == "") { alert("Algunos campos son requeridos."); return true; }
            }

            //if (!email_val($.trim($("#t4").val()))) { alert("Correo no válido."); return true; }
            //if (chk_int($.trim($("#t3").val()))) { alert("Agencia:sólo numero entero."); return true; }
            return false;
        }

        function email_val(correo) {
            var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(correo);
        }

        function chk_int(valor) {
            var n, num;
            for (n = 0; n < valor.length; n++) {
                num = valor.charCodeAt(n);
                if (!((num > 47) && (num < 58))) return true;
            }

            return false;
        }

        function otravez() {
            var i;

            i = 0;
            $("#gv tr").each(function () {
                if (i > 0) {
                    $(this).attr("id", $.trim($(this).children(":eq(0)").text()) + "_" + i);
                    $(this).attr("class", "hor" + i);
                    $(this).children(":first").attr("id", "ver" + i);
                }
                else {
                    $(this).attr("id", "encab0");
                }
                i++;
            }
            );
        }

        function otravez3() {
            var i;

            i = 0;
            $("#gv3 tr").each(function () {
                if (i > 0) {
                    $(this).attr("id", $.trim($(this).children(":eq(0)").text()) + "_" + i + "gv3");
                    $(this).attr("class", "cam" + i);
                    $(this).children(":first").attr("id", "imp" + i);
                }
                else {
                    $(this).attr("id", "lacab");
                }
                i++;
            }
            );
        }


        function estilo1() {
            $("#" + $(this).attr("id")).attr("style", "font-size:15px;font-weight: bold;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#DBBCF8;cursor:pointer;");
        }

        function estilo2() { 
            actual = $(this).attr("id");

            if ($("#memoria").val() == actual) return;

            $("#" + actual).attr("style", "font-size:15px;border-bottom-style:groove;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;cursor:default;");
        }

        function estilo5() {
            $("#" + $(this).attr("id")).attr("style", "font-size:15px;font-weight: bold;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#DBBCF8;cursor:pointer;");
        }

        function estilo6() {
            $("#" + $(this).attr("id")).attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;cursor:default;");
        }


        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="cmd" runat="server" />
    <asp:HiddenField ID="ids" runat="server" />
    <asp:HiddenField ID="memoria" runat="server" />
    <asp:HiddenField ID="elquery" runat="server" />

<table width="100%" border="0">
<tr>
<td>



       <section class="menu menu--circle">
   <input type="checkbox" id="menu__active" />
   <label for="menu__active" class="menu__active">
       <div class="menu__toggle">
           <div class="icon">
               <div class="hamburger"></div>
           </div>
       </div>
       <input style="visibility: hidden;" type="radio" name="arrow--up" id="degree--up-0" />
       <input style="visibility: hidden;" type="radio" name="arrow--up" id="degree--up-1" />
       <input style="visibility: hidden;" type="radio" name="arrow--up" id="degree--up-2" />
       <div class="menu__listings">
           <ul class="circle">
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E1" href="#" class="button" title="nuevo"><img width="40" height="40" src="../img/add.png" /></a>
                       </div>
                   </div>
               </li>
               
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E2" href="#" class="button" title="editar"><img width="40" height="40" src="../img/Folder T Blue.png" /></a>
                       </div>
                   </div>
               </li>
               <li>
                   <div class="placeholder">                       
                       <div class="upside">  <!-- vacio  -->
                           <a href="#" class="button" title=""><img width="40" height="40" src="../img/bac.jpg" /></a>
                       </div>
                   </div>
               </li>
               <li>
                  <div class="placeholder">
                      <div class="upside">
                          <a id="E3" href="#" class="button" title=""><img width="40" height="40" src="../img/folder_yellow.png" /></a>
                      </div>
                  </div>
               </li>
               
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E4" href="#" class="button" title=""><img width="40" height="40" src="../img/user.png" /></a>
                       </div>
                   </div>
               </li>               
               <li>
                   <div class="placeholder">
                       <div class="upside">                           
                           <a id="E5" href="#" class="button" title=""><img width="40" height="40" src="../img/resumen.png" /></a>
                       </div>
                   </div>
               </li>
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E6" href="#" class="button" title="exportar"><img width="40" height="40" src="../img/open.png" /></a>
                       </div>
                   </div>
               </li>
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E7" href="#" class="button" title=""><img width="40" height="40" src="../img/browser.png" /></a>
                       </div>
                   </div>
               </li>
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E8" href="#" class="button" title=""><img width="40" height="40" src="../img/pie.png" /></a>
                       </div>
                   </div>
               </li>
               <li>
                   <div class="placeholder">
                       <div class="upside">
                           <a id="E9" href="#" class="button" title="eliminar"><img width="40" height="40" src="../img/botonx.png" /></a>
                       </div>
                   </div>
               </li>
           </ul>
       </div>
       <div class="menu__arrow menu__arrow--top">
           <ul>
               <li>
                   <label for="degree--up-0"><div class="arrow"></div></label>
                   <label for="degree--up-1"><div class="arrow"></div></label>
                   <label for="degree--up-2"><div class="arrow"></div></label>
               </li>
           </ul>
       </div>
   </label>
</section>


    
    



</td>
<td>
 
    <center><div id="quick"><div id="caja"><input id="box" name="box" type="text" autocomplete="off" /></div></div></center>

</td>
</tr>
<tr>
<td colspan="2">
    
 
    

  
        
        <asp:Panel ID="pan3" runat="server">
   
          <div id="lacaja">
          <center>          
          <table border="0">
          <tr>
          <td valign="top">
              <font size="5" color="white">Email Administradores:</font><br />
              <asp:TextBox ID="correosadmin" runat="server" Height="78px" MaxLength="200" TextMode="MultiLine"></asp:TextBox><br />
              <font size="3" color="white">Nota: Recuerde separar los correos<br />con el caracter coma ( , )</font><br /><br /><br />
              <input id="boton4" type="button" value="Actualizar Correos de Administradores" onclick="act_boton4();" />

          </td>
            <td width="20"></td>
          <td valign="top">
          <table cellspacing="1" id="latabla" style="border-collapse:collapse;">
	      <tr id="larow">
          <th align="left" width="60">Id</th>
          <th align="left" width="150">Marca</th>
          <th align="left" width="150">Agencia</th>
          <th align="left" width="300">Gerente General</th>
          <th align="left" width="300">Extra1</th>
          <th align="left" width="300">Extra2</th>
		  </tr>          </table>       
          <asp:Panel ID="pan1" runat="server">
             <asp:GridView ID="gv" runat="server" GridLines="None" onrowdatabound="data_enlace"></asp:GridView>
          </asp:Panel>
          </td>
          </tr>
          </table>           
          </center>
          </div>
          </asp:Panel>
         <asp:Panel ID="snuevo" runat="server">
             <br />
             <br />
             <br />
         <center>
         <asp:Label ID="laberror" runat="server"></asp:Label>
         <table>
         <tr>
             <td class="tname" align="right">Marca:</td>
             <td><asp:TextBox ID="t1" runat="server" MaxLength="50" Width="360px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
             <td class="tname" align="right">Agencia:</td>
             <td><asp:TextBox ID="t2" runat="server" MaxLength="50" Width="360px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td></td>
         <td>
              <table border="0" cellspacing="1" style="border-collapse:collapse;">
              <tr id="larow2">
              <th align="left" width="60">Id</th>
              <th align="left" width="160">Marca</th>
              <th align="left" width="160">Agencia</th>
              </tr>              </table>
 <asp:Panel ID="pan20" runat="server" Width="380px" Height="350px" ScrollBars="Auto">
  <asp:GridView ID="gv3" runat="server" GridLines="None" onrowdatabound="data_enlace3"></asp:GridView>
</asp:Panel>
         </td>
         </tr>         
         <tr>
         <td class="tname" align="right">Gerente General:</td>
         <td><asp:TextBox ID="t3" runat="server" MaxLength="50" Width="360px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">Extra1:</td>
         <td><asp:TextBox ID="t4" runat="server" MaxLength="50" Width="360px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">Extra2:</td>
         <td><asp:TextBox ID="t5" runat="server" MaxLength="50" Width="360px" autocomplete="off"></asp:TextBox></td>
         </tr>                  
         </table>
         <input id="boton2" type="button" onclick="act_boton();" />
         <input id="boton3" type="button" onclick="act_boton2();" />
         </center>
         </asp:Panel>
         



</td>
</tr>
</table>


    </form>
</body>
</html>

