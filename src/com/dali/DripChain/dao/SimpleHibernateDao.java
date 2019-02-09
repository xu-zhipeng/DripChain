package com.dali.DripChain.dao;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import javax.transaction.Transactional;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

/**
 * 封装Hibernate原生API的DAO泛型基类.
 *
 * 可在Service层直接使用, 也可以扩展泛型DAO子类使用, 见两个构造函数的注释. 参考Spring2.5自带的Petlinc例子,
 * 取消了HibernateTemplate, 直接使用Hibernate原生API.
 *
 * @param <T>
 *            DAO操作的对象类型
 * @param <PK>
 *            主键类型
 *
 * @author
 */
@Transactional
@Repository
public class SimpleHibernateDao<T, PK extends Serializable> {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    protected SessionFactory sessionFactory;

    protected Class<T> entityClass;

    /**
     * 用于Dao层子类使用的构造函数. 通过子类的泛型定义取得对象类型Class. eg. public class UserDao extends
     * SimpleHibernateDao<User, Long>
     */
    public SimpleHibernateDao() {
        //第一种：使用spring提供的ReflectionUtils简化项目中反射代码的复杂性 import org.springframework.util.ReflectionUtils;
        //this.entityClass = ReflectionUtils.getSuperClassGenricType(getClass());
        //第二种：原生代码写反射
        /*  this.getClass();表示当前类的class
            superclass   表示当前类的父类的类型Type   */
        Type superclass = this.getClass().getGenericSuperclass();
        /* （必须判断）我们判断用到了另外的一个接口，通过判断superclass是否为这个接口的一个实例，来判断superclass是否被实例化
        这个接口是:   ParameterizedType  */
        if (superclass instanceof ParameterizedType) {
            Type[] p = ((ParameterizedType) superclass).getActualTypeArguments();
            this.entityClass = (Class<T>) p[0];
        }
    }

    /**
     * 用于用于省略Dao层, 在Service层直接使用通用SimpleHibernateDao的构造函数. 在构造函数中定义对象类型Class.
     * eg. SimpleHibernateDao<User, Long> userDao = new SimpleHibernateDao<User,
     * Long>(sessionFactory, User.class);
     */
    public SimpleHibernateDao(final SessionFactory sessionFactory,
                              final Class<T> entityClass) {
        this.sessionFactory = sessionFactory;
        this.entityClass = entityClass;
    }

    /**
     * 取得sessionFactory.
     */
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /**
     * 采用@Autowired按类型注入SessionFactory, 当有多个SesionFactory的时候在子类重载本函数.
     */
    @Autowired
    public void setSessionFactory(final SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    /**
     * 取得当前Session. 内部使用
     */
    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }
    /**
     * 取得当前Session.  外部调用
     */
    public Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    public Session openSession() {
        return sessionFactory.openSession();
    }

    /**
     * 保存新增的对象.
     */
    public Serializable save(final T entity) {
        Serializable serializable = null;
        try {
            serializable = getSession().save(entity);
            logger.debug("save entity: {}", entity);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("save 方法失败");
        }
        return serializable;
    }
    /**
     * 保存修改的对象.
     */
    public void update(final T entity) {
        try {
            getSession().update(entity);
            logger.debug("update entity: {}", entity);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("update 方法失败");
        }
    }
    /**
     * 保存新增或修改的对象.
     */
    public void saveOrUpdate(final T entity) {
        try {
            getSession().saveOrUpdate(entity);
            logger.debug("saveOrUpdate entity: {}", entity);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("saveOrUpdate 方法失败");
        }
    }
    /**
     * 删除对象.
     *
     * @param entity
     *            对象必须是session中的对象或含id属性的transient对象.
     */
    public void delete(final T entity) {
        try {
            getSession().delete(entity);
            logger.debug("delete entity: {}", entity);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("delete 方法失败");
        }
    }

    /**
     * 按id删除对象.
     */
    public void delete(final PK id) {
        try {
            delete(get(id));
            logger.debug("delete entity {},id is {}", entityClass.getSimpleName(),id);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("delete 方法失败");
        }
    }

    /**
     * 按id获取对象.
     */
    public T get(final PK id) {
        T t = null;
        try {
            t = (T) getSession().get(entityClass, id);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("get 方法失败");
        }
        return t;
    }


    /**
     * 获取全部对象.
     */
    public List<T> getAll() {
        List<T> list = null;
        try {
            list = find("from "+entityClass.getName());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getAll 方法失败");
        }
        return list;
    }

    /**
     * 按HQL查询对象列表.
     *
     * @param <X>
     *
     * @param values
     *            数量可变的参数,按顺序绑定.
     */
    public <X> List<X> find(final String hql, final Object... values) {
        List<X> list = null;
        try {
            list = createQuery(hql, values).list();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("find 方法失败");
        }
        return list;

    }

    /**
     * 按HQL查询对象列表.
     *
     * @param values
     *            命名参数,按名称绑定.
     */
    public <X> List<X> find(final String hql, final Map<String, ?> values) {
        List<X> list = null;
        try {
            list = createQuery(hql, values).list();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("find 方法失败");
        }
        return list;
    }

    /**
     * 按HQL查询唯一对象.
     *
     * @param values
     *            数量可变的参数,按顺序绑定.
     */
    public <X> X findUnique(final String hql, final Object... values) {
        X x = null;
        try {
            x = (X) createQuery(hql, values).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("findUnique 方法失败");
        }
        return x;
    }

    /**
     * 按HQL查询唯一对象.
     *
     * @param values
     *            命名参数,按名称绑定.
     */
    public <X> X findUnique(final String hql, final Map<String, ?> values) {
        X x = null;
        try {
            x = (X) createQuery(hql, values).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("findUnique 方法失败");
        }
        return x;
    }

    /**
     * 执行HQL进行批量修改/删除操作.
     *
     * @param values
     *            数量可变的参数,按顺序绑定.
     * @return 更新记录数.
     */
    public int executeUpdate(final String hql, final Object... values) {
        int result = 0;
        try {
            result = createQuery(hql, values).executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("executeUpdate 方法失败");
        }
        return result;
    }

    /**
     * 执行HQL进行批量修改/删除操作.
     *
     * @param values
     *            命名参数,按名称绑定.
     * @return 更新记录数.
     */
    public int executeUpdate(final String hql, final Map<String, ?> values) {
        int result = 0;
        try {
            result = createQuery(hql, values).executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("executeUpdate 方法失败");
        }
        return result;
    }

    /**
     * 按HQL查询对象列表.
     *
     * @param <X>
     *
     * @param values
     *            数量可变的参数,按顺序绑定.
     */
    public <X> List<X> findPage(final String hql,Integer startIndex,Integer pageSize, final Object... values) {
        List<X> list = null;
        Query query = createQuery(hql, values);
        //2.1设置第一个要查询的位置（计算公式：（当前页数-1）*每页的记录数）
        query.setFirstResult(startIndex);
        //2.2设置每页显示的最大记录数
        query.setMaxResults(pageSize);
        try {
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("findPage 方法失败");
        }
        return list;
    }

    /**
     * 根据查询HQL与参数列表创建Query对象. 与find()函数可进行更加灵活的操作.
     *
     * @param values
     *            数量可变的参数,按顺序绑定.
     */
    public Query createQuery(final String queryString, final Object... values) {
        Assert.hasText(queryString, "queryString不能为空");
        Query query = getSession().createQuery(queryString);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        return query;
    }

    /**
     * 根据查询HQL与参数列表创建Query对象. 与find()函数可进行更加灵活的操作.
     *
     * @param values
     *            命名参数,按名称绑定.
     */
    public Query createQuery(final String queryString,final Map<String, ?> values) {

        Query query = getSession().createQuery(queryString);
        if (values != null) {
            query.setProperties(values);
        }
        return query;
    }


    /**
     * 初始化对象. 使用load()方法得到的仅是对象Proxy, 在传到View层前需要进行初始化. 如果传入entity,
     * 则只初始化entity的直接属性,但不会初始化延迟加载的关联集合和属性. 如需初始化关联属性,需执行:
     * Hibernate.initialize(user.getRoles())，初始化User的直接属性和关联集合.
     * Hibernate.initialize
     * (user.getDescription())，初始化User的直接属性和延迟加载的Description属性.
     */
    public void initProxyObject(Object proxy) {
        Hibernate.initialize(proxy);
    }

    /**
     * Flush当前Session.
     */
    public void flush() {
        getSession().flush();
    }

}

