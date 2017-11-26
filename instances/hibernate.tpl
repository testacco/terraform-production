<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration
    PUBLIC "-//Hibernate/Hibernate Configuration DTD//EN"
    "http://hibernate.sourceforge.net/hibernate-configuration-3.0.dtd">

<hibernate-configuration>
        <session-factory>

                <!-- local connection properties -->
                <property name="hibernate.connection.driver_class">com.mysql.jdbc.Driver</property>
                <property name="dialect">org.hibernate.dialect.MySQL5Dialect</property>
                <property name="hibernate.connection.url">jdbc:mysql://${db_url}:3306/${db_name}</property>
                <property name="hibernate.connection.username">${db_user}</property>
                <property name="hibernate.connection.password">${db_pass}</property>

                <property name="hibernate.hbm2ddl.auto">create</property>

                <mapping class="com.softserveinc.edu.oms.domain.entities.Role" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.Region" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.CustomerType" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.User" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.OrderStatus" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.Order" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.Product" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.Dimension" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.OrderItem" />
                <mapping class="com.softserveinc.edu.oms.domain.entities.CreditCardType" />

        </session-factory>
</hibernate-configuration>


