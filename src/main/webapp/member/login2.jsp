<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>로그인 페이지</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">

    

    <!-- Bootstrap core CSS -->
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">
  </head>
  <body class="text-center">
    
	<main class="form-signin">
	  <form method="post" action="loginAction2.jsp">
	    <img class="mb-4" src="assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
	    <h1 class="h3 mb-3 fw-normal">Please sign in</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" name="memberID" placeholder="ID">
	      <label for="floatingInput">ID</label>
	    </div>
	    
	    <div class="form-floating">
	      <input type="password" class="form-control" name="memberPW" placeholder="Password">
	      <label for="floatingPassword">Password</label>
	    </div>
	
	    <button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
	   
	  </form>
      <p></p>
      <button class="w-100 btn btn-lg btn-primary" type="submit" onclick="location.href='join2.jsp'">회원가입</button>
      	    <p class="mt-5 mb-3 text-muted">&copy; 2017-2021</p>
	</main>


    
  </body>
</html>
