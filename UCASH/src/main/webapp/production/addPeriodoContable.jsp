<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="entidades.Vw_empresa, entidades.Vw_usuariorol, entidades.Vw_rolopciones, entidades.Tbl_periodoContable, entidades.Tbl_periodoFiscal,
	datos.Dt_rolOpciones, datos.Dt_periodoContable, datos.Dt_periodoFiscal, java.util.*;"%>
	
	<%
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
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Agregar | Periodo Contable</title>

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
							<h3>Agregar nuevo periodo contable</h3>
						</div>


					</div>
					<div class="clearfix"></div>




					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Formulario de periodos contables</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<br />
									<form class="" action="../Sl_periodoContable" method="post"
										novalidate>
										<input type="hidden" value="1" name="opcion" id="opcion" />
										<input type="hidden" value="0" name="transferBalance" id="transferBalance"/>
										<input type="hidden" value="<%=vwur.getIdEmpresa()%>" name="empresa" id="empresa"/>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Periodo Fiscal: <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<%
												ArrayList<Tbl_periodoFiscal> listaPF = new ArrayList<Tbl_periodoFiscal>();
												Dt_periodoFiscal dtpf = new Dt_periodoFiscal();
												listaPF = dtpf.listarperiodoFiscal(vwur.getIdEmpresa());
												%>
												<select class="form-control js-example-basic-single"
													name="cbxIDPF" id="cbxIDPF" required="required">
													<option value="">Seleccione...</option>
													<%
													for (Tbl_periodoFiscal pf : listaPF) {
													%>
													<option value="<%=pf.getIdPeriodoFiscal()%>"><%="Fecha de inicio: " + pf.getFechaInicio() + " " + " Fecha de finalización: " + pf.getFechaFinal()%></option>
													<%
													}
													%>
												</select>
											</div>
										</div>


										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha
												de inicio: <span class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input type="date" class="form-control"
													placeholder="Fecha de inicio" name="fechainicioc" required="required">
											</div>
										</div>



										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha
												Final: <span class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input type="date" class="form-control"
													placeholder="Fecha de inicio" name="fechafinalc" required="required">
											</div>
										</div>




										<div class="ln_solid"></div>
										<div class="form-group">
											<div class="col-md-9 col-sm-9  offset-md-3">
												<a href="tbl_periodoContable.jsp" type="button"
													class="btn btn-danger">Cancelar</a>
												<button type="submit" class="btn btn-success">Agregar</button>
												<input type="checkbox" id="balanceTransfer"/>
												<label style="color:#000;" for="balanceTransfer">- Transferir saldos</label>
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

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>
	<!-- Select2 -->
	<script src="../vendors/select2/dist/js/select2.full.min.js"></script>
	
	<script>
		var selection = document.getElementById("balanceTransfer");
		var balanceValue = document.getElementById("transferBalance");
		selection.addEventListener("click", ()=>{
			if(selection.checked){
				balanceValue.value = 1; 
			}else {
				balanceValue.value = 0;
			};
		});
		
	</script>
	
	<script>
		// initialize a validator instance from the "FormValidator" constructor.
		// A "<form>" element is optionally passed as an argument, but is not a must
		//Inicio select2
		$(document).ready(function() {
			$('.js-example-basic-single').select2();
		});
		//Cierre Select2
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
	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	<script src="../vendors/select2/dist/js/select2.min.js"></script>
</body>
</html>