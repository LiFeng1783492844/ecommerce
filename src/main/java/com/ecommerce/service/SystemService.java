package com.ecommerce.service;

/**
 * Created by lenovo on 2019/5/18.
 */
public interface SystemService {
    public String getNotice()throws Exception;

    public Boolean setNotice(String notice) throws Exception;
}
