<%@ page language="java" contentType="text/html; charset=UTF-8"
import="entidades.Tbl_empresa, entidades.Vw_empresa,entidades.Vw_usuariorol, entidades.Vw_rolopciones, entidades.Vw_representanteLegal, 
	entidades.Tbl_periodoFiscal, entidades.Tbl_departamento, entidades.Vw_municipio, entidades.Tbl_periodoEmpresa, 
	datos.Dt_empresa, datos.Dt_representanteLegal, datos.Dt_municipio, datos.Dt_periodoFiscal, datos.Dt_departamento, datos.Dt_rolOpciones, datos.Dt_periodoEmpresa,  
	 
	 java.util.ArrayList;"%>
<!DOCTYPE html>
<html lang="es">

<%
String empresa = "";
empresa = request.getParameter("idEmpresa") == null ? "0" : request.getParameter("idEmpresa");
Tbl_empresa tEmpresa = new Tbl_empresa();
Vw_empresa vEmpresa = new Vw_empresa();
Dt_empresa dtEmpresa = new Dt_empresa();
Dt_municipio dtMunicipio = new Dt_municipio(); 
tEmpresa = dtEmpresa.getTableEmpresaByID(Integer.parseInt(empresa));
vEmpresa = dtEmpresa.getEmpresaByID(Integer.parseInt(empresa));
int currentUsuario;
Tbl_periodoEmpresa periodoEmpresa = new Tbl_periodoEmpresa();
%>
	<script>
    function setForm(){
    	document.getElementById("ruc").value = "<%=vEmpresa.getRuc()%>";
    	document.getElementById("razonSocial").value = "<%=vEmpresa.getRazonSocial()%>";
    	document.getElementById("nombreComercial").value = "<%=vEmpresa.getNombreComercial()%>";
    	document.getElementById("telefono").value = "<%=vEmpresa.getTelefono()%>";
    	document.getElementById("correo").value = "<%=vEmpresa.getCorreo()%>";
    	document.getElementById("direccion").value = "<%=vEmpresa.getDireccion()%>";
    	
    	
    	
    	document.getElementById("representanteLegal").value = "<%=tEmpresa.getIdRepresentanteLegal()%>";
    	document.getElementById("departamento").value = "<%=tEmpresa.getIdDepartamento()%>";
    	
    	
    	function convertFirst(idDep){
    		var data = <%=dtMunicipio.convert()%>
    		var i = 0;
    		var $select = $('#municipio').empty().append('<option value="0">Seleccione...</option>')
    		var removedArray = [];
			var currentMun = 0;


    		removedArray = data.filter(function(item) {
    		    return item.iddepartamento == idDep
    		})

    		$.each(removedArray, function(id, name) {
    		    $select.append('<option value=' + name.idmunicipio + '>' + name.municipio + '</option>');
    		});

    		for(var i = 0; i < data.length; i++){
    			if(data[i].idmunicipio = <%=tEmpresa.getIdMunicipio()%>) {
    				document.getElementById("municipio").value = data[i].idmunicipio
    				break;
    			} 
    		}
    		}
    	convertFirst("<%=tEmpresa.getIdDepartamento()%>")
		
		}
		window.onload = setForm;
	</script>

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
		currentUsuario = vwur.getId_user();
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
		response.sendRedirect("page_403.jsp");
		//response.sendRedirect("page_403.jsp");
		return;
	}
	
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Editar | Empresa</title>

<!-- Bootstrap -->
<link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
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
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- top navigation -->
		
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Editar</h3>
						</div>

<!-- 						<div class="title_right"> -->
<!-- 							<div class="col-md-5 col-sm-5 form-group pull-right top_search"> -->
<!-- 								<div class="input-group"> -->
<!-- 									<input type="text" class="form-control" -->
<!-- 										placeholder="Buscar por..."> <span -->
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
									<h2>
										Formulario <small>Editar empresa</small>
									</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="../Sl_empresa" method="post" novalidate>
										<input type="hidden" value="2" name="opcion" id="opcion" /> 
										<input type="hidden" value="<%=tEmpresa.getIdEmpresa()%>" name="idEmpresaHidden" id="idEmpresaHidden" /> 
										
									    <input type="hidden" value=<%=currentUsuario%> name="currentUsuario" id="currentUsuario" />
										
										<input
											type="hidden" value="<%=tEmpresa.getIdEmpresa()%>"
											name="idEmpresa" id="idEmpresa" /> <span class="section">Datos
											de empresa</span>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">RUC<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input name="ruc" class="form-control" id="ruc"
													placeholder="ex. 2347827431" required="required" />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Razón social<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input name="razonSocial" class="form-control"
													id="razonSocial" class='optional' type="text"
													required="required" />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre
												comercial<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input name="nombreComercial" class="form-control"
													id="nombreComercial" class='optional' name="occupation"
													type="text" required="required" />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Correo<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input name="correo" class="form-control" class='email'
													id="correo" required="required" type="email" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Teléfono<span
												class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input name="telefono" class="form-control" type="tel"
													id="telefono" class='tel' required='required' />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Dirección<span
												class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input id="direccion" name="direccion" class="form-control"
													class='optional' name="occupation"
													data-validate-length-range="5,100" type="text"
													required="required" />
											</div>
										</div>



										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Representante
												legal: <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<!--                                                 
												<input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
												<%
												ArrayList<Vw_representanteLegal> listaRep = new ArrayList<Vw_representanteLegal>();
												Dt_representanteLegal dtRep = new Dt_representanteLegal();
												listaRep = dtRep.listarRepresentanteLegal();
												%>

												<select id="representanteLegal"
													class="form-control js-example-basic-single"
													name="representanteLegal" required="required">
													<option value="0">Seleccione...</option>
													<%
													for (Vw_representanteLegal representante : listaRep) {
													%>
													<option value="<%=representante.getIdRepresentante()%>">
														<%=representante.getNombreCompleto()%>
													</option>
													<%
													}
													%>

												</select>
											</div>
										<p>¿No encuentra el representante legal? <br />
										<a href="addRepresentanteLegal.jsp">Agregar representante legal aqui</a>
										</p>
									</div>


										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Departamento:
												<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
												<%
												ArrayList<Tbl_departamento> listaDep = new ArrayList<Tbl_departamento>();
												Dt_departamento dtDep = new Dt_departamento();
												listaDep = dtDep.listarDepartamento();
												%>
												<select onchange="checkDep()"  id="departamento"
													class="form-control js-example-basic-single"
													name="departamento" id="departamento" required="required">
													<option value="0">Seleccione...</option>
													<%
													for (Tbl_departamento depa : listaDep) {
													%>
													<option value="<%=depa.getIdDepartamento()%>">
														<%=depa.getDepartamento()%>
													</option>
													<%
													}
													%>

												</select>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Municipio:
												<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
											
												<select class="form-control js-example-basic-single"
													name="municipio" id="municipio" required="required">
													<option value="0">Seleccione...</option>
													
												
												</select>
											</div>
										</div>
										<div class="ln_solid">
											<div class="form-group" align="center">
												<div class="col-md-6 offset-md-3">
													<button id="agregarE" type='submit' class="btn btn-primary">Editar</button>
													<button id="cancelarE" type="button" 
														onclick="window.location.href='tbl_empresa.jsp'" class="btn btn-danger">
														Cancelar
													</button>
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
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>

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

	
	<!-- Funcion para filtrar los municipios segun el departamento -->
	<script>
	
	console.log(document.getElementById("departamento").value )
	function checkDep(){
    convert(document.getElementById("departamento").value )
	}
	</script>
<!-- Funcion para filtrar los municipios segun el departamento -->
<script>													
function convert(idDep){
var data = <%=dtMunicipio.convert()%>
var i = 0;
var $select = $('#municipio').empty().append('<option value="0">Seleccione...</option>')
var removedArray = data.filter(function(item) {
    return item.iddepartamento == idDep
})

$.each(removedArray, function(id, name) {
    $select.append('<option value=' + name.idmunicipio + '>' + name.municipio + '</option>');
});

console.log(data)

console.log(removedArray)
}

</script>
</body>

</html>