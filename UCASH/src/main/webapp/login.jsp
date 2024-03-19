<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.Tbl_rol, datos.Dt_rol, java.util.*;"%>
    
<%
//JAlert flag
	String signal = ""; 
	if(request.getParameter("msj") != null){
		signal = request.getParameter("msj");
	}	


//INVALIDA LA CACHE DEL NAVEGADOR //
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
	<link rel="icon" href="production/images/favicon.ico" type="image/ico" />
    <title>SISTEMA CONTABLE - UCASH | Login</title>

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
    
<link rel="stylesheet" href="vendors/jAlert/dist/jAlert.css" />
</head>
<body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form method="post" action="./Sl_login">
            <input type="hidden" value="<%=signal%>" id="JAlertInput"/>
              <h1>Acceso de Usuarios</h1>
              <input type="hidden" name="opcion" id="opcion" value="<%=opcion%>">
              <input type="hidden" name="codVerificacion" value="<%=codigo%>">
              <div>
                <input type="text" name="usuario" id="usuario" class="form-control" placeholder="Usuario" required="required" />
              </div>
              <div>
                <input type="password" name="password" id="password" class="form-control" placeholder="Contraseña" required="required" />
              </div>
              <div>
                <select class="form-control" name="rol" id="rol" required="required">
                <%
                  	ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
                  	Dt_rol dtr = new Dt_rol();
                  	listRol = dtr.listaRolesActivos();
              	%>
                	<option value="">Seleccione...</option>
                <% 
				  	for(Tbl_rol trol:listRol){
				  %>
				  <option value="<%=trol.getIdRol()%>"><%=trol.getNombre()%></option>
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
                	<div>
	                  <img alt="UCASH" src="production/images/logo_ucash.png" 
	                  	style="width: 100px; height: 100px;">
	                  <h1>Sistema Contable</h1>
                	</div>
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
            <form method="post" action="./Sl_login">
            <input type="hidden" name="opcion" id="opcion" value="3">
              <h1>Recuperar Contraseña</h1>
              <div>
                <input type="text" class="form-control" placeholder="Usuario" name="usuario" required />
              </div>
              <div>
                <input type="email" class="form-control" placeholder="Email" name="email" required />
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
                  	<div>
	                  <img alt="UCASH" src="production/images/logo_ucash.png" 
	                  	style="width: 100px; height: 100px;">
	                  <h1>Sistema Contable</h1>
                	</div>
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
    <!-- jQuery -->
	<script src="vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="vendors/nprogress/nprogress.js"></script>
	<!-- iCheck -->
	<script src="vendors/iCheck/icheck.min.js"></script>
	<!-- Datatables -->
	<script src="vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script src="vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script
		src="vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script
		src="vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script
		src="vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="vendors/jszip/dist/jszip.min.js"></script>
	<script src="vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="vendors/pdfmake/build/vfs_fonts.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="build/js/custom.min.js"></script>
	
	<!-- jAlert -->
    <script src="vendors/jAlert/dist/jAlert.min.js"></script>
    <script src="vendors/jAlert/dist/jAlert-functions.min.js"></script>
	
	<script>
			var mensaje = "";
			mensaje = document.getElementById("JAlertInput").value; 
			
			$(document).ready(function() {
				
				if (mensaje == "1") {
					successAlert('Exito', 'Estimado usuario hemos enviado un correo electrónico con sus datos de acceso.')
				}
                
                if (mensaje == "401") {
                	errorAlert('Error', 
                			'Verifique sus datos de acceso e intente nuevamente!'+ 
                			' Si el problema persiste contacte al Administrador del Sistema.')
                }
                if (mensaje == "403") {
                	errorAlert('Error', 'Usted no tiene permisos para acceder a esta página'+ 
                			' Si requiere acceder a este recurso contacte al Administrador del Sistema.')
                }

                if (mensaje == "404") {
                	errorAlert('Error', 'El correo electrónico o el usuario proporcionado no existe. '+
                			'Asegúrese de ingresar un usuario y correo válido! '+
                			'Si el problema persiste contacte al Administrador del Sistema.')
                }

                
               	
                $("#example1").DataTable({
                    "responsive": true,
                    "lengthChange": false,
                    "autoWidth": false,
                    "buttons": ["excel", "pdf"]
                }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

                /*$('#example2').DataTable({
                    "paging": true,
                    "lengthChange": false,
                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false,
                    "responsive": true,
                });*/
            });
    </script>
    
  </body>
</html>