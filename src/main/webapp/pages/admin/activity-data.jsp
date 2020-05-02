<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>资料编写</title>
        <link href="/games/static/js/switchery/switchery.min.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.css" rel="stylesheet" />
        <link href="/games/static/js/icheck/skins/all.css" rel="stylesheet">
        <link href="/games/static/css/owl.carousel.css" rel="stylesheet">
        <link href="/games/static/css/style.css" rel="stylesheet">
        <link href="/games/static/summernote/summernote-bs4.css" rel="stylesheet">
    </head>
    <body>
        <div class="container" style="margin-top:20px;">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h4 style="color: white">【${activityName}】-资料编写</h4>
                </div>
                <div class="col-sm-2">
                    <button type="button" class="btn btn-sm btn-success" onclick="saveData('${activityId}')">保存</button>
                </div>
            </div>
        </div>
        <div class="container-fluid" style="margin-top:30px;">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div id="summernote"></div>
                </div>
                <div class="col-sm-1"></div>
            </div>
        </div>
    <script src="/games/static/js/jquery-1.10.2.min.js"></script>
    <script src="/games/static/js/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="/games/static/js/jquery-migrate.js"></script>
    <script src="/games/static/js/bootstrap.min.js"></script>

    <script src="/games/static/js/icheck/skins/icheck.min.js"></script>
    <script src="/games/static/summernote/summernote-bs4.js"></script>
    <script src="/games/static/js/ajaxfileupload.js"></script>
    <script>
        $('#summernote').summernote({
            placeholder: 'Hello bootstrap 4',
            tabsize: 2,
            height: 400,
            callbacks: {
                onImageUpload: function (blobInfo,editor, welEditable) {
                    sendFile(blobInfo,editor, welEditable);
                }
            }
        });

        $('#summernote').summernote('code', '${activityData}');

        function saveData(obj) {
            var sHTML = $('#summernote').summernote('code');
            $.ajax({
                url: "/games/publics/activity/activity-data-save",
                type: "POST",
                dataType: "text",
                data: {
                    id: obj,
                    data: sHTML
                },
                success: function(ret) {
                    if (ret == "ERROR") {
                        alert("保存失败");
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

        function sendFile(blobInfo,editor, welEditable) {
            var xhr, formData;
            xhr = new XMLHttpRequest();
            xhr.withCredentials = false;
            xhr.open("POST", "/games/publics/upload/multiUpload");
            formData = new FormData();
            formData.append("file", blobInfo[0]);
            xhr.onload = function(path){
                console.log(path.currentTarget.response);
                $('#summernote').summernote('insertImage', path.currentTarget.response, 'image name');
            };
            xhr.send(formData);
        }
    </script>
    </body>

</html>
