package com.dali.DripChain.quartz;

import com.dali.DripChain.dao.AlarmDao;
import com.dali.DripChain.dao.AlarmRecordDao;

import javax.annotation.Resource;

public class AlarmTriggerQuartz {
    @Resource
    AlarmRecordDao alarmRecordDao;
    @Resource
    AlarmDao alarmDao;
    public void execute(){
        /*System.out.println("警报测试");*/
    }
}
