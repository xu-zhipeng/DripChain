package com.dali.DripChain.controller;

import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

@WebServlet("/PhoneCheckCode")
public class PhoneCheckCode extends HttpServlet implements Servlet {
    static final long serialVersionUID = 1L;

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String phone = request.getParameter("phone");
        //生成随机4位数字
        int phoneCheckCode = (int) (Math.random() * 9000) + 1000;
        //存入会话session
        HttpSession session = request.getSession(true);
        session.setAttribute("phoneCheckCode", phoneCheckCode);

        String url="http://utf8.api.smschinese.cn/?Uid=Mc江南雨&Key=d41d8cd98f00b204e980&smsMob=" + phone + "&smsText=【水滴链】短信验证码:" + phoneCheckCode + "。水滴链不会以任何形式向您索取该密码，请勿告诉他人。";
        String result="1";
        result = HttpGet(url);
        System.out.println("结果"+result);
        System.out.println("验证码："+phoneCheckCode);
        if(!result.isEmpty()){
            PrintWriter out = response.getWriter();
            out.println(result+","+phoneCheckCode);
            out.flush();
            out.close();
        }else {
            PrintWriter out = response.getWriter();
            out.println("系统错误！");
            out.flush();
            out.close();
        }


    }

    public String HttpGet(String url) {
        String result = "";
        BufferedReader in = null;
        //由于DefaultHttpClient过时了  所以将这里的 HttpClient httpClient = new DefaultHttpClient(); 替换为CloseableHttpClient httpClient = HttpClients.createDefault();
        // HttpClient类  替换为 CloseableHttpClient  HttpResponse类 替换为 CloseableHttpResponse
        //首先需要先创建一个的CloseableHttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        //创建一个HttpGet对象,传入目标的网络地址:url
        HttpGet httpGet = new HttpGet(url);
        CloseableHttpResponse response = null;
        try {
            //调用HttpClient的execute()方法,并将HttpGet对象传入即可:
            //执行execute()方法之后会返回一个HttpResponse对象,服务器所返回的所有信息就保护在HttpResponse里面.
            response = httpClient.execute(httpGet);
            //先取出服务器返回的状态码,如果等于200就说明请求和响应都成功了:
            //If(httpResponse.getStatusLine().getStatusCode()==200){...}
            if (HttpStatus.SC_OK == response.getStatusLine().getStatusCode()) {
                in = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
                String line;
                while ((line = in.readLine()) != null) {
                    result += line;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Http请求登录失败");
        } finally {
            //释放资源
            if (response != null) {
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (httpClient != null) {
                try {
                    httpClient.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println("HttpGetResult:" + result);
        return result;
    }
}