package com.ecommerce.service;

import com.ecommerce.model.Member;

import java.util.List;
import java.util.Map;

/**
 * Created by lenovo on 2019/5/1.
 */
public interface MemberService {

    Map<String,Object> register(Member member)throws Exception;

    Map<String,Object> login(Member member)throws Exception;

    Map<String,Object> updateMember(Member member)throws Exception;

    int getMaxPageNum(int maxnum)throws Exception;

    List<Member> getMemberList(int pageNum, int maxnum)throws Exception;

    Boolean delete(int memberId)throws Exception;

    Boolean modify(Member member)throws Exception;

}
