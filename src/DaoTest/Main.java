package DaoTest;

import com.dali.DripChain.dao.SimpleHibernateDao;
import com.dali.DripChain.dao.tbUserDao;
import com.dali.DripChain.entity.Alarm;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.Contact;
import com.dali.DripChain.entity.tbUser;
import com.dali.DripChain.service.DeviceService;
import com.dali.DripChain.service.LoginService;
import com.dali.DripChain.service.tbUserService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {
    public static SessionFactory sessionFactory;
    public static Session session;

    public static void openSession(){
        /*  测试openSession()方法  */
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        sessionFactory = (SessionFactory)ac.getBean("sessionFactory");
        session = sessionFactory.openSession();
        session.beginTransaction();
        session.save(new tbUser("OpenSession测试","123"));
        session.getTransaction().commit();
    }
    public static void getCurrentSession(){
        /*  测试getCurrentSession()方法  需要配置<prop key="hibernate.current_session_context_class">thread</prop> */
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        sessionFactory = (SessionFactory)ac.getBean("sessionFactory");
//        session = sessionFactory.getCurrentSession();
        SimpleHibernateDao<tbUser,String> stringSimpleHibernateDao=new SimpleHibernateDao<tbUser,String>();
        session = stringSimpleHibernateDao.getCurrentSession();
        session.beginTransaction();
        session.save(new tbUser("CurrentSession测试","123"));
        session.getTransaction().commit();
    }

    public static void getDao(){
        /*  测试getDao()方法  */
        System.out.println("开始");
        ApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        tbUserDao tbuserDao =(tbUserDao) ac.getBean("tbuserDao");//tbUserDao也可以调用
        tbUser tbuser = new tbUser();
        tbuser.setUsername("Dao测试");
        tbuser.setPassword("123456");
        try {
            tbuserDao.addtbUser(tbuser);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("结束");
    }

    public static void getService(){
        /*  测试getService()方法  */
        System.out.println("开始");
        ApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        tbUserService tbuserService =(tbUserService) ac.getBean("tbuserService");
        tbUser tbuser = new tbUser();
        tbuser.setUsername("Service测试");
        tbuser.setPassword("123456");
        try {
            tbuserService.addtbUser(tbuser);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("结束");
    }
    public static void getTransactionService(){
        /*  测试getService()方法  */
        System.out.println("开始");
        ApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        tbUserService tbuserService =(tbUserService) ac.getBean("tbuserService");
        try {
            tbuserService.test();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("结束");
    }
    public static void getLoginService(){
        /*  测试getService()方法  */
        System.out.println("开始");
        ApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        LoginService loginService =(LoginService) ac.getBean("loginService");
        try {
            Company company = new Company();
            company.setsUserName("56265");
            company.setsPassword("123456");
            company.setsGoc("671002");
            int id=loginService.doRegister(company);
            if (id!=0 && id!=2) {
                System.out.println("成功");
            }
            System.out.println("添加成功"+company);

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("结束");
    }
    public static void listTest(){
//          测试openSession()方法
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        sessionFactory = (SessionFactory)ac.getBean("sessionFactory");
        session = sessionFactory.openSession();
        session.beginTransaction();
        Alarm alarm = new Alarm();
        Contact contact = new Contact();
        contact.setId(1);
        contact.setsName("name1");
        contact.setsEmail("email1");
        contact.setsPhone("phone");
        contact.setsNote("note");
        System.out.println(contact);
//        session.save(contact);
        Set<Contact> contacts = new HashSet<Contact>();
        contacts.add(contact);
//        alarm.setContacts(contacts);
        List<Integer> integers = new ArrayList<Integer>();
        integers.add(111);
        integers.add(222);
        integers.add(333);
        alarm.setAlarmModes(integers);
        alarm.setsTriggerName("测试一对多");
        session.save(alarm);
        session.getTransaction().commit();
    }
    public static void testGuanLian(){
        /*  测试openSession()方法  */
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("Spring-Hibernate.xml");
        sessionFactory = (SessionFactory)ac.getBean("sessionFactory");
        DeviceService deviceService = (DeviceService)ac.getBean("deviceService");
        deviceService.test();
        /*Session session =sessionFactory.openSession();
        session.beginTransaction();*/

        /*删除一对多中 多的一方的部分记录（此方法无效）
        Device device=session.get(Device.class,7);
        device.setsDeviceName("测试设备");
        int i=0;
        DeviceSlave deviceSlave = session.get(DeviceSlave.class,6498);
        device.getDeviceSlaves().remove(deviceSlave);
        deviceSlave = session.get(DeviceSlave.class,6499);
        device.getDeviceSlaves().remove(deviceSlave);
        System.out.println(device);
        session.saveOrUpdate(device);*/

        /*Device device = new Device();
        device.getCompany().setId(1);
        device.getDeviceGroup().setId(Integer.valueOf(1));
        device.setsDeviceName("测试插入多对多");
        device.setsDeviceAddress("大理大学");
        device.setdDeviceLongitude(new BigDecimal("100.19"));
        device.setdDDeviceLatitude(new BigDecimal("25.6"));
        device.setiDeviceType(0);
        DeviceSlave deviceSlave=new DeviceSlave();
        deviceSlave.setsSlaveName("测试");
        device.getDeviceSlaves().add(deviceSlave);
        System.out.println(device.toString());
        int id=(Integer)session.save(device);
        System.out.println(id);*/
//        session.getTransaction().commit();
    }
    public static void main(String[] args) {
        openSession();
//        getCurrentSession();
        /*因为用hibernateDaosupport写的所以Dao成没有包含进事务的话，会报只读异常，如果Dao层用session写无影响*/
//        getDao();
//        getService();
//        getTransactionService();
//        getLoginService();
//        listTest();
//        testGuanLian();

    }
}
