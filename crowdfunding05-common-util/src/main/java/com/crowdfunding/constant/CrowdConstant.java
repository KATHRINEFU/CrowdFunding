package com.crowdfunding.constant;

public class CrowdConstant {
    //防止因为打错造成bug，定义常量（用在crowdExceptionResolver）
    public static final String ATTR_NAME_EXCEPTION = "exception";

    public static final String MESSAGE_LOGIN_FAILED = "Sorry! Username or Password not valid!";

    public static final String MESSAGE_LOGIN_ACCT_ALREADY_IN_USE = "Sorry! This account is already used!";

    public static final String MESSAGE_ACCESS_FORBIDDEN = "Please login to access";

    public static final String MESSAGE_STRING_INVALIDATE = "Illegal String, Do not input empty String!";

    public static final  String ATTR_NAME_LOGIN_ADMIN = "loginAdmin";

    public static final String MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE = "System error: not unique login account";

    public static final String ATTR_NAME_PAGE_INFO = "pageInfo";
}
