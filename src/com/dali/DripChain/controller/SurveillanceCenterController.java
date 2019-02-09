package com.dali.DripChain.controller;

import com.dali.DripChain.dao.DeviceDao;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/SurveillanceCenter")
public class SurveillanceCenterController {
    @Resource
    DeviceDao deviceDao;

    @RequestMapping(value = "/mapDisplay",method = RequestMethod.GET)
    public String mapDisplay(String searchWord,Map<String, Object> map, HttpServletRequest request){
        Company company = (Company)request.getSession().getAttribute("Company");
        if(searchWord!=null){
            request.getSession().setAttribute("alarmRecordListSearchWord",searchWord);
        }
        searchWord=(String) request.getSession().getAttribute("alarmRecordListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        List<Device> devices = deviceDao.find("from Device where company.id=? and sDeviceName like ?",company.getId(),"%"+searchWord+"%");
        List<Device> deviceList = deviceDao.find("from Device where company.id=?",company.getId());
        map.put("devices",devices);
        map.put("deviceList",deviceList);
        return "Ent-mapDisplay";
    }

    @RequestMapping(value = "/listDisplay",method = RequestMethod.GET)
    public String listDisplay(Map<String, Object> map){

        return "Ent-listDisplay";
    }

}
