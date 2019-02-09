package com.dali.DripChain.service;

import com.dali.DripChain.dao.tbUserDao;
import com.dali.DripChain.entity.tbUser;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Timer;
import java.util.TimerTask;

@Service
public class LoadData extends TimerTask {
    @Resource()
    tbUserDao tbuserDao;
    public static void main(String[] args) {
        Timer timer = new Timer();
        LoadData loadData = new LoadData();
        timer.schedule(loadData,0,2000);
    }
    @Override
    public void run() {
        tbuserDao.save(new tbUser("LoadData测试","123"));
    }
}
