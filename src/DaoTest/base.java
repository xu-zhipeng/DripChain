package DaoTest;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.support.ClassPathXmlApplicationContext;

class base {
	
	protected ClassPathXmlApplicationContext ac;
	@BeforeEach
	void setUp() throws Exception {
		ac = new ClassPathXmlApplicationContext(
				"Spring-Hibernate.xml",
				"Spring-MVC.xml");
	}

	@AfterEach
	public void close() {
		ac.close();
	}
}
