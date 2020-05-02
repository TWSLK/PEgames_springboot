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
                <li id="saishiguanli" name="menu-li" class="active" onclick="openUrl('/games/publics/activity/activity-list-page','saishiguanli')"><a><i class="fa fa-th-list"></i> <span>赛事管理</span></a></li>
                <li id="yonghuguanli" name="menu-li" onclick="openUrl('/games/publics/member/member-list-page','yonghuguanli')"><a><i class="fa fa-laptop"></i>  <span>用户管理</span></a></li>
                <li>
                    <h3 class="navigation-title">报表统计</h3>
                </li>
                <li id="baomingguanli" name="menu-li" onclick="openUrl('/games/publics/enter/enter-list-page','baomingguanli')"><a><i class="fa fa-book"></i> <span>报名管理</span></a></li>
                <li id="chengjiluru" name="menu-li" onclick="openUrl('/games/publics/enter/result-list-page','chengjiluru')"><a><i class="fa fa-bar-chart-o"></i> <span>成绩录入</span></a></li>
                <li id="chengjifabu" name="menu-li" onclick="openUrl('/games/publics/enter/publish-list-page','chengjifabu')"><a><i class="fa fa-bar-chart-o"></i> <span>成绩发布</span></a></li>
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
                                <img src="/games/static/img/avatar-mini.jpg" alt="">${admin.name}
                                <span class=" fa fa-angle-down"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu purple pull-right">
                                <li><a onclick="logout()"><i class="fa fa-sign-out pull-right"></i> 退出</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="page-wrapper">
        <iframe id="mainFrame" name="mainFrame" frameborder="no"
                scrolling="no" src="/games/publics/activity/activity-list-page"></iframe>
        </div>
    </div>
</section>
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
            url: "/games/publics/main/logout",
            type: "POST",
            dataType: "text",
            data: {
            },
            success: function(ret) {
                if (ret == "ERROR") {
                    alert("退出失败");
                } else {
                    window.location.href = "/games/publics/login/login-page";
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

</script>
</body>
</html>
