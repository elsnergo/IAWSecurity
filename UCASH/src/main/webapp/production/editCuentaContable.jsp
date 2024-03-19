<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*" %>
<!DOCTYPE html>
<html>

<!-- //DETALLE  -->
<%
String CCD = "";
Vw_cuentacontable_cuentacontable_det vwCCD = new Vw_cuentacontable_cuentacontable_det();
Dt_cuentaContable_Det dtCCD = new Dt_cuentaContable_Det();


int idCCD = request.getParameter("idCuenta") != null ? Integer.parseInt(request.getParameter("idCuenta")): 0;

Tbl_cuentaContable_Det ccd = new Tbl_cuentaContable_Det();
Dt_cuentaContable_Det dtCcd = new Dt_cuentaContable_Det();
ccd = dtCcd.getCcdbyID(idCCD);


vwCCD = dtCCD.getCCDbyID(idCCD);
%>



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
vwur = (Vw_usuariorol) session.getAttribute("acceso");
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

//Maestro
String cc = "";
cc = request.getParameter("idCuenta") == null ? "0" : request.getParameter("idCuenta");

Vw_catalogo_tipo_cuentacontable vwCc = new Vw_catalogo_tipo_cuentacontable();
Dt_cuentaContable dtCc = new Dt_cuentaContable();
vwCc = dtCc.getCuentaContableById(Integer.parseInt(cc));


Tbl_tipocuenta ttc = new Tbl_tipocuenta();
Dt_tipocuenta dtCtc = new Dt_tipocuenta();
ttc = dtCtc.getTableTipocuentaByID(Integer.parseInt(cc));


Vw_catalogocuenta_empresa cata = new Vw_catalogocuenta_empresa();
Dt_catalogocuenta dtCatC = new Dt_catalogocuenta();
cata = dtCatC.getCatalogoByID(Integer.parseInt(cc));


Tbl_cuentaContable tCuentaContable = new Tbl_cuentaContable(); 
int idCuentaContable = request.getParameter("idCuenta") != null ? Integer.parseInt(request.getParameter("idCuenta")): 0;
Dt_cuentaContable cuentaContable = new Dt_cuentaContable(); 

tCuentaContable = cuentaContable.getCuentaContableByIdTable(idCuentaContable); 

Vw_catalogocuenta_empresa Cata = new Vw_catalogocuenta_empresa();
Dt_catalogocuenta dtcata = new Dt_catalogocuenta();

Cata = dtcata.getCatalogoByIdEmpresa(vwur.getIdEmpresa());


%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Editar | Cuenta Contable</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
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
							<h3>Editar Cuenta Contable</h3>
						</div>

						
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Editar Cuenta Contable
									</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="../Sl_cuentaContable" method="post" novalidate>
										<input type="hidden" value="2" name="opcion" id="opcion"/>
										<input type="hidden" value="<%= vwCc.getIdCuenta()%>" name="idCuenta" id="idCuenta" />
										<input type="hidden" value="<%=vwCCD.getIdCuentaContableDet()%>" name="idCuentaContableDet" id="idCuentaContableDet" />
										<input type="hidden" value="<%=vwur.getIdEmpresa() %>" name="empresaActual" id="empresaActual" />
										<input type="hidden" value="<%=vwur.getIdPeriodoContable()%>" name="periodoContable" id="periodoContable" />
										<span class="section">Datos de Cuenta Contable Maestro</span>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Número de Cuenta:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="number" class="optional" name="numeroCuenta" id="numeroCuenta"
												value="<%= vwCc.getNumeroCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Cuenta:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="text" class="optional" name="SC" id="SC" 
												value="<%= vwCc.getsC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Sub-Cuenta:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="text" class="optional" name="SsC" id="SsC" 
												value="<%= vwCc.getSsC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Sub-Sub-Cuenta:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="text" class="optional" name="SssC" id="SssC" 
												value="<%= vwCc.getSssC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre Cuenta:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="text" class="optional" name="nombreCuenta" id="nombreCuenta" 
												value="<%= vwCc.getNombreCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nivel</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="number" class="optional" name="nivel" id="nivel" 
												value="<%= vwCc.getNivel() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Rubro:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" type="number" class="optional" name="rubro" id="rubro" 
												value="<%= vwCc.getRubro() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3  label-align">Tipo de Cuenta:</label>
                                            <div class="col-md-6 col-sm-6">
<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->

													<% 
													ArrayList<Tbl_tipocuenta> listaTc = new ArrayList<Tbl_tipocuenta>();
													Dt_tipocuenta dtTc = new Dt_tipocuenta();
													listaTc = dtTc.listaTipocuentaActivos();
													%>
													
								                 <select id="cbxTipoCuenta" class="form-control js-example-basic-single" name="cbxTipoCuenta" id="cbxTipoCuenta" required="required" >
								                 <option value="">Seleccione...</option>
													<%
												  		for(Tbl_tipocuenta tc : listaTc){
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
                                        
                                        <input type="hidden" id="catalogoCuenta"
													name="catalogoCuenta" value="<%=Cata.getIdCatalogo()%>"/>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Catálogo Cuenta<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
													<input type="text" class="form-control" id="txtCatalogo"
													name="txtCatalogo" value="<%=Cata.getTitulo()+ " / " + Cata.getnombreComercial()%>" class="required" readonly="readonly" />
											</div>
										</div>
                                        
                                        <div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Inicial</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" value="<%=vwCCD.getSaldoInicial()%>" name="saldoInicial" id="saldoInicial" step="0.001" oninput="calcular()"/>
											</div>
										</div>
                                        
                                        <div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Debe:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" value="<%=vwCCD.getDebe()%>" name="debe" id="debe" step="0.001" oninput="calcular()"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Haber:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control"  value="<%=vwCCD.getHaber()%>" name="haber" id="haber" step="0.001" oninput="calcular()"/>
											</div>
										</div>
										
										
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Final:</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" value="<%=vwCCD.getSaldoFinal()%>" name="saldoFinal" id="saldoFinal" step="0.001" oninput="calcular()" readonly/>
											</div>
										</div>
											
										
										<div class="ln_solid">
										<p> </p>
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<p> </p>
													<button type='submit' class="btn btn-primary">Editar</button>
													<a href="tbl_cuentacontable.jsp" class="btn btn-danger">Cancelar</a>
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
		</div>
	</div>
	
	<footer>
		<div class="pull-right">Sistema contable</div>
		<div class="clearfix"></div>
	</footer>
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>
	
	<!-- JavaScript Functions -->

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
    function setForm(){

    	document.getElementById("cbxTipoCuenta").value =  <%=tCuentaContable.getIdTipoCuenta()%>
    	document.getElementById("SubCategoria").value =  <%=tCuentaContable.getIdSubCategoria()%>
    	document.getElementById("cbxCatalogoCuenta").value =  <%=tCuentaContable.getIdCatalogo()%>

		}
		window.onload = setForm;
	</script>

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

</body>







<script type="text/javascript">
	
	function calcular(){
		try{
			var a = parseFloat(document.getElementById("saldoInicial").value) || 0,
			b = parseFloat(document.getElementById("debe").value) || 0,
			c = parseFloat(document.getElementById("haber").value) ||0;
			
			var resultado = 0;
			
			resultado = a + b;
			resultado =  resultado - c;
			
			document.getElementById("saldoFinal").value = resultado;
			
		}catch (e){
			
		}
	}
	
	</script>
</html>