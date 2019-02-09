package com.dali.DripChain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Map;

@Controller
@RequestMapping(value = "/DataAnalysis")
public class DataAnalysisController {
    @RequestMapping(value = "/currentData",method = RequestMethod.GET)
    public String currentData(Map<String, Object> map){

        return "Ent-currentData";
    }

    @RequestMapping(value = "/dataForecast",method = RequestMethod.GET)
    public String dataForecast(Map<String, Object> map){

        return "Ent-dataForecast";
    }
    @RequestMapping(value = "/dataVisual",method = RequestMethod.GET)
    public String dataVisual(Map<String, Object> map){

        return "Ent-dataVisual";
    }

    @RequestMapping(value = "/historyData",method = RequestMethod.GET)
    public String historyData(Map<String, Object> map){

        return "Ent-historyData";
    }
}
