package com.ecommerce.mapper;

import com.ecommerce.model.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * Created by lenovo on 2019/5/1.
 */
@Mapper
public interface MemberMapper {

    //根据用户名，即会员账号查找用户
    @Select("select * from member where user_account = #{account}")
    List<Member> isExist(@Param("account") String account);
    //注册用户，即向数据库插入数据
    @Insert("insert into member(user_account,user_pass,user_adds,user_mail,user_tel,user_regtime,user_postcode,user_name)"
            +" values(#{member.account},#{member.pass},#{member.adds},#{member.mail},#{member.tel},#{member.regtime},#{member.postcode},#{member.name})")
    Boolean setMember(@Param("member") Member member);

    //验证用户登录
    @Select("select * from member where user_account=#{member.account}")
    @Results({
            @Result(column = "user_id",property = "id"),
            @Result(column = "user_account",property = "account"),
            @Result(column = "user_pass",property = "pass"),
            @Result(column = "user_adds",property = "adds"),
            @Result(column = "user_mail",property = "mail"),
            @Result(column = "user_tel",property = "tel"),
            @Result(column = "user_regtime",property = "regtime"),
            @Result(column = "user_postcode",property = "postcode"),
            @Result(column = "user_name",property = "name")
    })
    Member referMember(@Param("member") Member member);

    //更新用户信息
    @Update("update member set user_pass = #{member.pass},user_adds = #{member.adds},user_mail = #{member.mail},"
            +"user_tel = #{member.tel},user_postcode = #{member.postcode},user_name = #{member.name} "
            +"where user_account = #{member.account}")
    int updateMember(@Param("member") Member member);

}
