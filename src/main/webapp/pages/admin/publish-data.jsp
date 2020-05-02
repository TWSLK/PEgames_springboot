<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>成绩详情</title>
        <link href="/games/static/js/switchery/switchery.min.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.css" rel="stylesheet" />
        <link href="/games/static/js/icheck/skins/all.css" rel="stylesheet">
        <link href="/games/static/css/owl.carousel.css" rel="stylesheet">
        <link href="/games/static/css/style.css" rel="stylesheet">
    </head>
    <body>
        <div class="container" style="margin-top:20px;">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h4 style="color: white">【${activity.name}】-【${item.name}项目】</h4>
                </div>
                <div class="col-sm-2">
                    <button type="button" class="btn btn-sm btn-success" onclick="rank('${activity.id}', '${item.id}', '${item.rank}')">生成排名</button>
                </div>
            </div>
        </div>
        <div class="container-fluid" style="margin-top:30px;">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <section class="panel">
                        <table class="table responsive-data-table data-table">
                            <thead>
                            <tr>
                                <th width="50px">序号</th>
                                <th>学号</th>
                                <th>名称</th>
                                <th>成绩</th>
                                <th>排名</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${enterList}" var="arr" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${arr.memberAccount}</td>
                                    <td>${arr.memberName}</td>
                                    <td>${arr.result}${item.unit}</td>
                                    <td>
                                        <c:if test="${arr.rank == null || arr.rank == ''}">未排名</c:if>
                                        <c:if test="${arr.rank != null && arr.rank != ''}">${arr.rank}</c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${enterList.size() == 0}">
                                <tr>
                                   <td colspan="5" style="text-align: center;">暂无数据</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </section>
                </div>
                <div class="col-sm-1"></div>
            </div>
        </div>
    <script src="/games/static/js/jquery-1.10.2.min.js"></script>
    <script src="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="/games/static/js/jquery-migrate.js"></script>
    <script src="/games/static/js/bootstrap.min.js"></script>

    <script src="/games/static/js/icheck/skins/icheck.min.js"></script>
    <script>
        function rank(activityId, itemId, itemRank) {
            $.ajax({
                url: "/games/publics/enter/rank",
                type: "POST",
                dataType: "text",
                data: {
                    activityId: activityId,
                    itemId: itemId,
                    rank: itemRank
                },
                success: function (ret) {
                    if (ret == "SUCCESS") {
                        alert("操作成功");
                        window.location.reload();
                    } else {
                        alert("操作失败");
                    }
                },
                error: function (res) {
                    alert("操作失败，请重新操作！");
                }
            });
        }
    </script>
    </body>

</html>
