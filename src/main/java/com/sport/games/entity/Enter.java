package com.sport.games.entity;

/**
 * 报名表
 */
public class Enter {

    /**
     * 主键id
     */
    private String id;
    /**
     * 会员id
     */
    private String memberId;
    /**
     * 活动id
     */
    private String activityId;
    /**
     * 状态码
     */
    private Integer status;
    /**
     * 成绩：时间
     */
    private Double result;
    /**
     * 排名
     */
    private Integer rank;
    /**
     * 项目id
     */
    private String itemId;

    /**
     * 额外字段
     */
    private String memberName;
    private String memberAccount;
    private String activityName;
    private String itemName;
    private String unit;
    private Integer itemRank;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Double getResult() {
        return result;
    }

    public void setResult(Double result) {
        this.result = result;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getMemberAccount() {
        return memberAccount;
    }

    public void setMemberAccount(String memberAccount) {
        this.memberAccount = memberAccount;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getItemRank() {
        return itemRank;
    }

    public void setItemRank(Integer itemRank) {
        this.itemRank = itemRank;
    }
}
