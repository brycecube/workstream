package com.brycecube.workstream.controller;

import com.brycecube.workstream.model.Stat;
import com.brycecube.workstream.sqlmap.StatDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * User: bryce
 */
@Controller
@RequestMapping("/Stat")
public class StatController {

    @Autowired
    StatDAO statDAO;

    @RequestMapping(method = RequestMethod.GET)
    public @ResponseBody Stat test() {
        return statDAO.getById(1);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public @ResponseBody Stat getById(@PathVariable Integer id) {
        return statDAO.getById(id);
    }

}
