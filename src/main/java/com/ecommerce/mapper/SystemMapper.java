package com.ecommerce.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * Created by lenovo on 2019/5/1.
 */
@Mapper
public interface SystemMapper {
    @Select("select notice from system where id='1'")
    public String getNotice();

    @Update("update system set notice = #{notice} where id = '1'")
    public int setNotice(String notice);
}
