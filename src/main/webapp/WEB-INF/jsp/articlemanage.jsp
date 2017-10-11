<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="util/header.jsp" %>
<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">文章管理</h4>
    </div>
    <div class="col-md-12">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th width="35%">文章标题</th>
                <th width="15%">发布时间</th>
                <th>浏览量</th>
                <th>所属分类</th>
                <th width="8%">发布状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            #for(post : articles.rows)
            <tr>
                <td>
                </td>
                <td>
                    #if(post.status == 'publish')
                    <span class="label label-success">已发布</span>
                    #elseif(post.status == 'draft')
                    <span class="label label-default">草稿</span>
                    #end
                </td>
                <td>
                    <a href="/admin/article/"
                       class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                            class="fa fa-edit"></i> <span>编辑</span></a>
                    <a href="javascript:void(0)" onclick="delPost(${post.cid});"
                       class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                            class="fa fa-trash-o"></i> <span>删除</span></a>
                    #if(post.status == 'publish')
                    <a class="btn btn-warning btn-sm waves-effect waves-light m-b-5" href="${permalink(post)}"
                       target="_blank"><i
                            class="fa fa-rocket"></i> <span>预览</span></a>
                    #end
                </td>
            </tr>
            #end
            </tbody>
        </table>
        #call pageAdminNav(articles)
    </div>
</div>
<script type="text/javascript">
    var tale = new $.tale();
    function delPost(cid) {
        tale.alertConfirm({
            title:'确定删除该文章吗?',
            then: function () {
                tale.post({
                    url : '/admin/article/delete',
                    data: {cid: cid},
                    success: function (result) {
                        if(result && result.success){
                            tale.alertOkAndReload('文章删除成功');
                        } else {
                            tale.alertError(result.msg || '文章删除失败');
                        }
                    }
                });
            }
        });
    }
</script>
<%@include file="util/footer.jsp"%>
</body>
</html>
