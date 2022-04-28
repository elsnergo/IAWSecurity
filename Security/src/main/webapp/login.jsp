<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.Tbl_rol, datos.Dt_rol, java.util.*;"%>
    
<%
	// INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	HttpSession hts = request.getSession(false);
	hts.removeAttribute("acceso");
	hts.invalidate();
	
	/* String mensaje = request.getParameter("msj");
 	mensaje=mensaje==null?"":mensaje; */
	
 	int opcion = 0;
	String codigo = request.getParameter("codverif");
	codigo=codigo==null?"":codigo;
	if(codigo.equals("")){
		opcion = 1;
	}
	else{
		opcion = 2;
	}

%>    
    
    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Security | Usuarios</title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet">
</head>
<body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form method="post" action="./Sl_login">
              <h1>Acceso de Usuarios</h1>
              <input type="hidden" name="opcion" id="opcion" value="<%=opcion%>">
              <input type="hidden" name="codVerificacion" value="<%=codigo%>">
              <div>
                <input type="text" name="usuario" id="usuario" class="form-control" placeholder="Usuario" required="required" />
              </div>
              <div>
                <input type="password" name="pwd" id="pwd" class="form-control" placeholder="Contraseña" required="required" />
              </div>
              <div>
                <select class="form-control" name="rol" id="rol" required="required">
                <%
                  	ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
                  	Dt_rol dtr = new Dt_rol();
                  	listRol = dtr.listaRolActivos();
              	%>
                	<option value="">Seleccione...</option>
                <% 
				  	for(Tbl_rol trol:listRol){
				  %>
				  <option value="<%=trol.getId_rol()%>"><%=trol.getRol()%></option>
				  <%
				  	}
				  %>
                </select>
              </div>

              <div class="clearfix"></div>
              <div class="separator"></div>
              <div>
              	<input type="submit" class="btn btn-primary" value="Ingresar"/>
              	<input type="reset" class="btn btn-danger" value="Cancelar"/>
              </div>

              <div class="separator">
                <p class="change_link">
                  <a href="#signup" class="to_register"> Recuperar Contraseña </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> MSc. Elsner B. González O.</h1>
                  <p>
               		<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
               			<img alt="Licencia de Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
               		</a>
               		<br />Este obra está bajo una 
               		<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
               			licencia de Creative Commons Reconocimiento-NoComercial-CompartirIgual 4.0 Internacional
               		</a>.
                  </p>
                </div>
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form method="post" action="./#">
              <h1>Recuperar Contraseña</h1>
              <div>
                <input type="text" class="form-control" placeholder="Usuario" required />
              </div>
              <div>
                <input type="email" class="form-control" placeholder="Email" required />
              </div>
              
              <div style="margin-right: 38px; margin-left: -38px;">
                <input class="btn btn-primary btn-lg btn-block" type="submit" value="Enviar">
              </div>
              <div class="clearfix"></div>
              <div>
                <a class="btn btn-secondary btn-lg btn-block" type="button" href="#signin">Regresar</a>
              </div>
              
              
              <div class="separator">
               
                <div>
                  <h1><i class="fa fa-paw"></i> MSc. Elsner B. González O.</h1>
                  <p>
               		<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
               			<img alt="Licencia de Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
               		</a>
               		<br />Este obra está bajo una 
               		<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
               			licencia de Creative Commons Reconocimiento-NoComercial-CompartirIgual 4.0 Internacional
               		</a>.
                  </p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
  </body>
</html>