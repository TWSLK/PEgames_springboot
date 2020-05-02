<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>资料查看</title>
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
                    <h4 style="color: white">【${activity.name}】-资料查看</h4>
                </div>
                <div class="col-sm-2">
                    <c:if test="${!endBln}">
                        <button type="button" class="btn btn-sm btn-success" onclick="showItem()">报名</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="container-fluid" style="margin-top:30px;">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div>${activity.data}</div>
                </div>
                <div class="col-sm-1"></div>
            </div>
        </div>


        <div class="modal fade" id="addEnterModal" style="z-index: 10000;" tabindex="-1" role="dialog"
             aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addEnterModalLabel">活动报名</h5>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="name" class="col-form-label">活动名称:</label>
                                <input type="text" class="form-control" disabled id="name" placeholder="输入活动名称" value="${activity.name}">
                            </div>
                            <div class="form-group">
                                <label for="startTime" class="col-form-label">开始时间:</label>
                                <input type="text" class="form-control" disabled id="startTime" placeholder="输入开始时间：如 2019-12-28" value="<fmt:formatDate value="${activity.startTime}" pattern="yyyy-MM-dd"/>">
                            </div>
                            <div class="form-group">
                                <label for="endTime" class="col-form-label">结束时间:</label>
                                <input type="text" class="form-control" disabled id="endTime" placeholder="输入结束时间：如 2019-12-29" value="<fmt:formatDate value="${activity.endTime}" pattern="yyyy-MM-dd"/>">
                            </div>
                            <div class="form-group">
                                <label class="col-form-label">项目:</label>
                                <label class="checkbox-custom check-success">
                                    <c:forEach items="${itemList}" var="arr" varStatus="status">
                                        <input type="checkbox" checked name="itemName" id="${arr.id}">
                                        <label for="${arr.id}">${arr.name}</label>
                                    </c:forEach>
                                </label>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" onclick="addEnter('${activity.id}')">提交</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="/games/static/js/jquery-1.10.2.min.js"></script>
    <script src="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="/games/static/js/jquery-migrate.js"></script>
    <script src="/games/static/js/bootstrap.min.js"></script>

    <script src="/games/static/js/icheck/skins/icheck.min.js"></script>
    <script>
        function showItem() {
            $('#addEnterModal').modal("show");
        }

        function addEnter(activityId) {
            var items = "";
            var count = 0;
            $("input:checkbox[name='itemName']:checked").each(function() { // 遍历name=test的多选框
                items += $(this).attr("id") + ";";
                count += 1;
            });
            if (count < 1) {
                alert("请至少选择一个项目报名");
                return;
            }
            if (count > 3) {
                alert("每届运动会最多报名三个，请重新选择");
                return;
            }
            // 保存到后台
            $.ajax({
                url: "/games/privates/enter/enter-add",
                type: "POST",
                dataType: "text",
                data: {
                    activityId: activityId,
                    items: items
                },
                success: function (ret) {
                    if (ret == "SUCCESS") {
                        alert("操作成功");
                        window.location.reload();
                    } else {
                        alert(ret);
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
