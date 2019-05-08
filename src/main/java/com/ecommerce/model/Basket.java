package com.ecommerce.model;

import lombok.Data;

import java.util.Date;

/**
 * Created by lenovo on 2019/5/1.
 */
@Data
public class Basket {
    private int id;	//购物车编号
    private int productId;	//商品编号
    private int account;	//会员账号
    private int count;	//商品数量
    private Date date;	//购物时间
    private int check;//是否结账 0:否 1:是
    private String name;  //商品名称
    private float price;  //商品价格
    private String num;	  //订单编号
}
