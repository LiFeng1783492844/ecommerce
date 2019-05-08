package com.ecommerce.service.Impl;

import com.ecommerce.mapper.MemberMapper;
import com.ecommerce.model.Member;
import com.ecommerce.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lenovo on 2019/5/1.
 */
@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    MemberMapper memberMapper;


    @Override   //注册用户，即向数据库插入数据
    public Map<String,Object> register(Member member) throws Exception {
        Map<String,Object> result = new HashMap<>();
        List<Member> referList = memberMapper.isExist(member.getAccount());
        //先检查用户是否已注册
        if(referList.size()>0){
            result.put("isExist",true);
            return result;
        }
        //用户未注册
        result.put("isExist",false);
        member.setRegtime(new Date());  //设置注册时间
        Boolean insertResult = memberMapper.setMember(member);
        if(insertResult){
            result.put("msg","注册成功！");
        }else {
            result.put("msg","注册失败！插入数据库失败！");
        }
        return result;
    }

    @Override   //进行登录验证
    public Map<String, Object> login(Member member) throws Exception {
        Map<String,Object> result = new HashMap<>();
//        List<Member> referList = memberMapper.referMember(member);
        Member member1 = memberMapper.referMember(member);
        if(member.getPass().equals(member1.getPass())){
            result.put("msg","登录成功！");
            result.put("flag",true);
            result.put("user",member1);
            return result;
        }
        result.put("msg","用户名或密码错误！");
        result.put("flag",false);
        return result;
    }

    @Override
    public Map<String, Object> updateMember(Member member) throws Exception {
        Map<String,Object> result = new HashMap<>();
        int resultCode = memberMapper.updateMember(member);
        if(resultCode>0){//更新成功
            result.put("flag",true);
            return result;
        }
        result.put("flag",false);
        return result;
    }
}
