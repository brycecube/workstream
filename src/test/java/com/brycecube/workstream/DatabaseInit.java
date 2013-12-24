package com.brycecube.workstream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;

/**
 * User: bryce
 * Created: 5/17/13 9:54 PM
 */
public class DatabaseInit {
    private static final Logger LOG = LoggerFactory.getLogger(DatabaseInit.class);

    private DataSource dataSource;

    private List<String> dbInitFiles;

    public void init() {

        LOG.info("Loading DB schema");
        Connection connection = null;
        try {
            connection = dataSource.getConnection();
            for( String file : dbInitFiles) {
                for(String line : linesFromFile(file)) {
                    line = line.trim();
                    if( !line.isEmpty() ) {
                        LOG.info("-- Execute startup statement: {}", line);
                        try {
                            Statement statement = connection.createStatement();
                            statement.execute(line);
                        } catch (SQLException e) {
                            LOG.error("Error on loading statement.", e);
                        }
                    }
                }
            }
        } catch (IOException e) {
            LOG.error("Error on loading database.", e);
        } catch (SQLException e) {
            LOG.error("Error on loading statements.", e);
        }
    }


    private List<String> linesFromFile(String file) throws IOException {
        FileInputStream in = new FileInputStream(new File(file));
        byte[] buffer = new byte[1024*1024*8];
        in.read(buffer);
        in.close();

        return Arrays.asList(new String(buffer).split(";"));
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void setDbInitFiles(List<String> dbInitFiles) {
        this.dbInitFiles = dbInitFiles;
    }
}
