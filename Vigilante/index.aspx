<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">    
    <link rel='stylesheet' href='css/delindex.css' />
    <title></title>
     <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
    var x;
    x = $(document);
    x.ready(def_eventos);

    function def_eventos() {
        $("#tblogin").val("");
        $("#tbpass").val("");
    }

    function act_boton() {
        $("#cmd").val("login");
        document.forms[0].submit();
    }
   
</script>
</head>



    <body translate="no">
  <body>
    <section class="container">
        <div class="login-container">
            <div class="circle circle-one"></div>
            <div class="form-container">
                <img src="img/mono5.png" alt="illustration" class="illustration" />
                <h1 class="opacity">LOGIN</h1>
                <form id="form1" runat="server">
                    <asp:HiddenField ID="cmd" runat="server" />
                    <!-- <input type="text" placeholder="USUARIO" />
                    <input type="password" placeholder="CLAVE" /> -->
                    


<asp:TextBox ID="tblogin" runat="server" MaxLength="15" placeholder="USUARIO"></asp:TextBox>
                    
<asp:TextBox ID="tbpass" runat="server" MaxLength="15" TextMode="Password" placeholder="CLAVE"></asp:TextBox>
                    
                    <button id="b1" runat="server" onclick="act_boton();">Enviar</button>
                </form>
                
            </div>
            <div class="circle circle-two"></div>
        </div>
        <div class="theme-btn-container"></div>
    </section>
</body>
  
      <script id="rendered-js" >

          /*
          const themes = [
              {
                  background: "#1A1A2E",
                  color: "#FFFFFF",
                  primaryColor: "#0F3460"
              },

              {
                  background: "#461220",
                  color: "#FFFFFF",
                  primaryColor: "#E94560"
              },

              {
                  background: "#192A51",
                  color: "#FFFFFF",
                  primaryColor: "#967AA1"
              },

              {
                  background: "#F7B267",
                  color: "#000000",
                  primaryColor: "#F4845F"
              },

              {
                  background: "#F25F5C",
                  color: "#000000",
                  primaryColor: "#642B36"
              },

              {
                  background: "#231F20",
                  color: "#FFF",
                  primaryColor: "#BB4430"
              }];


              
          const setTheme = theme => {
              const root = document.querySelector(":root");
              root.style.setProperty("--background", theme.background);
              root.style.setProperty("--color", theme.color);
              root.style.setProperty("--primary-color", theme.primaryColor);
              root.style.setProperty("--glass-color", theme.glassColor);
          };
          
          const displayThemeButtons = () => {
              const btnContainer = document.querySelector(".theme-btn-container");
              themes.forEach(theme => {
                  const div = document.createElement("div");
                  div.className = "theme-btn";
                  div.style.cssText = `background: ${theme.background}; width: 25px; height: 25px`;
                  btnContainer.appendChild(div);
                  div.addEventListener("click", () => setTheme(theme));
              });
          };

          displayThemeButtons();*/
//# sourceURL=pen.js
      </script>

  
</body>





</html>
