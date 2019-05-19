package com.ecommerce.controller;

import com.ecommerce.ConfigClass;
import com.ecommerce.model.Ad;
import com.ecommerce.model.Admin;
import com.ecommerce.model.Member;
import com.ecommerce.model.Product;
import com.ecommerce.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lenovo on 2019/5/18.
 */
@Controller
public class BackgroundController {
    private int maxPageNum; //最大分页数
    @Autowired
    private AdminService  adminService;
    @Autowired
    MemberService memberService;
    @Autowired
    ProductService productService;
    @Autowired
    SystemService systemService;
    @Autowired
    AdService adService;


    //后台登录
    @RequestMapping(value = "/background/login")
    public String login()throws Exception{
        return "/bgLogin";
    }
    @RequestMapping(value = "/bgLogin")
    @ResponseBody
    public Map<String,Object> doLogin(Admin admin, HttpServletRequest request)throws Exception{
        Map<String,Object> result = new HashMap<>();
        result = adminService.login(admin);
        if((Boolean) result.get("flag")){//登录成功
            //创建Session[ADMIN]
            request.getSession().setAttribute("ADMIN",result.get("admin"));
        }
        return result;
    }

    //后台主页
    @RequestMapping(value = "/bgIndex")
    public String bgIndex(HttpServletRequest request)throws Exception{
        Admin admin = new Admin();
        admin = (Admin)(request.getSession().getAttribute("ADMIN"));
        if (admin==null){
            return "/bgLogin";
        }
        return "/bgIndex";
    }

    //回到前台
    @RequestMapping(value = "/backIndex")
    public String backIndex()throws Exception{
        return "redirect:/index";
    }

    //商品管理
    @RequestMapping(value = "/manageProduct")
    public String manageProduct(Model model, HttpServletRequest request)throws Exception{
        maxPageNum = productService.getMaxPageNum(ConfigClass.bgmaxnum);
        model.addAttribute("maxPageNum",maxPageNum);
        return "/manageProduct";
    }
    @RequestMapping(value = "/bgChangeProductList")
    @ResponseBody
    public Map<String,Object> bgChangeProductList(@RequestParam("pagenum") String pagenum , HttpServletRequest request)throws Exception{
        Map<String,Object> resultMap = new HashMap<String, Object>();
        maxPageNum = productService.getMaxPageNum(ConfigClass.bgmaxnum);
        //得到第页的商品记录
        List<Product> productList = productService.getProductList(Integer.parseInt(pagenum),ConfigClass.bgmaxnum);

        resultMap.put("maxPageNum",maxPageNum);
        resultMap.put("productList",productList);
        return resultMap;
    }
    //删除商品
    @RequestMapping(value = "/manageProduct/delete")
    @ResponseBody
    public Map<String,String> deleteProduct(@RequestParam("productId") int productId ,HttpServletRequest request) throws Exception {
        Map<String,String> resultMap = new HashMap<String, String>();
        //删除保存的照片
        Product product = productService.getProductById(productId);
        File img = new File(ConfigClass.ImgsSavePath+product.getPic());
        img.delete();

        Boolean deleteFlag = productService.delete(productId);
        if (deleteFlag){
            maxPageNum = productService.getMaxPageNum(ConfigClass.bgmaxnum);
            if(maxPageNum==0){
                maxPageNum=1;
            }
            resultMap.put("msg","success");
            resultMap.put("maxPageNum",maxPageNum+"");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }
    //修改商品信息
    @RequestMapping(value = "/manageProduct/modify")
    @ResponseBody
    public Map<String,String> modifyProduct(@RequestParam("id")int id,@RequestParam("name")String name,@RequestParam("price")String price,
                                     @RequestParam("count")String count,@RequestParam("date")String date)throws Exception{
        Map<String,String> resultMap = new HashMap<String, String>();

        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setPrice(price==null?0:Float.parseFloat(price));
        product.setCount(count==null?0:Integer.parseInt(count));
        product.setDate(date);

        Boolean modifyFlag = productService.modify(product);
        if (modifyFlag){
            resultMap.put("msg","success");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }


    //用户管理
    @RequestMapping(value = "/manageMember")
    public String manageMember(Model model, HttpServletRequest request)throws Exception{
        maxPageNum = memberService.getMaxPageNum(ConfigClass.bgmaxnum);
        model.addAttribute("maxPageNum",maxPageNum);
        return "/manageMember";
    }
    @RequestMapping(value = "/bgChangeMemberList")
    @ResponseBody
    public Map<String,Object> bgChangeMemberList(@RequestParam("pagenum") String pagenum , HttpServletRequest request)throws Exception{
        Map<String,Object> resultMap = new HashMap<String, Object>();
        maxPageNum = memberService.getMaxPageNum(ConfigClass.bgmaxnum);
        //得到第页的商品记录
        List<Member> memberList = memberService.getMemberList(Integer.parseInt(pagenum),ConfigClass.bgmaxnum);

        resultMap.put("maxPageNum",maxPageNum);
        resultMap.put("memberList",memberList);
        return resultMap;
    }
    //删除用户
    @RequestMapping(value = "/manageMember/delete")
    @ResponseBody
    public Map<String,String> deleteMember(@RequestParam("memberId") int memberId ,HttpServletRequest request) throws Exception {
        Map<String,String> resultMap = new HashMap<String, String>();
        Boolean deleteFlag = memberService.delete(memberId);
        if (deleteFlag){
            maxPageNum = memberService.getMaxPageNum(ConfigClass.bgmaxnum);
            if(maxPageNum==0){
                maxPageNum=1;
            }
            resultMap.put("msg","success");
            resultMap.put("maxPageNum",maxPageNum+"");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }
    //修改用户密码
    @RequestMapping(value = "/manageMember/modify")
    @ResponseBody
    public Map<String,String> modifyMember(@RequestParam("id")int id,@RequestParam("pass")String pass)throws Exception{
        Map<String,String> resultMap = new HashMap<String, String>();

        Member member = new Member();
        member.setId(id);
        member.setPass(pass);

        Boolean modifyFlag = memberService.modify(member);
        if (modifyFlag){
            resultMap.put("msg","success");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }

    //公告管理
    @RequestMapping(value = "/manageNotice")
    public String manageNotice(Model model, HttpServletRequest request)throws Exception{
        String content = systemService.getNotice();
        model.addAttribute("content",content);
        return "/manageNotice";
    }
    @RequestMapping(value = "/manageNotic/save")
    @ResponseBody
    public Map<String,Object> saveNotice(@RequestParam("notice")String notice)throws Exception{
        Map<String,Object> result = new HashMap<>();
        if(systemService.setNotice(notice)){//保存成功
            result.put("flag",true);
            return result;
        }
        result.put("flag",false);
        return result;
    }

    //链接管理
    @RequestMapping(value = "/manageLink")
    public String manageLink(Model model, HttpServletRequest request)throws Exception{
        maxPageNum = adService.getMaxPageNum(ConfigClass.bgmaxnum-1);
        model.addAttribute("maxPageNum",maxPageNum);
        return "/manageLink";
    }
    @RequestMapping(value = "/bgChangeAdList")
    @ResponseBody
    public Map<String,Object> bgChangeAdList(@RequestParam("pagenum") String pagenum , HttpServletRequest request)throws Exception{
        Map<String,Object> resultMap = new HashMap<String, Object>();
        maxPageNum = adService.getMaxPageNum(ConfigClass.bgmaxnum);
        //得到第页的商品记录
        List<Ad> adList = adService.getAdList(Integer.parseInt(pagenum),(ConfigClass.bgmaxnum-1));

        resultMap.put("maxPageNum",maxPageNum);
        resultMap.put("adList",adList);
        return resultMap;
    }
    //删除链接
    @RequestMapping(value = "/manageAd/delete")
    @ResponseBody
    public Map<String,String> deleteAd(@RequestParam("adId") int adId ,HttpServletRequest request) throws Exception {
        Map<String,String> resultMap = new HashMap<String, String>();
        Boolean deleteFlag = adService.delete(adId);
        if (deleteFlag){
            maxPageNum = adService.getMaxPageNum(ConfigClass.bgmaxnum-1);
            if(maxPageNum==0){
                maxPageNum=1;
            }
            resultMap.put("msg","success");
            resultMap.put("maxPageNum",maxPageNum+"");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }
    //修改链接信息
    @RequestMapping(value = "/manageAd/modify")
    @ResponseBody
    public Map<String,String> modifyAd(@RequestParam("id")int id,@RequestParam("name")String name,@RequestParam("url")String url)throws Exception{
        Map<String,String> resultMap = new HashMap<String, String>();

        Ad ad = new Ad();
        ad.setId(id);
        ad.setName(name);
        ad.setUrl(url);

        Boolean modifyFlag = adService.modify(ad);
        if (modifyFlag){
            resultMap.put("msg","success");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }
    //添加链接
    @RequestMapping(value = "/manageAd/add")
    @ResponseBody
    public Map<String,String> addAd(@RequestParam("name")String name,@RequestParam("url")String url)throws Exception{
        Map<String,String> resultMap = new HashMap<String, String>();

        Ad ad = new Ad();
        ad.setName(name);
        ad.setUrl(url);

        Boolean modifyFlag = adService.add(ad);
        if (modifyFlag){
            resultMap.put("msg","success");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }

    //添加商品
    @RequestMapping(value = "/addProduct")
    public String add()throws Exception{
        return "/addProduct";
    }
    @RequestMapping(value = "/manageProduct/add")
    @ResponseBody
    public Map<String,String> addProduct(@RequestParam("name")String name, @RequestParam("price")String price, @RequestParam("info")String info,
                                         @RequestParam("imgBase64")String imgBase64, @RequestParam("count")String count, @RequestParam("date")String date)throws Exception{
        Map<String,String> resultMap = new HashMap<String, String>();
        String picUrl = null;

        //上传的图片的名字
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String picname = sdf.format(new Date());

        //图片上传
        //1.获取base64后面的数据，picUrlBase64字符串前面有一串东西是不需要的
        String base64Date = imgBase64.split(",")[1];
        //2.解码成字节数组
        Base64.Decoder decoder = Base64.getDecoder();
        byte[] bytes = decoder.decode(base64Date);
        //3.字节流转文件
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(ConfigClass.ImgsSavePath+"images"+File.separator+picname+".jpg");
            fos.write(bytes);
        }catch (Exception e){
            System.out.println(e);
        }finally {
            if (fos!=null){
                try {
                    fos.close();
                }catch (Exception e){
                    System.out.println(e);
                }
                picUrl = "/images/"+picname+".jpg";
            }
        }

        Product product = new Product();
        product.setName(name);
        product.setPrice(Float.parseFloat(price));
        product.setInfo(info);
        product.setPic(picUrl);
        product.setCount(Integer.parseInt(count));
        product.setDate(date);

        Boolean addFlag = productService.add(product);
        if (addFlag){
            resultMap.put("msg","success");
        }else {
            resultMap.put("msg","fail");
        }
        return resultMap;
    }

}
