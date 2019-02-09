package com.dali.DripChain.dao;

import com.dali.DripChain.entity.Company;
import org.springframework.stereotype.Repository;

@Repository
public class CompanyDao extends SimpleHibernateDao<Company,Integer> {
    /*//添加
    public int addCompany(Company company){
        return (int)this.getHibernateTemplate().save(company);
    }
    //修改
    public int updateUser(Company company) {
        try {
            this.getHibernateTemplate().update(company);
            return 1;
        } catch (DataAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    //删除
    public int deleteCompany(Company company) {
        try {
            this.getHibernateTemplate().delete(company);
            return 1;
        } catch (DataAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    //根据id查找
    public Company findCompanyById(int id) {
        return this.getHibernateTemplate().get(Company.class, id);
    }

    public List<Company> findCompanys() {
        String hql="from Company";
        List<Company> list = (List<Company>)this.getHibernateTemplate().find(hql);
        return  list;
    }

    public List<Company> findCompanyByPage(int begin, int pageSize) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Company.class);
        // 查询分页数据
        List<Company> list = (List<Company>) this.getHibernateTemplate().findByCriteria(criteria, begin, pageSize);
        return list;
    }

    public int findCount() {
        List<Long> list = (List<Long>) this.getHibernateTemplate().find("select count(*) from Company");
        if (list.size() > 0) {
            return list.get(0).intValue();
        }
        return 0;
    }*/

}
