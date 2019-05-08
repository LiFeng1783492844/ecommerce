package com.ecommerce.service.Impl;

import com.ecommerce.mapper.ProductMapper;
import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lenovo on 2019/5/2.
 */
@Service
public class ProductServiceImpl implements ProductService{
    @Autowired
    ProductMapper productMapper;

    @Override   //得到最大分页数
    public int getMaxPageNum(int maxnum) throws Exception {
        int count = productMapper.getCount();   //商品总数
        double result = ((double)count)/((double)maxnum);
        int maxPageNum = (int)Math.ceil(result);//向上取整
        if(maxPageNum==0){//如果商品总记录数为0，则最大分页数为1（至少要显示1页，哪怕是空白）
            maxPageNum=1;
        }
        return maxPageNum;
    }

    @Override   //得到第pageNum页的商品列表
    public List<Product> getProductList(int pageNum, int maxnum) throws Exception {
        int index = (pageNum-1)*maxnum; //开始查找的位置
        return productMapper.getProductList(index,maxnum);
    }

    @Override   //根据商品id查找商品
    public Product getProductById(int id) throws Exception {
//        Product t =   productMapper.getProductById(id);
        return productMapper.getProductById(id);
    }
}
