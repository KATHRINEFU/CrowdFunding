<%--
  Created by IntelliJ IDEA.
  User: katefu
  Date: 5/23/22
  Time: 6:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="menuConfirmModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
                aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">CF System Window</h4>
      </div>
      <form>
        <div class="modal-body">
          Please confirm to delete <span id="removeNodeSpan"></span> Node?
        </div>
        <div class="modal-footer">
          <button id="confirmBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-ok"></i> OK</button>
        </div>
      </form>
    </div>
  </div>
</div>
