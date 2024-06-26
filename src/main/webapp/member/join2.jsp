<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>회원가입 페이지</title>

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
  <form method="post" action="joinAction.jsp">
    <img class="mb-4" src="assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
    <h1 class="h3 mb-3 fw-normal">please sign up</h1>

    <div class="form-floating">
      <input type="text" class="form-control" name="memberID" placeholder="ID">
      <label for="floatingInput">ID</label>
    </div>
    
    <div class="form-floating">
      <input type="password" class="form-control" name="memberPW" placeholder="Password">
      <label for="floatingPassword">Password</label>
    </div>
    
    <div class="form-floating">
      <input type="text" class="form-control" name="memberName" placeholder="name">
      <label for="floatingPassword">Name</label>
    </div>

    <div class="form-floating">
      <input type="password" class="form-control" name="memberSN" placeholder="SocialNumber">
      <label for="floatingPassword">SocialNumber</label>
    </div>
 
    <div class="form-floating">
      <input type="date" class="form-control" name="birthDate" placeholder="birthDate(2024-05-01)">
      <label for="floatingPassword">birthDate(2024-05-01)</label>
    </div>

    <button class="w-100 btn btn-lg btn-primary" type="submit">Sign up</button>
    
    
    <p class="mt-5 mb-3 text-muted">&copy; 2017ㅡ2021</p>
  </form>
</main>


    
  </body>
</html>
