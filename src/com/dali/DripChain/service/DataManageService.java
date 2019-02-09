package com.dali.DripChain.service;

import com.dali.DripChain.dao.DataDao;
import com.dali.DripChain.dao.DataPointDao;
import com.dali.DripChain.dao.DataTemplateDao;
import com.dali.DripChain.entity.Data;
import com.dali.DripChain.entity.DataPoint;
import com.dali.DripChain.entity.DataTemplate;
import com.dali.DripChain.entity.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

@Transactional
@Service
public class DataManageService {
    @Resource
    DataTemplateDao dataTemplateDao;
    @Resource
    DataPointDao dataPointDao;
    @Resource
    DataDao dataDao;

    public PageBean<DataTemplate> dataTemplatePage(int pageNum, int pageSize, int iCompanyId, String searchWord){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = dataTemplateDao.<Long>findUnique("select count(*) from DataTemplate where company.id=? and sTemplateName like ?",iCompanyId,searchWord).intValue();

        PageBean<DataTemplate> pageBean = new PageBean<DataTemplate>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();

        pageBean.setList(dataTemplateDao.<DataTemplate>findPage("from DataTemplate where company.id=? and sTemplateName like ?",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

    public PageBean<DataPoint> getDataPointPageByDataTemaplateId(int pageNum, int pageSize, int iDataTemplateId, String searchWord){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = dataTemplateDao.<Long>findUnique("select count(*) from DataPoint where dataTemplate.id=? and sName like ?",iDataTemplateId,searchWord).intValue();
        PageBean<DataPoint> pageBean = new PageBean<DataPoint>(pageNum, pageSize, totalRecord);
        int startIndex = pageBean.getStartIndex();
        pageBean.setList(dataTemplateDao.<DataPoint>findPage("from DataPoint where dataTemplate.id=? and sName like ?",startIndex,pageSize,iDataTemplateId,searchWord));

        return pageBean;
    }

    public PageBean<Data> dataPage(int pageNum, int pageSize, int iCompanyId, String searchWord){
        //模糊查询
        searchWord="%"+searchWord+"%";
        int totalRecord = dataDao.<Long>findUnique("select count(*) from Data where iCompanyId=? and deviceName like ?",iCompanyId,searchWord).intValue();

        PageBean<Data> pageBean = new PageBean<Data>(pageNum, pageSize, totalRecord);

        int startIndex = pageBean.getStartIndex();

        pageBean.setList(dataDao.<Data>findPage("from Data where iCompanyId=? and deviceName like ?",startIndex,pageSize,iCompanyId,searchWord));

        return pageBean;
    }

}
