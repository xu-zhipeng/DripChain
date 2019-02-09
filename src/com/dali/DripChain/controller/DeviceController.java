package com.dali.DripChain.controller;

import com.dali.DripChain.aop.UserOperate;
import com.dali.DripChain.dao.DeviceDao;
import com.dali.DripChain.dao.DeviceGroupDao;
import com.dali.DripChain.entity.*;
import com.dali.DripChain.service.DeviceService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/Device")
public class DeviceController{
    @Resource
    DeviceDao deviceDao;
    @Resource
    DeviceGroupDao deviceGroupDao;
    @Resource
    DeviceService deviceService;

    //进入添加设备页面
    @RequestMapping(value = "/addDevice",method = RequestMethod.GET)
    public String addDevice(Model model,HttpSession session){
        Company company = (Company)session.getAttribute("Company");
        model.addAttribute("DeviceGroupList",deviceService.getDeviceGroupList(company.getId()));
        model.addAttribute("DataTemplateList",deviceService.getDataTemplateList(company.getId()));
        return "Ent-addDevice";
    }

    //处理添加设备请求
    @UserOperate(moduleName = "设备管理",funName = "doAddDevice",operateDesc = "添加设备")
    @RequestMapping(value = "/doAddDevice",method = RequestMethod.POST)
    public String doAddDevice(MultipartFile sImg, HttpServletRequest request, HttpServletResponse response, HttpSession session, Map<String,Object> map){
        //获取表单参数和session值
        String sDeviceName =request.getParameter("sDeviceName");
        String sDeviceId =request.getParameter("sDeviceId");
        String sDevicePass =request.getParameter("sDevicePass");//若为空则默认"123456"
        if(sDevicePass==null || sDevicePass.isEmpty()){
            sDevicePass="12345678";
        }
        String sSn =request.getParameter("sSn");
        String sDeviceAddress =request.getParameter("sDeviceAddress");
        String[] sSlaveIndex = request.getParameterValues("sSlaveIndex");
        String[] sSlaveName = request.getParameterValues("sSlaveName");
        String[] sSlaveAddr = request.getParameterValues("sSlaveAddr");
        String[] iDataTemplateId = request.getParameterValues("iDataTemplateId");
        Company company=(Company)session.getAttribute("Company");

        //创建并填充device
        Device device=new Device();
        device.setsDeviceName(sDeviceName);
        device.setsDeviceId(sDeviceId);
        device.setsDevicePass(sDevicePass);
        device.setsSn(sSn);
        if(request.getParameter("dDeviceLongitude")!=null && !request.getParameter("dDeviceLongitude").isEmpty()){
            BigDecimal dDeviceLongitude = new BigDecimal(request.getParameter("dDeviceLongitude"));
            device.setdDeviceLongitude(dDeviceLongitude);
        }
        if(request.getParameter("dDeviceLatitude")!=null && !request.getParameter("dDeviceLatitude").isEmpty()){
            BigDecimal dDeviceLatitude = new BigDecimal(request.getParameter("dDeviceLatitude"));
            device.setdDeviceLatitude(dDeviceLatitude);
        }
        device.setsDeviceAddress(sDeviceAddress);
        if(request.getParameter("iProtocol")!=null && !request.getParameter("iProtocol").isEmpty()){
            int iProtocol =Integer.parseInt(request.getParameter("iProtocol"));
            device.setiProtocol(iProtocol);
        }
        if(request.getParameter("iDeviceType")!=null && !request.getParameter("iDeviceType").isEmpty()){
            int iDeviceType = Integer.parseInt(request.getParameter("iDeviceType"));
            device.setiDeviceType(iDeviceType);
        }
        if(request.getParameter("iPollingInterval")!=null && !request.getParameter("iPollingInterval").isEmpty()){
            int iPollingInterval = Integer.parseInt(request.getParameter("iPollingInterval"));
            device.setiPollingInterval(iPollingInterval);
        }
        device.setdCreateTime(new Date());//设备添加时间
        device.setdUpdateTime(new Date());//设备修改时间
        System.out.println(device);

        //持久化company
        device.setCompany(deviceDao.<Company>findUnique("from Company where id=?",company.getId()));
        //持久化deviceGroup
        if(request.getParameter("iDeviceGroupId")!=null && !request.getParameter("iDeviceGroupId").isEmpty()){
            int iDeviceGroupId = Integer.parseInt(request.getParameter("iDeviceGroupId"));DeviceGroup deviceGroup=deviceDao.<DeviceGroup>findUnique("from DeviceGroup where id=?",iDeviceGroupId);
            device.setDeviceGroup(deviceGroup);
        }


        if(sSlaveIndex!=null){
            //持久化从机集合
            for(int i=0;i<sSlaveIndex.length;i++){
                DeviceSlave deviceSlave = new DeviceSlave();
                deviceSlave.setsSlaveIndex(sSlaveIndex[i]);
                deviceSlave.setsSlaveName(sSlaveName[i]);
                deviceSlave.setsSlaveAddr(sSlaveAddr[i]);
                DataTemplate dataTemplate = deviceDao.<DataTemplate>findUnique("from DataTemplate where id=?",Integer.parseInt(iDataTemplateId[i]));
                deviceSlave.setDataTemplate(dataTemplate);
                device.getDeviceSlaves().add(deviceSlave);
            }
            System.out.println("从机集合："+device.getDeviceSlaves());
        }

        //编辑设备接口
        String url="https://cloudapi.usr.cn/usrCloud/dev/addDevice";

        //上传图片
        int result = deviceService.addOrUpdateDevice(device,sImg,request,url);
        if(result==-1){//上传图片失败
            map.put("addDeviceMessage","系统错误，添加失败！请重新添加！");
        }else if(result==-2){
            map.put("addDeviceMessage","图片上传失败！请重新添加！");
        }else if(result==-3){
            map.put("addDeviceMessage","设备编号已存在！请重新添加！");
        }else if(result==-4){
            map.put("addDeviceMessage","数据透传平台添加失败！请重新添加！");
        }

        return "redirect:/Device/deviceList";
    }

    //显示设备信息列表（分页和搜索）
    @RequestMapping(value = {"/deviceList","/deviceList/{pageNum}"}, method = RequestMethod.GET)
    public String deviceList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord, Map<String,Object> map,HttpSession session){
        Company company = (Company)session.getAttribute("Company");
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
        PageBean<Device> pageBean = deviceService.findPage(pageNum,pageSize,company.getId(),searchWord);
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        //获取页面其他数据
        List<Device> deviceList =deviceDao.getAll();
        map.put("deviceList", deviceList);
        long onlineNum=deviceDao.findUnique("select count(*) from Device where company.id=? and iDeviceStatus=1",company.getId());
        long ModbusRTU=deviceDao.findUnique("select count(*) from Device where company.id=? and iProtocol=0",company.getId());
        long ModbusTCP=deviceDao.findUnique("select count(*) from Device where company.id=? and iProtocol=1",company.getId());
        long TCP=deviceDao.findUnique("select count(*) from Device where company.id=? and iProtocol=2",company.getId());
        long DLT64597=deviceDao.findUnique("select count(*) from Device where company.id=? and iProtocol=3",company.getId());
        long DLT64507 =deviceDao.findUnique("select count(*) from Device where company.id=? and iProtocol=4",company.getId());
        long smoke=deviceDao.findUnique("select count(*) from Device where company.id=? and iProtocol=5",company.getId());
        map.put("onlineNum", onlineNum);
        map.put("ModbusRTU", ModbusRTU);
        map.put("ModbusTCP", ModbusTCP);
        map.put("TCP", TCP);
        map.put("DLT64597", DLT64597);
        map.put("DLT64507", DLT64507);
        map.put("smoke", smoke);
        return "Ent-deviceList";
    }

    //进入编辑设备页面
    @RequestMapping(value = "/editDevice/{id}",method = RequestMethod.GET)
    public String editDevice(@PathVariable(value = "id",required = false) Integer id,HttpSession session, Map<String,Object> map){
        Device device = deviceDao.get(id);
        Company company = (Company)session.getAttribute("Company");
        map.put("DeviceGroupList",deviceService.getDeviceGroupList(company.getId()));
        map.put("DataTemplateList",deviceService.getDataTemplateList(company.getId()));
        map.put("device",device);
        return "Ent-editDevice";
    }

    //处理编辑设备请求
    @UserOperate(moduleName = "设备管理",funName = "doEditDevice",operateDesc = "编辑设备")
    @RequestMapping(value = "/doEditDevice",method = RequestMethod.POST)
    public String doEditDevice(MultipartFile sImg, HttpServletRequest request, HttpServletResponse response, HttpSession session, Map<String,Object> map){
        //获取表单参数和session值
        int id = Integer.parseInt(request.getParameter("DevicePK").isEmpty()?"0":request.getParameter("DevicePK"));
        String sDeviceName =request.getParameter("sDeviceName");
        String sDeviceId =request.getParameter("sDeviceId");
        String sDevicePass =request.getParameter("sDevicePass");//若为空则默认"123456"
        if(sDevicePass==null || sDevicePass.isEmpty()){
            sDevicePass="12345678";
        }
        String sSn =request.getParameter("sSn");
        String sDeviceAddress =request.getParameter("sDeviceAddress");
        String[] sSlaveIndex = request.getParameterValues("sSlaveIndex");
        String[] sSlaveName = request.getParameterValues("sSlaveName");
        String[] sSlaveAddr = request.getParameterValues("sSlaveAddr");
        String[] iDataTemplateId = request.getParameterValues("iDataTemplateId");
        Company company=(Company)session.getAttribute("Company");

        //创建并填充device
        Device device=new Device();
        if(!Objects.equals(id,0)){
            device.setId(id);
        }
        device.setsDeviceName(sDeviceName);
        device.setsDeviceId(sDeviceId);
        device.setsDevicePass(sDevicePass);
        if(request.getParameter("dDeviceLongitude")!=null && !request.getParameter("dDeviceLongitude").isEmpty()){
            BigDecimal dDeviceLongitude = new BigDecimal(request.getParameter("dDeviceLongitude"));
            device.setdDeviceLongitude(dDeviceLongitude);
        }
        if(request.getParameter("dDeviceLatitude")!=null && !request.getParameter("dDeviceLatitude").isEmpty()){
            BigDecimal dDeviceLatitude = new BigDecimal(request.getParameter("dDeviceLatitude"));
            device.setdDeviceLatitude(dDeviceLatitude);
        }
        device.setsDeviceAddress(sDeviceAddress);
        if(request.getParameter("iProtocol")!=null && !request.getParameter("iProtocol").isEmpty()){
            int iProtocol =Integer.parseInt(request.getParameter("iProtocol"));
            device.setiProtocol(iProtocol);
        }
        if(request.getParameter("iDeviceType")!=null && !request.getParameter("iDeviceType").isEmpty()){
            int iDeviceType = Integer.parseInt(request.getParameter("iDeviceType"));
            device.setiDeviceType(iDeviceType);
        }
        if(request.getParameter("iPollingInterval")!=null && !request.getParameter("iPollingInterval").isEmpty()){
            int iPollingInterval = Integer.parseInt(request.getParameter("iPollingInterval"));
            device.setiPollingInterval(iPollingInterval);
        }
        device.setdUpdateTime(new Date());//设备修改时间
        System.out.println(device);

        //持久化company
        device.setCompany(deviceDao.<Company>findUnique("from Company where id=?",company.getId()));
        //持久化deviceGroup
        if(request.getParameter("iDeviceGroupId")!=null && !request.getParameter("iDeviceGroupId").isEmpty()){
            int iDeviceGroupId = Integer.parseInt(request.getParameter("iDeviceGroupId"));DeviceGroup deviceGroup=deviceDao.<DeviceGroup>findUnique("from DeviceGroup where id=?",iDeviceGroupId);
            device.setDeviceGroup(deviceGroup);
        }

        if(sSlaveIndex!=null){
            //持久化从机集合
            for(int i=0;i<sSlaveIndex.length;i++){
                DeviceSlave deviceSlave = new DeviceSlave();
                deviceSlave.setsSlaveIndex(sSlaveIndex[i]);
                deviceSlave.setsSlaveName(sSlaveName[i]);
                deviceSlave.setsSlaveAddr(sSlaveAddr[i]);
                DataTemplate dataTemplate = deviceDao.<DataTemplate>findUnique("from DataTemplate where id=?",Integer.parseInt(iDataTemplateId[i]));
                deviceSlave.setDataTemplate(dataTemplate);
                device.getDeviceSlaves().add(deviceSlave);
            }
            System.out.println("从机集合："+device.getDeviceSlaves());
        }

        //编辑设备接口
        String url="https://cloudapi.usr.cn/usrCloud/dev/editDevice";
        //上传图片
        int result = deviceService.addOrUpdateDevice(device,sImg,request,url);
        if(result==-1){//上传图片失败
            map.put("editDeviceMessage","系统错误，修改失败！请重新修改！");
        }else if(result==-2){
            map.put("editDeviceMessage","图片上传失败！请重新添加！");
        }else if(result==-3){
            map.put("editDeviceMessage","设备编号已存在！请重新添加！");
        }else if(result==-4){
            map.put("editDeviceMessage","数据透传平台修改失败！请重新修改！");
        }

        return "redirect:/Device/deviceList";
    }

    //处理删除设备请求
    @UserOperate(moduleName = "设备管理",funName = "delDevice",operateDesc = "移除设备")
    @RequestMapping(value = "/delDevice/{sDeviceId}",method = RequestMethod.GET)
    public String delDevice(@PathVariable(value = "sDeviceId",required = false) String sDeviceId,HttpSession session, Map<String,Object> map){
        Company company = (Company)session.getAttribute("Company");
        int result=deviceService.delDevice(sDeviceId,company.getId());
        if(result==0){
            map.put("delDeviceMessage","设备删除成功！");
        }else if(result==-1){
            map.put("delDeviceMessage","设备删除失败！请重新删除！");
        }
        return "redirect:/Device/deviceList";
    }

    //处理批量删除设备请求
    @UserOperate(moduleName = "设备管理",funName = "delAllDevice",operateDesc = "批量删除设备")
    @RequestMapping(value = "/delAllDevice")
    @ResponseBody
    public String delAllDevice(int[] ids,Map<String, Object> map, HttpServletRequest request){
        String result="-1";
        Company company= (Company) request.getSession().getAttribute("Company");
        try {
            for(int id:ids){
                Device device=deviceDao.get(id);
                if(device==null){
                    result="-2";
                }else{
                    deviceService.delDevice(device.getsDeviceId(),company.getId());
                    result="0";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result="-1";
        }
        return result;
    }

    //进入设备分组列表页面(分页)
    @RequestMapping(value = {"/deviceGroupList","/deviceGroupList/{pageNum}"},method = RequestMethod.GET)
    public String deviceGroup(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord,Map<String,Object> map, HttpServletRequest request){
        Company company = (Company) request.getSession().getAttribute("Company");
        if(searchWord!=null){
            request.getSession().setAttribute("alarmListSearchWord",searchWord);
        }
        searchWord=(String) request.getSession().getAttribute("alarmListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=5;//设置每页显示的数据条数
        PageBean<Device> pageBean = deviceService.deviceGroupPage(pageNum,pageSize,company.getId(),searchWord);
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        return "Ent-deviceGroupList";
    }

    //进入添加设备分组页面
    @RequestMapping(value = "/addDeviceGroup",method = RequestMethod.GET)
    public String addDeviceGroup(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map,HttpServletRequest request){
        return "Ent-addDeviceGroup";
    }

    //进入编辑设备分组页面
    @RequestMapping(value = "/editDeviceGroup/{id}",method = RequestMethod.GET)
    public String editDeviceGroup(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map,HttpServletRequest request){
        if(id!=null){
            DeviceGroup deviceGroup = deviceDao.<DeviceGroup>findUnique("from DeviceGroup where id=?",id);
            if(deviceGroup==null){
                map.put("editDeviceGroupMessage","id错误，非法进入！");
            }
            map.put("deviceGroup",deviceGroup);
        }
        return "Ent-editDeviceGroup";
    }

    //处理添加修改设备分组请求
    @UserOperate(moduleName = "设备分组管理",funName = "doAddOrUpdateDeviceGroup",operateDesc = "添加和修改设备分组信息")
    @RequestMapping(value = "/doAddOrUpdateDeviceGroup",method = RequestMethod.POST)
    public String doAddDeviceGroup(DeviceGroup deviceGroup,Map<String,Object> map, HttpServletRequest request){
        Company company = (Company) request.getSession().getAttribute("Company");
        deviceGroup.setCompany(deviceDao.<Company>findUnique("from Company where id=?",company.getId()));
        try {
            if(Objects.equals(deviceGroup.getId(),0)){
                deviceGroup.setdCreateTime(new Date());
                deviceGroupDao.save(deviceGroup);
            }else{
                deviceGroup.setdUpdateTime(new Date());
                //deviceGroupDao.saveOrUpdate(deviceGroup);
                deviceDao.executeUpdate("update DeviceGroup set sGroupName=? ,dUpdateTime=? where id=?",
                        deviceGroup.getsGroupName(),deviceGroup.getdUpdateTime(),deviceGroup.getId());
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("DeviceGroupMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/Device/deviceGroupList";
    }

    //处理删除设备分组请求
    @UserOperate(moduleName = "设备分组管理",funName = "delDeviceGroup",operateDesc = "删除设备分组")
    @RequestMapping(value = "/delDeviceGroup/{id}",method = RequestMethod.GET)
    public String delDeviceGroup(@PathVariable(value = "id",required = false) Integer id, Map<String, Object> map){
        try {
            DeviceGroup deviceGroup = deviceGroupDao.get(id);
            if(deviceGroup==null){
                map.put("delDeviceGroupMessage","id错误，非法进入！");
            }else{
                deviceGroupDao.delete(deviceGroup);
                map.put("delDeviceGroupMessage","删除成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("delDeviceGroupMessage","系统错误，请稍后尝试！");
        }
        return "redirect:/Device/deviceGroupList";
    }

    //显示设备状态信息列表（分页和搜索）
    @RequestMapping(value = {"/deviceStatusList","/deviceStatusList/{pageNum}"}, method = RequestMethod.GET)
    public String deviceStatusList(@PathVariable(value = "pageNum",required = false) Integer pageNum, String searchWord, Map<String,Object> map,HttpSession session){
        Company company = (Company)session.getAttribute("Company");
        if(searchWord!=null){
            session.setAttribute("deviceStatusListSearchWord",searchWord);
        }
        searchWord=(String) session.getAttribute("deviceStatusListSearchWord");
        //没有搜索或搜索为空则默认查询全部
        if(searchWord==null){
            searchWord="";
        }
        if(pageNum == null || pageNum<=0){
            pageNum=1;
        }
        int pageSize=10;//设置每页显示的数据条数
        PageBean<Device> pageBean = deviceService.findPage(pageNum,pageSize,company.getId(),searchWord);
        map.put("pageBean", pageBean);
        map.put("searchWord",searchWord);
        //获取其他页面数据
        List<Device> deviceList =deviceDao.getAll();
        map.put("deviceList", deviceList);
        return "Ent-deviceStatus";
    }


}