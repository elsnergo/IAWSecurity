<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="entidades.Vw_empresa, entidades.Vw_usuariorol, entidades.Vw_rolopciones, entidades.Tbl_periodoFiscal,
	datos.Dt_rolOpciones, datos.Dt_periodoFiscal, java.util.*;"%>
	
	<%
	
	//JAlert flag
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Gestión | Periodo Fiscal</title>

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
							<h3>
								Periodo Fiscal
							</h3>
						</div>

<!-- 						<div class="title_right">			 -->
						</div>
					</div>

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="x_panel">
								<div class="x_title">
									<h2>Asientos Contables Registrados</h2>
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
									<div class="row">
										<div class="col-sm-12">
											<div class="card-box table-responsive">
												<div class="text-muted font-13 col-md-12"
													style="text-align: right;">
													<a href="addPeriodoFiscal.jsp"> <i class="fa fa-plus-square"></i>
														Nuevo Periodo Fiscal
													</a> <br></br>
												</div>
												<input type="hidden" value="<%=signal%>" id="JAlertInput"/>
												<table id="datatable-buttons"
													class="table table-striped table-bordered"
													style="width: 100%">
													<%
													System.out.print("Current company = " + Vw_empresa.empresaActual);
                      								ArrayList<Tbl_periodoFiscal> listarperiodoFiscal = new ArrayList<Tbl_periodoFiscal>();
                      								Dt_periodoFiscal dtPF = new Dt_periodoFiscal();
                      								listarperiodoFiscal = dtPF.listarperiodoFiscal(vwur.getIdEmpresa());
	                  								%>
													<thead>
														<tr>
															<th>ID</th>
															<th>Fecha Inicio</th>
															<th>Fecha Final</th>
															<th>Estado</th>
															<th>Opciones</th>
														</tr>
													</thead>
													<tbody>
														<%
                      									for(Tbl_periodoFiscal PF :listarperiodoFiscal){
                      										String estado = "";
    														if (PF.getEstado() != 3) {
    															estado = "ABIERTO";
    														} else {
    															estado = "CERRADO";
    														}
    														if(PF.getEstado() != 3){
                      									%>
														<tr>
															<td><%=PF.getIdPeriodoFiscal()%></td>
															<td><%=PF.getFechaInicio()%></td>
															<td><%=PF.getFechaFinal()%></td>
															<td><%=estado%></td>
															
															<td><a href="editPeriodoFiscal.jsp?idPeriodoFiscal=<%=PF.getIdPeriodoFiscal() %>"> <i
																	class="fa fa-edit" title="Editar Periodo Fiscal"></i>
																	
																	</a>&nbsp;&nbsp; <a href="viewPeriodoFiscal.jsp?idPeriodoFiscal=<%=PF.getIdPeriodoFiscal() %>">
																	<i class="fa fa-eye" title="Ver Periodo Fiscal"></i>
															</a> &nbsp;&nbsp;
															 <a href="eliminarPeriodoFiscal.jsp?idPeriodoFiscal=<%=PF.getIdPeriodoFiscal() %>"> 
															 	<i class="fa fa-lock" title="Cerrar Periodo Fiscal"></i>
															</a>
															</td>
														</tr>
														<%
    														}else if(PF.getEstado() == 3){
    															
    															%>
    															
    															<tr>
															<td><%=PF.getIdPeriodoFiscal()%></td>
															<td><%=PF.getFechaInicio()%></td>
															<td><%=PF.getFechaFinal()%></td>
															<td><%=estado%></td>
															
															<td><a href="viewPeriodoFiscal.jsp?idPeriodoFiscal=<%=PF.getIdPeriodoFiscal() %>">
																	<i class="fa fa-eye" title="Ver Periodo Fiscal"></i>
															</a>
															&nbsp;&nbsp;
															 <a href="openPeriodoFiscal.jsp?idPeriodoFiscal=<%=PF.getIdPeriodoFiscal() %>"> <i	class="fa fa-unlock" title="Abrir"></i>
															</a>
															</td>
														</tr>
    															
    															<%
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
			
			$(document).ready(function() {

                if (mensaje == "1") {
                    successAlert('Éxito', 'El Periodo Fiscal se ha guardado correctamente.')
                }
                
                if (mensaje == "2") {
                	errorAlert('Error', 'Los datos del Periodo Fiscal no se lograron guardar.')
                }
                
                if (mensaje == "3") {
                	successAlert('Éxito', 'Los datos del Periodo Fiscal se editaron correctamente.')
                }
                
                if (mensaje == "4") {
                	errorAlert('Error', 'Los datos del Periodo Fiscal no se pudieron editar.')
                }
                
                if (mensaje == "5") {
                	successAlert('Éxito', 'El periodo Fiscal fue cerrado correctamente.')
                }
                
                if (mensaje == "6") {
                	errorAlert('Error', 'No se pudo cerrar el periodo Fiscal.')
                }
                
                if (mensaje == "7") {
                	errorAlert('Error', 'Cierre primero los periodos contables que pertenezcan a este periodo fiscal.')
                }
                
                if (mensaje == "8") {
                	successAlert('Éxito', 'El Periodo fiscal se ha abierto correctamente.')
                }
                
                if (mensaje == "9") {
                	errorAlert('Error', 'El periodo fiscal no se logró abrir.')
                }

                $("#example1").DataTable({
                    "responsive": true,
                    "lengthChange": false,
                    "autoWidth": false,
                    "buttons": ["excel", "pdf"]
                }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

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