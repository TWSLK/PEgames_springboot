<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台登录</title>
    <link href="/games/static/css/style.css" rel="stylesheet">
    <link href="/games/static/css/style-responsive.css" rel="stylesheet">
</head>
<body class="login-body">
    <%
        String loginInfo = (String) request.getAttribute("loginInfo");
        if (loginInfo == null) {
            loginInfo = "";
        }
    %>
    <div class="login-logo">
    </div>

    <h2 class="form-heading">校园运动会系统 管理员登录</h2>
    <div class="container log-row">
        <form class="form-signin">
            <div class="login-wrap">
                <input id="account" type="text" class="form-control" placeholder="User ID" autofocus>
                <input id="password" type="password" class="form-control" placeholder="Password">
                <button onclick="login()" class="btn btn-lg btn-success btn-block" type="button">LOGIN</button>
                <div class="login-social-link">
                  
                </div>
                <div class="registration">
                    Don't have an account yet?
                    <a class="" onclick="alert('请联系管理员开通学号账户');">
                        Create an account
                    </a>
                </div>
            </div>
        </form>
    </div>
    <input type="hidden" id="loginInfo" value="<%=loginInfo%>" />
    <!--jquery-1.10.2.min-->
    <script src="/games/static/js/jquery-1.11.1.min.js"></script>
    <!--Bootstrap Js-->
    <script src="/games/static/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        // 判断是否需要在登陆页面给提示
        $(document).ready(function() {
            var loginInfo = $("#loginInfo").val();
            if (loginInfo != undefined && loginInfo != "") {
                alert(loginInfo);
                $("#loginInfo").val("");
            }
        });
        // 登陆校验
        function login() {
            var account = $("#account").val();
            var password = $("#password").val();
            if (account == "" || password == "") {
                alert("用户名或密码不能为空");
                return;
            }
            window.location.href = "/games/publics/login/login-check?account="
                + account + "&password=" + password;
        }

        document.onkeydown = function(e){
            if(e.keyCode == 13){
                login();
            }
        }
    </script>
</body>
</html>
