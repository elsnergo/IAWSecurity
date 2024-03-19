<%@page import="entidades.Vw_tasacambio"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="entidades.Tbl_tasaCambio, entidades.Vw_usuariorol, entidades.Vw_tasaCambioDet, entidades.Vw_rolopciones, datos.Dt_tasaCambio, datos.Dt_rolOpciones, java.util.*;" %>
    
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
		
		//RECUPERAMOS LA URL = MI OPCION ACTUAL
		int index = request.getRequestURL().lastIndexOf("/");
		String miPagina = request.getRequestURL().substring(index+1);
		
		//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
		for(Vw_rolopciones vrop : listOpc){
			if(vrop.getOpciones().trim().equals(miPagina.trim())){
				permiso = true; //ACCESO CONCEDIDO
				break;
			}
		}
	}
	else{
		response.sendRedirect("../login.jsp?msj=401");
		return;
	}
		
	if(!permiso){
		// response.sendRedirect("../login.jsp?msj=401");
		response.sendRedirect("page_403.jsp");
		return;
	}
	
%>
    
<!DOCTYPE html>
<html>

<%
String tasa = "";
tasa = request.getParameter("idTC") == null ? "0" : request.getParameter("idTC"); 

Vw_tasacambio tc = new Vw_tasacambio();
Dt_tasaCambio dttasa = new Dt_tasaCambio();
tc = dttasa.getTasaCambiobyID(Integer.parseInt(tasa));

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<!-- <meta charset="utf-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Eliminar | Maestro Tasa Cambio</title>

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
			</div>
			
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Eliminar Tasa Cambio</h3>
						</div>

<!-- 						<div class="title_right"> -->
<!-- 							<div class="col-md-5 col-sm-5 form-group pull-right top_search"> -->
<!-- 								<div class="input-group"> -->
<!-- 									<input type="text" class="form-control" -->
<!-- 										placeholder="Buscar..."> <span -->
<!-- 										class="input-group-btn"> -->
<!-- 										<button class="btn btn-default" type="button">Go!</button> -->
<!-- 									</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Eliminar Tasa Cambio</h2>

									<div class="clearfix"></div>
								</div>
								
								<div class="x_content">
								<input type="hidden" value="<%=signal%>" id="JAlertInput"/>
									<form class="" action="../Sl_tasaCambio" method="post" novalidate>
									<input type="hidden" value="3" name="opcion" id="opcion" />
									<input type="hidden" value="<%=tc.getIdTasaCambio() %>" name="idTasaCambio" id="idTasaCambio"/>
										<span class="section">Datos de Tasa Cambio</span>
										
										<%
															
															String mes = "";
															switch(tc.getMes()){
															case 1:
																mes = "Enero";
																break;
																
															case 2:
																mes = "Febrero";
																break;
																
															case 3:
																mes = "Marzo";
																break;
															
															case 4:
																mes = "Abril";
																break;
																
															case 5:
																mes = "Mayo";
																break;
																
															case 6:
																mes = "Junio";
																break;
																
															case 7:
																mes = "Julio";
																break;
																
															case 8:
																mes = "Agosto";
																break;
																
															case 9:
																mes = "Septiembre";
																break;
																
															case 10:
																mes = "Octubre";
																break;
																
															case 11:
																mes = "Noviembre";
																break;
																
															case 12:
																mes = "Diciembre";
																break;
																
															default:
																break;
															}
														%>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Mes<span class="required"></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="Fecha" value="<%=mes %>"  type="text" required="required" readonly/>
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Moneda Origen<span class="required"></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="MonedaOrigen" value="<%=tc.getNombreO() %>"  type="text" required="required" readonly/>
												
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Moneda Destino<span class="required"></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="MonedaDestino" value="<%=tc.getNombreC() %>"  type="text" required="required" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Año<span class="required"></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="TipoCambio" value="<%=tc.getAnio() %>"  type="text" required='required' readonly/>
											</div>
										</div>
										
										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button type='submit' name="btn1" class="btn btn-primary">Eliminar</button>
													<a href="tbl_tasaCambioMaestro.jsp" class="btn btn-danger">Cancelar</a>
												</div>
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
				<div class="pull-right">Sistema contable by UCASH</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>

	<!-- Javascript functions	-->
	
	

	<script>
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
	</script>

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- validator -->
	<!-- <script src="../vendors/validator/validator.js"></script> -->

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	
	<!-- jAlert -->
    <script src="../vendors/jAlert/dist/jAlert.min.js"></script>
    <script src="../vendors/jAlert/dist/jAlert-functions.min.js"></script>

</body>
</html>