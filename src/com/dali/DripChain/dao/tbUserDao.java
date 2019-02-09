package com.dali.DripChain.dao;

import com.dali.DripChain.entity.tbUser;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository(value="tbuserDao")
public class tbUserDao extends SimpleHibernateDao<tbUser,String> {

    public int addtbUser(tbUser tbuser) {
        System.out.println("......开始...........");
        getSession().save(tbuser);
        return 1;
    }

    public int updatetbUser(tbUser tbuser) {
        try {
            getSession().update(tbuser);
            return 1;
        } catch (DataAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    public int deletetbUser(tbUser tbuser) {
        try {
            getSession().delete(tbuser);
            return 1;
        } catch (DataAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    public tbUser findtbUserById(int id) {
        return getSession().get(tbUser.class, id);
    }
}
