package com.dali.DripChain.service;

import com.dali.DripChain.dao.tbUserDao;
import com.dali.DripChain.entity.tbUser;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service(value="tbuserService")
public class tbUserService {
	
	@Resource
	private tbUserDao tbuserDao;

	public int addtbUser(tbUser tbUser) {
		return tbuserDao.addtbUser(tbUser);
	}
	
	public int updatetbUser(tbUser tbUser) {
		return tbuserDao.updatetbUser(tbUser);
	}

	public int deletetbUser(tbUser tbUser) {
		return tbuserDao.deletetbUser(tbUser);
	}
	
	public tbUser findtbUserById(int id) {
		return tbuserDao.findtbUserById(id);
	}

	public void test(){
		tbUser tbuser1 = new tbUser();
		tbuser1.setUsername("事务回滚测试1");
		tbuser1.setPassword("123456");
		tbUser tbuser2 = new tbUser();
		tbuser2.setUsername("事务回滚测试2");
		tbuser2.setPassword("123456");
		tbuserDao.addtbUser(tbuser1);
		/*抛出一个异常看事务是否回顾，成功：是什么都没有插入，失败：只插入了tbuser1对象*/
		int a = 1 / 0;
		tbuserDao.addtbUser(tbuser2);
	}
}
