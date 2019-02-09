package com.dali.DripChain.quartz;

import com.dali.DripChain.dao.AlarmDao;
import com.dali.DripChain.dao.AlarmRecordDao;
import com.dali.DripChain.dao.DataDao;
import com.dali.DripChain.entity.Alarm;
import com.dali.DripChain.entity.AlarmRecord;
import com.dali.DripChain.entity.Data;
import com.dali.DripChain.entity.Device;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class DataLoadQuartz {
    @Resource
    DataDao dataDao;
    @Resource
    AlarmRecordDao alarmRecordDao;
    @Resource
    AlarmDao alarmDao;
    public void execute(){
        long startTime = System.currentTimeMillis();    //获取开始时间

        //代码操作
        //转换化时间戳
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Data> dataList = dataDao.findPage("from Data order by id desc",0,1);

        //创建(大理大学监测点)电导率数据
        Data conductivity =new Data();
        conductivity.setId(dataList.get(0).getId()+1);
        conductivity.setiCompanyId(1);
        conductivity.setDeviceId("00013592000000000001");
        conductivity.setDeviceName("大理大学监测点");
        conductivity.setDataPointId(21479);
        conductivity.setDataPointName("电导率");
        conductivity.setSlaveIndex(1);
        conductivity.setSlaveName("电导率");
        conductivity.setAlarm(0);
        conductivity.setValue("216.7");
        conductivity.setCreateTime(simpleDateFormat.format(new Date()));
        if(Objects.equals((int)(Math.random()*10),0)){
            conductivity.setValue("412.5");
        }
        //创建(大理大学监测点)温度数据
        Data temperature =new Data();
        temperature.setId(dataList.get(0).getId()+2);
        temperature.setiCompanyId(1);
        temperature.setDeviceId("00013592000000000001");
        temperature.setDeviceName("大理大学监测点");
        temperature.setDataPointId(21593);
        temperature.setDataPointName("环境温度");
        temperature.setSlaveIndex(2);
        temperature.setSlaveName("环境温度");
        temperature.setAlarm(0);
        temperature.setValue("25");
        temperature.setCreateTime(simpleDateFormat.format(new Date()));
        if(Objects.equals((int)(Math.random()*10),0)){
            temperature.setValue("40");
        }
        //保存数据库
        try {
            dataDao.save(conductivity);
            insertAlarmRecord(conductivity);
            dataDao.save(temperature);
            insertAlarmRecord(temperature);
            System.out.println("插入成功");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("插入失败");
        }

        long endTime = System.currentTimeMillis();    //获取结束时间
        System.out.println("程序运行时间：" + (endTime - startTime) + "ms");    //输出程序运行时间
    }

    //判断上一次是否异常
    public boolean isDeviceException(Alarm alarm){
        String hql="from AlarmRecord where device.id=? and dataPoint.id=? order by dAlarmTime desc";
        List<AlarmRecord> alarmRecordList = alarmRecordDao.findPage(hql,0,1,alarm.getDevice().getId(),alarm.getDataPoint().getId());
        if(alarmRecordList!=null && Objects.equals(alarmRecordList.get(0).getsType(),"异常警报")){
            return true;
        }else {
            return false;
        }
    }

    public void insertAlarmRecord(Data data){
        Device device = alarmDao.<Device>findUnique("from Device where sDeviceId=?",data.getDeviceId());
        List<Alarm> alarmList = alarmDao.find("from Alarm where iStatus=1 and dataPoint.id=? and device.id=? and company.id=?",data.getDataPointId(),device.getId(),data.getiCompanyId());
        for(Alarm alarm:alarmList){
            BigDecimal value= new BigDecimal(data.getValue());
            BigDecimal iMin = new BigDecimal(alarm.getiMin());
            BigDecimal iMax = new BigDecimal(alarm.getiMax());
            switch (alarm.getsTriggerCondition()){
                //触发条件(0:开关ON、1:开关OFF、2:数值低于、3:数值高于、4:数值介于、5:数值高于max低于min)
                case "0":
                    if(alarm.getDevice().getiDeviceStatus()==1){//设备在线
                        //插入一条异常警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsAbnormalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("异常警报");
                        alarmRecordDao.save(alarmRecord);
                    }else if(isDeviceException(alarm)){
                        //插入一条恢复警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsNomalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("恢复警报");
                        alarmRecordDao.save(alarmRecord);
                    }
                    break;
                case "1":
                    if(alarm.getDevice().getiDeviceStatus()==0){//设备离线
                        //插入一条异常警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsAbnormalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("异常警报");
                        alarmRecordDao.save(alarmRecord);
                    }else if(isDeviceException(alarm)){
                        //插入一条恢复警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsNomalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("恢复警报");
                        alarmRecordDao.save(alarmRecord);
                    }
                    break;
                case "2":
                    if(value.compareTo(iMin)<=0){
                        //插入一条异常警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsAbnormalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("异常警报");
                        alarmRecordDao.save(alarmRecord);
                    }else if(isDeviceException(alarm)){
                        //插入一条恢复警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsNomalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("恢复警报");
                        alarmRecordDao.save(alarmRecord);
                    }
                    break;
                case "3":
                    if(value.compareTo(iMin)>=0){
                        //插入一条异常警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsAbnormalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("异常警报");
                        alarmRecordDao.save(alarmRecord);
                    }else if(isDeviceException(alarm)){
                        //插入一条恢复警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsNomalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("恢复警报");
                        alarmRecordDao.save(alarmRecord);
                    }
                    break;
                case "4":
                    if(value.compareTo(iMin)>=0 && value.compareTo(iMax)<=0){
                        //插入一条异常警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsAbnormalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("异常警报");
                        alarmRecordDao.save(alarmRecord);
                    }else if(isDeviceException(alarm)){
                        //插入一条恢复警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsNomalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("恢复警报");
                        alarmRecordDao.save(alarmRecord);
                    }
                    break;
                case "5":
                    if(value.compareTo(iMin)<=0 || value.compareTo(iMax)>=0){
                        //插入一条异常警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsAbnormalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("异常警报");
                        alarmRecordDao.save(alarmRecord);
                    }else if(isDeviceException(alarm)){
                        //插入一条恢复警报记录
                        AlarmRecord alarmRecord = new AlarmRecord();
                        //id 自动递增不设
                        alarmRecord.setCompany(alarm.getCompany());
                        alarmRecord.setDevice(alarm.getDevice());
                        alarmRecord.setDataPoint(alarm.getDataPoint());
                        alarmRecord.setsAlarmedValue(value.toString());
                        alarmRecord.setsAlarmContent(alarm.getsNomalContent());
                        alarmRecord.setdAlarmTime(new Date());
                        alarmRecord.setsHandlingStatus("未处理");
                        alarmRecord.setsType("恢复警报");
                        alarmRecordDao.save(alarmRecord);
                    }
                    break;
                default:
                    break;
            }
        }

    }
}
