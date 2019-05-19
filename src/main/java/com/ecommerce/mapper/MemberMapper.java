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
    @Select("select  user_id as id,user_account as account,user_pass as pass,user_adds as adds,user_mail as mail," +
            "user_tel as tel,date_format(user_regtime,'%Y-%m-%d') as regtime,user_postcode as postcode," +
            "user_name as name  from member where user_account=#{member.account}")
    Member referMember(@Param("member") Member member);

    //更新用户信息
    @Update("update member set user_pass = #{member.pass},user_adds = #{member.adds},user_mail = #{member.mail},"
            +"user_tel = #{member.tel},user_postcode = #{member.postcode},user_name = #{member.name} "
            +"where user_account = #{member.account}")
    int updateMember(@Param("member") Member member);


    //得到用户总数
    @Select("select count(user_id) from member")
    int getCount();
    //从index条数据开始，得到用户列表
    @Select("select user_id as id,user_account as account,user_pass as pass,user_adds as adds,user_mail as mail," +
            "user_tel as tel,date_format(user_regtime,'%Y-%m-%d') as regtime,user_postcode as postcode," +
            "user_name as name from member limit #{index},#{maxnum}")
    List<Member> getMemberList(@Param("index") int index, @Param("maxnum") int maxnum);

    @Delete("delete from member where user_id = #{memberId}")
    int delete(int memberId);
    @Update("update member set user_pass = #{member.pass} where user_id = #{member.id}")
    int modify(@Param("member")Member member);

}
