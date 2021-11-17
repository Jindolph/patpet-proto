package com.goott.pp.common.config;

import org.apache.ibatis.datasource.pooled.PooledDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
//import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@MapperScan(basePackages = { "com.goott.pp.common.mappers" })
@EnableTransactionManagement
@PropertySource("/WEB-INF/config/jdbc/jdbc.properties")
public class MyBatisConfig {
	@Autowired
	Environment environment;

	@Bean(value = "dataSource")
	public PooledDataSource dataSource() {
		PooledDataSource dataSource = new PooledDataSource();
		dataSource.setDriver(environment.getProperty("jdbc.driverClassName"));
		dataSource.setUrl(environment.getProperty("jdbc.url"));
		dataSource.setUsername(environment.getProperty("jdbc.username"));
		dataSource.setPassword(environment.getProperty("jdbc.password"));

		return dataSource;
	}

	@Bean("sqlSessionFactory")
	public SqlSessionFactory sqlSessionFactory(PooledDataSource dataSource) throws Exception {
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		sessionFactory.setDataSource(dataSource);

		Resource resourceConfig = new DefaultResourceLoader().getResource("classpath:mybatis/models/modelConfig.xml");
		sessionFactory.setConfigLocation(resourceConfig);

		Resource[] resourceMappers = new PathMatchingResourcePatternResolver()
				.getResources("classpath:mybatis/mappers/*.xml");
		sessionFactory.setMapperLocations(resourceMappers);

		return sessionFactory.getObject();
	}

	@Bean("transactionManager")
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}

	@Bean("sqlSession")
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
