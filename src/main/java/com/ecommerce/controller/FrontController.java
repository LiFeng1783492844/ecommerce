package com.ecommerce.controller;

import com.ecommerce.ConfigClass;
import com.ecommerce.model.Basket;
import com.ecommerce.model.Member;
import com.ecommerce.model.Product;
import com.ecommerce.service.BasketService;
import com.ecommerce.service.MemberService;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lenovo on 2019/5/1.
 */
@Controller
public class FrontController {
    private Member member;
    private Product product;
    private Basket basket;
    private int maxPageNum; //最大分页数
    @Autowired
    MemberService memberService;
    @Autowired
    BasketService basketService;
    @Autowired
    ProductService productService;

    //注册
    @RequestMapping(value = "/register")
    public String register(HttpServletRequest request)throws Exception{
        return "/register";
    }
    @RequestMapping(value = "/doRegister")
    @ResponseBody
    public Map<String,Object> doRegister(Member member)throws Exception{
        return memberService.register(member);
    }

    //登录
    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request) throws Exception{
        return "/login";
    }
    @RequestMapping(value = "/doLogin")
    @ResponseBody
    public Map<String,Object> doLogin(Member member,HttpServletRequest request)throws Exception{
        Map<String,Object> result = new HashMap<>();
        result = memberService.login(member);
        if((Boolean) result.get("flag")){//登录成功
            //创建Session[USER]
            request.getSession().setAttribute("USER",result.get("user"));
        }
        return result;
    }

    //用户信息
    @RequestMapping(value = "/userInfo")
    public String userInfo(Model model, HttpServletRequest request)throws Exception{
        member=(Member) (request.getSession().getAttribute("USER"));
        if(member!=null){   //登录过了，就去用户信息页面
            model.addAttribute("member",member);
            return "/userInfo";
        }
        //没有登录过就返回登录页面
        return "/login";
    }

    //修改用户信息
    @RequestMapping(value = "/modifyMemberInfo")
    public String modifyMemberInfo(Model model,HttpServletRequest request)throws Exception{
        member=(Member) (request.getSession().getAttribute("USER"));
        if(member!=null){
            model.addAttribute("member",member);
            return "/modifyMemberInfo";
        }
        //没有登录过就返回登录页面
        return "/login";
    }
    @RequestMapping(value = "/modify")
    @ResponseBody
    public Map<String,Object> modify(Member member,HttpServletRequest request)throws Exception{
        return memberService.updateMember(member);
    }

    //购物车
    @RequestMapping(value = "/basket")
    public String basket(Model model, HttpServletRequest request)throws Exception{
        member=(Member) (request.getSession().getAttribute("USER"));
        if(member!=null){   //登录了
            model.addAttribute("flag",true);
            //没有结账的商品列表
            model.addAttribute("basketList",basketService.getListOfNotCheck(member));
            //结账的商品列表
            List<Basket> checkoutList = basketService.getListOfCheck(member);
            float total = 0;    //结账的商品列表的总价格
            for(int i=0;i<checkoutList.size();i++){
                Basket basket = checkoutList.get(i);
                total += basket.getPrice()*basket.getCount();
            }
            model.addAttribute("checkoutList",checkoutList);
            model.addAttribute("total",total);
        }else {
            model.addAttribute("flag",false);
        }
        return "/basket";
    }
    //确认购买商品
    @RequestMapping(value = "/confirm")
    @ResponseBody
    public Map<String,Object> confirm(Basket basket,HttpServletRequest request)throws Exception{
        basket.setDate(new Date());
        return basketService.confirm(basket);
    }

    //清空购物车
    @RequestMapping(value = "/cleanBasket")
    @ResponseBody
    public Map<String,Object> cleanBasket(HttpServletRequest request)throws Exception{
        member=(Member) (request.getSession().getAttribute("USER"));
        return basketService.cleanBasket(member);
    }
    //清空收银台
    @RequestMapping(value = "/cleanCheckout")
    @ResponseBody
    public Map<String,Object> cleanCheckout(HttpServletRequest request)throws Exception{
        member=(Member) (request.getSession().getAttribute("USER"));
        return basketService.cleanCheckout(member);
    }

    //结账
    @RequestMapping(value = "/checkout")
    public String checkout(Model model,HttpServletRequest request)throws Exception{
        member=(Member) (request.getSession().getAttribute("USER"));
        model.addAttribute("member",member);

        //订单编号
        SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMddHHmmss" );
        String subNum =member.getName() + sdf.format(new Date());
        model.addAttribute("subNum",subNum);

        model.addAttribute("checkoutFlag",basketService.checkout(member,subNum));

        return "/checkout";
    }

    //商品列表
    @RequestMapping(value = "/productList")
    public String productList(Model model, HttpServletRequest request)throws Exception{
        maxPageNum = productService.getMaxPageNum(ConfigClass.maxnum);
        //得到第一页的商品记录
        List<Product> productList = productService.getProductList(1,ConfigClass.maxnum);

        model.addAttribute("maxPageNum",maxPageNum);
        model.addAttribute("initial",productList);
        return "/productList";
    }
    @RequestMapping(value = "/changeProductList")
    @ResponseBody
    public Map<String,Object> changeProductList(@RequestParam("pagenum") String pagenum ,HttpServletRequest request)throws Exception{
        Map<String,Object> resultMap = new HashMap<String, Object>();
        maxPageNum = productService.getMaxPageNum(ConfigClass.maxnum);
        //得到第页的商品记录
        List<Product> productList = productService.getProductList(Integer.parseInt(pagenum),ConfigClass.maxnum);

        resultMap.put("maxPageNum",maxPageNum);
        resultMap.put("productList",productList);
        return resultMap;
    }

    //商品详情页
    @RequestMapping(value = "/details")
    @ResponseBody
    public Map<String,Object> productDetails(@RequestParam("productId") int productId, HttpServletRequest request)throws Exception{
        Map<String,Object> resultMap = new HashMap<String, Object>();
        //得到商品
        Product product = productService.getProductById(productId);
        resultMap.put("details",product);
        return resultMap;
    }

    //订购商品
    @RequestMapping(value = "/order")
    @ResponseBody
    public Map<String,Object> order(@RequestParam("productId")int productId,HttpServletRequest request)throws Exception{
        Map<String,Object> resultMap = new HashMap<String, Object>();
        member = (Member)(request.getSession().getAttribute("USER"));
        if (member!=null){//登录了
//            int id = Integer.parseInt(productId);
            resultMap.put("isLogin",true);
            //得到商品
            Product product = productService.getProductById(productId);
            //添加到购物车
            Boolean isOrder = basketService.order(member.getAccount(),product);
            resultMap.put("isOrder",isOrder);
            return resultMap;
        }
        resultMap.put("isLogin",false);
        return resultMap;
    }

    @RequestMapping(value = "/index")
    public String index()throws Exception{
        return "/index";
    }




}
