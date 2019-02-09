package com.dali.DripChain.dao;

import com.dali.DripChain.entity.User;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends SimpleHibernateDao<User,Integer> {

}
