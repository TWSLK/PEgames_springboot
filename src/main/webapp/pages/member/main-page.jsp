<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统首页</title>
    <link href="/games/static/js/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen" />
    <link rel="stylesheet" href="/games/static/js/vector-map/jquery-jvectormap-1.1.1.css">
    <link href="/games/static/css/slidebars.css" rel="stylesheet">
    <link href="/games/static/js/switchery/switchery.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.css" rel="stylesheet" />
    <link href="/games/static/js/icheck/skins/all.css" rel="stylesheet">
    <link href="/games/static/css/owl.carousel.css" rel="stylesheet">
    <link href="/games/static/css/style.css" rel="stylesheet">
    <link href="/games/static/css/style-responsive.css" rel="stylesheet">
    <style type="text/css">
        #mainFrame {
            border:0;
            width:100%;
            height:100%;
        }
    </style>
</head>

<body class="sticky-header">
<section>
    <div class="sidebar-left">
        <div class="sidebar-left-info">
            <ul class="nav nav-pills nav-stacked side-navigation">
                <li>
                    <h3 class="navigation-title">基础管理</h3>
                </li>
                <li id="zaixianbaoming" name="menu-li" class="active" onclick="openUrl('/games/privates/activity/activity-list-page','zaixianbaoming')"><a><i class="fa fa-th-list"></i> <span>在线报名</span></a></li>
                <li id="wodebaoming" name="menu-li" onclick="openUrl('/games/privates/enter/enter-list-page','wodebaoming')"><a><i class="fa fa-laptop"></i>  <span>我的报名</span></a></li>
                <li>
                    <h3 class="navigation-title">历史查询</h3>
                </li>
                <li id="lishihuodong" name="menu-li" onclick="openUrl('/games/privates/activity/activity-history-list-page','lishihuodong')"><a><i class="fa fa-book"></i> <span>历史活动</span></a></li>
            </ul>
        </div>
    </div>
    <div class="body-content" >
        <div class="header-section" style="background-color: #32323a">
            <div class="logo dark-logo-bg hidden-xs hidden-sm">
                <a>
                    <span class="brand-name"><strong>校园运动会</strong>管理系统</span>
                </a>
            </div>
            <div class="notification-wrap">
                <div class="right-notification">
                    <ul class="notification-menu">
                        <li>
                            <a href="javascript:;" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <img src="/games/static/img/img1.jpg" alt="">${member.name}
                                <span class=" fa fa-angle-down"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu purple pull-right">
                                <li><a onclick="userSet()"><i class="icon-user pull-right"></i> 个人设置</a></li>
                                <li><a onclick="logout()"><i class="fa fa-sign-out pull-right"></i> 退出</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="page-wrapper">
        <iframe id="mainFrame" name="mainFrame" frameborder="no"
                scrolling="no" src="/games/privates/activity/activity-list-page"></iframe>
        </div>
    </div>
</section>


<div class="modal fade" id="updateMemberModal" style="z-index: 10000;" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateMemberModalLabel">用户更新</h5>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="account" class="col-form-label">学号（账号）:</label>
                        <input type="text" disabled class="form-control" id="account" placeholder="输入学号" value="${member.account}">
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-form-label">用户名称:</label>
                        <input type="text" class="form-control" id="name" placeholder="输入用户名称" value="${member.name}">
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-form-label">密码:</label>
                        <input type="password" class="form-control" id="password" placeholder="输入密码" value="${member.password}">
                    </div>
                    <div class="form-group">
                        <label for="again-password" class="col-form-label">再次输入:</label>
                        <input type="password" class="form-control" id="again-password" placeholder="输入密码" value="${member.password}">
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-form-label">手机号:</label>
                        <input type="text" class="form-control" id="phone" placeholder="输入手机号" value="${member.phone}">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updateMember()">保存</button>
            </div>
        </div>
    </div>
</div>


<script src="/games/static/js/jquery-1.10.2.min.js"></script>
<script src="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
<script src="/games/static/js/jquery-migrate.js"></script>
<script src="/games/static/js/bootstrap.min.js"></script>
<script src="/games/static/js/modernizr.min.js"></script>
<script src="/games/static/js/jquery.nicescroll.js" type="text/javascript"></script>
<script src="/games/static/js/slidebars.min.js"></script>
<script src="/games/static/js/switchery/switchery.min.js"></script>
<script src="/games/static/js/switchery/switchery-init.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.js"></script>
<script src="/games/static/js/flot-chart/flot-spline.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.resize.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.tooltip.min.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.pie.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.selection.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.stack.js"></script>
<script src="/games/static/js/flot-chart/jquery.flot.crosshair.js"></script>
<script src="/games/static/js/earning-chart-init.js"></script>
<script src="/games/static/js/sparkline/jquery.sparkline.js"></script>
<script src="/games/static/js/sparkline/sparkline-init.js"></script>
<script src="/games/static/js/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
<script src="/games/static/js/easy-pie-chart.js"></script>
<script src="/games/static/js/vector-map/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/games/static/js/vector-map/jquery-jvectormap-world-mill-en.js"></script>
<script src="/games/static/js/dashboard-vmap-init.js"></script>
<script src="/games/static/js/icheck/skins/icheck.min.js"></script>
<script src="/games/static/js/todo-init.js"></script>
<script src="/games/static/js/jquery-countTo/jquery.countTo.js"  type="text/javascript"></script>
<script src="/games/static/js/owl.carousel.js"></script>
<%--<script src="/games/static/js/scripts.js"></script>--%>
<script type="text/javascript">
    function logout() {
        $.ajax({
            url: "/games/privates/main/logout",
            type: "POST",
            dataType: "text",
            data: {
            },
            success: function(ret) {
                if (ret == "ERROR") {
                    alert("退出失败");
                } else {
                    window.location.href = "/games/privates/login/login-page";
                }
            },
            error: function(res){
                alert("操作失败，请重新操作！");
            }
        });
    }

    function openUrl(url, obj) {
        $("[name='menu-li']").each(function(index,el){
            $(el).removeClass("active");
        });

        $("#" + obj).addClass("active");
        $("#mainFrame").attr("src", url);
    }

    function userSet() {
        $("#updateMemberModal").modal("show");
    }

    function updateMember() {
        // 获得基本信息
        var account = $("#account").val();
        var name = $("#name").val();
        var password = $("#password").val();
        var againPassword = $("#again-password").val();
        var phone = $("#phone").val();
        if (name == "" || password == "" || againPassword == "" || phone == "") {
            alert("请全部填写");
            return;
        }
        if (password != againPassword) {
            alert("密码两次输入不一致，请重新输入");
            return;
        }

        $.ajax({
            url: "/games/privates/member/update-member",
            type: "POST",
            dataType: "text",
            data: {
                account: account,
                name: name,
                password: password,
                phone: phone
            },
            success: function(ret) {
                if (ret == "ERROR") {
                    alert("操作失败");
                } else {
                    alert("保存成功");
                    window.location.reload();
                }
            },
            error: function(res){
                alert("操作失败，请重新操作！");
            }
        });
    }

</script>
</body>
</html>
