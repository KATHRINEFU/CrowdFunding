<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="addModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">CF System Window</h4>
            </div>
            <div class="modal-body">
                <form class="form-signin" role="form">
                    <div class="form-group has-success has-feedback">
                        <input type="text" name="roleName" class="form-control" placeholder="Enter role name" autofocus>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="saveRoleBtn" type="button" class="btn btn-success">Save</button>
            </div>
        </div>
    </div>
</div>