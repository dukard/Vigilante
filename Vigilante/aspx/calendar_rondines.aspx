<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calendar_rondines.aspx.cs" Inherits="aspx_calendar_rondines" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link rel="stylesheet" href="../css/jquery-ui20.css" />
<link rel='stylesheet' href='../css/estilon.css' />
<style>
</style>
    <title></title>
    <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
    var x, igual;
    x = $(document);
    x.ready(def_eventos);

    function def_eventos() {
        otravez();
        $("#gv").attr("style", "border-collapse:collapse;");
        $("[id^='gv_nek0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:80px;");
        $("[id^='gv_nek1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:60px;");
        $("[id^='gv_nek2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:200px;");
        $("[id^='gv_nek3']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:200px;");
        $("[id^='gv_nek4']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:120px;");
        $("[id^='gv_nek5']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;width:600px;");      
        $("#larow").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");        
        $("#encab0").attr("style", "font-size:15px;background-color:#FFFFFF;color:#FFFFFF");
        $("[class^='hor']").attr("style","height:60px;font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;");
        $("[class^='hor']").hover(estilo1, estilo2);
        $("#pan1").attr("width", (((screen.width) * 95) / 100));
        $("#pan1").attr("height", ((screen.height * 80) / 100));
        $("#boton3").attr("value", "Cancelar");
        $(".rbutton").click(checkradio);
        $("[id^='cajitas']").hide();
        $("#enviar").click(guardar);
        
        if (($("#cmd").val() == "") || ($("#cmd").val() == "exportar") || ($("#cmd").val() == "borrar")) {
            //
        }
        
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


    function radial() {
        este = $("#memoria").val();

        switch ($(this).attr("id")) {
            case "E1": alert("Funcion Deshabilitada"); /*nuevo();*/ break;
            case "E2": alert("Funcion Deshabilitada"); /*if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); editar($.trim($("#" + este + " td:nth-child(2)").text().toString()), $.trim($("#" + este + " td:nth-child(3)").text().toString()), $.trim($("#" + este + " td:nth-child(7)").text().toString()), $.trim($("#" + este + " td:nth-child(8)").text().toString()), $.trim($("#" + este + " td:nth-child(9)").text().toString()), $.trim($("#" + este + " td:nth-child(10)").text().toString()));*/ break;
            case "E6": if ($("#elquery").val() == "") { alert("Realice una Consulta"); return; } $("#cmd").val("exportar"); document.forms[0].submit(); break;
            case "E9": if (este == "") { alert("Seleccione una fila."); return; } $("#ids").val($.trim($("#" + este + " td:nth-child(1)").text().toString())); $("#cmd").val("borrar"); document.forms[0].submit(); break;
        }
    }


    function checkradio() {

        var ids=$(this).attr("name").substr(4);

        if ($(this).attr("id").substr(0, 4) == "otro") {
            $("#cajitas" + ids).show();
        }
        else {
            $("#cajitas" + ids).hide();
        }
    }

    function guardar() {
        var i = 0, ids, valor, dias = "", calendario;

        $("#losdatos").val("");

        $("#gv tr").each(function () {
            if (i > 0) {
                ids = $.trim($(this).children(":eq(0)").text());
                calendario = $.trim($("input[type='radio'][name=name" + ids + "]:checked", "#form1").val());

                if ( calendario== "Otro") {
                    dias = ids + "%+Otro:";
                    valor = $.trim($("input[type='checkbox'][name=lunes" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";
                    valor = $.trim($("input[type='checkbox'][name=martes" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";
                    valor = $.trim($("input[type='checkbox'][name=miercoles" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";
                    valor = $.trim($("input[type='checkbox'][name=jueves" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";
                    valor = $.trim($("input[type='checkbox'][name=viernes" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";
                    valor = $.trim($("input[type='checkbox'][name=sabado" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";
                    valor = $.trim($("input[type='checkbox'][name=domingo" + ids + "]:checked", "#form1").val());
                    if (valor != "") dias += valor + ",";

                    if (dias == (ids + "%+Otro:")) dias = "";
                    else dias = dias.substr(0, (dias.length - 1));
                }
                else { // (diario) o (lunes a viernes)
                    if (calendario == "") dias = "";
                    else dias = ids + "%+" + calendario;
                }

                if (dias != "") $("#losdatos").val($("#losdatos").val() + dias + "%&");
            }
            
            i++;
        });

        valor = $("#losdatos").val();

        if (valor != "") {
            valor = valor.substr(0, (valor.length - 2));
            $("#losdatos").val(valor);
            $("#cmd").val("guardar");
            //alert($("#losdatos").val());
            //$("#losdatos").val("");
            document.forms[0].submit();
        }
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
        $("#" + $(this).attr("id")).attr("style", "height:60px;font-size:15px;font-weight: bold;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#DBBCF8;cursor:pointer;");
    }

    function estilo2() {
        actual = $(this).attr("id");

        if ($("#memoria").val() == actual) return;

        $("#" + actual).attr("style", "height:60px;font-size:15px;border-bottom-style:groove;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#FFFFFF;cursor:default;");
    }


</script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="cmd" runat="server" />
        <asp:HiddenField ID="iduser" runat="server" />
        <asp:HiddenField ID="elquery" runat="server" />
        <asp:HiddenField ID="losdatos" runat="server" />


    <center>
    <table border="0">
    <tr valign="top">
        <td valign="top">
            <asp:Panel ID="pan3" runat="server">

                <div id="lacaja">
                    <center>
                        <table border="0">
                            <tr>
                                <td align="right">
                                    <img id="enviar" style="cursor:pointer;" src="../img/env_bot.png" height="30" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellspacing="1" id="latabla" style="border-collapse: collapse;">
                                        <tr id="larow">
                                            <th align="left" width="85">Id</th>
                                            <th align="left" width="65">IdUser</th>
                                            <th align="left" width="200">Marca</th>
                                            <th align="left" width="200">Agencia</th>
                                            <th align="left" width="120">Hora Rondin</th>
                                            <th align="left" width="600">Calendario</th>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="pan1" runat="server">
                                        <asp:GridView ID="gv" runat="server" GridLines="None" OnRowDataBound="data_enlace"></asp:GridView>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </center>
                </div>
            </asp:Panel>
        </td>
    </tr>
    </table>

  </center>
        
 









    </form>
</body>
</html>
