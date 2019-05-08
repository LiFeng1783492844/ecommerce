package com.ecommerce.mapper;

import com.ecommerce.model.Basket;
import com.ecommerce.model.Member;
import com.ecommerce.model.Product;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * Created by lenovo on 2019/5/1.
 */
@Mapper
public interface BasketMapper {
    //得到check为0的数据，即未确认购买的商品
    @Select("select * from basket where user_account = #{account} and basket_check = '0'")
    @Results(value = {
            @Result(column = "basket_id",property = "id"),
            @Result(column = "hw_id",property = "productId"),
            @Result(column = "user_account",property = "account"),
            @Result(column = "basket_count",property = "count"),
            @Result(column = "basket_date",property = "date"),
            @Result(column = "basket_check",property = "check"),
            @Result(column = "hw_name",property = "name"),
            @Result(column = "hw_price",property = "price"),
            @Result(column = "sub_num",property = "num")
    })
    List<Basket> getListOfNotCheck(@Param("account") String account);

    //得到check为1，且sub_num(订单号)为空的数据，即确认购买的商品
    @Select("select * from basket where user_account = #{account} and basket_check = '1' and "
                +"(sub_num = '' or sub_num is null)")
    @Results(value = {
            @Result(column = "basket_id",property = "id"),
            @Result(column = "hw_id",property = "productId"),
            @Result(column = "user_account",property = "account"),
            @Result(column = "basket_count",property = "count"),
            @Result(column = "basket_date",property = "date"),
            @Result(column = "basket_check",property = "check"),
            @Result(column = "hw_name",property = "name"),
            @Result(column = "hw_price",property = "price"),
            @Result(column = "sub_num",property = "num")
    })
    List<Basket> getListOfCheck(@Param("account") String account);

    //确认购买商品，即将check改为1，更新商品数量和订购时间
    @Update("update basket set basket_count = #{basket.count},basket_date = #{basket.date},basket_check = '1' "
            +"where basket_id = #{basket.id}")
    int confirm(@Param("basket") Basket basket);

    //清空购物车，即删除check=0的数据
    @Delete("delete from basket where user_account = #{member.account} and basket_check = '0'")
    int cleanBasket(@Param("member") Member member);

    //清空收银台，即将check=1且sub_num为空的数据更新为check=0
    @Update("update basket set basket_check = '0' where user_account = #{member.account} and basket_check = '1'"
            +" and (sub_num = '' or sub_num is null)")
    int cleanCheckout(@Param("member") Member member);

    //更新sub_num，即结账
    @Update("update basket set sub_num = #{subNum} where user_account = #{member.account} and basket_check = '1'")
    int checkout(@Param("member") Member member, @Param("subNum") String subNum);

    //订购商品，即将商品添加到购物车
    @Insert("insert into basket (hw_id,user_account,hw_name,hw_price)"
            +" values(#{product.id},#{account},#{product.name},#{product.price})")
    Boolean order(@Param("account") String account, @Param("product") Product product);

}
