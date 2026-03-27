<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showtarjetas.aspx.cs" Inherits="aspx_showtarjetas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
    var x, igual;
    x = $(document);
    x.ready(def_eventos);

    function def_eventos() {
        otravez3();
        $("#gv3").attr("style", "border-collapse:collapse;");
        $("[id^='gv3_nek0']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:60px;");
        $("[id^='gv3_nek1']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:60px;");
        $("[id^='gv3_nek2']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:200px;");
        $("[id^='gv3_nek3']").attr("style", "padding: 0px 0px 0px 5px;overflow:hidden;height:20px;width:400px;");
        $("#encab0").attr("style", "font-size:15px;background-color:#FFFFFF;color:#FFFFFF");
        $("[class^='hor']").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;color:#000000;background-color:#FFFFFF;");
        $("#larow2").attr("style", "font-size:15px;border-right-style:groove;border-left-style:groove;border-bottom-style:groove;border-right-width:thin;border-left-width:thin;border-bottom-width:thin;border-top-style: groove;border-top-width: thin;background-color:#002451;color:#FFFFFF");
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

</script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="idrondin" runat="server" />
        <center>
            <table cellspacing="1" style="border-collapse: collapse;">
                <tr id="larow2">
                    <th align="left" width="65">Id</th>
                    <th align="left" width="65">Idtarjeta</th>
                    <th align="left" width="205">Serial</th>
                    <th align="left" width="400">Ubicación</th>
                </tr>
            </table>
            <asp:Panel ID="pan20" runat="server" ScrollBars="Auto">
                <asp:GridView ID="gv3" runat="server" GridLines="None" OnRowDataBound="data_enlace3"></asp:GridView>
            </asp:Panel>
        </center>
    </form>
</body>
</html>
