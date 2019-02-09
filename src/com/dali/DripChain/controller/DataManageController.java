package com.dali.DripChain.controller;

import com.dali.DripChain.dao.DataPointDao;
import com.dali.DripChain.dao.DataTemplateDao;
import com.dali.DripChain.entity.*;
import com.dali.DripChain.service.DataManageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/DataManage")
public class DataManageController {
    @Resource
    DataTemplateDao dataTemplateDao;
    @Resource
    DataPointDao dataPointDao;
    @Resource
    DataManageService dataManageService;

    //进入添加模板页面
    @RequestMapping(value = "/addDataTemplate",method = RequestMethod.GET)
    public String addDataTemplate(Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");

        return "Ent-addDataTemplate";
    }

    //进入修改模板页面
    @RequestMapping(value = "/editDataTemplate/{id}",method = RequestMethod.GET)
    public String editDataTemplate(@PathVariable(value = "id",required = false) Integer id, Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        if(id!=null){
            DataTemplate dataTemplate = dataTemplateDao.<DataTemplate>findUnique("from DataTemplate where id=?",id);
            if(dataTemplate==null){
                map.put("editDataTemplateMessage","id错误，非法进入！");
            }
            map.put("dataTemplate",dataTemplate);
        }
        return "Ent-editDataTemplate";
    }

    //处理添加和修改模板请求
    @RequestMapping(value = "/doAddOrUpdateDataTemplate",method = RequestMethod.POST)
    public String doAddDataTemplate(DataTemplate dataTemplate, Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        dataTemplate.setCompany(dataTemplateDao.<Company>findUnique("from Company where id=?",company.getId()));
        try {
            dataTemplateDao.saveOrUpdate(dataTemplate);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("DataTemplateMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/DataManage/dataTemplateList";
    }

    //进入模板列表页面(分页)
    @RequestMapping(value = {"/dataTemplateList","/dataTemplateList/{pageNum}"},method = RequestMethod.GET)
    public String dataTemplateList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord,Map<String,Object> map, HttpServletRequest request){
        Company company = (Company) request.getSession().getAttribute("Company");
        if(searchWord!=null){
            request.getSession().setAttribute("dataTemplateListSearchWord",searchWord);
        }
        searchWord=(String) request.getSession().getAttribute("dataTemplateListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=5;//设置每页显示的数据条数
        PageBean<DataTemplate> pageBean = dataManageService.dataTemplatePage(pageNum,pageSize,company.getId(),searchWord);
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        return "Ent-dataTemplateList";
    }

    //处理删除模板请求
    @RequestMapping(value = "/delDataTemplate/{id}",method = RequestMethod.GET)
    public String delDataTemplate(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map, HttpServletRequest request){
        Company company= (Company) request.getSession().getAttribute("Company");
        try {
            DataTemplate dataTemplate = dataTemplateDao.get(id);
            if(dataTemplate==null){
                map.put("delDataTemplateMessage","id错误，非法进入！");
            }else{
                //可以加判断删除是否属于该公司，避免恶意操作
                if(!Objects.equals(dataTemplate.getCompany().getId(),company.getId())){
                    map.put("delDataTemplateMessage","非法操作！");
                }else {
                    dataPointDao.executeUpdate("delete from DataPoint where dataTemplate.id=?",id);
                    dataTemplateDao.delete(dataTemplate);
                    map.put("delDataTemplateMessage","删除成功！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("delDataTemplateMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/DataManage/dataTemplateList";
    }

    //进入模板详情页
    @RequestMapping(value ={ "/getDataTemplate","/getDataTemplate/{pageNum}"},method = RequestMethod.GET)
    public String getDataTemplate(@PathVariable(value = "pageNum",required = false) Integer pageNum,String searchWord,Integer iDataTemplateId, Map<String, Object> map, HttpServletRequest request){
        Company company= (Company) request.getSession().getAttribute("Company");
        if(iDataTemplateId==null){
            map.put("DataTemplateMessage","非法操作！");
            return "Ent-dataPointList";
        }
        DataTemplate dataTemplate = dataTemplateDao.get(iDataTemplateId);
        if(dataTemplate==null){
            map.put("DataTemplateMessage","id错误，非法进入！");
        }else{
            //可以加判断删除是否属于该公司，避免恶意操作
            if(!Objects.equals(dataTemplate.getCompany().getId(),company.getId())){
                map.put("DataTemplateMessage","非法操作！");
            }else {
                //分页操作
                if(searchWord!=null){
                    request.getSession().setAttribute("dataPointListSearchWord",searchWord);
                }
                searchWord=(String) request.getSession().getAttribute("dataPointListSearchWord");
                //没有搜索或搜索为空则默认查询全部
                if(searchWord==null){
                    searchWord="";
                }
                if(pageNum == null || pageNum<=0){
                    pageNum=1;
                }
                int pageSize=5;//设置每页显示的数据条数
                PageBean<DataPoint> pageBean = dataManageService.getDataPointPageByDataTemaplateId(pageNum,pageSize,iDataTemplateId,searchWord);
                map.put("pageBean", pageBean);
                map.put("searchWord",searchWord);
                map.put("iDataTemplateId",iDataTemplateId);
            }
        }
        return "Ent-dataPointList";
    }

    //进入添加数据点页面
    @RequestMapping(value = "/addDataPoint",method = RequestMethod.GET)
    public String addDataPoint(Integer iDataTemplateId,Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        List<DataTemplate> dataTemplates = dataTemplateDao.find("from DataTemplate where company.id=?",company.getId());
        map.put("DataTemplateList",dataTemplates);
        if(iDataTemplateId!=null){
            map.put("iDataTemplateId",iDataTemplateId);
        }
        return "Ent-addDataPoint";
    }

    //进入修改数据点页面
    @RequestMapping(value = "/editDataPoint/{id}",method = RequestMethod.GET)
    public String editDataPoint(@PathVariable(value = "id",required = false) Integer id, Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        List<DataTemplate> dataTemplates = dataTemplateDao.find("from DataTemplate where company.id=?",company.getId());
        map.put("DataTemplateList",dataTemplates);
        if(id!=null){
            DataPoint dataPoint = dataPointDao.<DataPoint>findUnique("from DataPoint where id=?",id);
            if(dataPoint==null){
                map.put("editDataPointMessage","id错误，非法进入！");
            }
            map.put("dataPoint",dataPoint);
        }
        return "Ent-editDataPoint";
    }


    //处理添加和修改数据点请求
    @RequestMapping(value = "/doAddOrUpdateDataPoint",method = RequestMethod.POST)
    public String doAddDataPoint(DataPoint dataPoint,Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        int iDataTemplateId = Integer.parseInt(request.getParameter("iDataTemplateId"));
        dataPoint.setDataTemplate(dataTemplateDao.get(iDataTemplateId));
        //设置字节长度
        if(dataPoint.getiValueKind()!=null){
            switch (dataPoint.getiValueKind()){
                case 0:
                case 1:
                    dataPoint.setiDecimalAccuracy(null);
                    dataPoint.setiLength(1);
                    break;
                case 2:
                case 3:
                case 6:
                case 8:
                    dataPoint.setiDecimalAccuracy(null);
                    dataPoint.setiLength(2);
                    break;
                case 4:
                case 10:
                    dataPoint.setiLength(2);
                    break;
                case 11:
                    dataPoint.setiDecimalAccuracy(null);
                    dataPoint.setiLength(5);
                    break;
                case 12:
                    dataPoint.setiDecimalAccuracy(null);
                    dataPoint.setiLength(4);
                    break;
                case 13:
                    dataPoint.setiDecimalAccuracy(null);
                    dataPoint.setiLength(8);
                    break;
                case 14:
                    dataPoint.setiDecimalAccuracy(null);
                    break;
            }
        }else{
            dataPoint.setiValueKind(0);
            dataPoint.setiLength(1);
            dataPoint.setiDecimalAccuracy(null);
        }
        dataPointDao.saveOrUpdate(dataPoint);
        return "redirect:/DataManage/getDataTemplate?iDataTemplateId="+iDataTemplateId;
    }

    //处理删除模板请求
    @RequestMapping(value = "/delDataPoint/{id}",method = RequestMethod.GET)
    public String delDataPoint(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map, HttpServletRequest request){
        Company company= (Company) request.getSession().getAttribute("Company");
        int iDataTemplateId=0;
        try {
            DataPoint dataPoint = dataPointDao.get(id);
            if(dataPoint==null){
                map.put("delDataPointMessage","id错误，非法进入！");
            }else{
                //可以加判断删除是否属于该公司，避免恶意操作
                if(!Objects.equals(dataPoint.getDataTemplate().getCompany().getId(),company.getId())){
                    map.put("delDataPointMessage","非法操作！");
                }else {
                    iDataTemplateId = dataPoint.getDataTemplate().getId();
                    dataPointDao.delete(dataPoint);
                    map.put("delDataPointMessage","删除成功！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("delDataPointMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/DataManage/getDataTemplate?iDataTemplateId="+iDataTemplateId;
    }

    //显示设备状态信息列表（分页和搜索）
    @RequestMapping(value = {"/dataList","/dataList/{pageNum}"}, method = RequestMethod.GET)
    public String dataList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord, Map<String,Object> map, HttpSession session){
        Company company = (Company)session.getAttribute("Company");
        if(searchWord!=null){
            session.setAttribute("dataListSearchWord",searchWord);
        }
        searchWord=(String) session.getAttribute("dataListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=10;//设置每页显示的数据条数
        PageBean<Data> pageBean = dataManageService.dataPage(pageNum,pageSize,company.getId(),searchWord);
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        return "Ent-dataList";
    }


}
