package com.dali.DripChain.controller;

import com.dali.DripChain.aop.UserOperate;
import com.dali.DripChain.dao.AlarmDao;
import com.dali.DripChain.dao.AlarmRecordDao;
import com.dali.DripChain.dao.ContactDao;
import com.dali.DripChain.entity.*;
import com.dali.DripChain.service.AlarmService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/Alarm")
public class AlarmController {
    @Resource
    AlarmDao alarmDao;
    @Resource
    AlarmRecordDao alarmRecordDao;
    @Resource
    AlarmService alarmService;
    @Resource
    ContactDao contactDao;

    //进入添加警报页面
    @RequestMapping(value = "/addAlarm",method = RequestMethod.GET)
    public String addAlarm(Map<String, Object> map,HttpSession session){
        Company company= (Company)session.getAttribute("Company");
        map.put("DataTemplateList",alarmService.getDataTemplateList(company.getId()));
        map.put("ContactList",alarmService.getContactList(company.getId()));
        map.put("DeviceList",alarmService.getDeviceList(company.getId()));
        return "Ent-addAlarm";
    }

    //处理添加警报请求
    @UserOperate(moduleName = "警报模块",funName = "doAddAlarm",operateDesc = "添加警报")
    @RequestMapping(value = "/doAddAlarm",method = RequestMethod.POST)
    public String doAddAlarm(Alarm alarm,HttpServletRequest request, Map<String, Object> map,HttpSession session){
        Company company= (Company)session.getAttribute("Company");
        int iDatatemplateId=Integer.parseInt(request.getParameter("iDatatemplateId"));
        int iDatapointId=Integer.parseInt(request.getParameter("iDatapointId"));
        int iContactId=Integer.parseInt(request.getParameter("iContactId"));
        int iDeviceId=Integer.parseInt(request.getParameter("iDeviceId"));
        alarm.setDataPoint(alarmDao.<DataPoint>findUnique("from DataPoint where id=?",iDatapointId));
        alarm.setDataTemplate(alarmDao.<DataTemplate>findUnique("from DataTemplate where id=?",iDatatemplateId));
        alarm.setContact(alarmDao.<Contact>findUnique("from Contact where id=?",iContactId));
        alarm.setDevice(alarmDao.<Device>findUnique("from Device where id=?",iDeviceId));
        alarm.setCompany(alarmDao.<Company>findUnique("from Company where id=?",company.getId()));
        alarm.setdUpdateTime(new Date());
        System.out.println("警报："+alarm);
        int result=alarmService.addAlarm(alarm);
        if(result==-1){
            map.put("addAlarmMessage","系统错误，请重新添加！");
        }
        return "redirect:/Alarm/alarmList";
    }

    //进入警报列表页面（带分页和查询功能）
    @RequestMapping(value = {"/alarmList","/alarmList/{pageNum}"},method = RequestMethod.GET)
    public String alarmList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord, Map<String, Object> map,HttpSession session){
        Company company= (Company)session.getAttribute("Company");
        if(searchWord!=null){
            session.setAttribute("alarmListSearchWord",searchWord);
        }
        searchWord=(String) session.getAttribute("alarmListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=10;//设置每页显示的数据条数
        PageBean<Alarm> pageBean = alarmService.findPage(pageNum,pageSize,searchWord,company.getId());
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        return "Ent-alarmList";
    }

    //进入编辑警报页面
    @RequestMapping(value = "/editAlarm/{id}",method = RequestMethod.GET)
    public String editAlarm(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map,HttpSession session){
        Alarm alarm= alarmDao.findUnique("from Alarm where id=?",id);
        Company company= (Company)session.getAttribute("Company");
        map.put("DataTemplateList",alarmService.getDataTemplateList(company.getId()));
        map.put("ContactList",alarmService.getContactList(company.getId()));
        map.put("DeviceList",alarmService.getDeviceList(company.getId()));
        map.put("alarm",alarm);
        return "Ent-editAlarm";
    }

    //处理编辑警报请求
    @UserOperate(moduleName = "警报模块",funName = "doEditAlarm",operateDesc = "编辑警报")
    @RequestMapping(value = "/doEditAlarm",method = RequestMethod.POST)
    public String doEditAlarm(Alarm alarm,HttpServletRequest request, Map<String, Object> map,HttpSession session){
        Company company= (Company)session.getAttribute("Company");
        int id=Integer.parseInt(request.getParameter("AlarmPK"));
        int iDatatemplateId=Integer.parseInt(request.getParameter("iDatatemplateId"));
        int iDatapointId=Integer.parseInt(request.getParameter("iDatapointId"));
        int iContactId=Integer.parseInt(request.getParameter("iContactId"));
        int iDeviceId=Integer.parseInt(request.getParameter("iDeviceId"));
        alarm.setId(id);
        alarm.setDataPoint(alarmDao.<DataPoint>findUnique("from DataPoint where id=?",iDatapointId));
        alarm.setDataTemplate(alarmDao.<DataTemplate>findUnique("from DataTemplate where id=?",iDatatemplateId));
        alarm.setContact(alarmDao.<Contact>findUnique("from Contact where id=?",iContactId));
        alarm.setDevice(alarmDao.<Device>findUnique("from Device where id=?",iDeviceId));
        alarm.setCompany(alarmDao.<Company>findUnique("from Company where id=?",company.getId()));
        alarm.setdUpdateTime(new Date());
        System.out.println("警报："+alarm);
        int result=alarmService.updateAlarm(alarm);
        if(result==-1){
            map.put("addAlarmMessage","系统错误，请重新编辑！");
        }
        return "redirect:/Alarm/alarmList";
    }

    //处理删除警报请求
    @UserOperate(moduleName = "警报模块",funName = "delAlarm",operateDesc = "删除警报")
    @RequestMapping(value = "/delAlarm/{id}",method = RequestMethod.GET)
    public String delAlarm(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map, HttpServletRequest request){
        Company company= (Company) request.getSession().getAttribute("Company");
        try {
            Alarm alarm = alarmDao.get(id);
            if(alarm==null){
                map.put("delAlarmMessage","id错误，非法进入！");
            }else{
                //可以加判断删除是否属于该公司，避免恶意操作
                if(!Objects.equals(alarm.getCompany().getId(),company.getId())){
                    map.put("delAlarmMessage","非法操作！");
                }else {
                    alarmDao.delete(alarm);
                    map.put("delAlarmMessage","删除成功！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("delAlarmMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/Alarm/alarmList";
    }

    //处理批量删除警报请求
    @UserOperate(moduleName = "警报模块",funName = "delAllAlarm",operateDesc = "批量删除警报")
    @RequestMapping(value = "/delAllAlarm",method = RequestMethod.POST)
    @ResponseBody
    public String delAllAlarm(int[] ids,Map<String, Object> map, HttpServletRequest request){
        String result="-1";
        Company company= (Company) request.getSession().getAttribute("Company");
        try {
            for(int id:ids){
                Alarm alarm = alarmDao.get(id);
                if(alarm==null){
                    result="-2";
                }else{
                    //可以加判断删除是否属于该公司，避免恶意操作
                    if(!Objects.equals(alarm.getCompany().getId(),company.getId())){
                        result="-3";
                    }else {
                        alarmDao.delete(alarm);
                        result="0";
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result="-1";
        }
        return result;
    }

    /*联系人管理*/
    //进入添加联系人页面
    @RequestMapping(value = "/addContact",method = RequestMethod.GET)
    public String addContact(Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");

        return "Ent-addContact";
    }

    //进入修改联系人页面
    @RequestMapping(value = "/editContact/{id}",method = RequestMethod.GET)
    public String editContact(@PathVariable(value = "id",required = false) Integer id, Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        if(id!=null){
            Contact contact = contactDao.<Contact>findUnique("from Contact where id=?",id);
            if(contact==null){
                map.put("editContactMessage","id错误，非法进入！");
            }
            map.put("contact",contact);
        }
        return "Ent-editContact";
    }

    //处理添加和修改联系人请求
    @UserOperate(moduleName = "联系人模块",funName = "doAddOrUpdateContact",operateDesc = "添加和编辑联系人")
    @RequestMapping(value = "/doAddOrUpdateContact",method = RequestMethod.POST)
    public String doAddOrUpdateContact(Contact contact, Map<String,Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        contact.setCompany(contactDao.<Company>findUnique("from Company where id=?",company.getId()));
        try {
            contactDao.saveOrUpdate(contact);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("ContactMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/Alarm/contactList";
    }

    //进入联系人列表页面(分页和查询)
    @RequestMapping(value = {"/contactList","/contactList/{pageNum}"},method = RequestMethod.GET)
    public String contactList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord,Map<String,Object> map, HttpServletRequest request){
        Company company = (Company) request.getSession().getAttribute("Company");
        if(searchWord!=null){
            request.getSession().setAttribute("contactListSearchWord",searchWord);
        }
        searchWord=(String) request.getSession().getAttribute("contactListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=5;//设置每页显示的数据条数
        PageBean<Contact> pageBean = alarmService.contactPage(pageNum,pageSize,searchWord,company.getId());
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        return "Ent-contactList";
    }

    //处理删除联系人请求
    @UserOperate(moduleName = "联系人模块",funName = "delContact",operateDesc = "删除联系人")
    @RequestMapping(value = "/delContact/{id}",method = RequestMethod.GET)
    public String delContact(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map, HttpServletRequest request){
        Company company= (Company) request.getSession().getAttribute("Company");
        try {
            Contact contact = contactDao.get(id);
            if(contact==null){
                map.put("delContactMessage","id错误，非法进入！");
            }else{
                //可以加判断删除是否属于该公司，避免恶意操作
                if(!Objects.equals(contact.getCompany().getId(),company.getId())){
                    map.put("delContactMessage","非法操作！");
                }else {
                    //删除跟该联系人所有相关的警报
                    alarmService.delContact(contact);
                    map.put("delContactMessage","删除成功！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("delContactMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/Alarm/contactList";
    }

    //处理批量删除警报请求
    @UserOperate(moduleName = "联系人模块",funName = "delAllContact",operateDesc = "批量删除联系人")
    @RequestMapping(value = "/delAllContact",method = RequestMethod.POST)
    @ResponseBody
    public String delAllContact(int[] ids,Map<String, Object> map, HttpServletRequest request){
        String result="-1";
        Company company= (Company) request.getSession().getAttribute("Company");
        try {
            for(int id:ids){
                Contact contact = contactDao.get(id);
                if(contact==null){
                    result="-2";
                }else{
                    //可以加判断删除是否属于该公司，避免恶意操作
                    if(!Objects.equals(contact.getCompany().getId(),company.getId())){
                        result="-3";
                    }else {
                        //删除跟该联系人所有相关的警报
                        alarmService.delContact(contact);
                        result="0";
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result="-1";
        }
        return result;
    }

    //进入警报记录页面（带分页和查询功能）
    @RequestMapping(value = {"/alarmRecordList","/alarmRecordList/{pageNum}"},method = RequestMethod.GET)
    public String alarmRecordList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord, Map<String, Object> map,HttpSession session){
        Company company= (Company)session.getAttribute("Company");
        if(searchWord!=null){
            session.setAttribute("alarmRecordListSearchWord",searchWord);
        }
        searchWord=(String) session.getAttribute("alarmRecordListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=10;//设置每页显示的数据条数
        PageBean<AlarmRecord> pageBean = alarmService.alarmRecordPage(pageNum,pageSize,searchWord,company.getId());
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        return "Ent-alarmRecordList";
    }

    //处理修改警报处理状态请求
    @UserOperate(moduleName = "警报记录模块",funName = "updateAlarmRecordStatus",operateDesc = "修改警报处理状态")
    @RequestMapping(value = "/updateAlarmRecordStatus/{id}")
    public String updateAlarmRecordStatus(@PathVariable(value = "id",required = false) Integer id){
        AlarmRecord alarmRecord=alarmRecordDao.get(id);
        if(alarmRecord!=null){
            alarmRecord.setsHandlingStatus("已处理");
            try {
                alarmService.updateAlarmRecord(alarmRecord);
            } catch (Exception e) {
                System.out.println("警报处理状态修改失败");
                e.printStackTrace();
            }
        }
        return "redirect:/Alarm/alarmRecordList";
    }


}
