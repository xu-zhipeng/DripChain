package com.dali.DripChain.service;

import com.dali.DripChain.dao.CompanyDao;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

@Transactional
@Service
public class LoginService {
    @Resource
    private CompanyDao companyDao;
    //进行用户登录操作
    public Company doCompanyLogin(String sUserName_login , String sPassword_login){
        String hql = "from Company where sUserName= ? and sPassword= ?";
        Company company=companyDao.<Company>findUnique(hql,sUserName_login,sPassword_login);
        if(company!=null){
            return company;
        }else{
            return null;
        }

    }
    public User doUserLogin(String sUserName_login , String sPassword_login){
        String hql = "from User where sUserName= ? and sPassword= ?";
        User user=companyDao.<User>findUnique(hql,sUserName_login,sPassword_login);
        if(user!=null){
            return user;
        }else{
            return null;
        }

    }
    //进行用户注册操作
    public int doRegister(Company company){
        company.setsUserRight("公司管理员");
        Company companyUnique = companyDao.findUnique("from Company where sUserName=?",company.getsUserName());
        User userUnique=companyDao.<User>findUnique("from User where sUserName=?",company.getsUserName());
        if(companyUnique!=null || userUnique!=null){
            return -2;
        }
        if(companyUnique==null){
            try {
                return (Integer)companyDao.save(company);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }
}
