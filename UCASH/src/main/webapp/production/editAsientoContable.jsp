<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="datos.Dt_moneda, datos.Dt_periodoContable, entidades.Vw_usuariorol, entidades.Tbl_moneda, entidades.Vw_empresa, entidades.Tbl_periodoContable,
	entidades.Vw_rolopciones,entidades.Tbl_asientoContable, entidades.Tbl_tipoDocumento, entidades.Vw_tasaCambioDet, 
	entidades.Vw_catalogo_tipo_cuentacontable, entidades.Vw_asientoContableDet, entidades.Tbl_empresa, entidades.Tbl_cuentaContable, entidades.Vw_catalogocuenta_empresa,
	datos.Dt_rolOpciones, datos.Dt_asientoContable, datos.Dt_tipoDocumento, datos.Dt_tasaCambio, datos.Dt_cuentaContable, datos.Dt_tasacambio_det,
	datos.Dt_asientoContableDet, datos.Dt_catalogocuenta, java.sql.Timestamp, java.util.*, java.text.SimpleDateFormat, 
	java.time.LocalDateTime, java.text.DecimalFormat, java.text.DecimalFormatSymbols, java.time.format.DateTimeFormatter, java.text.DateFormat;"%>

<%
//INVALIDA LA CACHE DEL NAVEGADOR //
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
response.setDateHeader("Expires", -1);

//DECLARACIONES
Tbl_moneda moneda = new Tbl_moneda();
Tbl_periodoContable pContable = new Tbl_periodoContable();
Dt_periodoContable periodoContable = new Dt_periodoContable();
Dt_tasacambio_det tipoCambio  = new Dt_tasacambio_det();
Vw_usuariorol vwur = new Vw_usuariorol();
Dt_moneda dtMoneda = new Dt_moneda();
Dt_rolOpciones dtro = new Dt_rolOpciones();
ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
boolean permiso = false; //VARIABLE DE CONTROL

//Obteniendo fecha y hora actual del sistema 
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
DateFormat df = new SimpleDateFormat("yyyy/MM/dd");

Vw_tasaCambioDet tipoCambioSugerido = new Vw_tasaCambioDet(); 

//OBTENEMOS LA SESION
vwur = (Vw_usuariorol) session.getAttribute("acceso");
if (vwur != null) {
	//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL

	listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

	pContable = periodoContable.obtenerPContablePorId(vwur.getIdPeriodoContable());

	moneda = dtMoneda.getMonedaByID(vwur.getIdMoneda());
	//se obtiene el tipo de cambio sugerido segun el pContable
	String fechaFinPC = dtf.format(pContable.getFechaFinal().toLocalDate());
	tipoCambioSugerido = tipoCambio.ObtenerTasaCambioPorFecha(fechaFinPC);
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

<%
Tbl_asientoContable tpacont = new Tbl_asientoContable();
Dt_asientoContable dtac = new Dt_asientoContable();

int idac = (request.getParameter("ascont") != null) ? Integer.parseInt(request.getParameter("ascont")) : 0;
tpacont = dtac.obtenerAContablePorId(idac);

%>



<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Editar Asiento Contable</title>

<!-- Bootstrap -->
<link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Select2 -->
<link href="../vendors/select2/dist/css/select2.min.css"
	rel="stylesheet" />
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
<!--Jquery Toast Plugin -->
<link href="../vendors/jquery.toast.min.css" rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
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
						<div class="col-md-8">
							<h3>Editar Asiento Contable</h3>
						</div>
						<div class="col-md-4" style="text-align: right;">
							<h2 id="fecha_hora_sistem"></h2>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<form class="" action="../Sl_asientoContable" method="post" novalidate>
								<div class="row">
									<div class="col-md-12 col-sm-12">
										<div class="x_panel">
											<div class="x_title">
												<div class="col-md-12">
													<h2 class="col-md-4">
														Encabezado: Asiento Contable
													</h2>
													<h2 class="col-md-8" style="text-align: right;">
														Periodo Contable [Del:
														<%=pContable.getFechaInicio()%>
														Al:
														<%=pContable.getFechaFinal()%>]
													</h2>	
												</div>
												<div class="clearfix"></div>
											</div>
											<div class="x_content">
												<input type="hidden" value="2" name="opcion" id="opcion" readonly="readonly"/>  
												<input type="hidden" value="0" name="detallesEliminados" id="detallesEliminados", readonly="readonly" />
												<input type="hidden" value="0" name="detalles" id="detalles" readonly="readonly"/>
												<input type="hidden" value="0" name="detallesAgregados" id="detallesAgregados" readonly="readonly"/> 
												<input type="hidden" value="<%=tpacont.getIdAsientoContable()%>" name="idAcont" id="idAcont" readonly="readonly"/>
												<input type="hidden" value="<%=vwur.getIdPeriodoContable() %>" name="periodoContable" id="periodoContable" readonly="readonly"/>
												<input type="hidden" value="<%=Vw_empresa.empresaActual %>" name="empresaActual" id="empresaActual" readonly="readonly"/>
												<input type="hidden" value="<%=vwur.getId_user()%>" name="usuarioModificacion" id="usuarioModificacion" readonly="readonly"/>
												<input type="hidden" value="<%=vwur.getIdMoneda()%>" name="moneda" id="moneda" readonly="readonly"/>
												<div class="field item form-group">
													<label class="col-md-3 label-align" style="font-size: 16px; font-weight: bold;">
														<span class="required">Asiento Contable N°:</span>
													</label>
													<label class="col-md-6" style="font-size: 16px; font-weight: bold;">
														<span class="required">&nbsp;<%=tpacont.getNumeroComprobante()%></span>
													</label>
												</div>
												<div class="field item form-group">
													<label class="col-form-label col-md-3 col-sm-3 label-align">
														Tipo documento: <span class="required">*</span>
													</label>
													<div class="col-md-6 col-sm-6">
														<%
														ArrayList<Tbl_tipoDocumento> listaTD = new ArrayList<Tbl_tipoDocumento>();
														Dt_tipoDocumento dttd = new Dt_tipoDocumento();
														listaTD = dttd.listaTipoDocumento();
														%>
														<select class="form-control js-example-basic-single" name="cbxIDTD" id="cbxIDTD" required="required">
															<option value="">Seleccione...</option>
															<%
															for (Tbl_tipoDocumento td : listaTD) {
															%>
															<option value="<%=td.getIdTipoDocumento()%>"><%=td.getTipo()%></option>
															<%
															}
															%>
														</select>
													</div>
												</div>
	
												<div class="field item form-group">
													<label class="col-form-label col-md-3 col-sm-3  label-align">
														Tipo de cambio: <span class="required">*</span>
													</label>
													<div class="col-md-6 col-sm-6">
														<%
														int valCambio = 0;
														ArrayList<Vw_tasaCambioDet> listaTC = new ArrayList<Vw_tasaCambioDet>();
														Dt_tasaCambio dttc = new Dt_tasaCambio();
														listaTC = dttc.listarTasaCambioDet();
														if(moneda.getIdMoneda()==1){
															valCambio = 1;
															System.out.println("ValCambio: "+valCambio);
														}	
														%>
														<select class="form-control js-example-basic-single"
															name="cbxIDTCD" id="cbxIDTCD" required="required">
															<option value="">Seleccione...</option>
															<% 
															if(valCambio!=0){
															%>
																<option value="<%=valCambio%>"><%=valCambio%></option>
															<%}
															for (Vw_tasaCambioDet tc : listaTC) {
															%>
																<option value="<%=tc.getTipoCambio()%>"><%=tc.getTipoCambio()%></option>
															<%
																}
															%>
														</select>
													</div>
												</div>
	
												<div class="field item form-group">
													<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha:</label>
													<div class="col-md-6 col-sm-6">
														<input type="date" class="form-control" placeholder="Fecha de inicio" 
															name="fechainicioc" min="<%=pContable.getFechaInicio()%>"
															max="<%=pContable.getFechaFinal()%>" value="<%=tpacont.getFecha()%>">
													</div>
												</div>
	
												<div class="field item form-group">
													<label class="col-form-label col-md-3 col-sm-3  label-align"
														for="descripcion">Concepto<span class="required">*</span>
													</label>
													<div class="col-md-6 col-sm-6">
														<textarea class="form-control" rows="3" placeholder="Concepto" 
															id="descripcion" name="descripcion"
															maxlength="150"><%=tpacont.getDescripcion()%>
														</textarea>
														<div id="contador">
															<span id="cantidadCaracteres">0</span>/150
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 col-sm-12">
										<div class="x_panel">
											<div class="x_title">
												<div class="col-md-12">
													<h2>Detalle: Asiento Contable</h2>
												</div>
												<div class="clearfix"></div>
											</div>
											<div class="x_content">
													<div class="field item form-group col-md-4">
														<label class="col-form-label label-align" style="font-size: 16px; font-weight: bold;">
															Cuenta
														</label>
													</div>
													<div class="field item form-group col-md-2" style="font-size: 16px; font-weight: bold;">
														<label class="col-form-label label-align">
															Debe
														</label>
													</div>
													<div class="field item form-group col-md-2" style="font-size: 16px; font-weight: bold;">
														<label class="col-form-label label-align">
															Haber
														</label>
													</div>
													<div class="form-group col-md-4" style="text-align: center; font-size: 16px; font-weight: bold;">
														<label class="col-form-label label-align">
															Opciones
														</label>
													</div>
													<div class="field item form-group col-md-4">
														<%
														ArrayList<Tbl_cuentaContable> listaCC = new ArrayList<Tbl_cuentaContable>();
														Vw_catalogocuenta_empresa CE = new Vw_catalogocuenta_empresa();
														Dt_cuentaContable dtcc = new Dt_cuentaContable();
														Dt_catalogocuenta  dtcac = new Dt_catalogocuenta();
														CE = dtcac.getCatalogoByIdEmpresa(vwur.getIdEmpresa());
														int idCatalogo = 0;
														%>
														<select name="cbxCC" id="cbxCC" class="js-example-basic-single">
															<option value="" disabled selected>Seleccione...</option>
															<%
															idCatalogo = CE.getIdCatalogo();
															listaCC = dtcc.getCuentasContablesByCatalogo(idCatalogo);
															for (Tbl_cuentaContable cc : listaCC) {
															%>
															<option value="<%=cc.getIdCuenta()%>">
																<%=cc.getNumeroCuenta().trim()+"."+cc.getsC().trim()+"."+cc.getSsC().trim()+"."+cc.getSssC().trim()+" "+cc.getNombreCuenta().trim()%>
															</option>
															<%
															}
															%>
														</select>
													</div>
													<div class="field item form-group col-md-2">
														<input type="text" class="form-control text-right" name="debe" id="debe" value="0" min="0" />
													</div>
													<div class="field item form-group col-md-2">
														<input type="text" class="form-control text-right" name="haber" id="haber" value="0" min="0" />
													</div>
													<div class="field item form-group col-md-2">
														<a tabindex="0" id="agregardet" class="btn btn-success" 
															style="color: white; font-size: 16px; font-weight: bold;" 
															title="Agregar registro">&nbsp; [+] Agregar &nbsp;
														</a>
													</div>
													<div class="field item form-group col-md-2">
														<a tabindex="0" id="vaciardet" class="btn btn-warning" 
															style="font-size: 16px; font-weight: bold;" 
															title="Limpia los datos de la tabla">&nbsp; [-] Limpiar &nbsp;
														</a>
													</div>
													<div class="col-md-12">
														<div class="card-box table-responsive">
															<table class="table table-striped jambo_table bulk_action" style="width: 100%" id="tbldet">
																<%
																ArrayList<Vw_asientoContableDet> listaAsientoContable = new ArrayList<Vw_asientoContableDet>();
																Dt_asientoContableDet dtac1 = new Dt_asientoContableDet();
																listaAsientoContable = dtac1.listarasientocontableDET();
																double total = 0;
																double debe = 0;
																double haber = 0;
																%>
																<thead>
																	<tr>
																		<th class="col-md-1 text-center">ID Cta</th>
																		<th class="col-md-6 text-center">Cuenta</th>
																		<th class="col-md-2 text-center">Debe</th>
																		<th class="col-md-2 text-center">Haber</th>
																		<th class="col-md-1 text-center">Opción</th>
																	</tr>
																</thead>
																<tbody>
				
																	<%
																	int detallesSalientes = 1;
																	String patron = "###,###,###.##";
																	DecimalFormat miFormato = new DecimalFormat(patron, DecimalFormatSymbols.getInstance(Locale.US));
																	miFormato.setMinimumFractionDigits(2);
																	for (Vw_asientoContableDet ac : listaAsientoContable) {
																		if (ac.getIdAsientoContable() == idac) {
																	%>
																	<tr id='detail'>
																		<td class="col-md-1">
																			<input type="text" class="form-control" 
																			name="<%="idCuenta"+detallesSalientes%>" 
																			value="<%=ac.getIdCuenta()%>" 
																			readonly="readonly">
																		</td>
																		<td class="col-md-6">
																			<input type="text" class="form-control"
																			value="<%=ac.getNumeroCuenta().trim()+"."+ac.getSC().trim()+"."+ac.getSsC().trim()+"."+ac.getSssC().trim()+" "+ac.getNombreCuenta().trim()%>"
																			readonly="readonly">
																		</td>
																		<td id='tddebe' class="col-md-2">
																			<input type="text" class="form-control text-right"
																			value="<%=miFormato.format(ac.getDebe())%>"
<%-- 																			value="<%=ac.getDebe()%>" --%>
																			name="<%="debe"+detallesSalientes%>"
																			readonly="readonly">
																		</td>
																		<td id="tdhaber" class="col-md-2">
																			<input type="text" class="form-control text-right"
																			value="<%=miFormato.format(ac.getHaber())%>"
<%-- 																			value="<%=ac.getHaber()%>" --%>
																			name="<%="haber"+detallesSalientes%>"
																			readonly="readonly">
																		</td>
																		<td id='agreg' class="col-md-1">
																			<input type="button" id="btnBorrarDetalle" value="Borrar" class="btn btn-danger"/>
																			<input type="text" hidden="hidden" value="<%=ac.getIdAsientoContableDet()%>">
																		</td>
																	</tr>
																	<%
																		total = (total+ac.getDebe())-ac.getHaber();
																		debe += ac.getDebe();
																		haber += ac.getHaber();
																		detallesSalientes++;
																		}
																	}
																	%>
																</tbody>
															</table>
														</div>
													</div>
													<div class="col-md-12">
														<div class="card-box table-responsive">
															<table class="table table-striped jambo_table bulk_action"
																style="width: 100%" id="tblSaldos">
																<thead>
																	<tr>
																		<th class="col-md-1 text-center">&nbsp;</th>
																		<th class="col-md-5 text-center">&nbsp;</th>
																		<th class="col-md-2 text-right">Total Debe</th>
																		<th class="col-md-2 text-right">Total Haber</th>
																		<th class="col-md-2 text-right">Saldo</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td class="col-md-1 text-right">&nbsp;</td>
																		<td class="col-md-5 text-right">&nbsp;</td>
																		<td id="divTotaldebe" class="col-md-2">
																			<p class="text-right" style="font-weight: bold; font-size: 16px">
																				<span id="tdebe"><%=miFormato.format(debe) %></span>
																			</p>
																		</td>
																		<td id="divTotalhaber" class="col-md-2">
																			<p class="text-right" style="font-weight: bold; font-size: 16px">
																				<span id="thaber"><%=miFormato.format(haber) %></span>
																			</p>
																		</td>
																		<td id="divTotal" class="col-md-2">
																			<p class="text-right" style="font-weight: bold; font-size: 16px">
																				<span id="total"><%=miFormato.format(total) %></span>
																			</p>
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-12 text-center">
															<button id="btnGuardar" type='submit' class="btn btn-primary">Guardar</button>
															<a href="tbl_asientoContable.jsp" type="button" class="btn btn-danger">Cancelar</a>
														</div>
													</div>
												</div>
										</div>
									</div>
								</div>
							</form>
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>
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
	<script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="../vendors/jszip/dist/jszip.min.js"></script>
	<script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="../vendors/pdfmake/build/vfs_fonts.js"></script>
	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	<script src="../vendors/jquery.toast.min.js"></script>
	
	<!-- Javascript functions	-->
	<script>
		function hideshow() {
			var password = document.getElementById("password1");
			var slash = document.getElementById("slash");
			var eye = document.getElementById("eye");

			if (password.type === 'password') {
				password.type = "text";
				slash.style.display = "block";
				eye.style.display = "none";
			} else {
				password.type = "password";
				slash.style.display = "none";
				eye.style.display = "block";
			}

		}
	</script>

	<script>
	var data = {
			<%-- id : <%=tipoCambioSugerido.getIdTasaCambioDet()%>,  --%>
			id : <%=tipoCambioSugerido.getTipoCambio()%>, 
			valor : <%=tipoCambioSugerido.getTipoCambio()%>
 	}
	function setVals() {
		$("#cbxIDTD").val("<%=tpacont.getIdTipoDocumento()%>");
		var newOption = new Option(data.id, data.valor, false, false);
		if(<%=valCambio%>==0){
			$("#cbxIDTCD").val(data.id);
		}
		else{
			$("#cbxIDTCD").val(1).change();
		}
	}

		$(document).ready(function() {
			////CARGAMOS LOS VALORES EN LOS CONTROLES 
			setVals();
			
			var botonGuardar = document.getElementById("btnGuardar");

	        botonGuardar.addEventListener('click', (e) => {
	            if(saldo !== 0){
	            	$.toast({
	            	    text: "El saldo debe ser 0 para poder guardar",
	            	    heading: 'Advertencia - saldo',
	            	    icon: 'warning',
	            	    showHideTransition: 'slide',
	            	    allowToastClose: false, 
	            	    hideAfter: 5000,
	            	    stack: 5,
	            	    position: 'top-center',  
	            	    
	            	    textAlign: 'left',
	            	    loader: true,
	            	    loaderBg: '#9EC600',
	            	    
	            	});
	                e.preventDefault();
	            };
	            
	            if($("#detalles").val() == 0){
	            	$.toast({
	            	    text: "Tiene que haber detalles para poder guardar los cambios",
	            	    heading: 'Advertencia - detalles',
	            	    icon: 'warning',
	            	    showHideTransition: 'slide',
	            	    allowToastClose: false, 
	            	    hideAfter: 5000,
	            	    stack: 5,
	            	    position: 'top-center',  
	            	    
	            	    textAlign: 'left',
	            	    loader: true,
	            	    loaderBg: '#9EC600',
	            	    
	            	});
	                e.preventDefault();
	            };
	        });
			
		});
	</script>

	<script>
	var counter = 100000;  
	var dateContainer = document.getElementById("fecha_hora_sistem");
	var today = new Date();
	dateContainer.innerHTML = "Fecha y Hora del Sistema: " + today.getDate() + "/" 
		+ (today.getMonth() + 1) + "/" + today.getFullYear() 
		+ "&nbsp;";
	var temp = dateContainer.innerHTML;
	
	function refreshHour(){
		var todayTime = new Date();
		var time = "";
		var newFormat = (todayTime.getHours()) >= 12 ? 'PM' : 'AM';
		
		dateContainer.innerHTML = "";
		if(counter > 0){
			counter--; 
			time = "&nbsp;" + (todayTime.getHours() < 12 ? "0" + todayTime.getHours() : todayTime.getHours() - 12) + ":" + (todayTime.getMinutes() < 10 ? "0" + todayTime.getMinutes() : todayTime.getMinutes()) + ":" + (todayTime.getSeconds() < 10 ? "0" + todayTime.getSeconds() : todayTime.getSeconds()) +" "+  newFormat;
			dateContainer.innerHTML = temp + time; 
			setTimeout(refreshHour, 1000);
		}else {
			counter = 100000; 
			setTimeout(refreshHour, 1000);
		};
	};
	
	refreshHour();
</script>

	<script>
		//Inicio select2
		$(document).ready(function() {
			$('.js-example-basic-single').select2();
		});
		//Cierre Select2
		var saldo = 0;
		var debe = 0;
		var haber = 0;
		var tdebe = parseFloat($("#tdebe").text());
		var thaber = parseFloat($("#thaber").text());
		var tableBody = document.getElementById("tbldet");
		var rows = getCantRows();
		var deletedRows = 0;
		var addedRows = 0;
		var addedRegistersCounters = [ 0, 0, 0 ];
		var deletedRegServletKeyWords = [];
		
		//funcion para formatear los numeros
    	const formateador = (number) => {
		  const exp = /(\d)(?=(\d{3})+(?!\d))/g;
		  const rep = '$1,';
		  return number.toString().replace(exp,rep);
		}

    	//Boton agregar movimientos del Asiento Contable //elsnergo
    	$("#agregardet").click(function() {
			if (!$.isNumeric($("#debe").val()) || !$.isNumeric($("#haber").val())
					|| $("#cbxCC option:checked").val() == 0) {
					$.toast({
							text : "Datos inválidos", // Text that is to be shown in the toast
							icon : 'warning', // Type of toast icon
							showHideTransition : 'plain', // fade, slide or plain
							allowToastClose : false, // Boolean value true or false
							hideAfter : 5000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
							stack : 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
							position : 'mid-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
							textAlign : 'left', // Text alignment i.e. left, right or center
							loader : true, // Whether to show loader or not. True by default
							loaderBg : '#9EC600', // Background color of the toast loader
							});
				} else {
					var cc = $("#cbxCC").val(); //Obtenemos el Id de la Cuenta //elsnergo
					console.log("cc: "+cc);
					var detCC = $.trim($('select[name="cbxCC"] option:selected').text().toUpperCase());
					console.log("detCC: "+detCC); //Obtenemos el nombre de la Cuenta //elsnergo
					//Agregando un movimiento contable //Tabla Asiento Contable Detalles //elsnergo
					$("#tbldet tbody").append(
							"<tr>"
							+ "<td class='col-md-1'>"
							+ '<input type="text" class="form-control" value="'+cc+'"'
							//+ cc
							+ ' readOnly>'
							+ "</td>"
							+ "<td class='col-md-6'>"
							+ '<input type="text" class="form-control" value="'+detCC+'"'
							//+ detCC
							+ ' readOnly>'
							+ "</td>"
							+ "<td id='tddebe' class='col-md-2'>"
							+ '<input type="text" class="form-control text-right" value='
								+ formateador(($('#debe').val()*$('#cbxIDTCD').val()).toFixed(2))//cordobizamos segun T/C y ajustamos precision decimal a 2 //elsnergo
							//+ ($('#debe').val()*$('#cbxIDTCD').val()).toFixed(2)//cordobizamos segun T/C y ajustamos precision decimal a 2 //elsnergo
							+ ' readOnly>'
							+ "</td>"
							+ "<td id='tdhaber' class='col-md-2'>"
							+ '<input type="text" class="form-control text-right" value='
								+ formateador(($('#haber').val()*$('#cbxIDTCD').val()).toFixed(2))//cordobizamos segun T/C y ajustamos precision decimal a 2 //elsnergo
							//+ ($('#haber').val()*$('#cbxIDTCD').val()).toFixed(2)//cordobizamos segun T/C y ajustamos precision decimal a 2 //elsnergo
							+ ' readOnly>'
							+ "</td>"
							+ "<td class='col-md-1 text-center'>"
							+ '<input type="button" id="btnBorrarDetalle" class="btn btn-danger" value="Borrar" />'
							+ "</td>"
							+ "</tr>");
//								debe = parseFloat($("#debe").val());
							debe = parseFloat(($('#debe').val().replace(",", "")*$('#cbxIDTCD').val()).toFixed(2)); //cordobizamos segun T/C y ajustamos precision decimal a 2 //elsnergo
//								haber = parseFloat($("#haber").val());
							haber = parseFloat(($('#haber').val().replace(",", "")*$('#cbxIDTCD').val()).toFixed(2)); //cordobizamos segun T/C y ajustamos precision decimal a 2 //elsnergo
							saldo = (parseFloat(saldo.replace(",", "")) + parseFloat((debe.replace(",", "") - haber.replace(",", "")))).toFixed(2); //Ajustamos precision decimal a 2 //elsnergo
							tdebe = (parseFloat(tdebe.replace(",", "")) + parseFloat(debe.replace(",", ""))).toFixed(2); //Ajustamos precision decimal a 2 //elsnergo
							thaber = (parseFloat(thaber.replace(",", "")) + parseFloat(haber.replace(",", ""))).toFixed(2); //Ajustamos precision decimal a 2 //elsnergo
							$("#tdebe").text(formateador(tdebe));
							$("#thaber").text(formateador(thaber));
							$("#debe").val(0);
							$("#haber").val(0);
							$("#cbxCC").val("").change();
							if (saldo == 0) {
								$("#divTotal").css({
									"background" : "lightgreen"
								});
							} else if (saldo > 0) {
								$("#divTotal").css({
									"background" : "red" //Ajustamos el color del td del saldo //elsnergo
//										"background" : "lightblue" 
								});
							} else if (saldo < 0) {
								$("#divTotal").css({
									"background" : "red" //Ajustamos el color del td del saldo //elsnergo
//										"background" : "pink"
								});
							}
						}
				$("#total").text(formateador(saldo));
				//Creamos una variable que referencia la tabla Asiento Contable Detalles //elsnergo
				var tableBody = document.getElementById("tbldet");
				var cantDetalles = document.getElementById("detalles");
//					var columns = 5;
				var columns = $("#tbldet tr:last td").length; //obtenemos la cantidad de columnas //elsnergo
				console.log("nColumnas" + columns);
				//El arreglo de columnas comienza en 0
				var columnsName = [ "idCuenta", "cuenta", "debe", "haber", "Opcion" ]; //Asignamos los titulos de columnas //elsnergo
//					var rows = tableBody.childNodes[3].childNodes.length;
//					for (var x = 1; x < columns; x++) {
//						for (var y = 0; y < rows; y++) {
//							tableBody.childNodes[3].childNodes[y+1].childNodes[x].firstElementChild.setAttribute('name', columnsName[x-1]+y);
//						}
//					};
				//El tr en la posicion 0 contiene los titulos de las columnas
				//El tr que contiene datos comienza en la posicion 1 
				var rows = $("#tbldet tr").length; //Obtenemos la cantidad de filas //elsnergo
					for (var y = 1; y < rows; y++) {
							//tabla.fila.columna.input //Asignamos dinamicamente el nombre de cada input //elsnergo
							tableBody.rows[y].cells[0].querySelector("input").setAttribute('name', columnsName[0]+y);
							tableBody.rows[y].cells[2].querySelector("input").setAttribute('name', columnsName[2]+y);
							tableBody.rows[y].cells[3].querySelector("input").setAttribute('name', columnsName[3]+y);
					};
				cantDetalles.value = rows; //Asignamos la cantidad de filas y/o detalles a registrar //elsnergo
				//console.log(tableBody.childNodes[3]);
				console.log("nFilas" + rows);
				$("#cbxCC").focus(); //Fijamos el cursor en el combobox que contiene las Cuentas Contables //elsnergo
		});
		
    	//Botón para eliminar cada fila contenida en la Tabla Asiento Contable Detalles
		$("#tbldet").on('click', '#btnBorrarDetalle', function() {
			//Creamos una variable que referencia la tabla Asiento Contable Detalles //elsnergo
			var tableBody = document.getElementById("tbldet");
			var cantDetalles = document.getElementById("detalles");
			//obtenemos los valores del registro actual de la tabla
			//var currentRow = $(this).closest("tr");
			//debe = parseFloat(currentRow.find("#tddebe").children().val());
			//console.log("tddebe: "+debe);
			//haber = parseFloat(currentRow.find("#tdhaber").children().val());
			//console.log("tdhaber: "+haber);
			$(this).parent().parent().remove();
			//recorremos las filas de la tabla y obtenemos valores totales
			var columns = $("#tbldet tr:last td").length; //obtenemos la cantidad de columnas //elsnergo
			console.log("nColumnas "+columns);
			var rows = $("#tbldet tr").length; //Obtenemos la cantidad de filas //elsnergo
			console.log("nFilas " +rows);
			var totalDebe = 0;
			var debeNew = 0
			var totalHaber = 0;
			var haberNew = 0;
			var saldoNew = 0;
			for (var y = 1; y < rows; y++) {
				//obtenemos el valor de los debe //elsnergo
				console.log("input debe"+y+": "+tableBody.rows[y].cells[2].querySelector('input').value);
				debeNew = tableBody.rows[y].cells[2].querySelector('input').value;
				console.log("debeNew: "+debeNew);
				//totalDebe = totalDebe + Number.parseFloat(tableBody.rows[y].cells[2].querySelector('input').value);
				totalDebe += Number.parseFloat(debeNew.replace(/,/g, ''));
				console.log("totalDebe: "+totalDebe);
				//obtenemos el valor de los haber //elsnergo
				console.log("input haber"+y+": "+tableBody.rows[y].cells[3].querySelector('input[name="haber'+y+'"]').value);
				haberNew = tableBody.rows[y].cells[3].querySelector('input[name="haber'+y+'"]').value;
				console.log("haberNew: "+haberNew);
//					totalHaber = totalHaber + Number.parseFloat(tableBody.rows[y].cells[3].querySelector('input[name="haber'+y+'"]').value);
				totalHaber += Number.parseFloat(haberNew.replace(/,/g, ''));
				console.log("totalHaber: "+totalHaber);
			};
			//saldo = (tdebe - thaber).toFixed(2);
			saldoNew = (totalDebe - totalHaber);
			console.log("saldo: "+saldoNew);
			$("#tdebe").text(formateador(totalDebe.toFixed(2)));
			$("#thaber").text(formateador(totalHaber.toFixed(2)));
			$("#total").text(formateador(saldoNew.toFixed(2)));
			if (saldoNew == 0) {
				$("#divTotal").css({
					"background" : "lightgreen"
				});
			} else if (saldoNew > 0) {
				$("#divTotal").css({
					"background" : "red" //Ajustamos el color del td del saldo //elsnergo
//						"background" : "lightblue" 
				});
			} else if (saldoNew < 0) {
				$("#divTotal").css({
					"background" : "red" //Ajustamos el color del td del saldo //elsnergo
//						"background" : "pink"
				});
			}
			
			//Restamos la fila eliminada a la cantidad de filas del detalle a registrar //elsnergo
            //var rows = tableBody.childNodes[3].childNodes.length - 1;
            var cantDetalles = document.getElementById("detalles");
          	//Asignamos la cantidad de filas y/o detalles a registrar //elsnergo
            cantDetalles.setAttribute('value', ""+rows+"");
		});
		
		//Botón para eliminar todas las filas del detalle a registrar //elsnergo
		$("#vaciardet").click(function() {
			saldo = 0;
			tdebe = 0;
			thaber = 0;
			$("#cbxCC").val("").change();
			$("#tdebe").text(tdebe);
			$("#thaber").text(thaber);
			$("#tbldet tbody tr").remove();
			$("#total").text(saldo);
			if (saldo == 0) {
				$("#divTotal").css({
					"background" : "lightgreen"
				});
			} else if (saldo > 0) {
				$("#divTotal").css({
					"background" : "red" //Ajustamos el color del td del saldo //elsnergo
//						"background" : "lightblue" 
				});
			} else if (saldo < 0) {
				$("#divTotal").css({
					"background" : "red" //Ajustamos el color del td del saldo //elsnergo
//						"background" : "pink"
				});
			}
			var cantDetalles = document.getElementById("detalles");
			//Asignamos la cantidad de filas y/o detalles a registrar //elsnergo
            cantDetalles.setAttribute('value', "0");
			
		});

		function deletedRowsNameMapper() { 
			var columns = 0;
			var idCeldaAgregado = "agreg";
			var idRegistro = "";
			var cantDetallesEliminados = document.getElementById("detallesEliminados");
			var cantDetallesAgregados = document.getElementById("detallesAgregados");
			var detallesAbortados = 0;

			for (var x = 0; x < tableBody.childNodes[3].childNodes.length; x++) {
				if (tableBody.childNodes[3].childNodes[x].tagName == "TR" && !tableBody.childNodes[3].childNodes[x].classList.contains("addedAndConfigured")) {
					if (tableBody.childNodes[3].childNodes[x].style.display == "none" && !tableBody.childNodes[3].childNodes[x].classList.contains("abortedReg")) {
						columns = tableBody.childNodes[3].childNodes[x].childNodes.length;
						for (var y = 0; y < columns; y++) {
							if (tableBody.childNodes[3].childNodes[x].childNodes[y].tagName == "TD" && tableBody.childNodes[3].childNodes[x].childNodes[y].id == idCeldaAgregado) {
								if (!tableBody.childNodes[3].childNodes[x].childNodes[y].classList.contains("deleted")) {
									tableBody.childNodes[3].childNodes[x].childNodes[y].classList.add("deleted");
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.setAttribute('name', "detalleEliminado" + deletedRows);
									deletedRows++;
									cantDetallesEliminados.setAttribute('value', deletedRows);
								};
							};
						};
					};
				} else if (tableBody.childNodes[3].childNodes[x].tagName == "TR" && tableBody.childNodes[3].childNodes[x].classList.contains("addedAndConfigured")) {
					if (tableBody.childNodes[3].childNodes[x].style.display == "none") {
						tableBody.childNodes[3].childNodes[x].classList.remove("addedAndConfigured")
						tableBody.childNodes[3].childNodes[x].classList.add("abortedReg")
						detallesAbortados++;
						addedRows--;
						cantDetallesAgregados.setAttribute('value', parseInt(cantDetallesAgregados.value) - detallesAbortados);
						columns = tableBody.childNodes[3].childNodes[x].childNodes.length;
						for (var y = 0; y < columns; y++) {
							if (tableBody.childNodes[3].childNodes[x].childNodes[y].tagName == "TD") {
								switch (tableBody.childNodes[3].childNodes[x].childNodes[y].id) {
								case "idCuenta":
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.removeAttribute('name');
									addedRegistersCounters[0]--;
									break;
								case "tddebe":
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.removeAttribute('name');
									addedRegistersCounters[1]--;
									break;
								case "tdhaber":
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.removeAttribute('name');
									addedRegistersCounters[2]--;
									break;
								};
							};
						};
					};
				};
			};
		};

		function addedRowsNameMapper() {
			var columns = 0;
			var idCeldaAgregado = "agreg";
			var idRegistro = "";
			var cantDetallesAgregados = document.getElementById("detallesAgregados");

			for (var x = 0; x < tableBody.childNodes[3].childNodes.length; x++) {
				if (tableBody.childNodes[3].childNodes[x].tagName == "TR") {
					if (tableBody.childNodes[3].childNodes[x].classList.contains("added")) {
						tableBody.childNodes[3].childNodes[x].classList.remove("added");
						tableBody.childNodes[3].childNodes[x].classList.add("addedAndConfigured");
						addedRows++;
						cantDetallesAgregados.setAttribute('value', addedRows);
						columns = tableBody.childNodes[3].childNodes[x].childNodes.length;
						for (var y = 0; y < columns; y++) {
							if (tableBody.childNodes[3].childNodes[x].childNodes[y].tagName == "TD") {
								switch (tableBody.childNodes[3].childNodes[x].childNodes[y].id) {
								case "idCuenta":
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.setAttribute('name',"idCuenta" + (addedRegistersCounters[0]));
									addedRegistersCounters[0]++;
									break;
								case "tddebe":
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.setAttribute('name',"debe" + (addedRegistersCounters[1]));
									addedRegistersCounters[1]++;
									break;
								case "tdhaber":
									tableBody.childNodes[3].childNodes[x].childNodes[y].firstElementChild.setAttribute('name',"haber" + (addedRegistersCounters[2]));
									addedRegistersCounters[2]++;
									break;
								};
							};
						};
					};
				};
			};
		};

		function getCantRows() {
			var rowsCant = 0;
			for (var x = 0; x < tableBody.childNodes[3].childNodes.length; x++) {
				if (tableBody.childNodes[3].childNodes[x].tagName == "TR" && tableBody.childNodes[3].childNodes[x].style.display != "none") {
					rowsCant++;
				};
			}
			return rowsCant;
		};
	</script>

	<script>
		$('document').ready(function() {

							document.getElementById('cantidadCaracteres').innerHTML = document.getElementById('descripcion').value.length;

							const mensaje = document.getElementById('descripcion');
							const contador = document.getElementById('cantidadCaracteres');
							saldo = <%=total%>;
							debe = <%=debe%>;
							haber = <%=haber%>;
		if (saldo == 0) {
								$("#divTotal").css({"background" : "lightgreen"});
							} else if (saldo > 0) {
								$("#divTotal").css({"background" : "lightblue"});
							} else if (saldo < 0) {
								$("#divTotal").css({"background" : "pink"});
							}

							mensaje.addEventListener('input', function(e) {
								const target = e.target;
								const longitudMax = target.getAttribute('maxlength');
								const longitudAct = target.value.length;
								contador.innerHTML = longitudAct;
							});
						});
		$("#detalles").val(<%=detallesSalientes%>);
	</script>
	<script src="../vendors/select2/dist/js/select2.min.js"></script>
</body>
</html>