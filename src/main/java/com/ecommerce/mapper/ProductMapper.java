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
    @Select("select hw_id as id,hw_name as name,hw_price as price,hw_info as info,hw_pic as pic,hw_count as count,date_format(hw_date,'%Y-%m-%d') as date from product limit #{index},#{maxnum}")
    List<Product> getProductList(@Param("index") int index, @Param("maxnum") int maxnum);

    ////根据商品id查找商品
    @Select("select  hw_id as id,hw_name as name,hw_price as price,hw_info as info,hw_pic as price,hw_count as count,date_format(hw_date,'%Y-%m-%d') as date from product where hw_id = #{id}")
    Product getProductById(@Param("id") int id);

    @Delete("delete from product where hw_id = #{productId}")
    int delete(int productId);

    @Update("update product set hw_name = #{product.name},hw_price = #{product.price},hw_count = #{product.count}," +
            "hw_date = #{product.date} where hw_id = #{product.id}")
    int modify(@Param("product")Product product);

    @Insert("insert into product (hw_name,hw_price,hw_info,hw_pic,hw_count,hw_date) " +
            "values(#{product.name},#{product.price},#{product.info},#{product.pic},#{product.count},#{product.date})")
    @Options(useGeneratedKeys=true,keyProperty="id") //如果插入的表以自增列为主键，则允许 JDBC 支持自动生成主键，并可将自动生成的主键返回
    int add(@Param("product")Product product);
}
