package com.dali.DripChain.service;

import com.dali.DripChain.dao.CompanyDao;
import com.dali.DripChain.dao.UserDao;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.PageBean;
import com.dali.DripChain.entity.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

@Transactional
@Service
public class UserService {
   @Resource
    private UserDao userDao;
   @Resource
   private CompanyDao companyDao;
     //添加子用户
    public int doAddSuser(User user){
           User userUnique = userDao.findUnique("from User  where sUserName=?",user.getsUsername());//注意：hql语句from后面跟的是对象，即类名
           User emailUnique=userDao.findUnique("from User  where sEmail=?",user.getsEmail());
           User phoneUnique=userDao.findUnique("from User  where sTelephone=?",user.getsTelephone());
           User nickUnique=userDao.findUnique("from User where sNickName=?",user.getsNickName());
        if(userUnique!=null){
            return -2;
        }
       if(emailUnique!=null){
            return -3;
        }
       if(phoneUnique!=null){
            return -4;
        }
        if(nickUnique!=null){
            return -5;
        }
        if(userUnique==null &&emailUnique==null && phoneUnique==null &&nickUnique==null){
            try{
                return (Integer) userDao.save(user);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return 0;
    }
    //修改子用户密码
    public int  updataSubpwd(User user){
        try{
            userDao.update(user);
            return user.getId();
        }catch(Exception e){
          e.printStackTrace();
            System.out.println("修改密码失败");
        }
        return -1;
    }
    //修改根用户的密码
    public int updataCompany(Company company){
        try{
            companyDao.update(company);
            return company.getId();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println("修改密码失败啦！");
        }
        return -1;
    }
    //删除子用户
    public int  doDelesub(int userId){
        try {
            userDao.delete(userId);
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -2;
        }

    }
    //通过子用户来查询
    public PageBean<User> findPage(int pageNum, int pageSize,String sUsername, int iCompanyId){
        //模糊查询
        sUsername="%"+sUsername+"%";
        int totalRecord = userDao.<Long>findUnique("select count(*) from User where company.id=? and sUsername like ?",iCompanyId,sUsername).intValue();
        PageBean<User> pageBean = new PageBean<User>(pageNum, pageSize, totalRecord);
        int startIndex = pageBean.getStartIndex();
        pageBean.setList(userDao.<User>findPage("from User where company.id=? and sUsername like ?",startIndex,pageSize,iCompanyId,sUsername));
        return pageBean;
    }
    //修改子用户从信息
    public int updatasub(User user){
        try{
            userDao.update(user);
            return user.getId();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }
    //显示子用户信息
    public User showsub(int id){
        if(id!=-1){
            userDao.get(id);
        }
        return null;
    }
    //显示根用户的信息
    public Company showcompany(int id){
        if(id!=-1){
            companyDao.get(id);
        }
        return null;
    }
}
