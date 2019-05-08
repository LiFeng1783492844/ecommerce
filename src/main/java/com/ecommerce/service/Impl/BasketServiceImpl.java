package com.ecommerce.service.Impl;

import com.ecommerce.mapper.BasketMapper;
import com.ecommerce.model.Basket;
import com.ecommerce.model.Member;
import com.ecommerce.model.Product;
import com.ecommerce.service.BasketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lenovo on 2019/5/2.
 */
@Service
public class BasketServiceImpl implements BasketService{
    @Autowired
    BasketMapper basketMapper;

    @Override   //得到未结账的商品列表
    public List<Basket> getListOfNotCheck(Member member) throws Exception {
        return basketMapper.getListOfNotCheck(member.getAccount());
    }

    @Override   //得到确认结账（购买）的商品列表
    public List<Basket> getListOfCheck(Member member) throws Exception {
        return basketMapper.getListOfCheck(member.getAccount());
    }

    @Override   //确认购买商品，即将记录的count和check更新
    public Map<String,Object> confirm(Basket basket) throws Exception {
        Map<String,Object> result = new HashMap<>();
        int t = basketMapper.confirm(basket);
        if(t>0){
            result.put("flag",true);
            result.put("msg","更新成功！");
            return result;
        }
        result.put("flag",false);
        return result;
    }

    @Override   //清空购物车，即删除basket表中check为0的数据
    public Map<String, Object> cleanBasket(Member member) throws Exception {
        int count = basketMapper.cleanBasket(member);
        Map<String, Object> result = new HashMap<>();
        if(count>0){   //删除成功
            result.put("flag",true);
            result.put("msg","删除成功！");
            return result;
        }
        result.put("flag",false);
        return result;
    }

    @Override//清空收银台，即将check=1且sub_num为空的数据更新为check=0
    public Map<String, Object> cleanCheckout(Member member) throws Exception {
        Map<String, Object> result = new HashMap<>();
        if(member!=null){   //登录了
            result.put("isLogin",true);
            int count = basketMapper.cleanCheckout(member);
            if(count>0){   //删除成功
                result.put("flag",true);
                result.put("msg","删除成功！");
                return result;
            }
        }
        result.put("isLogin",false);
        result.put("flag",false);
        return result;
    }

    @Override   //更新sub_num
    public Boolean checkout(Member member,String subNum) throws Exception {
        int result = basketMapper.checkout(member,subNum);
        return result > 0;
    }

    @Override   //订购商品，即将商品添加到购物车
    public Boolean order(String account, Product product) throws Exception {
        return basketMapper.order(account,product);
    }
}
