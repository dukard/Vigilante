<%@ Page Language="C#" AutoEventWireup="true" CodeFile="altatarjetasNFC.aspx.cs" Inherits="aspx_altatarjetasNFC" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../css/jquery-ui20.css" />
    <link rel='stylesheet' href='../css/estilon.css' />
     <style>

         
html {
    -ms-text-size-adjust: 100%;
    -webkit-text-size-adjust: 100%;
    font-family: arial;
    /*background-color: #FFFFFF;*/    
}

body {
    margin: 0;
}

     #tablon {
         /* From https://css.glass */
         display:inline-block;
         padding:100px;
         background: rgba(255, 255, 255, 0.21);
         border-radius: 16px;
         box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
         backdrop-filter: blur(3.5px);
         -webkit-backdrop-filter: blur(3.5px);
         border: 1px solid rgba(255, 255, 255, 0.84);
     }

     
    #t1 {
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

    #t1::placeholder {
        color: #fff;
        opacity: 0.7; /* Firefox */
    }
    
    #enviar{
        cursor:pointer;
    }

    

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



 </style>
  <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
  <script type="text/javascript" src="../js/filters.js"></script>
  <script type="text/javascript" src="../js/jquery-ui20.js"></script>
  <script type="text/javascript">
      var x,igual;
      x = $(document);
      x.ready(def_eventos);

      function def_eventos() {
          $("#enviar").click(cargar);
          otravez();
          $("#gv").attr("style", "border-collapse:collapse;");
          $("[id^='gv_nek0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:40px;");
          $("[id^='gv_nek1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:100px;");
          $("[id^='gv_nek2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:180px;");
          $("[id^='gv_nek3']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:700px;");
          $("[id^='gv_nek4']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:100px;");
          $("[id^='gv_nek5']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:100px;");
          $("[id^='gv_nek6']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:100px;");
          $("#larow").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");
          $("#encab0").attr("style", "font-size:15px;background-color:#FFFFFF;color:#FFFFFF");
          $("[class^='hor']").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;");
          $("[class^='hor']").hover(estilo1, estilo2);
          $("[class^='hor']").click(memclick);
          $("#pan1").attr("width", (((screen.width) * 95) / 100));
          $("#pan1").attr("height", ((screen.height * 80) / 100));

          if (($("#cmd").val() == "") || ($("#cmd").val() == "env_pass") || ($("#cmd").val() == "exportar") || ($("#cmd").val() == "borrar")) $("#snuevo").hide();
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

      function cargar() {
          $("#cmd").val("env_pass");
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


      function radial() {
          este = $("#memoria").val();

          switch ($(this).attr("id")) {
              case "E1": alert("Funcion Deshabilitada"); /*nuevo();*/ break;
              case "E2": alert("Funcion Deshabilitada"); /*if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); editar($.trim($("#" + este + " td:nth-child(2)").text().toString()), $.trim($("#" + este + " td:nth-child(3)").text().toString()), $.trim($("#" + este + " td:nth-child(7)").text().toString()), $.trim($("#" + este + " td:nth-child(8)").text().toString()), $.trim($("#" + este + " td:nth-child(9)").text().toString()), $.trim($("#" + este + " td:nth-child(10)").text().toString()));*/ break;
              case "E6": if ($("#elquery").val() == "") { alert("Realice una Consulta"); return; } $("#cmd").val("exportar"); document.forms[0].submit(); break;
              case "E9": if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); $("#cmd").val("borrar"); document.forms[0].submit(); break;
          }
      }


      function editar(nombres, apellidos, email, tel, log, pass) {
          $("#pan3").hide();
          $("#snuevo").show();
          $("#boton2").attr("value", "Editar");
          $("#t1").val(nombres);
          $("#t2").val(apellidos);
          $("#t4").val(email);
          $("#t5").val(tel);
          $("#t6").val(log);
          $("#t7").val(pass);
          $("#secreto").hide();
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

      function chekeo(quien) {
          if (quien) {
              if ($.trim($("#t1").val()) == "" || $.trim($("#t2").val()) == "" || $.trim($("#t3").val()) == "" || $.trim($("#t4").val()) == "" || $.trim($("#t5").val()) == "" || $.trim($("#t6").val()) == "" || $.trim($("#t7").val()) == "") { alert("Algunos campos son requeridos."); return true; }
          }
          else {
              if ($.trim($("#t1").val()) == "" || $.trim($("#t2").val()) == "" || $.trim($("#t4").val()) == "" || $.trim($("#t5").val()) == "" || $.trim($("#t6").val()) == "" || $.trim($("#t7").val()) == "") { alert("Algunos campos son requeridos."); return true; }
          }
          if (!email_val($.trim($("#t4").val()))) { alert("Correo no válido."); return true; }
          if (chk_int($.trim($("#t3").val()))) { alert("Agencia:sólo numero entero."); return true; }
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
<asp:HiddenField ID="elquery" runat="server" />
     <center>
        <asp:Panel ID="tablon" runat="server">
            <asp:TextBox ID="t1" runat="server" MaxLength="20" TextMode="Password" placeholder="Password" Width="300px" autocomplete="off"></asp:TextBox><br /><br />
            <img id="enviar" src="../img/env_bot.png" height="30" />
        </asp:Panel>
     </center>






<asp:Panel ID="pan5" runat="server">

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
          <table>
          <tr>
          <td>
          <table cellspacing="1" id="latabla" style="border-collapse:collapse;">
	      <tr id="larow">
          <th align="left" width="50">Id</th>
          <th align="left" width="100">IdUser</th>
          <th align="left" width="180">Serial</th>
          <th align="left" width="700">RegistroNFC</th>
          <th align="left" width="100">Asignada</th>
          <th align="left" width="100">Fecha</th>
          <th align="left" width="100">Hora</th>
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
         <td class="tname" align="right">Nombres:</td>
         <td><asp:TextBox ID="TextBox1" runat="server" MaxLength="50" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>         
         <tr>
         <td class="tname" align="right">Apellidos:</td>
         <td><asp:TextBox ID="t2" runat="server" MaxLength="50" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr id="secreto">
         <td class="tname" align="right" valign="top">Agencia:</td>
         <td>
            <asp:TextBox ID="t3" runat="server" MaxLength="5" Width="300px" autocomplete="off"></asp:TextBox>
            <table cellspacing="1" style="border-collapse:collapse;">
	        <tr id="larow2">
            <th align="left" width="60">Id</th>
            <th align="left" width="130">Marca</th>
            <th align="left" width="130">Agencia</th>
		    </tr>            </table>
            <asp:Panel ID="pan20" runat="server" Height="150px" ScrollBars="Auto">
             
           </asp:Panel>
         </td>
         </tr>
         <tr>
         <td class="tname" align="right">Email:</td>
         <td><asp:TextBox ID="t4" runat="server" MaxLength="30" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">Teléfono:</td>
         <td><asp:TextBox ID="t5" runat="server" MaxLength="50" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">Login:</td>
         <td><asp:TextBox ID="t6" runat="server" MaxLength="15" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>
         <tr>
         <td class="tname" align="right">Pass:</td>
         <td><asp:TextBox ID="t7" runat="server" MaxLength="15" Width="300px" autocomplete="off"></asp:TextBox></td>
         </tr>         
         </table>
         <input id="boton2" type="button" onclick="act_boton();" />
         <input id="boton3" type="button" onclick="act_boton2();" />
         </center>
         </asp:Panel>
         



</td>
</tr>
</table>


</asp:Panel>

    
    </form>
</body>
</html>
