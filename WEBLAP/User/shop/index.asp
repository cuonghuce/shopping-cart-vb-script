<%

'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=CUONG-IT;Database=Doan_2023;User Id=sa; Password=123456"
connDB.ConnectionString = strConnection
%>
<%
    ' code here to retrive the data from product table
    Dim sqlString, rs
    sqlString = "Select * from tbl_SanPham"
    connDB.Open()
    set rs = connDB.execute(sqlString)  
%>

<!DOCTYPE html>
<html lang="en">

<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Website bán đồ điện tử</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<!-- Bootstrap style -->
	<link id="callCss" rel="stylesheet" href="themes/bootshop/bootstrap.min.css" media="screen" />
	<link href="themes/css/base.css" rel="stylesheet" media="screen" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<!-- Bootstrap style responsive -->
	<link href="themes/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link href="themes/css/font-awesome.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="./themes/css/all.min.css">
	<!-- Google-code-prettify -->
	<link href="themes/js/google-code-prettify/prettify.css" rel="stylesheet" />
	<!-- fav and touch icons -->
	<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" sizes="144x144"
		href="themes/images/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114"
		href="themes/images/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="themes/images/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="themes/images/ico/apple-touch-icon-57-precomposed.png">
	<style type="text/css" id="enject"></style>
	<style>
		.btn-hover:hover {
			background-color: #212529!important;
		}
		a:hover {
			
			 color:#005580!important;
			}
		.fa-user {
			font-size:30px;
		}
		.user_link {
			margin-left:10px;
			margin-top:3px;
		}
	</style>
</head>

<body>
	<header class="p-3 bg-dark text-white">
		<div class="container">
			<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
				<a href="#" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
										
					<h5 style="margin-top:11px;" class="nav-link px-2 text-white"><img width="40" height="32" src="../../img/logo.png" class="bi me-2" /><span>Shopping</span></h5>
					
				</a>

				<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li><a href="index.asp" class="nav-link px-2 text-secondary btn-hover">Trang Chủ</a></li>
					<li><a href="#" class="nav-link px-2 text-white btn-hover">Sản Phẩm</a></li>
					<li><a href="#" class="nav-link px-2 text-white btn-hover">Giới Thiệu</a></li>
					<li><a href="#" class="nav-link px-2 text-white btn-hover">Hỗ Trợ Online</a></li>
				</ul>

				<form style="margin-top:8px;" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
					<input style="height:29px;" type="search" class="form-control form-control-dark" placeholder="Search..." aria-label="Search">
				</form>

				<div class="text-end" style="display:flex;">

					<a href="shoppingcart.asp" type="button" class="btn btn-info"><i class="fa-sharp fa-cart-shopping"></i> Giỏ Hàng</a>

					<div class="user_link">
						<a href="logoutUser.asp" class=""><i class="fa fa-user"></i> </a>
					</div>
				</div>
			</div>
		</div>
  </header>
	<!-- Header End====================================================================== -->
	<div class="container">
		<div class="container">
			<%
				If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
			%>
					<div class="alert alert-success mt-2" role="alert">
						<%=Session("Success")%>
					</div>
			<%
					Session.Contents.Remove("Success")
				End If
			%>
			<%
				If (NOT IsEmpty(Session("Error")) AND NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
			%>
					<div class="alert alert-danger mt-2" role="alert">
						<%=Session("Error")%>
					</div>
			<%
					Session.Contents.Remove("Error")
				End If
			%>
		</div>
		<div id="carouselBlk">
			<div id="myCarousel" class="carousel slide">
				<div class="carousel-inner">
					<div class="item active">
						<div class="container">
							<a href="register.html"><img style="width:100%" src="themes/images/carousel/3.png"
									alt="special offers" /></a>
							<div class="carousel-caption">
								<h4>Second Thumbnail label</h4>
								<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
									gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="container">
							<a href="register.html"><img style="width:100%" src="themes/images/carousel/2.png" alt="" /></a>
							<div class="carousel-caption">
								<h4>Second Thumbnail label</h4>
								<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
									gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="container">
							<a href="register.html"><img src="themes/images/carousel/3.png" alt="" /></a>
							<div class="carousel-caption">
								<h4>Second Thumbnail label</h4>
								<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
									gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
							</div>

						</div>
					</div>
					<div class="item">
						<div class="container">
							<a href="register.html"><img src="themes/images/carousel/4.png" alt="" /></a>
							<div class="carousel-caption">
								<h4>Second Thumbnail label</h4>
								<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
									gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
							</div>

						</div>
					</div>
					<div class="item">
						<div class="container">
							<a href="register.html"><img src="themes/images/carousel/5.png" alt="" /></a>
							<div class="carousel-caption">
								<h4>Second Thumbnail label</h4>
								<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
									gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="container">
							<a href="register.html"><img src="themes/images/carousel/6.png" alt="" /></a>
							<div class="carousel-caption">
								<h4>Second Thumbnail label</h4>
								<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
									gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
							</div>
						</div>
					</div>
				</div>
				<a class="left carousel-control" href="#myCarousel" data-slide="prev"><i style="font-size:30px; margin-bottom:10px;" class="fa-solid fa-angle-left"></i></a>
				<a class="right carousel-control" href="#myCarousel" data-slide="next"><i style="font-size:30px; margin-bottom:10px;" class="fa-solid fa-angle-right"></i></a>
			</div>
		</div>
	</div>
	
	<div id="mainBody" style="border:none;">
		<div class="container">
					
			<div class="row">
				
				<div class="span9">
					<div class="container" style="margin: 0 -24px;">
						<div class="well well-small">
							<h4>Featured Products <small class="pull-right">200+ featured products</small></h4>
							<div class="row-fluid">
								<div id="featured" class="carousel slide">
									<div class="carousel-inner">
										<div class="item active">
											<ul class="thumbnails">
												<li class="span3">
													<div class="thumbnail">
														<i class="tag"></i>
														<a href="product_details.html"><img
																src="themes/images/products/1.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<i class="tag"></i>
														<a href="product_details.html"><img
																src="themes/images/products/2.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<i class="tag"></i>
														<a href="product_details.html"><img
																src="themes/images/products/3.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<i class="tag"></i>
														<a href="product_details.html"><img
																src="themes/images/products/4.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
											</ul>
										</div>
										<div class="item">
											<ul class="thumbnails">
												<li class="span3">
													<div class="thumbnail">
														<i class="tag"></i>
														<a href="product_details.html"><img
																src="themes/images/products/5.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<i class="tag"></i>
														<a href="product_details.html"><img
																src="themes/images/products/6.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/7.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/8.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
											</ul>
										</div>
										<div class="item">
											<ul class="thumbnails">
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/9.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/10.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/11.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/1.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
											</ul>
										</div>
										<div class="item">
											<ul class="thumbnails">
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/2.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/3.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/4.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
												<li class="span3">
													<div class="thumbnail">
														<a href="product_details.html"><img
																src="themes/images/products/5.jpg" alt=""></a>
														<div class="caption">
															<h5>Sản Phẩm HOT</h5>
															<h4><a class="btn" href="product_details.html">VIEW</a> <span
																	class="pull-right">$222.00</span></h4>
														</div>
													</div>
												</li>
											</ul>
										</div>
									</div>
									<a class="left carousel-control" href="#featured" data-slide="prev"><i style="font-size:30px; margin-bottom:10px;" class="fa-solid fa-angle-left"></i></a>
									<a class="right carousel-control" href="#featured" data-slide="next"><i style="font-size:30px; margin-bottom:10px;" class="fa-solid fa-angle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="container">
					<h4>Latest Products </h4>
						<div class="row d-flex">
								<%
								do while not rs.EOF
								%>
							<div class="col-4">
								
									<ul class="thumbnails">
										<li class="span3">
											<div class="thumbnail">
												<a href="product_details.html"><img src="themes/images/products/4.jpg" alt="" /></a>
												<div class="caption">
													<h5><% = rs("TenSP")%></h5>
													<p class="text-truncate">
														<% = rs("MoTa") %>
													</p>

													<h4 style="text-align:center">
														<a class="btn" href="product_details.html"> 
															<i class="icon-zoom-in" style="padding-top: 4px;"></i>
														</a> 
														<a class="btn" href="addCart.asp?idproduct=<%= rs("MaSP")%>">Add to 
															<i class="icon-shopping-cart" style="padding-top: 4px;"></i>
														</a>
														<a class="btn btn-primary" href="#">$<% = rs("GiaBan") %></a>
													</h4>
												</div>
											</div>
										</li>							
									</ul>									
							</div>
							<%
								rs.MoveNext
							loop
							rs.Close()
							connDB.Close()
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer ================================================================== -->
	<div id="">
		<div class="">

			<footer class="bg-dark text-center text-white">
				<!-- Grid container -->
				<div class="container p-4 pb-0">
					<!-- Section: Social media -->
					<section class="mb-4">
					<!-- Facebook -->
					<a class="btn" href="#!" role="button"
						><i class="fa-brands fa-facebook"></i
					></a>

					<!-- Twitter -->
					<a class="btn  btn-floating m-1" href="#!" role="button"
						><i class="fa-brands fa-twitter"></i
					></a>

					<!-- Google -->
					<a class="btn  btn-floating m-1" href="#!" role="button"
						><i class="fa-brands fa-google"></i
					></a>

					<!-- Instagram -->
					<a class="btn  btn-floating m-1" href="#!" role="button"
						><i class="fa-brands fa-instagram"></i
					></a>

					<!-- Linkedin -->
					<a class="btn  btn-floating m-1" href="#!" role="button"
						><i class="fa-brands fa-linkedin-in"></i
					></a>

					<!-- Github -->
					<a class="btn  btn-floating m-1" href="#!" role="button"
						><i class="fa-brands fa-github"></i
					></a>
					</section>
					<!-- Section: Social media -->
				</div>
				<!-- Grid container -->

				<!-- Copyright -->
				<div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
					© 2023 
					<a class="text-white" href="https://mdbootstrap.com/">MDBootstrap.com</a>
				</div>
				<!-- Copyright -->
			</footer>
		</div><!-- Container End -->
	</div>
	<!-- Placed at the end of the document so the pages load fater ============================================= -->
	<script src="themes/js/jquery.js" type="text/javascript"></script>
	<script src="themes/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="themes/js/google-code-prettify/prettify.js"></script>
	<script src="themes/js/bootshop.js"></script>
	<script src="themes/js/all.js"></script>
	<script src="themes/js/jquery.lightbox-0.5.js"></script>
	<script>
		window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
	</script>

	<span id="themesBtn"></span>
</body>

</html>