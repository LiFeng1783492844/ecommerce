package com.ecommerce.model;

import lombok.Data;

/**
 * Created by lenovo on 2019/5/1.
 */
@Data
public class Admin {
    private int id;	//管理员编号
    private String account;	//管理员账号
    private String pass;	//管理员密码
}
