package com.ecommerce.service;

import com.ecommerce.model.Ad;

import java.util.List;

/**
 * Created by lenovo on 2019/5/18.
 */
public interface AdService {
    List<Ad> getLinkList()throws Exception;

    int getMaxPageNum(int maxnum)throws Exception;

    List<Ad> getAdList(int pageNum, int maxnum)throws Exception;

    Boolean delete(int adId)throws Exception;

    Boolean modify(Ad ad)throws Exception;

    Boolean add(Ad ad)throws Exception;
}
