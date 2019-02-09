package com.dali.DripChain.service;

import com.dali.DripChain.dao.DeviceDao;
import com.dali.DripChain.dao.DeviceSlaveDao;
import com.dali.DripChain.entity.*;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.hibernate.Session;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.*;

@Transactional
@Service
public class DeviceService {
    @Resource
    private DeviceDao deviceDao;
    @Resource
    private DeviceSlaveDao deviceSlaveDao;

    public void test(){
        //解除级联后，先删除被引用的记录（从表记录），在删主记录（主表）
       /* Device device=deviceDao.findUnique("from Device where id=?",14);

        for(DeviceSlave deviceSlave:device.getDeviceSlaves()){
            deviceSlaveDao.delete(deviceSlave);
        }
        System.out.println(device);
        deviceDao.delete(device);*/
    }

    public List<DeviceGroup> getDeviceGroupList(int iCompanyId){
        return deviceDao.<DeviceGroup>find("from DeviceGroup where company.id=?",iCompanyId);
    }

    public List<DataTemplate> getDataTemplateList(int iCompanyId){
        return deviceDao.<DataTemplate>find("from DataTemplate where company.id=?",iCompanyId);
    }

    public PageBean<Device> findPage(int pageNum, int pageSize,int iCompanyId,String searchWord){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = deviceDao.<Long>findUnique("select count(*) from Device where company.id=? and sDeviceName like ?",iCompanyId,searchWord).intValue();

        PageBean<Device> pageBean = new PageBean<Device>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();

        pageBean.setList(deviceDao.<Device>findPage("from Device where company.id=? and sDeviceName like ?",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

    public PageBean<Device> deviceGroupPage(int pageNum, int pageSize,int iCompanyId,String searchWord){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = deviceDao.<Long>findUnique("select count(*) from DeviceGroup where company.id=? and sGroupName like ?",iCompanyId,searchWord).intValue();

        PageBean<Device> pageBean = new PageBean<Device>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();

        pageBean.setList(deviceDao.<Device>findPage("from DeviceGroup where company.id=? and sGroupName like ?",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

    //添加设备操作
    public int addOrUpdateDevice(Device device, MultipartFile sImg, HttpServletRequest request,String url){
        //jackson 对象转字符串
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);//Include.NON_EMPTY 属性为 空（“”） 或者为 NULL 都不序列化

        int result=-1;
        //数据透传平台添加设备
        String rs = judgeType(device,url);
        Map<String,Object> map=null;
        try {
            map = objectMapper.readValue(rs,Map.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if(!Objects.equals(map.get("status"),0)) {
            return -4;
        }
        if(Objects.equals(device.getId(),0)){  //添加设备  加入返回的id
            Map<String,Object> data = (Map<String,Object>)map.get("data");
            //插入设备编号
            String sDeviceId = (String)data.get("deviceId");
            device.setsDeviceId(sDeviceId);
            //查询设备编号是否重复
            Device deviceUnique = deviceDao.<Device>findUnique("from Device where sDeviceId=?",device.getsDeviceId());
            if(deviceUnique!=null){
                //删除有人添加的设备
                Map<String,Object> loginData = HttpPostLogin();
                String token = (String)loginData.get("token");
                Map<String,Object> requestmap=new HashMap<String,Object>();
                requestmap.put("token",token);
                List<String> deviceIds=new ArrayList<String>();
                deviceIds.add(device.getsDeviceId());
                requestmap.put("deviceIds",deviceIds);
                String delresult=HttpPost("https://cloudapi.usr.cn/usrCloud/dev/deleteDevices",requestmap);
                System.out.println("设备编号重复-删除设备-返回字符串："+delresult);
                return -3;
            }
        }

        //插入数据库操作
        if(!sImg.isEmpty()){
            Date currentTime = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
            String date = simpleDateFormat.format(currentTime);
            simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            String dateTime = simpleDateFormat.format(currentTime);
            //获取上传文件的原始名称
            String originName = sImg.getOriginalFilename();
            //使用UUID重新命名上传的文件名称（看公司需求，也可以用日期时间）
            //String newName= UUID.randomUUID()+originName.substring(originName.lastIndexOf("."));
            String newName= dateTime + originName.substring(originName.lastIndexOf("."));
            //设置上传文件的保存地址目录
            String rootPath=request.getSession().getServletContext().getRealPath("/");
            String filePath="views\\upLoad\\images\\"+date+"\\";
            File dir =new File(rootPath+filePath);
            //如果保存文件的地址不存在，就先创建目录
            if(!dir.exists()){
                dir.mkdirs();
            }

            try {
                //使用MultipartFile接口的方法完成文件上传到指定位置
                sImg.transferTo(new File(rootPath+filePath+newName));
            } catch (IOException e) {
                System.out.println("图片上传失败");
                e.printStackTrace();
                return -2;
            }
            //文件上传成功后，需要将文件存放路径存入数据库中
            device.setsImg("views/upLoad/images/"+date+"/"+newName);
            try {
                //设备添加操作
                if(Objects.equals(device.getId(),0)){
                    Set<DeviceSlave> deviceSlaves = device.getDeviceSlaves();
                    device.setDeviceSlaves(null);
                    result = (Integer)deviceDao.save(device);
                    for(DeviceSlave deviceSlave : deviceSlaves){
                        deviceSlave.setDevice(deviceDao.get(result));
                        deviceSlaveDao.save(deviceSlave);
                    }
                }else {//设备修改操作
                    Set<DeviceSlave> deviceSlavesNow = device.getDeviceSlaves();
                    device.setDeviceSlaves(null);
                    //用deviceDao的currentSession报对象重复的错，因为上面查询图片把他查询出来，所以使用openSession新建一个session
                    Session session =deviceDao.openSession();
                    session.beginTransaction();
                    session.saveOrUpdate(device);
                    session.getTransaction().commit();
                    session.close();
                    //先删除之前从机
                    List<DeviceSlave> deviceSlavesAgo = deviceDao.<DeviceSlave>find("from DeviceSlave where iDeviceId=?",device.getId());
                    for(DeviceSlave deviceSlave : deviceSlavesAgo){
                        deviceSlaveDao.delete(deviceSlave);
                    }
                    //添加从机
                    for(DeviceSlave deviceSlave : deviceSlavesNow){
                        deviceSlave.setDevice(deviceDao.get(device.getId()));
                        deviceSlaveDao.save(deviceSlave);
                    }
                    System.out.println("显示："+device);
                    result=device.getId();
                }

            } catch (Exception e) {
                System.out.println("添加设备到数据库失败");
                //将存入的图片删除
                File targetFile = new File(rootPath+filePath+newName);
                if(targetFile.exists()){
                    boolean isDelete = targetFile.delete();
                    System.out.println("图片删除成功");
                }
                e.printStackTrace();
            }
            return result;

        }else{//不添加图片操作
            if(Objects.equals(device.getId(),0)){//设备添加操作
                Set<DeviceSlave> deviceSlaves = device.getDeviceSlaves();
                device.setDeviceSlaves(null);
                System.out.println("显示："+device);
                result=(Integer)deviceDao.save(device);
                for(DeviceSlave deviceSlave : deviceSlaves){
                    deviceSlave.setDevice(deviceDao.get(result));
                    deviceSlaveDao.save(deviceSlave);
                }
            }else {//设备修改操作
                String imgurl=deviceDao.<String>findUnique("select sImg from Device where id=?",device.getId());
                if(imgurl!=null && !imgurl.isEmpty()){
                    device.setsImg(imgurl);
                }
                Set<DeviceSlave> deviceSlavesNow = device.getDeviceSlaves();
                device.setDeviceSlaves(null);
                //用deviceDao的currentSession报对象重复的错，因为上面查询图片把他查询出来，所以使用openSession新建一个session
                Session session =deviceDao.openSession();
                session.beginTransaction();
                session.saveOrUpdate(device);
                session.getTransaction().commit();
                session.close();
                //先删除之前从机
                List<DeviceSlave> deviceSlavesAgo = deviceDao.<DeviceSlave>find("from DeviceSlave where iDeviceId=?",device.getId());
                for(DeviceSlave deviceSlave : deviceSlavesAgo){
                    deviceSlaveDao.delete(deviceSlave);
                }
                //添加从机
                for(DeviceSlave deviceSlave : deviceSlavesNow){
                    deviceSlave.setDevice(deviceDao.get(device.getId()));
                    deviceSlaveDao.save(deviceSlave);
                }
                System.out.println("显示："+device);
                result=device.getId();
            }
            return result;
        }

    }

    public int delDevice(String sDeviceId,int iCompanyId ){
        String url="https://cloudapi.usr.cn/usrCloud/dev/deleteDevices";
        Device device =deviceDao.findUnique("from Device where sDeviceId=? and company.id=?",sDeviceId,iCompanyId);
        System.out.println(device);
        //jackson 对象转字符串
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);//Include.NON_EMPTY 属性为 空（“”） 或者为 NULL 都不序列化

        Map<String,Object> loginData = HttpPostLogin();
        String token = (String)loginData.get("token");
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("token",token);
        List<String> deviceIds=new ArrayList<String>();
        deviceIds.add(sDeviceId);
        map.put("deviceIds",deviceIds);
        String result=HttpPost(url,map);
        try {
            map=objectMapper.readValue(result,Map.class);
            if(Objects.equals(map.get("status"),0)){
                for(DeviceSlave deviceSlave:device.getDeviceSlaves()){
                    deviceSlaveDao.delete(deviceSlave);
                }
                deviceDao.delete(device);
                return 0;
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("删除设备失败！");
        }
        return -1;
    }

    public String HttpPost(String url,Map<String,Object> map){
        //jackson 对象转字符串
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);//Include.NON_EMPTY 属性为 空（“”） 或者为 NULL 都不序列化

        String result ="";
        BufferedReader in =null;
        //由于DefaultHttpClient过时了  所以将这里的 HttpClient httpClient = new DefaultHttpClient(); 替换为CloseableHttpClient httpClient = HttpClients.createDefault();
        // HttpClient类  替换为 CloseableHttpClient  HttpResponse类 替换为 CloseableHttpResponse
        //首先需要先创建一个的CloseableHttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        //发送POST请求:
        //创建一个HttpPost对象,传入目标的网络地址:  HttpPost httpPost =new HttpPost("https://cloudapi.usr.cn/usrCloud/user/login");
        HttpPost httpPost =new HttpPost(url);
        CloseableHttpResponse response = null;
        try{
            //设置URL
            //httpPost.setURI(new URI(url));

            //jackson 对象转字符串
            String jsonstr = objectMapper.writeValueAsString(map);
            System.out.println("requestjson:"+jsonstr);

            //然后调用HttpPost的setEntity()方法将构建好的StringEntity传入:
            httpPost.setEntity(new StringEntity(jsonstr,"utf-8"));
            httpPost.setHeader("Content-Type","application/x-www-form-urlencoded");
            //调用HttpClient的execute()方法,并将HttpPost对象传入即可:
            //执行execute()方法之后会返回一个HttpResponse对象,服务器所返回的所有信息就保护在HttpResponse里面.
            response =httpClient.execute(httpPost);
            //先取出服务器返回的状态码,如果等于200就说明请求和响应都成功了:
            //If(httpResponse.getStatusLine().getStatusCode()==200){...}
            if(HttpStatus.SC_OK==response.getStatusLine().getStatusCode())
            {
                in = new BufferedReader(new InputStreamReader(response.getEntity().getContent(),"UTF-8"));
                String line;
                while((line=in.readLine()) != null){
                    result+=line;
                }

            }
        }catch(Exception e) {
            e.printStackTrace();
            System.out.println("Http请求登录失败");
        }finally {
            //释放资源
            if(response != null){
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(httpClient != null){
                try {
                    httpClient.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        System.out.println("HttpPostResult:"+result);
        return result;
    }

    public Map<String,Object> HttpPostLogin(){
        //jackson 对象转字符串
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);//Include.NON_EMPTY 属性为 空（“”） 或者为 NULL 都不序列化

        String result = "";
        String url = "https://cloudapi.usr.cn/usrCloud/user/login";
        //数据写入map
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("account","dlyhc");
        map.put("password","e10adc3949ba59abbe56e057f20f883e");
        result = HttpPost(url,map);
        if(result.isEmpty()){
            System.out.println("HttpPost方法失败");
            return null;
        }
        map = null;
        try {
            map = objectMapper.readValue(result, Map.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,Object> data =null;
        if(Objects.equals(map.get("status"),0)){
            data= (Map<String, Object>) map.get("data");
        }else{
            System.out.println("数据透传平台登录失败");
        }
        return data;
    }

    //默认设备（ModbusRTU、Modbus TCP、DL/T645-97、DL/T645-07）0  :[0,1,3,4]
    public String addDeviceDefaultModbus(Device device,String url){
        //返回数据 {"data":{"deviceId":"00013592000571761747"},"info":"ok","status":0}
        String result="failed";

        Map<String,Object> loginData = HttpPostLogin();
        String token = (String)loginData.get("token");
        int uid =(Integer)loginData.get("uid");
        Map<String,Object> requestdata = new HashMap<String, Object>();
        requestdata.put("token",token);
        Map<String,Object> devicedata = new HashMap<String, Object>();
        //如果设备编号为空自动生成
        if(device.getsDeviceId()!=null && !device.getsDeviceId().isEmpty()){
            devicedata.put("deviceId",device.getsDeviceId());
        }
        devicedata.put("pass",device.getsDevicePass());
        devicedata.put("groupId","0");
        devicedata.put("name",device.getsDeviceName());
        devicedata.put("type",String.valueOf(device.getiDeviceType()));
        devicedata.put("protocol",String.valueOf(device.getiDeviceType()));
        devicedata.put("pollingInterval",device.getiPollingInterval());
        String position = String.valueOf(device.getdDeviceLongitude())+","+String.valueOf(device.getdDeviceLatitude());
        devicedata.put("position",position);
        devicedata.put("address",device.getsDeviceAddress());
        requestdata.put("device",devicedata);
        List<Map> deviceSlaves = new ArrayList<Map>();
        for(DeviceSlave deviceSlave:device.getDeviceSlaves()){
            Map<String,Object> formap = new HashMap<String, Object>();
            formap.put("slaveIndex",Integer.parseInt(deviceSlave.getsSlaveIndex()));
            formap.put("slaveName",deviceSlave.getsSlaveName());
            formap.put("slaveAddr",deviceSlave.getsSlaveAddr());
            formap.put("dataTemplateId",deviceSlave.getDataTemplate().getId());
            deviceSlaves.add(formap);
        }
        requestdata.put("deviceSlaves",deviceSlaves);
        result = HttpPost(url,requestdata);
        return result;
    }

    //设备类型：0：默认设备 1：LoRa集中器 2：CoAP/NB-IoT 3 ：LoRa模块 4：网络io 5：二维码添加 6：LoRaWAN 7.电信 CoAP/NB-IoT 8:PLC云网关
    //通讯协议  0:ModbusRTU    1:ModbusTCP   2:TCP透传  3:DL/T645-97    4:DL/T645-07   5:烟感协议
    //通过设备的类型和协议判断提交类型
    public String judgeType(Device device,String url){
        String result = "failed";
        int iDeviceType = device.getiDeviceType();
        int iProtocol = device.getiProtocol();
        //登陆参数
        Map<String,Object> loginData = HttpPostLogin();
        String token = (String)loginData.get("token");
        int uid =(Integer)loginData.get("uid");
        Map<String,Object> requestdata = new HashMap<String, Object>();
        requestdata.put("token",token);
        Map<String,Object> devicedata = new HashMap<String, Object>();
        List<Map> deviceSlaves = new ArrayList<Map>();
        switch (iDeviceType){
            case 0:
            case 6:
            case 3:
            case 2:
            case 7:
                devicedata.put("groupId","0");
                devicedata.put("name",device.getsDeviceName());
                devicedata.put("type",String.valueOf(device.getiDeviceType()));
                //如果设备编号为空自动生成
                if(iDeviceType==0 &&device.getsDeviceId()!=null && !device.getsDeviceId().isEmpty()){
                    devicedata.put("deviceId",device.getsDeviceId());
                }
                if(iDeviceType==0){
                    devicedata.put("pass",device.getsDevicePass());
                }
                if(Arrays.asList(new String[]{"6","3","2","7"}).contains(String.valueOf(iDeviceType))){//通过ArrayList判读字符串是否在里面进行操作
                    //"QRcode":"deviceId:xxxxxxx,sn:xxxxxxx", // 二维码 组成规则 ‘deviceId:’+IMEI+‘,sn:’+校验码
                    devicedata.put("QRcode","deviceId:"+device.getsDeviceId()+",sn:"+device.getsSn());
                }
                devicedata.put("protocol",String.valueOf(device.getiDeviceType()));
                if(Arrays.asList(new String[]{"0","1","3","4"}).contains(String.valueOf(iProtocol))){
                    devicedata.put("pollingInterval",device.getiPollingInterval());
                }
                devicedata.put("address",device.getsDeviceAddress());
                String position = String.valueOf(device.getdDeviceLongitude())+","+String.valueOf(device.getdDeviceLatitude());
                devicedata.put("position",position);
                requestdata.put("device",devicedata);
                //添加从机
                if(Arrays.asList(new String[]{"0","1","3","4"}).contains(String.valueOf(iProtocol))){
                    if(device.getDeviceSlaves()!=null){
                        for(DeviceSlave deviceSlave:device.getDeviceSlaves()){
                            Map<String,Object> formap = new HashMap<String, Object>();
                            formap.put("slaveIndex",Integer.parseInt(deviceSlave.getsSlaveIndex()));
                            formap.put("slaveName",deviceSlave.getsSlaveName());
                            formap.put("slaveAddr",deviceSlave.getsSlaveAddr());
                            formap.put("dataTemplateId",deviceSlave.getDataTemplate().getId());
                            deviceSlaves.add(formap);
                        }
                        requestdata.put("deviceSlaves",deviceSlaves);
                    }else{
                        return result;
                    }
                }
                break;
            case 1:
            case 9:
                devicedata.put("groupId","0");
                devicedata.put("name",device.getsDeviceName());
                devicedata.put("type",String.valueOf(device.getiDeviceType()));
                //"deviceId":"deviceId:xxxxxxx,sn:xxxxxxx", // 设备id  组成规则 ‘deviceId:’+MAC+‘,sn:’+SN/校验码
                devicedata.put("deviceId","deviceId:"+device.getsDeviceId()+",sn:"+device.getsSn());
                devicedata.put("address",device.getsDeviceAddress());
                String position1 = String.valueOf(device.getdDeviceLongitude())+","+String.valueOf(device.getdDeviceLatitude());
                devicedata.put("position",position1);
                requestdata.put("device",devicedata);
                break;
            case 4:
            case 5:
                devicedata.put("type",String.valueOf(device.getiDeviceType()));
                devicedata.put("QRcode","deviceId:"+device.getsDeviceId()+",sn:"+device.getsSn());
                requestdata.put("device",devicedata);
                break;
        }
        result = HttpPost(url,requestdata);
        return result;
    }
}
