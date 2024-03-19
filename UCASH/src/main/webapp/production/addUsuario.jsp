<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="entidades.*, datos.*, java.util.*;"%>
	
	 
<%
	String signal = ""; 
	if(request.getParameter("msj") != null){
		signal = request.getParameter("msj");
	}

	//INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	//DECLARACIONES
	Vw_usuariorol vwur = new Vw_usuariorol();
	Dt_rolOpciones dtro = new Dt_rolOpciones();
	ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
	boolean permiso = false; //VARIABLE DE CONTROL
	
	//OBTENEMOS LA SESION
	vwur = (Vw_usuariorol) session.getAttribute("acceso");
	if(vwur!=null){
		//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
		
		listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());
		
		for(int x = 0; x < listOpc.size(); x++){
			System.out.print(listOpc.get(x).getOpciones());
		};
		
		
		//RECUPERAMOS LA URL = MI OPCION ACTUAL
		int index = request.getRequestURL().lastIndexOf("/");
		String miPagina = request.getRequestURL().substring(index+1);
		
		//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
		for(Vw_rolopciones vrop : listOpc){
			if(vrop.getOpciones().trim().equals(miPagina.trim())){
				permiso = true; //ACCESO CONCEDIDO
				System.out.print("ESTA ES LA PAGINA RECUPERADA: " + " " + vrop.getOpciones().trim() +  " " + "ESTA ES LA PAGINA EN LA QUE NOS ENCONTRAMOS: " + miPagina.trim());
				break;
			}
		}
	}
	else{
		response.sendRedirect("../login.jsp?msj=401");
		return;
	}
		
	if(!permiso){
		response.sendRedirect("page_403.jsp");
		return;
	}
	
%>
	
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<!-- <meta charset="utf-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Agregar | Usuario</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Agregar nuevo usuario</h3>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Formulario de usuarios</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<input type="hidden" value="<%=signal%>" id="JAlertInput"/>	
									<form class="" action="../Sl_usuario" method="post" id="myForm" novalidate>
										<input type="hidden" value="1" name="opcion" id="opcion" />
										<input type="hidden" value="<%=vwur.getId_user()%>" name="usuarioCreacion" id="usuarioCreacion" />
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre<span
												class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input id="txt_nombre" class="form-control" class='optional' name="nombres"
													type="text" placeholder="Nombres" required/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Apellidos<span
												class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input id="txt_apellido" class="form-control" class='optional'
													name="apellidos" type="text" placeholder="Apellidos" required/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Correo
												Electronico<span class="required">:</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input id="txtemail" class="form-control" class='optional' name="email"
													type="text" placeholder="Correo Electronico" required/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Confirme
												Email<span class="required">:</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="email" name="email2" id="txtemail2"
													class="form-control" name="name"
													placeholder="ejemplo: ejemplo@ejemplo.com"
													title="Correo electrónico institucional"
													required />
											</div>
										</div>
										
										<div class="field item form-group">
											<div class="col-md-3 col-sm-3 label-align">
												<label id="lblEmail_error"></label>
											</div>
											<div class="col-md-6 col-sm-6">
												<label id="msjEmail_error"></label>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Usuario<span
												class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input id="txt_usuario" class="form-control" class='optional' name="usuario"
													type="text" placeholder="Nombre de Usuario" required/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Contraseña<span
												class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input type="password" name="pwd" id="txtclave1" 
													class="form-control" class='optional'
													title="Utilice letras mayúsculas, minúsculas, números y caracteres especiales"
													placeholder="Contraseña" required/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">Confirme
												Contraseña<span class="required">:</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="password" name="txtclave2" id="txtclave2"
													class="form-control" class='optional'
													title="Utilice letras mayúsculas, minúsculas, números y caracteres especiales"
													placeholder="Confirme Contraseña" required/>
											</div>
										</div>
										
										<div class="field item form-group">
											<div class="col-md-3 col-sm-3 label-align">
												<label id="label_error"></label>
											</div>
											<div class="col-md-6 col-sm-6">
												<label id="mensaje_error"></label>
											</div>
										</div>

										<div class="ln_solid"></div>
										<div class="form-group">
											<div class="col-md-9 col-sm-9  offset-md-3">
												<button type='submit' id="button_execute" class="btn btn-primary">Agregar</button>
												<button type="button" id="button_cancel" onClick="window.location.href='tbl_usuario.jsp'" class="btn btn-danger">Cancelar</button>
											</div>
										</div>

									</form>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>

			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">UCASH >> Sistema contable</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>

	<!-- Javascript functions	-->

	<script>
	
		$(document).ready(function () {
		    $('#mensaje_error').hide();  
		    $('#label_error').hide();  
		    $('#msjEmail_error').hide();  
		    $('#lblEmail_error').hide();  
		});
	
		// initialize a validator instance from the "FormValidator" constructor.
		// A "<form>" element is optionally passed as an argument, but is not a must
		var validator = new FormValidator({
			"events" : [ 'blur', 'input', 'change' ]
		}, document.forms[0]);
		// on form "submit" event
		document.forms[0].onsubmit = function(e) {
			var submit = true, validatorResult = validator.checkAll(this);
			console.log(validatorResult);
			return !!validatorResult.valid;
		};
		// on form "reset" event
		document.forms[0].onreset = function(e) {
			validator.reset();
		};
		// stuff related ONLY for this demo page:
		$('.toggleValidationTooltips').change(function() {
			validator.settings.alerts = !this.checked;
			if (this.checked)
				$('form .alert').remove();
		}).prop('checked', false);
		
		
		$("#txtclave2").keyup(function () {
		    var cont = $('#txtclave1').val();
		    var cont2 = $('#txtclave2').val();
		    if (cont == cont2) {
		        $('#mensaje_error').attr("class", "text-success");
		        $('#mensaje_error').html("Las contraseñas si coinciden");
		        $('#label_error').attr("class", "text-success");
		        $('#label_error').html("¡Excelente!");
		        $('#mensaje_error').show();
		        $('#label_error').show();
		    } else {
		    	$('#mensaje_error').attr("class", "text-danger");
		        $('#mensaje_error').html("Las contraseñas no coinciden");
		    	$('#label_error').attr("class", "text-danger");
		        $('#label_error').html("¡Alerta!");
		        $('#mensaje_error').show();
		        $('#label_error').show();
		    }
		});
		$("#txtemail2").keyup(function () {
		    var cont = $('#txtemail').val();
		    var cont2 = $('#txtemail2').val();
		    if (cont == cont2) {
		        $('#msjEmail_error').attr("class", "text-success");
		        $('#msjEmail_error').html("Los correos si coinciden");
		        $('#lblEmail_error').attr("class", "text-success");
		        $('#lblEmail_error').html("¡Excelente!");
		        $('#msjEmail_error').show();
		        $('#lblEmail_error').show();
		    } else {
		    	$('#msjEmail_error').attr("class", "text-danger");
		        $('#msjEmail_error').html("Los correos no coinciden");
		    	$('#lblEmail_error').attr("class", "text-danger");
		        $('#lblEmail_error').html("¡Alerta!");
		        $('#msjEmail_error').show();
		        $('#lblEmail_error').show();
		    }
		});
			
	</script>
	<!--Keyboard navigation-->
	<script src="js/navigation/userTableNavigation.js"></script>
	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- iCheck -->
	<script src="../vendors/iCheck/icheck.min.js"></script>
	<!-- Datatables -->
	<script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script
		src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script
		src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script
		src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="../vendors/jszip/dist/jszip.min.js"></script>
	<script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	
	<!-- jAlert -->
    <script src="../vendors/jAlert/dist/jAlert.min.js"></script>
    <script src="../vendors/jAlert/dist/jAlert-functions.min.js"></script>
</body>
</html>