package com.sport.games.entity;

import java.util.Date;

/**
 * 活动表
 */
public class Activity {

    /**
     * 主键id
     */
    private String id;
    /**
     * 活动名称
     */
    private String name;
    /**
     * 活动开始时间
     */
    private Date startTime;
    /**
     * 活动结束时间
     */
    private Date endTime;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 资料
     */
    private String data;
    /**
     * 运动会包含的项目
     */
    private String itemJson;

    /**
     * 状态
     */
    private String status;

    /**
     * 项目字符串
     */
    private String items;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getItemJson() {
        return itemJson;
    }

    public void setItemJson(String itemJson) {
        this.itemJson = itemJson;
    }

    public String getItems() {
        return items;
    }

    public void setItems(String items) {
        this.items = items;
    }
}
