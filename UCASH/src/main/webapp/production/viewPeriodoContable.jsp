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
<html lang="es">
<%
Tbl_periodoContable tpcontable = new Tbl_periodoContable();
Dt_periodoContable dtpcontable = new Dt_periodoContable();

int idpcontable = (request.getParameter("contablever") != null)
		? Integer.parseInt(request.getParameter("contablever"))
		: 0;

tpcontable = dtpcontable.obtenerPContablePorId(idpcontable);

Tbl_periodoFiscal tpfiscal = new Tbl_periodoFiscal();
Dt_periodoFiscal dtpfiscal = new Dt_periodoFiscal();

int idpfiscal = tpcontable.getIdPeriodoFiscal();

tpfiscal = dtpfiscal.obtenerPFiscalPorId(idpfiscal);
%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Ver | Periodo Contable</title>

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
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Ver período contable</h3>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Formulario <small>Mostrar Periodo Contable</small>
									</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="" method="post" novalidate>
										<span class="section">Datos de Periodo Contable</span>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha
												Inicio del Periodo Fiscal: <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<%
												ArrayList<Tbl_periodoFiscal> listaPF = new ArrayList<Tbl_periodoFiscal>();
												Dt_periodoFiscal dtpf = new Dt_periodoFiscal();
												listaPF = dtpf.listarperiodoFiscal(vwur.getIdEmpresa());
												%>
												<select class="form-control js-example-basic-single"
													name="cbxIDPF" id="cbxIDPF" required="required" disabled="disabled">
													<option value="">Seleccione...</option>
													<%
													for (Tbl_periodoFiscal pf : listaPF) {
													%>
													<option value="<%=pf.getIdPeriodoFiscal()%>"><%=pf.getFechaInicio()%></option>
													<%
													}
													%>
												</select>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha
												Final del Periodo Fiscal: <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<select class="form-control js-example-basic-single"
													name="cbxIDPFFF" id="cbxIDPFFF" required="required" disabled="disabled">
													<option value="">Seleccione...</option>
													<%
													for (Tbl_periodoFiscal pf : listaPF) {
													%>
													<option value="<%=pf.getIdPeriodoFiscal()%>"><%=pf.getFechaFinal()%></option>
													<%
													}
													%>
												</select>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha
												de inicio: </label>
											<div class="col-md-6 col-sm-6">
												<input type="date"
													value="<%=tpcontable.getFechaInicio()%>"
													class="form-control" placeholder="Fecha de inicio"
													name="fechainicioc" readonly="readonly">
											</div>
										</div>



										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha
												Final: </label>
											<div class="col-md-6 col-sm-6">
												<input type="date" value="<%=tpcontable.getFechaFinal()%>"
													class="form-control" placeholder="Fecha de inicio"
													name="fechafinalc" readonly="readonly">
											</div>
										</div>

										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<a href="tbl_periodoContable.jsp" type="button"
														class="btn btn-primary">Regresar</a>
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
        ///SOLO ESTE VALOR NO LO PUEDO PONER DE OTRA MANERA
        function setValores() {
            $("#cbxIDPF").val("<%= tpcontable.getIdPeriodoFiscal()%>");
            $("#cbxIDPFFF").val("<%= tpcontable.getIdPeriodoFiscal()%>");
        }

        $(document).ready(function() {
            ////CARGAMOS LOS VALORES EN LOS CONTROLES 
            setValores();
        });
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

</html>