package com.crowdfunding.spring.boot.entity;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * @ClassName Student
 * @Description 当前类存放读取yml文件配置的数据，要求该类也在IOC容器中
 * @Author katefu
 * @Date 6/22/22 8:48 PM
 * @Version 1.0
 **/

@Component //放到IOC容器
@ConfigurationProperties(prefix = "student") //读取yml文件student
public class Student {
    private Integer stuId;
    private String stuName;
    private boolean graduated;
    private String[] subjects;

    private Date birthday;
    private Map<String, String> teachers;
    private Address address;

    public Student() {
    }

    public Student(Integer stuId, String stuName, boolean graduated, String[] subjects, Date birthday, Map<String, String> teachers, Address address) {
        this.stuId = stuId;
        this.stuName = stuName;
        this.graduated = graduated;
        this.subjects = subjects;
        this.birthday = birthday;
        this.teachers = teachers;
        this.address = address;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuId=" + stuId +
                ", stuName='" + stuName + '\'' +
                ", graduated=" + graduated +
                ", subjects=" + Arrays.toString(subjects) +
                ", birthday=" + birthday +
                ", teachers=" + teachers +
                ", address=" + address +
                '}';
    }

    public Integer getStuId() {
        return stuId;
    }

    public String getStuName() {
        return stuName;
    }

    public boolean isGraduated() {
        return graduated;
    }

    public String[] getSubjects() {
        return subjects;
    }

    public Date getBirthday() {
        return birthday;
    }

    public Map<String, String> getTeachers() {
        return teachers;
    }

    public Address getAddress() {
        return address;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public void setGraduated(boolean graduated) {
        this.graduated = graduated;
    }

    public void setSubjects(String[] subjects) {
        this.subjects = subjects;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public void setTeachers(Map<String, String> teachers) {
        this.teachers = teachers;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}
