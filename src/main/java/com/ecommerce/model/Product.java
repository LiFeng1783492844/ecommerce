package com.ecommerce.model;

import lombok.Data;

import java.util.Date;

/**
 * Created by lenovo on 2019/5/1.
 */
@Data
public class Product {
    private int id;	//商品编号
    private String name;	//商品名称
    private float price;	//商品价格
    private String info;	//商品信息
    private String pic;		//商品图片
    private int count;		//商品数量
    private Date date;		//商品日期
}
