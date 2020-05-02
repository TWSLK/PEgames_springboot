package com.sport.games.controller.publics;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/publics/upload")
public class UploadPublicsController {

    @Value("${image.path}")
    private String IMAGE_PATH;

    @ResponseBody
    @RequestMapping(value="/multiUpload",method= RequestMethod.POST)
    public String multiUpload(HttpServletRequest request) {

        List<MultipartFile> files = ((MultipartHttpServletRequest) request).getFiles("file");
        UUID uuid = UUID.randomUUID();
        String filePath = IMAGE_PATH;
        String fileName="";
        File f = new File(filePath);
        File fileParent = f.getParentFile();
        if(!fileParent.exists()){
            fileParent.mkdirs();
        }
        for (int i = 0; i < files.size(); i++) {
            MultipartFile file = files.get(i);
            if (file.isEmpty()) {
                return "上传第" + (i++) + "个文件失败";
            }
            fileName = file.getOriginalFilename();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            fileName =uuid+ "."+suffix;
            File dest = new File(filePath + fileName);
            try {
                file.transferTo(dest);
            } catch (IOException e) {
                return "上传第" + (i++) + "个文件失败";
            }
        }
        return "/games/publics/upload/file/" + fileName;
    }

    @RequestMapping(value = "/file/{fileName}")
    public void downloadFile(@PathVariable("fileName") String fileName, HttpServletResponse res) {
        try {
            //设置响应头
            res.setContentType("application/force-download");// 设置强制下载不打开
            res.addHeader("Content-Disposition", "attachment;fileName=" +
                    new String(fileName.getBytes("gbk"), "iso8859-1"));// 设置文件名
            res.setHeader("Context-Type", "application/xmsdownload");

            //判断文件是否存在
            File file = new File(IMAGE_PATH + fileName);
            if (file.exists()) {
                byte[] buffer = new byte[1024];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = res.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (bis != null) {
                        try {
                            bis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
