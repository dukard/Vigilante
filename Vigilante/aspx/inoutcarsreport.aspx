<%@ Page Language="C#" AutoEventWireup="true" CodeFile="inoutcarsreport.aspx.cs" Inherits="aspx_inoutcarsreport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">    
    <link rel="stylesheet" href="../css/jquery-ui20.css" />
    <link rel='stylesheet' href='../css/estilon.css' />
    <link rel="stylesheet" href="../css/jquery200-ui.css?t=1254" media="screen" />
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




    .fechapicker {
        background-color: rgba(7,65,158,0.8);
        border-radius: 12px;
        border: 0;
        box-sizing: border-box;
        color: #fff;
        font-size: 18px;        
        outline: 0;
        padding: 4px 20px 0;
        width: 150px;
        height: 30px;
    }

    .fechapicker::placeholder {
        color: #fff;
        opacity: 0.7; /* Firefox */
    }

    #enviar{
        cursor:pointer;
    }




/*       

        .arrow {
            width: 70px;
            height: 16px;
            overflow: hidden;
            position: absolute;
            left: 50%;
            margin-left: -35px;
            bottom: -16px;
        }

            

            .arrow.top {
                top: -16px;
                bottom: auto;
            }

            
            .arrow.left {
                left: 20%;
            }
            

            .arrow:after {
                content: "";
                position: absolute;
                left: -12px;
                top: 5px;
                width: 25px;
                height: 25px;
                box-shadow: 6px 5px 9px -9px black;
                -webkit-transform: rotate(45deg);
                -ms-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            .arrow.top:after {
                bottom: -20px;
                top: auto;
            }
            */
        
.box {
  display:inline-block;
}


.box select {
  background-color: #0563af;
  color: white;
  padding: 5px;
  width: 250px;
  border: none;
  font-size: 14px;
  box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
  -webkit-appearance: button;
  appearance: button;
  outline: none;
}

/*.box::before {
  content: "\f13a";
  font-family: arial;
  position: absolute;
  top: 0;
  right: 0;
  width: 20%;
  height: 100%;
  text-align: center;
  font-size: 14px;
  line-height: 25px;
  color: rgba(255, 255, 255, 0.5);
  background-color: rgba(255, 255, 255, 0.1);
  pointer-events: none;
}

.box:hover::before {
  color: rgba(255, 255, 255, 0.6);
  background-color: rgba(255, 255, 255, 0.2);
}*/

.box select option {
  padding: 25px;
}



::-webkit-scrollbar{
  width: 15px;
  background-color: rgba(0,0,0,0.1);
}

::-webkit-scrollbar-thumb{
  /*background-color: rgba(0,119,255,0.7);*/
  background-color: rgba(0,0,200,0.6);
  border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover{
  background-color: rgba(0,0,255,0.8);
  cursor:pointer;
}

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
            $("[id^='gv_nek0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:40px;");
            $("[id^='gv_nek1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:40px;");
            $("[id^='gv_nek2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek3']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek4']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek5']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            //$("[id^='gv_nek6']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            //$("[id^='gv_nek6']").attr("style", "visibility: hidden;");
            $("[id^='gv_nek6']").attr("style", "display:none;");
            $("[id^='gv_nek7']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek8']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:200px;");
            $("[id^='gv_nek9']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:150px;");
            $("[id^='gv_nek10']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:300px;");
            $("[id^='gv_nek11']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:100px;");
            $("[id^='gv_nek12']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:80px;");
           
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

            $("#enviar").click(cargar);

            $(".fechapicker").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy'
            });

        }


        function cargar() {
            if (($.trim($("#fecha1").val()) == "") || (($.trim($("#fecha2").val()) == ""))) { alert("Seleccione el Rango de Fechas"); return; }
            $("#lafecha1").val($.trim($("#fecha1").val()));
            $("#lafecha2").val($.trim($("#fecha2").val()));
            $("#cmd").val("cargar");
            document.forms[0].submit();
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
                case "E1": alert("Funcion Deshabilitada"); /*nuevo();*/ break;
                case "E2": if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); editar($.trim($("#" + este + " td:nth-child(5)").text().toString()), $.trim($("#" + este + " td:nth-child(6)").text().toString()), $.trim($("#" + este + " td:nth-child(7)").text().toString()), $.trim($("#" + este + " td:nth-child(8)").text().toString()), $.trim($("#" + este + " td:nth-child(9)").text().toString())); break;
                case "E6": if ($("#elquery").val() == "") { alert("Realice una Consulta"); return; } $("#cmd").val("exportar"); document.forms[0].submit(); break;
                case "E9": if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); $("#cmd").val("borrar"); document.forms[0].submit(); break;
            }
        }

        /*function nuevo() {
            $("#pan3").hide();
            $("#boton").hide();
            $("#snuevo").show();
            $("#boton2").attr("value", "Agregar");
            $("#t1").val("");
            $("#t2").val("");
            $("#t3").val("");
            $("#t4").val("");
            $("#t5").val("");
            $("#t6").val("");
            $("#t7").val("");
            $("#marca").val("");
            $("#agencia").val("");
        }*/

        function editar(entradasalida, depto, repuve, placa, vin) {
            $("#pan3").hide();
            $("#snuevo").show();
            $("#boton2").attr("value", "Editar");
            
            /*$("#ddl1 option[value='" + entradasalida + "']").attr("selected", true);
            $("#ddl2 option[value='" + depto + "']").attr("selected", true);*/

            $("#ddl1").val(entradasalida);
            $("#ddl2").val(depto);

            $("#t1").val(repuve);
            $("#t2").val(placa);
            $("#t3").val(vin);
        }

        function act_boton() {
            switch ($("#boton2").attr("value")) {
                /*case "Agregar": if (chekeo(true)) { return; } $("#cmd").val("nuevo"); break;*/
                case "Editar": if (chekeo(false)) { return; } $("#cmd").val("editar"); break;
            }
            document.forms[0].submit();
        }

        function act_boton2() {
            $("#pan3").show();
            $("#boton").show();
            $("#snuevo").hide();
        }

        function chekeo(quien) {
            if (quien) {
                if ($.trim($("#t1").val()) == "" || $.trim($("#t2").val()) == "") { alert("Algunos campos son requeridos."); return true; }
            }
            else {
                if ($.trim($("#t1").val()) == "" || $.trim($("#t2").val()) == "") { alert("Algunos campos son requeridos."); return true; }
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


        function estilo1() {
            $("#" + $(this).attr("id")).attr("style", "font-size:15px;font-weight: bold;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#DBBCF8;cursor:pointer;");
        }

        function estilo2() { 
            actual = $(this).attr("id");

            if ($("#memoria").val() == actual) return;

            $("#" + actual).attr("style", "font-size:15px;border-bottom-style:groove;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;cursor:default;");
        }


        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="cmd" runat="server" />
    <asp:HiddenField ID="ids" runat="server" />
    <asp:HiddenField ID="marca" runat="server" />
    <asp:HiddenField ID="agencia" runat="server" />
    <asp:HiddenField ID="memoria" runat="server" />
    <asp:HiddenField ID="lafecha1" runat="server" />
    <asp:HiddenField ID="lafecha2" runat="server" />
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
 
    <center>
        <table border="0">
            <tr valign="top">
                <td valign="top">
                    <div class="box">
                    <font color="#FFFFFF" size="4">Marca:</font>&nbsp;<asp:DropDownList ID="ddlmarca" runat="server" AutoPostBack="false"></asp:DropDownList>&nbsp; &nbsp; &nbsp;
                    <font color="#FFFFFF" size="4">Agencia:</font>&nbsp;<asp:DropDownList ID="ddlagencia" runat="server" AutoPostBack="false"></asp:DropDownList>
                    </div>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                    <asp:TextBox ID="fecha1" CssClass="fechapicker" runat="server" placeholder="Fecha Inicio" autocomplete="off"></asp:TextBox>&nbsp; &nbsp; &nbsp;
                    <asp:TextBox ID="fecha2" CssClass="fechapicker" runat="server" placeholder="Fecha Fin" autocomplete="off"></asp:TextBox>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                    <img id="enviar" src="../img/env_bot.png" height="30" />
                </td>
                <td width="200">

                </td>
                <td>
                    <div id="quick">            
                        <div id="caja"><input id="box" name="box" type="text" autocomplete="off" /></div>
                    </div>
                </td>
            </tr>
        </table>
    </center>

</td>
</tr>
<tr>
<td colspan="2">
    
 
    

  
        
        <asp:Panel ID="pan3" runat="server">
   
          <div id="lacaja">
          <center>          
          <table>
          <tr>
          <td>
          <table cellspacing="1" id="latabla" style="border-collapse:collapse;">
	      <tr id="larow">
          <th align="left" width="50">Id</th>
          <th align="left" width="60">IdVig.</th>
          <th align="left" width="160">Marca</th>
          <th align="left" width="160">Agencia</th>
          <th align="left" width="150">Entrada/Salida</th>
          <th align="left" width="150">Departamento</th>
          <th style="display:none;" align="left" width="150">Repuve</th>
          <th align="left" width="150">Placa</th>
          <th align="left" width="200">VIN</th>
          <th align="left" width="150">Folio/Factura</th>
          <th align="left" width="300">Foto</th>
          <th align="left" width="100">Fecha</th>
          <th align="left" width="50">Hora</th>
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
         <td class="tname" align="right">Entrada/Salida:</td>
         <td><asp:DropDownList ID="ddl1" runat="server" AutoPostBack="false"></asp:DropDownList></td>
         </tr>         
         <tr>
         <td class="tname" align="right">Departamento:</td>
         <td><asp:DropDownList ID="ddl2" runat="server" AutoPostBack="false"></asp:DropDownList></td>
         </tr>         
         <tr>
         <td class="tname" align="right">Repuve:</td>
         <td><asp:TextBox ID="t1" runat="server" MaxLength="30" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">Placa:</td>
         <td><asp:TextBox ID="t2" runat="server" MaxLength="50" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">VIN:</td>
         <td><asp:TextBox ID="t3" runat="server" MaxLength="15" Width="300px" autocomplete="off"></asp:TextBox></td>
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
