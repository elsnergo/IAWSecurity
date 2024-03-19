<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"
	import="entidades.Tbl_empresa, entidades.Vw_empresa,entidades.Vw_usuariorol, entidades.Vw_rolopciones, entidades.Vw_representanteLegal, 
	entidades.Tbl_periodoFiscal, entidades.Tbl_departamento, entidades.Vw_municipio,
	datos.Dt_empresa, datos.Dt_representanteLegal, datos.Dt_municipio, datos.Dt_periodoFiscal, datos.Dt_departamento, datos.Dt_rolOpciones , 
	 
	 java.util.ArrayList;"%>

<%
//JAlert flag
String signal = "";
if (request.getParameter("msj") != null) {
	signal = request.getParameter("msj");
	
	

}
%>



<%
Dt_empresa dtEmpresa = new Dt_empresa();

int idEmpresa = dtEmpresa.idEmpresa() + 1;
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

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Gestión | Empresa</title>
<link rel="stylesheet" href="../vendors/jAlert/dist/jAlert.css" />
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
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>
								Empresa <small> Datos de empresa</small>
							</h3>
						</div>

<!-- 						<div class="title_right"> -->
<!-- 							<div -->
<!-- 								class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search"> -->
<!-- 								<div class="input-group"> -->
<!-- 									<input type="text" class="form-control" -->
<!-- 										placeholder="Buscar por..."> <span -->
<!-- 										class="input-group-btn"> -->
<!-- 										<button class="btn btn-secondary" type="button">Go!</button> -->
<!-- 									</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-md-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Empresas registradas</h2>
<!-- 									<ul class="nav navbar-right panel_toolbox"> -->
<!-- 										<li> -->
<!-- 											<a class="collapse-link"> -->
<!-- 												<i class="fa fa-chevron-up"></i> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="col-md-12">
											<div class="card-box table-responsive">
												<div class="text-muted font-13 col-md-12"
													style="text-align: right;">
													<a href="addEmpresa.jsp?idEmpresaHidden=<%=idEmpresa%>"> <i
														class="fa fa-plus-square"></i>
														Nuevo Empresa </a>
													</a> <br></br>
												</div>
												<input type="hidden" value="<%=signal%>" id="JAlertInput" />
												<table id="datatable-buttons"
													class="table table-striped table-bordered"
													style="width: 100%">
													<%
													ArrayList<Vw_empresa> listaEmpresa = new ArrayList<Vw_empresa>();
													Dt_empresa dtE = new Dt_empresa();
													listaEmpresa = dtE.listarEmpresa();
													%>
													<thead>
														<tr>
															<!-- <th>Id</th> -->
															<th>RUC</th>
															<th>Razón social</th>
															<th>Nombre comercial</th>
															<!-- <th>Dirección</th> -->
															<!-- <th>Representante legal</th> -->
															<!-- <th>Departamento</th> -->
															<!-- <th>Municipio</th> -->
															<th>Periodo Fiscal</th>
															<!-- <th>Telefono</th> -->
															<!-- <th>Correo</th> -->
															<th>Opciones</th>
														</tr>
													</thead>
													<tbody>
														<%
														for (Vw_empresa empresa : listaEmpresa) {
														%>
														<tr>
<%-- 															<td><%=empresa.getIdEmpresa()%></td> --%>
															<td><%=empresa.getRuc()%></td>
															<td><%=empresa.getRazonSocial()%></td>
															<td><%=empresa.getNombreComercial()%></td>
															<%-- <td><%=empresa.getDireccion()%></td> --%>
															<%-- <td><%=empresa.getRepresentante()%></td> --%>
															<%-- <td><%=empresa.getDepartamentoNombre()%></td> --%>
															<%-- <td><%=empresa.getMunicipioNombre()%></td> --%>

															<%if(empresa.getPeriodoFiscal() != null){%>
															<td><%=empresa.getPeriodoFiscal()%></td>
															<%}
else{%>
															<td>No se ha establecido un periodo fiscal</td> <%}%>

															<%-- <td><%=empresa.getTelefono()%></td> --%>
															<%-- <td><%=empresa.getCorreo()%></td> --%>

															<td>
																<a href="editEmpresa.jsp?idEmpresa=<%=empresa.getIdEmpresa()%>">
																	<i class="fa fa-edit" title="Editar empresa"></i>
																</a> &nbsp;&nbsp; 
																<a href="viewEmpresa.jsp?idEmpresa=<%=empresa.getIdEmpresa()%>">
																	<i class="fa fa-eye" title="Ver empresa"></i>
																</a> &nbsp;&nbsp;
																<a href="addLogoEmpresa.jsp?idE=<%=empresa.getIdEmpresa()%>"> 
																	<i class="fa fa-camera" title="Añadir Logo a Empresa"></i>
																</a>&nbsp;&nbsp;
															</td>
														</tr>
														<%
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
	<footer>
		<div class="pull-right">Sistema contable by UCASH</div>
		<div class="clearfix"></div>
	</footer>
	<!-- /footer content -->
	<script>
		// IMPRIMIR REPORTE SIN PARAMETROS //
		function printListEmpresa() {
			window.open("../Sl_rptListEmpresas", '_blank');
		}
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
										'La empresa ha sido registrado correctamente.')
								console.log(mensaje);

							}

							if (mensaje == "2") {
								errorAlert('Error',
										'La empresa no se ha podido guardar. Por favor verifique los datos')
							}

							if (mensaje == "3") {
								successAlert('Exito',
										'Los datos de la empresa se han editado correctamente.')
							}

							if (mensaje == "4") {
								errorAlert('Error',
										'Los datos de la empresa no se han editado correctamente.')
							}

							$("#myTable").DataTable({
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