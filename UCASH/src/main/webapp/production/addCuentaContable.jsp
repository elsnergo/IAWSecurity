<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="entidades.*,datos.*, java.util.*;"%>


<%
//INVALIDA LA CACHE DEL NAVEGADOR //
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
response.setDateHeader("Expires", -1);

//DECLARACIONES
Vw_usuariorol vwur = new Vw_usuariorol();
Dt_rolOpciones dtro = new Dt_rolOpciones();
ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
boolean permiso = false; //VARIABLE DE CONTROL

//OBTENEMOS LA SESION
String msjError = "";
vwur = (Vw_usuariorol) session.getAttribute("acceso");
msjError = (String) session.getAttribute("error");
msjError = msjError==null?" ":msjError;
HttpSession https = request.getSession(false);
https.removeAttribute("error");
//https.invalidate();

if (vwur != null) {
	//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL

	listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

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
	response.sendRedirect("page_403.jsp");
	//response.sendRedirect("page_403.jsp");
	return;
}
%>

<%
String CCD = "";
Vw_cuentacontable_cuentacontable_det vwCCD = new Vw_cuentacontable_cuentacontable_det();
Dt_cuentaContable_Det dtCCD = new Dt_cuentaContable_Det();

String Ccd = "";
Tbl_cuentaContable_Det ccd = new Tbl_cuentaContable_Det();

int idCCD = request.getParameter("idCD") != null ? Integer.parseInt(request.getParameter("idCD")) : 0;
vwCCD = dtCCD.getCCDbyID(idCCD);

Vw_catalogocuenta_empresa Cata = new Vw_catalogocuenta_empresa();
Dt_catalogocuenta dtcata = new Dt_catalogocuenta();

Cata = dtcata.getCatalogoByIdEmpresa(vwur.getIdEmpresa());
%>

<!DOCTYPE html>
<html lang="en">

<head>

<style>
.select[readonly] option, select[readonly] optgroup {
	display: none;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Agregar | Cuenta Contable</title>

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
							<h3>Agregar Cuenta Contable</h3>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">

									<div class="clearfix"></div>
								</div>

								<div class="x_content">
									<form class="" action="../Sl_cuentaContable" method="post" novalidate>
										<input type="hidden" value="<%=vwur.getIdEmpresa()%>" name="empresaActual" id="empresaActual" /> 
										<input type="hidden" value="<%=vwur.getIdPeriodoContable()%>" name="periodoContable" id="periodoContable" /> 
										<input type="hidden" value="1" name="opcion" id="opcion" /> 
										<span class="section">Datos de Cuenta Contable</span>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												Cuenta
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional'
													id="numeroCuenta" name="numeroCuenta" type="number"
													class="required" required="required" title="Cuenta Contable"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												SCta
												<span class="required"> *</span></label>
											<div class="col-md-6 col-sm-6">
												<input type="number" class="form-control" id="SC" name="SC"
													class="required" required="required"
													title="Sub-Cuenta" value="0"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												SSCta
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="number" class="form-control" id="SsC"
													name="SsC" class="required" required="required"
													title="Sub-Sub-Cuenta" value="0"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">
												SSSCta
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="number" class="form-control" id="SssC"
													name="SssC" class="required" required="required"
													title="Sub-Sub-Sub-Cuenta" value="0"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												Nombre Cuenta
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="text" class="form-control" id="nombreCuenta"
													name="nombreCuenta" class="required" required="required"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												Nivel
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="number" class="form-control" id="nivel"
													name="nivel" class="required" required="required"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												Rubro<span class="required"> *</span></label>
											<div class="col-md-6 col-sm-6">
												<input type="number" class="form-control" id="rubro"
													name="rubro" class="required" required="required"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												Tipo Cuenta
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<!--  <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->

												<%
												ArrayList<Tbl_tipocuenta> listaTc = new ArrayList<Tbl_tipocuenta>();
												Dt_tipocuenta dtTc = new Dt_tipocuenta();
												listaTc = dtTc.listaTipocuentaActivos();
												%>

												<select class="form-control js-example-basic-single"
													name="tipoCuenta" id="tipoCuenta" required="required">
													<option value="">Seleccione...</option>
													<%
													for (Tbl_tipocuenta tc : listaTc) {
													%>
													<option value="<%=tc.getIdTipoCuenta()%>">
														<%=tc.getTipoCuenta()%>
													</option>
													<%
													}
													%>
												</select>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">
												SubTipo Cuenta
												<span class="required"> *</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<!-- <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->

												<%
												ArrayList<SubCategoria> listaScat = new ArrayList<SubCategoria>();
												Dt_SubTipoCategoria dtScat = new Dt_SubTipoCategoria();
												listaScat = dtScat.listarSubCategoria();
												%>

												<select class="form-control js-example-basic-single"
													name="SubCategoria" id="SubCategoria" required="required">
													<option value="">Seleccione...</option>
													<%
														for (SubCategoria sct : listaScat) {
													%>
													<option value="<%=sct.getIdSupTipo()%>">
														<%=sct.getNombreSupTipo()%>
													</option>
													<%
													}
													%>
												</select>
											</div>
										</div>

										<input type="hidden" id="catalogoCuenta" name="catalogoCuenta"
											value="<%=Cata.getIdCatalogo()%>" />
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Catalogo
												Cuenta<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input type="text" class="form-control" id="txtCatalogo"
													name="txtCatalogo"
													value="<%=Cata.getTitulo() + " / " + Cata.getnombreComercial()%>"
													class="required" readonly="readonly" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo
												Inicial<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional'
													name="saldoInicial" id="saldoInicial" type="number"
													required="required" step="0.001" oninput="calcular()" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Debe<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="debe"
													id="debe" type="number" required="required" step="0.001"
													oninput="calcular()" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Haber<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="haber"
													id="haber" type="number" required="required" step="0.001"
													oninput="calcular()" />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo
												Final<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="number" class='optional'
													name="saldoFinal" id="saldoFinal" required='required'
													step="0.001" oninput="calcular()" readonly />
											</div>
										</div>


										<!-- <div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Cuenta
												Contable<span class="required">*</span>
											</label> -->
										<div class="col-md-6 col-sm-6">
											<input class="form-control" class='optional' type="hidden"
												name="idCuenta" id="idCuenta" value="0" />
										</div>
										<!-- </div> -->


										<div class="ln_solid">
  											<p style="color:red; font-size: 12px;" align="center"><%=msjError%></p>
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button id="AgregarCC" type='submit'
														class="btn btn-primary">Agregar</button>
													<a href="tbl_cuentacontable.jsp" class="btn btn-danger">Cancelar</a>
<!-- 													<a href="tbl_cuentacontable.jsp"><button -->
<!-- 															id="CancelarCC" type="button" class="btn btn-primary">Volver -->
<!-- 															a la tabla</button></a> -->
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>


					<%-- <div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Agregar Detalle CC</h2>

									<div class="clearfix"></div>
								</div>

								<div class="x_content">
									<form class="" action="../Sl_cuentaContableDet" method="post" novalidate>
									<input type="hidden" value="1" name="opcion" id="opcion" /> 
										<span class="section">Datos de Detalle CC</span>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Debe<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="debe" id="debe"
													 type="text"
													required="required" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Haber<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="haber" id="haber"
													 type="text"
													required="required" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Inicial<span
												class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional'
													name="saldoInicial" id="saldoInicial"
													type="text" required="required" />
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo
												Final<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="tel" class='optional'
													name="saldoFinal" id="saldoFinal" required='required'
													/>
											</div>
										</div>
										
										
									<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre de cuenta<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<%
												ArrayList<Vw_catalogo_tipo_cuentacontable> listaNc = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
												Dt_cuentaContable dtidCuenta = new Dt_cuentaContable();
												listaNc = dtidCuenta.listaCuentasContables();
												%>
												<select class="form-control js-example-basic-single"
													name="idCuenta" id="idCuenta" required="required" style="pointer-events: none;">
													<option id="idCuentaC" value="0" >Seleccione...</option>
													<%
													for (Vw_catalogo_tipo_cuentacontable ccDS : listaNc){
													%>
													<option value="<%=ccDS.getIdCuenta()%>">
													<%=ccDS.getNombreCuenta()%>
												</option>
													<%
													}
													%>
												</select>
											</div>
										</div>
										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button id="AgregarCCD" type='submit' class="btn btn-primary">Agregar</button>
													<button id="ResetCCD"
													 type='reset' onClick=(location.reload()) class="btn btn-success">Reiniciar</button>
													<a  href="tbl_cuentacontable.jsp"><button id="CancelarCCD" type="button" class="btn btn-primary">Cancelar</button></a>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div> --%>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">Sistema contable</div>
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

	<script type="text/javascript"></script>
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

	<script>
		function getURL() {
			const url = window.location.href;
			const idR = url.substring(url.indexOf('=') + 1);
			document.getElementById("idCuenta").value = idR;
			if (url == "production/addCuentaContable.jsp?idCuenta=" + idR) {
				console.log("Test");
			} else if (url == "production/addCuentaContable.jsp") {
			}
		}

		window.onload = getURL();
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




</body>

<script type="text/javascript">
	function calcular() {
		try {
			var a = parseFloat(document.getElementById("saldoInicial").value) || 0, b = parseFloat(document
					.getElementById("debe").value) || 0, c = parseFloat(document
					.getElementById("haber").value) || 0;

			var resultado = 0;

			resultado = a + b;
			resultado = resultado - c;

			document.getElementById("saldoFinal").value = resultado;

		} catch (e) {

		}
	}

	function setZero() {
		try {
			var a = parseFloat(document.getElementById("saldoInicial").value) || 0, b = parseFloat(document
					.getElementById("debe").value) || 0, c = parseFloat(document
					.getElementById("haber").value) || 0;

			document.getElementById("saldoInicial").value = 0;
			document.getElementById("debe").value = 0;
			document.getElementById("haber").value = 0;
			document.getElementById("saldoFinal").value = 0;
		} catch (e) {

		}
	}
	window.onload = setZero;
</script>

</html>