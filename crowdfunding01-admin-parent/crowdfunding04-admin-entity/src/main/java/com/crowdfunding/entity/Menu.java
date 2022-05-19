package com.crowdfunding.entity;

import java.util.ArrayList;
import java.util.List;

public class Menu {
    //primary key
    private Integer id;

    //father node id
    private Integer pid;

    //node name
    private String name;

    //node url, target address
    private String url;

    //icon format
    private String icon;

    //story children nodes, avoid null pointer exception
    private List<Menu> children = new ArrayList<>();

    //node status open or not
    private boolean open = true;

    public Menu() {
    }

    public Menu(Integer id, Integer pid, String name, String url, String icon, List<Menu> children, boolean open) {
        this.id = id;
        this.pid = pid;
        this.name = name;
        this.url = url;
        this.icon = icon;
        this.children = children;
        this.open = open;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", pid=" + pid +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", icon='" + icon + '\'' +
                ", children=" + children +
                ", open=" + open +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public List<Menu> getChildren() {
        return children;
    }

    public boolean isOpen() {
        return open;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }
}