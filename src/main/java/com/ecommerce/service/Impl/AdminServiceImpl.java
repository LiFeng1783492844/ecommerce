package com.ecommerce.service.Impl;

import com.ecommerce.mapper.AdminMapper;
import com.ecommerce.model.Admin;
import com.ecommerce.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lenovo on 2019/5/18.
 */
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    AdminMapper adminMapper;

    @Override
    public Map<String, Object> login(Admin admin) throws Exception {
        Map<String,Object> result = new HashMap<>();
        Admin admin1 = adminMapper.referAdmin(admin);
        if(admin.getPass().equals(admin1.getPass())){
            result.put("msg","登录成功！");
            result.put("flag",true);
            result.put("admin",admin1);
            return result;
        }
        result.put("msg","用户名或密码错误！");
        result.put("flag",false);
        return result;
    }
}
