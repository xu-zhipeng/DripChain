package com.dali.DripChain.service;

import com.dali.DripChain.dao.AlarmDao;
import com.dali.DripChain.dao.AlarmRecordDao;
import com.dali.DripChain.dao.ContactDao;
import com.dali.DripChain.entity.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AlarmService {
    @Resource
    AlarmDao alarmDao;
    @Resource
    AlarmRecordDao alarmRecordDao;
    @Resource
    ContactDao contactDao;


    public List<DataTemplate> getDataTemplateList(int iCompanyId){
        return alarmDao.<DataTemplate>find("from DataTemplate where company.id=?",iCompanyId);
    }

    public List<Contact> getContactList(int iCompanyId){
        return alarmDao.<Contact>find("from Contact where company.id=?",iCompanyId);
    }

    public List<Device> getDeviceList(int iCompanyId){
        return alarmDao.<Device>find("from Device where company.id=?",iCompanyId);
    }

    public PageBean<Alarm> findPage(int pageNum, int pageSize,String searchWord, int iCompanyId){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = alarmDao.<Long>findUnique("select count(*) from Alarm where company.id=? and sTriggerName like ?",iCompanyId,searchWord).intValue();
        PageBean<Alarm> pageBean = new PageBean<Alarm>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();
        pageBean.setList(alarmDao.<Alarm>findPage("from Alarm where company.id=? and sTriggerName like ?",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

    public int addAlarm(Alarm alarm){
        try {
            return (Integer)alarmDao.save(alarm);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("添加警报失败！");
        }
        return -1;
    }

    public int updateAlarm(Alarm alarm){
        try {
            alarmDao.saveOrUpdate(alarm);
            return alarm.getId();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("添加警报失败！");
        }
        return -1;
    }


    public PageBean<AlarmRecord> alarmRecordPage(int pageNum, int pageSize,String searchWord, int iCompanyId){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = alarmRecordDao.<Long>findUnique("select count(*) from AlarmRecord where company.id=? and device.sDeviceName like ?",iCompanyId,searchWord).intValue();
        PageBean<AlarmRecord> pageBean = new PageBean<AlarmRecord>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();
        pageBean.setList(alarmRecordDao.<AlarmRecord>findPage("from AlarmRecord where company.id=? and device.sDeviceName like ? order by dAlarmTime desc",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

    public PageBean<Contact> contactPage(int pageNum, int pageSize,String searchWord, int iCompanyId){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = contactDao.<Long>findUnique("select count(*) from Contact where company.id=? and sName like ?",iCompanyId,searchWord).intValue();
        PageBean<Contact> pageBean = new PageBean<Contact>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();
        pageBean.setList(contactDao.<Contact>findPage("from Contact where company.id=? and sName like ?",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

    //删除与该联系人相关的警报
    public void delContact(Contact contact){
        try {
            List<Alarm> alarmList=alarmDao.find("from Alarm where contact.id=?",contact.getId());
            for(Alarm alarm:alarmList){
                alarmDao.delete(alarm);
            }
            contactDao.delete(contact);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("删除失败");
        }
    }

    public int updateAlarmRecord(AlarmRecord alarmRecord){
        try {
            alarmRecordDao.saveOrUpdate(alarmRecord);
            return alarmRecord.getId();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("添加警报失败！");
        }
        return -1;
    }
}
