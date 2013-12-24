package com.brycecube.workstream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * User: bryce
 */
@Controller
public class IndexController {

    @RequestMapping(value = "/")
    public String index(Model model) {
        return "index";
    }
}
