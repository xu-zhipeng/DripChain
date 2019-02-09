package com.dali.DripChain.dao;

import com.dali.DripChain.entity.Contact;
import org.springframework.stereotype.Repository;

@Repository
public class ContactDao extends SimpleHibernateDao<Contact,Integer> {

}
