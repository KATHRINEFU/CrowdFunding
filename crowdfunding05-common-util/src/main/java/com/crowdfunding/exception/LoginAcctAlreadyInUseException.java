package com.crowdfunding.exception;

/**
 * @ClassName LoginAcctAlreadyInUseException
 * @Description exception when user want to add/update a duplicate new admin
 * @Author katefu
 * @Date 5/11/22 11:24 PM
 * @Version 1.0
 **/
public class LoginAcctAlreadyInUseException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public LoginAcctAlreadyInUseException() {
        super();
    }

    public LoginAcctAlreadyInUseException(String message) {
        super(message);
    }

    public LoginAcctAlreadyInUseException(String message, Throwable cause) {
        super(message, cause);
    }

    public LoginAcctAlreadyInUseException(Throwable cause) {
        super(cause);
    }

    protected LoginAcctAlreadyInUseException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
