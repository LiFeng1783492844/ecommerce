package com.ecommerce.mapper;

import com.ecommerce.model.Product;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * Created by lenovo on 2019/5/1.
 */
@Mapper
public interface ProductMapper {
    //得到商品总数
    @Select("select count(hw_id) from product")
    int getCount();

    //从index条数据开始，得到商品列表
    @Select("select * from product limit #{index},#{maxnum}")
    @Results({
            @Result(column = "hw_id",property = "id"),
            @Result(column = "hw_name",property = "name"),
            @Result(column = "hw_price",property = "price"),
            @Result(column = "hw_info",property = "info"),
            @Result(column = "hw_pic",property = "pic"),
            @Result(column = "hw_count",property = "count"),
            @Result(column = "hw_date",property = "date")
    })
    List<Product> getProductList(@Param("index") int index, @Param("maxnum") int maxnum);

    ////根据商品id查找商品
    @Select("select * from product where hw_id = #{id}")
    @Results({
            @Result(column = "hw_id",property = "id"),
            @Result(column = "hw_name",property = "name"),
            @Result(column = "hw_price",property = "price"),
            @Result(column = "hw_info",property = "info"),
            @Result(column = "hw_pic",property = "pic"),
            @Result(column = "hw_count",property = "count"),
            @Result(column = "hw_date",property = "date")
    })
    Product getProductById(@Param("id") int id);

}
