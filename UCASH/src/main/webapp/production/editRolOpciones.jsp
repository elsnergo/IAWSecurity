<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

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
		response.sendRedirect("page_403.jsp");
		//response.sendRedirect("page_403.jsp");
		return;
	}
	
%>


<!DOCTYPE html>
<html>
<%
Vw_rolopciones rolOpciones = new Vw_rolopciones();
Dt_rolOpciones datosUsuarioRol = new Dt_rolOpciones();

int idRolOp = (request.getParameter("idRolOpciones") != null) ? Integer.parseInt(request.getParameter("idRolOpciones")) : 0;

rolOpciones = datosUsuarioRol.ObtenerRolOpcionPorId(idRolOp);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Editar | Detalle Rol Opciones</title>

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
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Editar Rol Opciones</h3>
						</div>

<!-- 						<div class="title_right"> -->
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Editar Rol Opciones</h2>

									<div class="clearfix"></div>
								</div>
								
								<div class="x_content">
									<form class="" action="../Sl_rolOpciones" method="post" novalidate>
									  <input type="hidden" value="2" name="opcion" id="opcion"/>
									  <input type="hidden" value="<%=rolOpciones.getIdRolOpciones()%>" name="idRolOpciones"/>
										<span class="section">Datos de Rol Opciones</span>
			
										<div class="field item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3  label-align">Rol: <span class="required"></span></label>
                                            <div class="col-md-6 col-sm-6">
<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
												<%
							                      	ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
							                      	Dt_rol dtr = new Dt_rol();
							                      	listRol = dtr.listaRolesActivos();
								                 %>
								                 <select class="form-control js-example-basic-single" name="cbxRol" id="cbxRol" required="required">
												  <option value=""><%="Dato actual: " + rolOpciones.getRol()%></option>
												  <% 
												  	for(Tbl_rol trol :listRol){
												  %>
												  <option value="<%=trol.getIdRol()%>"><%=trol.getNombre()%></option>
												  <%
												  	}
												  %>
								                
												</select>
											</div>
                                        </div>
                                        
                                        <div class="field item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3  label-align">Opción: <span class="required"></span></label>
                                            <div class="col-md-6 col-sm-6">
<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
                                                  <%
							                      	ArrayList<Tbl_opciones> listaOpciones = new ArrayList<Tbl_opciones>();
							                      	Dt_opciones dto = new Dt_opciones();
							                      	listaOpciones = dto.listaOpcionesActivas();
								                 %>

								                 <select class="form-control js-example-basic-single" name="cbxOpciones" id="cbxOpciones" required="required">
												  <option value=""><%="Dato actual: " + rolOpciones.getDescripcion() %></option>
												  <% 
												  	for(Tbl_opciones to :listaOpciones){
												  %>
												  <option value="<%=to.getIdOpciones()%>"><%=to.getDescripcion()%></option>
												  <%
												  	}
												  %>


												</select>
											</div>
                                        </div>
										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button type="button" onClick="window.location.href='tbl_rolOpciones.jsp'" class="btn btn-danger">Cancelar</button>
													<button type='submit' class="btn btn-primary">Editar</button>
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
	<!-- Select2 -->
	<script src="../vendors/select2/dist/js/select2.full.min.js"></script>

	<!-- Javascript functions	-->

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
	<!-- validator -->
	<!-- <script src="../vendors/validator/validator.js"></script> -->

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	<script src="../vendors/select2/dist/js/select2.min.js"></script>
</body>
</html>