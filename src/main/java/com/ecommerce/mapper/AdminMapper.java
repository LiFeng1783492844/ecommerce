package com.ecommerce.mapper;

import com.ecommerce.model.Admin;
import org.apache.ibatis.annotations.*;

/**
 * Created by lenovo on 2019/5/1.
 */
@Mapper
public interface AdminMapper {
    //验证管理员登录
    @Select("select * from admin where admin_account=#{admin.account}")
    @Results({
            @Result(column = "admin_id",property = "id"),
            @Result(column = "admin_account",property = "account"),
            @Result(column = "admin_pass",property = "pass")
    })
    Admin referAdmin(@Param("admin") Admin admin);
}
