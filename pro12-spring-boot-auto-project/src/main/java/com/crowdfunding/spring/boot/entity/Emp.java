package com.crowdfunding.spring.boot.entity;

/**
 * @ClassName Emp
 * @Description TODO
 * @Author katefu
 * @Date 6/23/22 10:05 PM
 * @Version 1.0
 **/
public class Emp {
    private Integer empId;
    private String empName;
    private Integer empAge;

    public Emp() {
    }

    public Emp(Integer empId, String empName, Integer empAge) {
        this.empId = empId;
        this.empName = empName;
        this.empAge = empAge;
    }

    @Override
    public String toString() {
        return "Emp{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empAge=" + empAge +
                '}';
    }

    public Integer getEmpId() {
        return empId;
    }

    public String getEmpName() {
        return empName;
    }

    public Integer getEmpAge() {
        return empAge;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public void setEmpAge(Integer empAge) {
        this.empAge = empAge;
    }
}
