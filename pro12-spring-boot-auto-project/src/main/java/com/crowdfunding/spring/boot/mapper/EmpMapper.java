package com.crowdfunding.spring.boot.mapper;

import com.crowdfunding.spring.boot.entity.Emp;

import java.util.List;

public interface EmpMapper {
    List<Emp> selectAll();
}
