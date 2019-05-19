package com.ecommerce.service.Impl;

import com.ecommerce.mapper.SystemMapper;
import com.ecommerce.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by lenovo on 2019/5/18.
 */
@Service
public class SystemServiceImpl implements SystemService{
    @Autowired
    SystemMapper systemMapper;

    @Override
    public String getNotice() throws Exception {
        return systemMapper.getNotice();
    }

    @Override
    public Boolean setNotice(String notice) throws Exception {
        int result = systemMapper.setNotice(notice);
        if (result>0){
            return true;
        }
        return false;
    }
}
