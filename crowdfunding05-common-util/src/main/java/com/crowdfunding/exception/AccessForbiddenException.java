package com.crowdfunding.exception;

/**
 * @ClassName AccessForbiddenException
 * @Description user request protected resource without login
 * @Author katefu
 * @Date 5/8/22 10:16 AM
 * @Version 1.0
 **/
public class AccessForbiddenException extends RuntimeException{
    private static final long serialVersionUID=1L;

    public AccessForbiddenException() {
    }

    public AccessForbiddenException(String message) {
        super(message);
    }

    public AccessForbiddenException(String message, Throwable cause) {
        super(message, cause);
    }

    public AccessForbiddenException(Throwable cause) {
        super(cause);
    }

    public AccessForbiddenException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
