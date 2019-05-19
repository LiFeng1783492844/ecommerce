package com.ecommerce.service;

import com.ecommerce.model.Product;

import java.util.List;

/**
 * Created by lenovo on 2019/5/2.
 */
public interface ProductService {

    int getMaxPageNum(int maxnum)throws Exception;

    List<Product> getProductList(int pageNum, int maxnum)throws Exception;

    Product getProductById(int id)throws Exception;

    Boolean delete(int productId)throws Exception;

    Boolean modify(Product product)throws Exception;

    Boolean add(Product product)throws Exception;
}
