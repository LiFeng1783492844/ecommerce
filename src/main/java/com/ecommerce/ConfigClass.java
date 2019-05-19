package com.ecommerce;

/**
 * Created by lenovo on 2019/5/3.
 */
public class ConfigClass {
    //每页显示的最大照片数
    public static int maxnum = 12;

    //后台管理每页显示最大记录数
    public static int bgmaxnum = 18;

    //路径
    public static final String ImgsSavePath = getPath();
    public static String getPath(){
        String classPath=ConfigClass.class.getResource("/").getPath();
        String path = classPath.replaceAll("%20"," ");
        return path+"static/";
    }
}
