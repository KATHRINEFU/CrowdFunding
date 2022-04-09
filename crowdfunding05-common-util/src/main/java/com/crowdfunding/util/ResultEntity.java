package com.crowdfunding.util;

/**
 * standardize Ajax request return result for whole project (can be used in module calls in distributed system)
 * @author katefu
 * @param <T>
 */

public class ResultEntity<T> {
    public static final String SUCCESS = "SUCCESS";
    public static final String FAILED = "FAILED";
    private String result; //package current request result: success/fail
    private String message; //returned error message when request process fails
    private T data; //returned data


    //declare and use a generic
    //generic method
    //use after declare

    /**
     * request process succeed and do not need to return data
     * most used by add/update/delete
     * @param <Type>
     * @return
     */
    public static <Type> ResultEntity<Type> successWithoutData(){
        return new ResultEntity<Type>(SUCCESS, null, null);
    }

    /**
     * request process succeed and do need to return data
     * most used by select
     * @param data
     * @param <Type>
     * @return
     */
    public static <Type> ResultEntity<Type> successWithData(Type data){
        return new ResultEntity<Type>(SUCCESS, null, data);
    }

    /**
     * request process failed
     * @param message error message
     * @param <Type>
     * @return
     */
    public static <Type> ResultEntity<Type> failed(String message) {
        return new ResultEntity<Type>(FAILED, message, null);
    }

    public ResultEntity() {
    }

    public ResultEntity(String result, String message, T data) {
        this.result = result;
        this.message = message;
        this.data = data;
    }

    @Override
    public String toString() {
        return "ResultEntity{" +
                "result='" + result + '\'' +
                ", message='" + message + '\'' +
                ", data=" + data +
                '}';
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}

