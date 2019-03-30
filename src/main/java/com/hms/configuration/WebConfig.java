package com.hms.configuration;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class WebConfig {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public MessageSource messageSource() {
        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        messageSource.setBasename("messages");
        return messageSource;
    }

/*    @Bean
    @ConfigurationProperties(prefix = "spring.datasource.hikari")
    public DataSource dataSource(DataSourceProperties dataSourceProperties) {

        String herokuUrl = dataSourceProperties.getUrl();
        if (herokuUrl != null) {
            return DataSourceBuilder
                    .create(dataSourceProperties.getClassLoader())
                    .type(HikariDataSource.class)
                    .url(herokuUrl)
                    .username(dataSourceProperties.getUsername())
                    .password(dataSourceProperties.getPassword())
                    .build();
        } else {
            throw new ApplicationContextException("Heroku database URL is not configured, you must set $JDBC_DATABASE_URL");
        }
    }*/
}