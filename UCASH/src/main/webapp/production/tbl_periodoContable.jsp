<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"

	import="entidades.Vw_empresa, 
	entidades.Vw_usuariorol, 
	entidades.Vw_rolopciones, 
	entidades.Tbl_periodoFiscal,
	entidades.Tbl_periodoContable, 
	entidades.Tbl_periodoFiscal, 
	entidades.Vw_periodoContable,
	datos.Dt_rolOpciones, 
	datos.Dt_periodoContable, 
	datos.Dt_periodoFiscal, 
	java.util.*;"%>

<%
//JAlert flag
String signal = "";
if (request.getParameter("msj") != null) {
	signal = request.getParameter("msj");
}

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
	// response.sendRedirect("../login.jsp?msj=401");
	response.sendRedirect("page_403.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Gestión | Periodo Contable</title>

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

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
<link rel="stylesheet" href="../vendors/jAlert/dist/jAlert.css" />

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
							<h3>Periodo Contable</h3>
						</div>

<!-- 						<div class="title_right"></div> -->
					</div>

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="x_panel">
								<div class="x_title">
									<h2>Periodos Contables Registrados</h2>
<!-- 									<ul class="nav navbar-right panel_toolbox"> -->
<!-- 										<li><a class="collapse-link"><i -->
<!-- 												class="fa fa-chevron-up"></i></a></li> -->
<!-- 										<li class="dropdown"><a href="#" class="dropdown-toggle" -->
<!-- 											data-toggle="dropdown" role="button" aria-expanded="false"><i -->
<!-- 												class="fa fa-wrench"></i></a> -->
<!-- 											<div class="dropdown-menu" -->
<!-- 												aria-labelledby="dropdownMenuButton"> -->
<!-- 												<a class="dropdown-item" href="#">Settings 1</a> <a -->
<!-- 													class="dropdown-item" href="#">Settings 2</a> -->
<!-- 											</div></li> -->
<!-- 										<li><a class="close-link"><i class="fa fa-close"></i></a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div style="border: #73879C 2px solid; margin: 0 auto; width: 50%; padding: 10px; text-align: center">
										<p><b>Leyenda:</b></p>
										
										<div class="row" style="margin: 0 auto">
											<div style="background-color: #ff7878; width: 20px; height: 20px"></div>
											<p>&nbsp;Período fiscal</p>
										</div>

										<div class="row" style="margin: 0 auto">
											<div style="background-color: #52a0ff; width: 20px; height: 20px"></div>
											<p>&nbsp;Período contable</p>
										</div>

									</div>
									<div class="row">
										<div class="col-sm-12">
											<div class="card-box table-responsive">
												<div class="text-muted font-13 col-md-12"
													style="text-align: right;">
													<a href="addPeriodoContable.jsp"> <i
														class="fa fa-plus-square"></i> Nuevo Periodo Contable
													</a> <br></br>
												</div>

												<input type="hidden" value="<%=signal%>" id="JAlertInput" />

												<table id="datatable-buttons"
													class="table table-striped table-bordered"
													style="width: 100%">
													<%
													ArrayList<Vw_periodoContable> listaperiodoContable = new ArrayList<Vw_periodoContable>();
													Dt_periodoContable dtPC = new Dt_periodoContable();
													listaperiodoContable = dtPC.listarperiodoContable(vwur.getIdEmpresa());
													%>
													<thead>
														<tr>
															<th>ID</th>
															<th style="background-color: #ff7878">Fecha Inicio
																del Periodo Fiscal</th>
															<th style="background-color: #52a0ff">Fecha Inicio
																del Periodo Contable</th>
															<th style="background-color: #52a0ff">Fecha Final
																del Periodo Contable</th>
															<th style="background-color: #ff7878">Fecha Final
																del Periodo Fiscal</th>
															<th>Estado</th>
															<th>Opciones</th>
														</tr>
													</thead>
													<tbody>
														<%
														for (Vw_periodoContable PC : listaperiodoContable) {
															String estado = "";
															if (PC.getEstado() != 3) {
																estado = "ABIERTO";
															} else {
																estado = "CERRADO";
															}

															Dt_periodoFiscal dtpf = new Dt_periodoFiscal();
															Tbl_periodoFiscal Tpf = new Tbl_periodoFiscal();
															Tpf = dtpf.obtenerPFiscalPorId(PC.getIdPeriodoFiscal());
															int estadopf = Tpf.getEstado();

															if (PC.getEstado() != 3) {
														%>
														<tr>
															<td><%=PC.getIdPeriodoContable()%></td>
															<td style="background-color: #ffa6a6"><%=PC.getFechaInicioPF()%></td>
															<td style="background-color: #a1cbff"><%=PC.getFechaInicio()%></td>
															<td style="background-color: #a1cbff"><%=PC.getFechaFinal()%></td>
															<td style="background-color: #ffa6a6"><%=PC.getFechaFinalPF()%></td>

															<td><%=estado%></td>
															<td><a
																href="editPeriodoContable.jsp?contable=<%=PC.getIdPeriodoContable()%>">
																	<i class="fa fa-edit" title="Editar Periodo Contable"></i>
															</a> &nbsp;&nbsp; <a
																href="viewPeriodoContable.jsp?contablever=<%=PC.getIdPeriodoContable()%>">
																	<i class="fa fa-eye" title="Ver Periodo Contable"></i>
															</a> &nbsp;&nbsp; <a
																href="eliminarPeriodoContable.jsp?contableeliminar=<%=PC.getIdPeriodoContable()%>">
																	<i class="fa fa-lock" title="Cerrar Periodo Contable"></i>
															</a></td>
														</tr>
														<%
														} else if (estadopf != 3 && PC.getEstado() == 3) {
														%>
														<tr>
															<td><%=PC.getIdPeriodoContable()%></td>
															<td style="background-color: #ffa6a6"><%=PC.getFechaInicioPF()%></td>
															<td style="background-color: #a1cbff"><%=PC.getFechaInicio()%></td>
															<td style="background-color: #a1cbff"><%=PC.getFechaFinal()%></td>
															<td style="background-color: #ffa6a6"><%=PC.getFechaFinalPF()%></td>
															<td><%=estado%></td>
															<td><a
																href="viewPeriodoContable.jsp?contablever=<%=PC.getIdPeriodoContable()%>">
																	<i class="fa fa-eye" title="Ver Periodo Contable"></i>
															</a> &nbsp;&nbsp; <a
																href="openPeriodoContable.jsp?contable=<%=PC.getIdPeriodoContable()%>">
																	<i class="fa fa-unlock" title="Abrir"></i>
															</a></td>
														</tr>

														<%
														} else if (estadopf == 3 && PC.getEstado() == 3) {
														%>
														<tr>
															<td><%=PC.getIdPeriodoContable()%></td>
															<td><%=PC.getFechaInicioPF()%></td>
															<td><%=PC.getFechaFinalPF()%></td>
															<td><%=PC.getFechaInicio()%></td>
															<td><%=PC.getFechaFinal()%></td>
															<td><%=estado%></td>
															<td><a
																href="viewPeriodoContable.jsp?contablever=<%=PC.getIdPeriodoContable()%>">
																	<i class="fa fa-eye" title="Ver Periodo Contable"></i>
															</a> <%
 }

 }
 %>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>


					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /page content -->

	<!-- footer content -->


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

	<script>
		var mensaje = "";
		mensaje = document.getElementById("JAlertInput").value;
		console.log(mensaje);

		$(document)
				.ready(
						function() {

							if (mensaje == "1") {
								successAlert('Exito',
										'El Periodo Contable se ha guardado correctamente.')
							}

							if (mensaje == "2") {
								errorAlert('Error',
										'Los datos del Periodo Contable no se lograron guardar.')
							}

							if (mensaje == "3") {
								successAlert('Exito',
										'Los datos del Periodo Contable se editaron correctamente.')
							}

							if (mensaje == "4") {
								errorAlert('Error',
										'Los datos del Periodo Contable no se pudieron editar.')
							}

							if (mensaje == "5") {
								successAlert('Exito',
										'El periodo Contable fue cerrado correctamente.')
							}

							if (mensaje == "6") {
								errorAlert('Error',
										'No se pudo cerrar el Periodo Contable.')
							}

							if (mensaje == "7") {
								successAlert('Exito',
										'El periodo Contable fue abierto correctamente.')
							}

							if (mensaje == "8") {
								errorAlert('Error',
										'No se pudo abrir el Periodo Contable.')
							}

							$("#example1").DataTable({
								"responsive" : true,
								"lengthChange" : false,
								"autoWidth" : false,
								"buttons" : [ "excel", "pdf" ]
							}).buttons().container().appendTo(
									'#example1_wrapper .col-md-6:eq(0)');

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