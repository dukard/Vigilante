<%@ Page Language="C#" AutoEventWireup="true" CodeFile="altapuntos.aspx.cs" Inherits="aspx_altapuntos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        body{
            color:#FFFFFF;
        }

        #pan20{
            width: 50vw;
            height: 70vh;
        }

        #pan40{
            width:48vw;
            height: 70vh;
        }
    </style>

    <title></title>
    <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
    <script type="text/javascript">
        var x, igual;
        x = $(document);
        x.ready(def_eventos);

        function def_eventos() {
            otravez3();
            $("#gv3").attr("style", "border-collapse:collapse;");
            $("[id^='gv3_nek0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:50px;");
            $("[id^='gv3_nek1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:150px;");
            $("[id^='gv3_nek2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:500px;");
            $("[id^='gv3_nek3']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:120px;");
            $("#encab0").attr("style", "font-size:15px;background-color:#FFFFFF;color:#FFFFFF");
            $("[class^='hor']").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;color:#000000;background-color:#FFFFFF;");
            $("[class^='hor']").hover(estilo1, estilo2);
            $("[class^='hor']").click(function () { $("#t2").val($.trim($("#" + $(this).attr("id") + " td:nth-child(1)").text().toString())); $("#t3").val($.trim($("#" + $(this).attr("id") + " td:nth-child(2)").text().toString())); $("#t1").val($.trim($("#" + $(this).attr("id") + " td:nth-child(3)").text().toString())); });

            $("#boton3").attr("value", "Cancelar");
            $("#larow2").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");
            $("#larow3").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");
            //$("#pan20").attr("width", (((screen.width) * 95) / 100));
            //$("#pan20").attr("height", ((screen.height * 80) / 100));
            $("#pan40").hide()

            if (($("#cmd").val() == "") || ($("#cmd").val() == "exportar")) $("#snuevo").hide();
            else {
                switch ($("#cmd").val()) {
                    case "nuevo": $("#boton2").attr("value", "Agregar"); break;
                    case "editar": $("#boton2").attr("value", "Editar"); break;
                }
            }
        }

        function act_boton() {

            var i = 0;
            var cad = "";
            $("#gv40 tr").each(function () {
                if (i > 0) {
                    //alert($.trim($(this).children(":eq(0)").text()) + " - " + $.trim($(this).children(":eq(1)").text()) + " - " + $.trim($(this).children(":eq(2)").text()));
                    cad = $.trim($(this).children(":eq(0)").text()) + "%+" + $.trim($(this).children(":eq(1)").text()) + "%+" + $.trim($(this).children(":eq(2)").text()) + "%&";
                    $("#lospuntos").val($("#lospuntos").val() + cad);
                }
                i++;
            }
            );

            $("#cmd").val("nuevo");
            document.forms[0].submit();
        }

        function act_boton2() {
            $("#cmd").val("cancelar");
            document.forms[0].submit();
        }

        function act_boton4() {

            if (($("#t2").val() == "") || ($("#t3").val() == "") || ($("#t1").val() == "")) return;

            //CHECAR SI ESTA REPETIDO EN LA MISMA LISTA
            var i = 0, repetida = false;
            $("#gv40 tr").each(function () {
                if (i > 0) {                    
                    if ($.trim($(this).children(":eq(1)").text()) == $("#t3").val()) {
                        alert("Tarjeta repetida en el rondin...");
                        repetida = true;
                        return;
                    }
                }
                i++;
            }
            );

            if (!repetida) {
                $("#gv40").append("<tr id='fila" + $("#t2").val() + "' bgcolor='#FFFFFF' style='color:#000000;'><td>" + $("#t2").val() + "</td><td>" + $("#t3").val() + "</td><td>" + $("#t1").val() + "</td><td><img id='del" + $("#t2").val() + "' src='../img/botonx.png' height='30' height='30' style='cursor:pointer;'/></td></tr>");
                $("#del" + $("#t2").val()).on("click", function () {
                    var k = $(this).attr("id").substring(3);
                    var j = 0;

                    $("#gv3 tr").each(function () {
                        if (j > 0) {
                            if ($.trim($(this).children(":eq(0)").text()) == k) {
                                $(this).show();
                            }
                        }
                        j++;
                    }
                    );

                    //$("#fila" + k).hide();
                    $("#fila" + k).remove();
                });

                $("#t1").val("");
                $("#t2").val("");
                $("#t3").val("");
                $("#pan40").show();
            }            
        }

        function otravez3() {
            var i;

            i = 0;
            $("#gv3 tr").each(function () {
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
            $("#" + $(this).attr("id")).attr("style", "font-size:15px;font-weight: bold;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;color:#000000;background-color:#DBBCF8;cursor:pointer;");
        }

        function estilo2() {
            actual = $(this).attr("id");

            if ($("#memoria").val() == actual) return;

            $("#" + actual).attr("style", "font-size:15px;border-bottom-style:groove;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;color:#000000;background-color:#FFFFFF;cursor:default;");
        }




    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="cmd" runat="server" />
        <asp:HiddenField ID="ids" runat="server" />
        <asp:HiddenField ID="lospuntos" runat="server" />
        <asp:HiddenField ID="iduser" runat="server" />
        <asp:HiddenField ID="idrondin" runat="server" />
        <asp:HiddenField ID="memoria" runat="server" />


        <center>
<asp:Label ID="laberror" runat="server"></asp:Label>
<asp:Label ID="labhead" runat="server" Font-Size="Larger"></asp:Label>
<br /><br />


<table border="1">
    <tr valing="top">
        <td>            
             <table cellspacing="1" style="border-collapse:collapse;">
             <tr id="larow2">
             <th align="left" width="60">Id</th>
             <th align="left" width="160">Serial</th>
             <th align="left" width="500">RegistroNFC</th>
             <th align="left" width="130">Asignada</th>
             </tr>
             </table>
             <asp:Panel ID="pan20" runat="server" ScrollBars="Auto">
                <asp:GridView ID="gv3" runat="server" GridLines="None" onrowdatabound="data_enlace3"></asp:GridView>
             </asp:Panel>
            Tarjeta:
            <asp:TextBox ID="t2" runat="server" MaxLength="10" Width="40px" autocomplete="off"></asp:TextBox>
            <asp:TextBox ID="t3" runat="server" MaxLength="60" Width="150px" autocomplete="off"></asp:TextBox>
            <asp:TextBox ID="t1" runat="server" MaxLength="200" Width="500px" autocomplete="off"></asp:TextBox><br /><br />
             <center><input id="boton4" type="button" value="Agregar Punto" onclick="act_boton4();" /></center>
        </td>
        <td valign="top" style="width:50vw;">
            <asp:Panel ID="pan40" runat="server" ScrollBars="Auto">
                <table id="gv40" border="0" cellspacing="0" cellpadding="3">
                    <tr id="larow3" valign="top">
                        <td>Idtarjeta</td>
                        <td>Serial</td>
                        <td>RegistroNFC</td>
                        <td>Botón</td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>





 






<br />
<input id="boton2" type="button" onclick="act_boton();" />
<input id="boton3" type="button" onclick="act_boton2();" />
</center>


    </form>
</body>
</html>