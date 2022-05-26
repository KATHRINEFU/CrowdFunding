<%--
  Created by IntelliJ IDEA.
  User: katefu
  Date: 5/23/22
  Time: 3:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="menuAddModal" class="modal fade" tabindex="-1" role="dialog">
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
                    Enter Node Name：<input type="text" name="name" /><br />
                    Enter URL：<input type="text" name="url" /><br />
                    <i class="glyphicon glyphicon-th-list"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-th-list" />&nbsp;

                    <i class="glyphicon glyphicon-dashboard"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-dashboard" /> &nbsp;

                    <i class="glyphicon glyphicon glyphicon-tasks"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon glyphicon-tasks" /> &nbsp;

                    <i class="glyphicon glyphicon-user"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-user" /> &nbsp;

                    <i class="glyphicon glyphicon-king"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-king" /> &nbsp;

                    <i class="glyphicon glyphicon-lock"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-lock" /> &nbsp;

                    <i class="glyphicon glyphicon-ok"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-ok" /> &nbsp;

                    <i class="glyphicon glyphicon-check"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-check" /> &nbsp;

                    <i class="glyphicon glyphicon-th-large"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-th-large" /> <br />

                    <i class="glyphicon glyphicon-picture"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-picture" /> &nbsp;

                    <i class="glyphicon glyphicon-equalizer"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-equalizer" /> &nbsp;

                    <i class="glyphicon glyphicon-random"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-random" /> &nbsp;

                    <i class="glyphicon glyphicon-hdd"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-hdd" /> &nbsp;

                    <i class="glyphicon glyphicon-comment"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-comment" /> &nbsp;

                    <i class="glyphicon glyphicon-list"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-list" /> &nbsp;

                    <i class="glyphicon glyphicon-tags"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-tags" /> &nbsp;

                    <i class="glyphicon glyphicon-list-alt"></i>
                    <input type="radio" name="icon" value="glyphicon glyphicon-list-alt" /> &nbsp;
                    <br />

                </div>
                <div class="modal-footer">
                    <button id="menuSaveBtn" type="button" class="btn btn-default"><i class="glyphicon glyphicon-plus"></i> Save</button>
                    <button id="menuResetBtn" type="reset" class="btn btn-primary"><i class="glyphicon glyphicon-refresh"></i> Reset</button>
                </div>
            </form>
        </div>
    </div>
</div>