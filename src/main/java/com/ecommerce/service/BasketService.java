package com.ecommerce.service;

import com.ecommerce.model.Basket;
import com.ecommerce.model.Member;
import com.ecommerce.model.Product;

import java.util.List;
import java.util.Map;

/**
 * Created by lenovo on 2019/5/2.
 */
public interface BasketService {
    List<Basket> getListOfNotCheck(Member member)throws Exception;

    List<Basket> getListOfCheck(Member member)throws Exception;

    Map<String,Object> confirm(Basket basket)throws Exception;

    Map<String,Object> cleanBasket(Member member)throws Exception;

    Map<String,Object> cleanCheckout(Member member)throws Exception;

    Boolean checkout(Member member, String subNum)throws Exception;

    Boolean order(String account, Product product)throws Exception;


}
