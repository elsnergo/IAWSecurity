<%@page import="datos.Dt_catalogocuenta"%>
<%@page import="entidades.Tbl_cuentaContable"%>
<%@page import="entidades.Vw_catalogocuenta_empresa"%>
<%@page import="datos.Dt_periodoContable"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="datos.*, entidades.*, entidades.Tbl_moneda, entidades.Vw_empresa, entidades.Tbl_periodoContable,
	entidades.Vw_rolopciones,entidades.Tbl_asientoContable, entidades.Tbl_tipoDocumento, entidades.Vw_tasaCambioDet,
	entidades.Vw_catalogo_tipo_cuentacontable, entidades.Vw_asientoContableDet, entidades.Tbl_empresa,
	datos.Dt_rolOpciones, datos.Dt_asientoContable, datos.Dt_tipoDocumento, datos.Dt_tasaCambio, datos.Dt_cuentaContable,
	datos.Dt_asientoContableDet, datos.Dt_tasacambio_det, java.sql.Timestamp, java.util.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter,
	java.text.SimpleDateFormat,
	java.sql.Date,
	java.text.DateFormat;"%>

<%
// Placeholder para el mensaje
String codigoMensaje = "";

if (request.getParameter("msj") != null)
	codigoMensaje = request.getParameter("msj");

//Obteniendo fecha y hora actual del sistema 

//INVALIDA LA CACHE DEL NAVEGADOR //
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
response.setDateHeader("Expires", -1);

//DECLARACIONES
Tbl_moneda moneda = new Tbl_moneda();
Tbl_periodoContable pContable = new Tbl_periodoContable();
Dt_periodoContable periodoContable = new Dt_periodoContable();
Dt_tasacambio_det tipoCambio = new Dt_tasacambio_det();
Vw_usuariorol vwur = new Vw_usuariorol();
Dt_rolOpciones dtro = new Dt_rolOpciones();
Dt_moneda dtMoneda = new Dt_moneda();
Dt_asientoContable asientoContable = new Dt_asientoContable();
ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
ArrayList<Integer> cuentas = new ArrayList<Integer>();
boolean permiso = false; //VARIABLE DE CONTROL
int numeroComprobante = 0;
Vw_tasaCambioDet tipoCambioSugerido = new Vw_tasaCambioDet();

DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
DateFormat df = new SimpleDateFormat("yyyy/MM/dd");

String fechaActual = dtf.format(LocalDateTime.now());
tipoCambioSugerido = tipoCambio.ObtenerTasaCambioPorFecha(fechaActual);

// Comparación de la fecha actual del sistema con la que regresa el método ObtenerTasaCambioPorFecha
String fechaDelCambioSugerido = df.format(tipoCambioSugerido.getFecha());

boolean fechaIgual = (fechaActual.equals(fechaDelCambioSugerido)) ? true : false;

//OBTENEMOS LA SESION
vwur = (Vw_usuariorol) session.getAttribute("acceso");
if (vwur != null) {
	//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL

	listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

	pContable = periodoContable.obtenerPContablePorId(vwur.getIdPeriodoContable());

	moneda = dtMoneda.getMonedaByID(vwur.getIdMoneda());

	numeroComprobante = asientoContable.comprobarNumeroComprobanteAC(vwur.getIdPeriodoContable());
	//RECUPERAMOS LA URL = MI OPCION ACTUAL
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index + 1);

	//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
	for (Vw_rolopciones vrop : listOpc) {
		if (vrop.getOpciones().trim().equals(miPagina.trim())) {
	permiso = true; //ACCESO CONCEDIDO
	break;
		}
	}
} else {
	response.sendRedirect("../login.jsp?msj=401");
	return;
}

if (!permiso) {
	// response.sendRedirect("../login.jsp?msj=401");
	response.sendRedirect("page_403.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Balance General</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- Datatables -->

<link
	href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">

<!--Jquery Toast Plugin -->
<link href="../vendors/jquery.toast.min.css" rel="stylesheet">

<!-- Select2 -->
<link href="../vendors/select2/dist/css/select2.min.css"
	rel="stylesheet" />

</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Balance General</h3>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_content">
									<form class="" action="../Sl_rptBalanceGeneral" method="post"
										data-parsley-validate>
										<input type="hidden" value="1" name="opcion" id="opcion" /> <input
											type="hidden" value="0" name="detalles" id="detalles" /> <input
											type="hidden" value="<%=vwur.getIdPeriodoContable()%>"
											name="periodoContable" id="periodoContable" /> <input
											name="idEmpresa" id="idEmpresa" type="hidden"
											value="<%=vwur.getIdEmpresa()%>" name="empresaActual"
											id="empresaActual" /> <input type="hidden"
											value="<%=vwur.getId_user()%>" name="usuarioCreacion"
											id="usuarioCreacion" /> <input type="hidden"
											value="<%=moneda.getIdMoneda()%>" name="moneda" id="moneda" />



										<div>
													<div class="col-md-12 col-sm-12">
														<%
														ArrayList<HistoricoSaldos> historial = new ArrayList<HistoricoSaldos>();
														Dt_historicoSaldos historialFechas = new Dt_historicoSaldos();
														historial = historialFechas.ObtenerHistoricoFechas(vwur.getIdEmpresa());
														%>
														<select class="form-control js-example-basic-single" name="fecha_historico" id="fecha_historico" required="required">
															<option value="" disabled selected>Seleccione una fecha.</option>
															<%
															for (int x = 0; x < historial.size(); x++) {
																try {
																	
															%>
															<option value="<%=historial.get(x).getIdHistorico()%>"><%=historial.get(x).getFecha() + " - " + historial.get(x+1).getFecha()%></option>
															<%
																} catch(Exception ex){
																	%>
																	<option value="<%=historial.get(x).getIdHistorico()%>"><%=historial.get(x).getFecha()%></option>
																	<%
																}
															}
															%>
														</select>
													</div>
												</div>
										<div class="ActivoCirculante">

											<div>
												<div class="col-md-12 col-sm-12">
													<%
													ArrayList<Vw_catalogo_tipo_cuentacontable> listaCuentasAC = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
													Dt_cuentaContable dtCuentaAC = new Dt_cuentaContable();
													listaCuentasAC = dtCuentaAC.getCuentaContableByIdEmpresaActivos(vwur.getIdEmpresa());
													%>
													<select class="form-control js-example-basic-single"
														name="cuenta_contable_AC" id="cuenta_contable_AC"
														required="required">
														<option value="" disabled selected>Seleccione
															cuenta para activo circulante...</option>
														<%
														for (Vw_catalogo_tipo_cuentacontable cuenta : listaCuentasAC) {
														%>
														<option value="<%=cuenta.getIdCuenta()%>"><%=cuenta.getNombreCuenta()%></option>
														<%
														}
														%>
													</select>
												</div>
											</div>

											<div class="col-md-12">
												<div class="card-box table-responsive">
													<div class="text-muted font-13 col-md-12"
														style="text-align: right;"></div>
													<input type="hidden" value="" name="AC_Total" id="AC_Total" />
													<table class="table table-striped jambo_table bulk_action"
														style="width: 100%" id="tbldetAC">
														<thead>
															<tr>
																<th>Opción</th>
																<th>ID Cuenta</th>
																<th>Nombre cuenta</th>
															</tr>
														</thead>

														<tbody>

														</tbody>

													</table>
												</div>
											</div>
											<div class="ln_solid">
												<div class="form-group">
													<div class="col-md-6">
														<button id="btnAgregarActivoCirculante" type='button'
															class="btn btn-primary">Agregar</button>
													</div>
												</div>
											</div>

										</div>

										<div class="ActivoFijo">

											<div>
												<div class="col-md-12 col-sm-12">
													<%
													ArrayList<Vw_catalogo_tipo_cuentacontable> listaCuentasAF = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
													Dt_cuentaContable dtCuentaAF = new Dt_cuentaContable();
													listaCuentasAF = dtCuentaAF.getCuentaContableByIdEmpresaActivos(vwur.getIdEmpresa());
													%>
													<select class="form-control js-example-basic-single"
														name="cuenta_contable_AF" id="cuenta_contable_AF"
														required="required">
														<option value="" disabled selected>Seleccione
															cuenta para activo fijo...</option>
														<%
														for (Vw_catalogo_tipo_cuentacontable cuenta : listaCuentasAF) {
														%>
														<option value="<%=cuenta.getIdCuenta()%>"><%=cuenta.getNombreCuenta()%></option>
														<%
														}
														%>
													</select>
												</div>
											</div>

											<div class="col-md-12">
												<div class="card-box table-responsive">
													<div class="text-muted font-13 col-md-12"
														style="text-align: right;"></div>
													<input type="hidden" value="" name="AF_Total" id="AF_Total" />
													<table class="table table-striped jambo_table bulk_action"
														style="width: 100%" id="tbldetAF">
														<thead>
															<tr>
																<th>Opción</th>
																<th>ID Cuenta</th>
																<th>Nombre cuenta</th>
															</tr>
														</thead>

														<tbody>

														</tbody>

													</table>
												</div>
											</div>
											<div class="ln_solid">
												<div class="form-group">
													<div class="col-md-6">
														<button id="btnAgregarActivoFijo" type='button'
															class="btn btn-primary">Agregar</button>
													</div>
												</div>
											</div>

										</div>

										<div class="ActivoDiferido">

											<div>
												<div class="col-md-12 col-sm-12">
													<%
													ArrayList<Vw_catalogo_tipo_cuentacontable> listaCuentasAD = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
													Dt_cuentaContable dtCuentaAD = new Dt_cuentaContable();
													listaCuentasAD = dtCuentaAD.getCuentaContableByIdEmpresaActivos(vwur.getIdEmpresa());
													%>
													<select class="form-control js-example-basic-single"
														name="cuenta_contable_AD" id="cuenta_contable_AD"
														required="required">
														<option value="" disabled selected>Seleccione
															cuenta para activo diferido...</option>
														<%
														for (Vw_catalogo_tipo_cuentacontable cuenta : listaCuentasAD) {
														%>
														<option value="<%=cuenta.getIdCuenta()%>"><%=cuenta.getNombreCuenta()%></option>
														<%
														}
														%>
													</select>
												</div>
											</div>

											<div class="col-md-12">
												<div class="card-box table-responsive">
													<div class="text-muted font-13 col-md-12"
														style="text-align: right;"></div>
													<input type="hidden" value="" name="AD_Total" id="AD_Total" />
													<table class="table table-striped jambo_table bulk_action"
														style="width: 100%" id="tbldetAD">
														<thead>
															<tr>
																<th>Opción</th>
																<th>ID Cuenta</th>
																<th>Nombre cuenta</th>
															</tr>
														</thead>

														<tbody>

														</tbody>

													</table>
												</div>
											</div>
											<div class="ln_solid">
												<div class="form-group">
													<div class="col-md-6">
														<button id="btnAgregarActivoDiferido" type='button'
															class="btn btn-primary">Agregar</button>
													</div>
												</div>
											</div>

										</div>

										<div class="PasivoCirculante">

											<div>
												<div class="col-md-12 col-sm-12">
													<%
													ArrayList<Vw_catalogo_tipo_cuentacontable> listaCuentasPC = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
													Dt_cuentaContable dtCuentaPC = new Dt_cuentaContable();
													listaCuentasPC = dtCuentaPC.getCuentaContableByIdEmpresaPasivos(vwur.getIdEmpresa());
													%>
													<select class="form-control js-example-basic-single"
														name="cuenta_contable_PC" id="cuenta_contable_PC"
														required="required">
														<option value="" disabled selected>Seleccione
															cuenta para pasivo circulante...</option>
														<%
														for (Vw_catalogo_tipo_cuentacontable cuenta : listaCuentasPC) {
														%>
														<option value="<%=cuenta.getIdCuenta()%>"><%=cuenta.getNombreCuenta()%></option>
														<%
														}
														%>
													</select>
												</div>
											</div>

											<div class="col-md-12">
												<div class="card-box table-responsive">
													<div class="text-muted font-13 col-md-12"
														style="text-align: right;"></div>
													<input type="hidden" value="" name="PC_Total" id="PC_Total" />
													<table class="table table-striped jambo_table bulk_action"
														style="width: 100%" id="tbldetPC">
														<thead>
															<tr>
																<th>Opción</th>
																<th>ID Cuenta</th>
																<th>Nombre cuenta</th>
															</tr>
														</thead>

														<tbody>

														</tbody>

													</table>
												</div>
											</div>
											<div class="ln_solid">
												<div class="form-group">
													<div class="col-md-6">
														<button id="btnAgregarPasivoCirculante" type='button'
															class="btn btn-primary">Agregar</button>
													</div>
												</div>
											</div>

										</div>


										<div class="CapitalNeto">

											<div>
												<div class="col-md-12 col-sm-12">
													<%
													ArrayList<Vw_catalogo_tipo_cuentacontable> listaCuentasCN = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
													Dt_cuentaContable dtCuentaCN = new Dt_cuentaContable();
													listaCuentasCN = dtCuentaCN.getCuentaContableByIdEmpresaCapital(vwur.getIdEmpresa());
													%>
													<select class="form-control js-example-basic-single"
														name="cuenta_contable_CN" id="cuenta_contable_CN"
														required="required">
														<option value="" disabled selected>Seleccione
															cuenta para capital neto...</option>
														<%
														for (Vw_catalogo_tipo_cuentacontable cuenta : listaCuentasCN) {
														%>
														<option value="<%=cuenta.getIdCuenta()%>"><%=cuenta.getNombreCuenta()%></option>
														<%
														}
														%>
													</select>
												</div>
											</div>

											<div class="col-md-12">
												<div class="card-box table-responsive">
													<div class="text-muted font-13 col-md-12"
														style="text-align: right;"></div>
													<input type="hidden" value="" name="CN_Total" id="CN_Total" />
													<table class="table table-striped jambo_table bulk_action"
														style="width: 100%" id="tbldetCN">
														<thead>
															<tr>
																<th>Opción</th>
																<th>ID Cuenta</th>
																<th>Nombre cuenta</th>
															</tr>
														</thead>

														<tbody>

														</tbody>

													</table>
												</div>
											</div>
											<div class="ln_solid">
												<div class="form-group">
													<div class="col-md-6">
														<button id="btnAgregarCapitalNeto" type='button'
															class="btn btn-primary">Agregar</button>
													</div>
												</div>
											</div>

										</div>



										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button id="btnGuardarTodo" type='submit'
														class="btn btn-danger">Guardar todo</button>
													<a href="tbl_asientoContable.jsp" type="button"
														class="btn btn-primary">Cancelar</a>
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
		</div>
	</div>
	<!-- /page content -->
	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- bootstrap-progressbar -->
	<script
		src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
	<!-- iCheck -->
	<script src="../vendors/iCheck/icheck.min.js"></script>
	<!-- bootstrap-daterangepicker -->
	<script src="../vendors/moment/min/moment.min.js"></script>
	<script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- bootstrap-wysiwyg -->
	<script src="../vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
	<script src="../vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
	<script src="../vendors/google-code-prettify/src/prettify.js"></script>
	<!-- jQuery Tags Input -->
	<script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
	<!-- Switchery -->
	<script src="../vendors/switchery/dist/switchery.min.js"></script>
	<!-- Select2 -->
	<script src="../vendors/select2/dist/js/select2.full.min.js"></script>
	<!-- Parsley -->
	<script src="../vendors/parsleyjs/dist/parsley.min.js"></script>
	<!-- Autosize -->
	<script src="../vendors/autosize/dist/autosize.min.js"></script>
	<!-- jQuery autocomplete -->
	<script
		src="../vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
	<!-- starrr -->
	<script src="../vendors/starrr/dist/starrr.js"></script>
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

	<script src="../vendors/jquery.toast.min.js"></script>

	<script>
		var button = document.getElementById("btnAgregarActivoCirculante");
		var cuenta = document.getElementById("cuenta_contable_AC");
		
		$(document).ready(function() {
			$('.js-example-basic-single').select2();
		});
		
		button.addEventListener("click", () => {
			localStorage.setItem('nombreCuenta', ""+$("#cuenta_contable_AC").select2('val')+"");
		});
	</script>

	<script>
	var contadorAC = 0; 
	var activoCirculanteTotal = document.getElementById("AC_Total");
		$("#btnAgregarActivoCirculante").click(
			function(){
				contadorAC++; 
				$("#tbldetAC tbody")
				.append(
						"<tr>"
								+ "<td>"
								+ '<input type="button" id="btnBorrarDetalleAC" value="Borrar" />'
								+ "</td>"
								+ "<td>"
								+ '<input type="text"  id="AC'+contadorAC+'" name="AC'+contadorAC+'" class="form-control col-sm-3" value='
								+ $("#cuenta_contable_AC").val()
								+ ' readOnly>'
								+ "</td>"
								+ "<td>"
								+ '<input type="text" class="form-control col-sm-6" value='
								+ $('#cuenta_contable_AC option:selected').text()
								+ ' readOnly>'
								+ "</td>");	
				activoCirculanteTotal.value = contadorAC; 
			}	
		);
		
		$("#tbldetAC").on('click', '#btnBorrarDetalleAC', function() {
			var currentRow = $(this).closest("tr");
			$(this).parent().parent().remove();
		});
		
		
		
		var contadorAF = 0; 
		var activoFijoTotal = document.getElementById("AF_Total");
			$("#btnAgregarActivoFijo").click(
				function(){
					contadorAF++; 
					$("#tbldetAF tbody")
					.append(
							"<tr>"
									+ "<td>"
									+ '<input type="button" id="btnBorrarDetalleAF" value="Borrar" />'
									+ "</td>"
									+ "<td>"
									+ '<input type="text"  id="AF'+contadorAF+'" name="AF'+contadorAF+'" class="form-control col-sm-3" value='
									+ $("#cuenta_contable_AF").val()
									+ ' readOnly>'
									+ "</td>"
									+ "<td>"
									+ '<input type="text" class="form-control col-sm-6" value='
									+ $('#cuenta_contable_AF option:selected').text()
									+ ' readOnly>'
									+ "</td>");	
					activoFijoTotal.value = contadorAF; 
				}	
			);
			
			$("#tbldetAF").on('click', '#btnBorrarDetalleAF', function() {
				var currentRow = $(this).closest("tr");
				$(this).parent().parent().remove();
			});
			
			
			var contadorAD = 0; 
			var activoDiferidoTotal = document.getElementById("AD_Total");
				$("#btnAgregarActivoDiferido").click(
					function(){
						contadorAD++; 
						$("#tbldetAD tbody")
						.append(
								"<tr>"
										+ "<td>"
										+ '<input type="button" id="btnBorrarDetalleAD" value="Borrar" />'
										+ "</td>"
										+ "<td>"
										+ '<input type="text"  id="AD'+contadorAD+'" name="AD'+contadorAD+'" class="form-control col-sm-3" value='
										+ $("#cuenta_contable_AD").val()
										+ ' readOnly>'
										+ "</td>"
										+ "<td>"
										+ '<input type="text" class="form-control col-sm-6" value='
										+ $('#cuenta_contable_AD option:selected').text()
										+ ' readOnly>'
										+ "</td>");	
						activoDiferidoTotal.value = contadorAD; 
					}	
				);
				
				$("#tbldetAD").on('click', '#btnBorrarDetalleAD', function() {
					var currentRow = $(this).closest("tr");
					$(this).parent().parent().remove();
				});
				
				
				var contadorPC = 0; 
				var pasivoCirculanteTotal = document.getElementById("PC_Total");
					$("#btnAgregarPasivoCirculante").click(
						function(){
							contadorPC++; 
							$("#tbldetPC tbody")
							.append(
									"<tr>"
											+ "<td>"
											+ '<input type="button" id="btnBorrarDetallePC" value="Borrar" />'
											+ "</td>"
											+ "<td>"
											+ '<input type="text"  id="PC'+contadorPC+'" name="PC'+contadorPC+'" class="form-control col-sm-3" value='
											+ $("#cuenta_contable_PC").val()
											+ ' readOnly>'
											+ "</td>"
											+ "<td>"
											+ '<input type="text" class="form-control col-sm-6" value='
											+ $('#cuenta_contable_PC option:selected').text()
											+ ' readOnly>'
											+ "</td>");	
							pasivoCirculanteTotal.value = contadorPC; 
						}	
					);
					
					$("#tbldetPC").on('click', '#btnBorrarDetallePC', function() {
						var currentRow = $(this).closest("tr");
						$(this).parent().parent().remove();
					});
					
					
					
					var contadorCN = 0; 
					var capitalNetoTotal = document.getElementById("CN_Total");
						$("#btnAgregarCapitalNeto").click(
							function(){
								contadorCN++; 
								$("#tbldetCN tbody")
								.append(
										"<tr>"
												+ "<td>"
												+ '<input type="button" id="btnBorrarDetalleCN" value="Borrar" />'
												+ "</td>"
												+ "<td>"
												+ '<input type="text"  id="CN'+contadorCN+'" name="CN'+contadorCN+'" class="form-control col-sm-3" value='
												+ $("#cuenta_contable_CN").val()
												+ ' readOnly>'
												+ "</td>"
												+ "<td>"
												+ '<input type="text" class="form-control col-sm-6" value='
												+ $('#cuenta_contable_CN option:selected').text()
												+ ' readOnly>'
												+ "</td>");	
								capitalNetoTotal.value = contadorCN; 
							}	
						);
						
						$("#tbldetCN").on('click', '#btnBorrarDetalleCN', function() {
							var currentRow = $(this).closest("tr");
							$(this).parent().parent().remove();
						});
	</script>

	<script src="../vendors/select2/dist/js/select2.min.js"></script>


</body>
</html>