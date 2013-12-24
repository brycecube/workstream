package com.brycecube.workstream.dao;

import com.brycecube.workstream.model.Stat;
import com.brycecube.workstream.sqlmap.StatDAO;
import junit.framework.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

/**
 * User: bryce
 * Date: 10/24/11 11:12 PM
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/test-spring-context.xml", "classpath:spring/spring-dataSource.xml"})
public class StatDAOTest {

    @Autowired
    private StatDAO statDAO;

    @Test
    public void testGetAll_empty() {
        Assert.assertTrue(statDAO.getAll().isEmpty());
    }

    @Test
    public void testInsertThenGetById() {
        Date now = new Date();
        Stat stat = new Stat();
        stat.setUserId(1);
        stat.setWeight(160.0);
        stat.setFatPercent(10.5);
        stat.setMusclePercent(43.5);
        stat.setRecordDate(now);
        statDAO.save(stat);

        stat = statDAO.getById(stat.getId());

        Assert.assertEquals(new Integer(1), stat.getId());
        Assert.assertEquals(160.0, stat.getWeight());
        Assert.assertEquals(10.5, stat.getFatPercent());
        Assert.assertEquals(43.5, stat.getMusclePercent());
        Assert.assertEquals(now.toString(), stat.getRecordDate().toString());
    }

}
