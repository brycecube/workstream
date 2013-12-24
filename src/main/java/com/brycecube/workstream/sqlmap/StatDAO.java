package com.brycecube.workstream.sqlmap;

import com.brycecube.workstream.model.Stat;

import java.util.List;

/**
 * User: bryce
 */
public interface StatDAO {
    Stat getById( Integer testId );
    List<Stat> getAll();
    int save(Stat stat);
}
