package com.ecommerce.service;

import com.ecommerce.model.Admin;

import java.util.Map;

/**
 * Created by lenovo on 2019/5/18.
 */
public interface AdminService {

    Map<String,Object> login(Admin admin)throws Exception;

}

