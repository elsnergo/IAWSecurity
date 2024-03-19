<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Editar | Detalle Tasa Cambio</title>

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
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.html" class="site_title"><i class="fa fa-money"></i>
							<span>Sistema Contable</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile clearfix">
						<div class="profile_pic">
							<img src="img.jpg" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Bienvenido,</span>
							<h2>Lic. José Ortega.</h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<br />

					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<ul class="nav side-menu">
								<li><a href="index.html"><i class="fa fa-home"></i>Inicio</a></li>
							</ul>
						</div>
						
						<div class="menu_section">
							<h3>Gestión</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-shield"></i> Seguridad <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_usuario.jsp">Usuarios</a></li>
										<li><a href="tbl_rol.jsp">Roles</a></li>
										<li><a href="tbl_opciones.jsp">Opciones</a></li>
										<li><a href="tbl_usuarioRol.jsp">Roles de Usuario</a></li>
										<li><a href="tbl_rolOpciones.jsp">Opciones de Rol</a></li>
									</ul></li>
									
									<li><a><i class="fa fa-building"></i> Empresa<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_empresa.jsp">Empresas</a></li>
                                                            <li><a href="tbl_departamento.jsp">Departamento</a></li>
										<li><a href="tbl_municipio.jsp">Municipio</a></li>
										<li><a href="listadoRepresentanteLegal.jsp">Representante Legal</a></li>
									</ul></li>
									
									<li><a><i class="fa fa-file"></i> Cuenta Contable<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_catalogocuenta.jsp">Catalogo Cuenta</a></li>
										<li><a href="tbl_tipocuenta.jsp">Tipo Cuenta</a></li>
										<li><a href="tbl_cuentacontable.jsp">Cuenta Contable</a></li>
									</ul></li>
									
									<li><a><i class="fa fa-dollar"></i> Moneda<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_moneda.jsp">Moneda</a></li>
										<li><a href="tbl_tasaCambio.jsp">Tasa Cambio</a></li>
									</ul></li>

								<li><a><i class="fa fa-book"></i> Asiento Contable<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_asientoContable.jsp">Asiento Contable</a></li>
										<li><a href="tbl_periodoContable.jsp">Periodo Contable</a></li>
										<li><a href="tbl_periodoFiscal.jsp">Periodo Fiscal</a></li>
										<li><a href="tbl_tipoDocumento.jsp">Tipo Documento</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
					<!-- /sidebar menu -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<div class="nav toggle">
						<a id="menu_toggle"><i class="fa fa-bars"></i></a>
					</div>
					<nav class="nav navbar-nav">
						<ul class=" navbar-right">
							<li class="nav-item dropdown open" style="padding-left: 15px;">
								<a href="javascript:;" class="user-profile dropdown-toggle"
								aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown"
								aria-expanded="false"> <img src="img.jpg" alt="">Lic. José Ortega.
							</a>
								<div class="dropdown-menu dropdown-usermenu pull-right"	aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="login.html"><i class="fa fa-sign-out pull-right"></i>Cerrar Sesión</a>
								</div>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->
			<!-- /top navigation -->
			
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Editar Tasa Cambio</h3>
						</div>

<!-- 						<div class="title_right"> -->
<!-- 							<div class="col-md-5 col-sm-5 form-group pull-right top_search"> -->
<!-- 								<div class="input-group"> -->
<!-- 									<input type="text" class="form-control" -->
<!-- 										placeholder="Buscar..."> <span -->
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
									<h2>Editar Tasa Cambio</h2>

									<div class="clearfix"></div>
								</div>
								
								<div class="x_content">
									<form class="" action="../Sl_tasaCambio" method="post" novalidate>
									  <input type="hidden" value="1" name="opcion" id="opcion"/>
										<span class="section">Datos de Tasa Cambio</span>
			
										<div class="field item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3  label-align">Id Moneda Origen<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6">
<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
                                                 <%
							                      	ArrayList<Tbl_moneda> listMoneda = new ArrayList<Tbl_moneda>();
							                      	Dt_moneda dtmon = new Dt_moneda();
							                      	listMoneda = dtmon.listaMonedasActivas();
								                 %>
								                 <select class="form-control js-example-basic-single" name="cbxMonedaO" id="cbxMonedaO" required="required">
												  <option value="">Seleccione...</option>
												  <% 
												  	for(Tbl_moneda moneda :listMoneda){
												  %>
												  <option value="<%=moneda.getIdMoneda()%>"><%=moneda.getNombre()%></option>
												  <%
												  	}
												  %>
												</select>
											</div>
                                        </div>
                                        
                                        <div class="field item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3  label-align">Id Moneda Destino<span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6">
<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
                                                 <%
							                      	ArrayList<Tbl_moneda> listaMoneda = new ArrayList<Tbl_moneda>();
							                      	Dt_moneda dtmo = new Dt_moneda();
							                      	listaMoneda = dtmo.listaMonedasActivas();
								                 %>
								                 <select class="form-control js-example-basic-single" name="cbxMonedaD" id="cbxMonedaD" required="required">
												  <option value="">Seleccione...</option>
												  <% 
												  	for(Tbl_moneda mon :listaMoneda){
												  %>
												  <option value="<%=mon.getIdMoneda()%>"><%=mon.getNombre()%></option>
												  <%
												  	}
												  %>
												</select>
											</div>
                                        </div>
										
										<!--  <div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Fecha<span class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="fecha" data-validate-length-range="5,15" type="date" required="required"/>
											</div>
										</div> -->
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Tipo Cambio<span class="required">*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="tipoCambio" type="number" required='required' placeholder="Tipo de Cambio" />
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Valor<span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="valor"  type="number" required="required" placeholder="valor"/>
											</div>
										</div>
									
										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button type='submit' class="btn btn-primary">Editar</button>
													<button type="button" class="btn btn-primary">Cancelar</button>
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
				<div class="pull-right">UCASH >> Sistema contable</div>
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

</body>
</html>