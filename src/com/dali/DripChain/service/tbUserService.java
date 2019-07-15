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


	public void testOut(){//Spring的事务管理默认对Error异常和RuntimeException异常以及其子类进行事务回滚，且必须抛出异常，
						  // 若使用try-catch对其异常捕获则不会进行回滚！
						  // （Error异常和RuntimeException异常抛出时不需要方法调用throws或try-catch语句）；
						//		解决办法：
						//      throw new RuntimeException();//第一种办法  抛出异常
						//		throw e;//第二种办法  抛出异常
						//      TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();//第三章办法   手动回滚事务
		tbUser tbuser1 = new tbUser();
		tbuser1.setUsername("事务回滚测试111");
		tbuser1.setPassword("123456");
		tbUser tbuser2 = new tbUser();
		tbuser2.setUsername("事务回滚测试222");
		tbuser2.setPassword("123456");
		tbuserDao.addtbUser(tbuser1);
		System.out.println("打钱");
		test();
//		int a = 1 / 0;
		tbuserDao.addtbUser(tbuser2);
	}
}
