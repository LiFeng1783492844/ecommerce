package com.ecommerce.service.Impl;

import com.ecommerce.mapper.AdMapper;
import com.ecommerce.model.Ad;
import com.ecommerce.service.AdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lenovo on 2019/5/18.
 */
@Service
public class AdServiceImpl implements AdService {
    @Autowired
    private AdMapper adMapper;

    @Override   //前台使用
    public List<Ad> getLinkList() throws Exception {
        return adMapper.getLinkList();
    }

    @Override
    public int getMaxPageNum(int maxnum) throws Exception {
        int count = adMapper.getCount();   //总数
        double result = ((double)count)/((double)maxnum);
        int maxPageNum = (int)Math.ceil(result);//向上取整
        if(maxPageNum==0){//如果商品总记录数为0，则最大分页数为1（至少要显示1页，哪怕是空白）
            maxPageNum=1;
        }
        return maxPageNum;
    }

    @Override
    public List<Ad> getAdList(int pageNum, int maxnum) throws Exception {
        int index = (pageNum-1)*maxnum; //开始查找的位置
        return adMapper.getAdList(index,maxnum);
    }

    @Override
    public Boolean delete(int adId) throws Exception {
        int result  = adMapper.delete(adId);
        if (result>0){
            return true;
        }
        return false;
    }

    @Override
    public Boolean modify(Ad ad) throws Exception {
        int result  = adMapper.modify(ad);
        if (result>0){
            return true;
        }
        return false;
    }

    @Override
    public Boolean add(Ad ad) throws Exception {
        int result  = adMapper.add(ad);
        if (result>0){
            return true;
        }
        return false;
    }
}
