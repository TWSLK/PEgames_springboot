package com.sport.games.filter;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println(" LoginFilter init");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // 对所有的请求进行拦截，进行额外处理
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        String path = req.getContextPath();
        String basePath = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + path;
        HttpSession session = req.getSession(true);

        // 判断是否为登请求，如是，则直接访问
        String url = req.getRequestURL().toString();
        // 判断是否管理员相关登录：
        if (url.indexOf("/publics/") > -1) {
            if (url.indexOf("/login/login-page") > -1 || url.indexOf("/login/login-check") > -1 || url.indexOf("/upload/file") > -1) {
                // 对于登录页面和校验登录，不做处理
                filterChain.doFilter(req, resp);
            } else {
                String adminId = (String) session.getAttribute("admin_id");
                if (adminId == null || "".equals(adminId.trim())) {
                    redirectToAdminLoginPage(resp, basePath + "/publics/login/login-page");
                } else {
                    filterChain.doFilter(req, resp);
                }
            }
        } else if (url.indexOf("/privates/") > -1) {
           if (url.indexOf("/login/login-page") > -1 || url.indexOf("/login/login-check") > -1) {
                // 对于登录页面和校验登录，不做处理
                filterChain.doFilter(req, resp);
            } else {
                String memberId = (String) session.getAttribute("member_id");
                if (memberId == null || "".equals(memberId.trim())) {
                    redirectToAdminLoginPage(resp, basePath + "/privates/login/login-page");
                } else {
                    filterChain.doFilter(req, resp);
                }
            }
        } else {
            filterChain.doFilter(req, resp);
        }
    }


    @Override
    public void destroy() {
        System.out.println("LoginFilter destroy");
    }

    private void redirectToAdminLoginPage(HttpServletResponse resp, String path) throws IOException {
        resp.setHeader("Cache-Control", "no-store");
        resp.setDateHeader("Expires", 0);
        resp.setHeader("Prama", "no-cache");
        resp.sendRedirect(path);
    }
}
