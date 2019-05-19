package com.ecommerce.mapper;

import com.ecommerce.model.Ad;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * Created by lenovo on 2019/5/18.
 */
@Mapper
public interface AdMapper {
    //前台使用
    @Select("select ad_id as id,name,url from ad where ad_id > '0'")
    List<Ad> getLinkList();

    //得到总数
    @Select("select count(ad_id) from ad")
    int getCount();

    //从index条数据开始，得到列表
    @Select("select ad_id as id,name,url from ad limit #{index},#{maxnum}")
    List<Ad> getAdList(@Param("index") int index, @Param("maxnum") int maxnum);

    @Delete("delete from ad where ad_id = #{adId}")
    int delete(int adId);

    @Update("update ad set name = #{ad.name},url= #{ad.url} where ad_id = #{ad.id}")
    int modify(@Param("ad")Ad ad);

    @Insert("insert into ad (name,url) values (#{ad.name},#{ad.url})")
    @Options(useGeneratedKeys=true,keyProperty="id") //如果插入的表以自增列为主键，则允许 JDBC 支持自动生成主键，并可将自动生成的主键返回
    int add(@Param("ad")Ad ad);
}
