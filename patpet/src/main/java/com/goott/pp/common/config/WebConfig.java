package com.goott.pp.common.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
	// contextConfigLocation 대체
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { RootConfig.class };
	}

	// appServlet에서 contextConfigLocation 대체
	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] { ServletConfig.class, MyBatisConfig.class };
	}

	// appServlet 매핑
	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	@Override
	protected Filter[] getServletFilters() {
		return new Filter[] { new CharacterEncodingFilter("utf-8") };
	}

}
