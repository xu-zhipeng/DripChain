package com.dali.DripChain.controller;

import com.dali.DripChain.dao.AlarmRecordDao;
import com.dali.DripChain.entity.AlarmRecord;
import com.dali.DripChain.entity.Device;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
public class Test {
    @Resource
    public static AlarmRecordDao alarmRecordDao;
    public static void main(String[] args) {
        ObjectMapper objectMapper = new ObjectMapper();
//        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
        Device device = new Device();
        device.setId(1);
        device.setsDeviceName("测试设备");
        device.getCompany().setsCompanyName("公司名");
        String str1 = null;
        try {
            str1 = objectMapper.writeValueAsString(device);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            System.out.println("转换失败");
        }
        System.out.println("str1:"+str1);
        String a = "[{\"id\":27,\"text\":\"网络\"},{\"id\":32,\"text\":\"机身内存\",\"test\":\"测试\"}]";
        String b ="{\"subAccount\":\"test2\",\"device\":{\"QRcode\":\"deviceId:xxxxxxx,sn:xxxxxxx\",\"groupId\":\"0\",\"name\":\"设备名称\",\"type\":\"6\",\"img\":\"\",\"protocol\":\"0\",\"position\":\"117.02496707,36.68278473\",\"address\":\"山东省济南市历下区\"},\"deviceSlaves\":[{\"slaveIndex\":1,\"slaveName\":\"从机名称\",\"slaveAddr\":\"1\",\"dataTemplateId\":1493},{\"slaveIndex\":2,\"slaveName\":\"从机名称2\",\"slaveAddr\":\"2\",\"dataTemplateId\":1494}],\"token\":\"eyJhbGciOiJI.V4cCI6MTUyMjgyMDI0MSw.uWqKvFJ8jR...\"}";
        Map<String,Object> map =null;
        List<Map> listmap = null;
        Device device1 = null;
        JavaType javaType = objectMapper.getTypeFactory().constructCollectionLikeType(List.class, Map.class);
        try {
            map = objectMapper.readValue(b,Map.class);
            device1 = objectMapper.readValue(str1,Device.class);
            listmap = objectMapper.readValue(a,javaType);
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("转换失败");
        }
        System.out.println(map);
        System.out.println(listmap);
        System.out.println(device1);
        int[] array=new int[]{0,1,3,4};
        String[] array1=new String[]{"0","1","3","4"};
        boolean b1=Arrays.asList(new String[]{"0","1","3","4"}).contains(String.valueOf(0));
        System.out.println(b1);
        String str = "Login/login";
        int index = str.indexOf("/login");
        System.out.println(index);
        String hql="from AlarmRecord where device.id=? and dataPoint.id=? order by dAlarmTime desc";
        List<AlarmRecord> alarmRecordList = alarmRecordDao.findPage(hql,0,1,1,21479);
        System.out.println(alarmRecordList.get(0));
    }
}
