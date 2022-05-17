<%--
  Created by IntelliJ IDEA.
  User: katefu
  Date: 5/7/22
  Time: 12:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-sm-3 col-md-2 sidebar">
  <div class="tree">
    <ul style="padding-left:0px;" class="list-group">
      <li class="list-group-item tree-closed" >
        <a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> Dashboard</a>
      </li>
      <li class="list-group-item tree-closed">
        <span><i class="glyphicon glyphicon glyphicon-tasks"></i> Access Control <span class="badge" style="float:right">5</span></span>
        <ul style="margin-top:10px;display:none;">
          <li style="height:30px;">
            <a href="/crowdfunding02_admin_webui_war/admin/get/page.html"><i class="glyphicon glyphicon-user"></i> User Maintenance</a>
          </li>
          <li style="height:30px;">
            <a href="/crowdfunding02_admin_webui_war/role/to/page.html"><i class="glyphicon glyphicon-king"></i> Role Maintenance</a>
          </li>
          <li style="height:30px;">
            <a href="permission.html"><i class="glyphicon glyphicon-lock"></i> Menu Maintenance</a>
          </li>
        </ul>
      </li>
      <li class="list-group-item tree-closed">
        <span><i class="glyphicon glyphicon-ok"></i> Business Audit <span class="badge" style="float:right">3</span></span>
        <ul style="margin-top:10px;display:none;">
          <li style="height:30px;">
            <a href="auth_cert.html"><i class="glyphicon glyphicon-check"></i> Real-name authentication audit</a>
          </li>
          <li style="height:30px;">
            <a href="auth_adv.html"><i class="glyphicon glyphicon-check"></i> Advertisement Audit</a>
          </li>
          <li style="height:30px;">
            <a href="auth_project.html"><i class="glyphicon glyphicon-check"></i> Project Audit</a>
          </li>
        </ul>
      </li>
      <li class="list-group-item tree-closed">
        <span><i class="glyphicon glyphicon-th-large"></i> Business Management <span class="badge" style="float:right">7</span></span>
        <ul style="margin-top:10px;display:none;">
          <li style="height:30px;">
            <a href="cert.html"><i class="glyphicon glyphicon-picture"></i> Qualification Maintenance</a>
          </li>
          <li style="height:30px;">
            <a href="type.html"><i class="glyphicon glyphicon-equalizer"></i> Category Management</a>
          </li>
          <li style="height:30px;">
            <a href="process.html"><i class="glyphicon glyphicon-random"></i> Process Management</a>
          </li>
          <li style="height:30px;">
            <a href="advertisement.html"><i class="glyphicon glyphicon-hdd"></i> Advertisement Management</a>
          </li>
          <li style="height:30px;">
            <a href="message.html"><i class="glyphicon glyphicon-comment"></i> Message Template</a>
          </li>
          <li style="height:30px;">
            <a href="project_type.html"><i class="glyphicon glyphicon-list"></i> Project Category</a>
          </li>
          <li style="height:30px;">
            <a href="tag.html"><i class="glyphicon glyphicon-tags"></i> Project Label</a>
          </li>
        </ul>
      </li>
      <li class="list-group-item tree-closed" >
        <a href="param.html"><i class="glyphicon glyphicon-list-alt"></i> Parameter Management</a>
      </li>
    </ul>
  </div>
</div>