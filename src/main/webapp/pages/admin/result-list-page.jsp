<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>成绩录入</title>
    <link href="/games/static/js/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen" />
    <link rel="stylesheet" href="/games/static/js/vector-map/jquery-jvectormap-1.1.1.css">
    <link href="/games/static/css/slidebars.css" rel="stylesheet">
    <link href="/games/static/js/switchery/switchery.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.css" rel="stylesheet" />
    <link href="/games/static/js/icheck/skins/all.css" rel="stylesheet">
    <link href="/games/static/css/owl.carousel.css" rel="stylesheet">
    <link href="/games/static/css/style.css" rel="stylesheet">
    <link href="/games/static/css/style-responsive.css" rel="stylesheet">
    <link href="/games/static/js/data-table/css/jquery.dataTables.css" rel="stylesheet">
    <link href="/games/static/js/data-table/css/dataTables.tableTools.css" rel="stylesheet">
    <link href="/games/static/js/data-table/css/dataTables.colVis.min.css" rel="stylesheet">
    <link href="/games/static/js/data-table/css/dataTables.responsive.css" rel="stylesheet">
    <link href="/games/static/js/data-table/css/dataTables.scroller.css" rel="stylesheet">
    <style>
        .list-body-content {
            background: #f3f3f3;
            min-height: 900px;
            position: relative;
        }
        .mytable {
            table-layout: fixed;
            width: 98%;
            border:0px;
            margin: 0px;
        }
        .mytable tr td {
            text-overflow: ellipsis; /* for IE */
            -moz-text-overflow: ellipsis; /* for Firefox,mozilla */
            overflow: hidden;
            white-space: nowrap;
            text-align: left
        }
    </style>
</head>

<body style="overflow-y:auto">
<div class="list-body-content">
    <div class="page-head">
        <h3>
            成绩录入
        </h3>
    </div>
    <div class="wrapper">
        <div class="row">
            <div class="col-sm-12">
                <section class="panel">
                    <table class="table responsive-data-table data-table mytable">
                        <thead>
                        <tr>
                            <th width="50px">编号</th>
                            <th>姓名</th>
                            <th>学号</th>
                            <th>活动名称</th>
                            <th>项目名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${enterList}" var="arr" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${arr.memberName}</td>
                            <td>${arr.memberAccount}</td>
                            <td>${arr.activityName}</td>
                            <td>${arr.itemName}</td>
                            <td>
                                <button type="button" onclick="showModal('${arr.id}','${arr.activityName}','${arr.itemName}','${arr.memberAccount}','${arr.unit}')" class="btn btn-sm btn-info">成绩录入</button>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="updateResultModal" style="z-index: 10000;" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateResultModalLabel">录入成绩</h5>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="account" class="col-form-label">学号（账号）:</label>
                        <input type="text" disabled class="form-control" id="account">
                    </div>
                    <div class="form-group">
                        <label for="activityName" class="col-form-label">运动会:</label>
                        <input type="text" disabled class="form-control" id="activityName">
                    </div>
                    <div class="form-group">
                        <label for="itemName" class="col-form-label">运动项目:</label>
                        <input type="text" disabled class="form-control" id="itemName">
                    </div>
                    <div class="form-group">
                        <label for="result" class="col-form-label">成绩（<span id="enterUnit">米</span>）:</label>
                        <input type="text" class="form-control" id="result" placeholder="输入成绩">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveResult()">保存</button>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="enterId"/>

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
<script src="/games/static/js/data-table/js/jquery.dataTables.min.js"></script>
<script src="/games/static/js/data-table/js/dataTables.tableTools.min.js"></script>
<script src="/games/static/js/data-table/js/bootstrap-dataTable.js"></script>
<script src="/games/static/js/data-table/js/dataTables.colVis.min.js"></script>
<script src="/games/static/js/data-table/js/dataTables.responsive.min.js"></script>
<script src="/games/static/js/data-table/js/dataTables.scroller.min.js"></script>
<script src="/games/static/js/data-table-init.js"></script>
<script type="text/javascript">

    function saveResult() {
        var result = $("#result").val();
        var enterId = $("#enterId").val();

        $.ajax({
            url: "/games/publics/enter/enter-update-result",
            type: "POST",
            dataType: "text",
            data: {
                id: enterId,
                result: result
            },
            success: function(ret) {
                if (ret == "ERROR") {
                    alert("操作失败");
                } else {
                    alert("操作成功");
                    window.location.reload();
                }
            },
            error: function(res){
                alert("删除失败，请重新操作！");
            }
        });
    }

    function showModal(enterId, activityName, itemName, memberAccount, unit) {
        $("#enterId").val(enterId);
        $("#account").val(memberAccount);
        $("#activityName").val(activityName);
        $("#itemName").val(itemName);
        $("#enterUnit").html(unit);
        $('#updateResultModal').modal("show");
    }

</script>
</body>
</html>
