package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_userinfo", schema = "db_dripchain", catalog = "")
public class UserInfo {
    private int id;//用户详细信息id
    private User user;//用户（外键关联iUserId）
    private String sRealname;//用户真实姓名
    private String sSex;//性别
    private String sTelephone;//电话
    private String sEmail;//邮箱
    private String sAddress;//地址
    private String sCompanyName;//公司名称
    private String sRemark;//备注

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @OneToOne
    @JoinColumn(name = "iUserId")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Basic
    @Column(name = "sRealname")
    public String getsRealname() {
        return sRealname;
    }

    public void setsRealname(String sRealname) {
        this.sRealname = sRealname;
    }

    @Basic
    @Column(name = "sSex")
    public String getsSex() {
        return sSex;
    }

    public void setsSex(String sSex) {
        this.sSex = sSex;
    }

    @Basic
    @Column(name = "sTelephone")
    public String getsTelephone() {
        return sTelephone;
    }

    public void setsTelephone(String sTelephone) {
        this.sTelephone = sTelephone;
    }

    @Basic
    @Column(name = "sEmail")
    public String getsEmail() {
        return sEmail;
    }

    public void setsEmail(String sEmail) {
        this.sEmail = sEmail;
    }

    @Basic
    @Column(name = "sAddress")
    public String getsAddress() {
        return sAddress;
    }

    public void setsAddress(String sAddress) {
        this.sAddress = sAddress;
    }

    @Basic
    @Column(name = "sCompanyName")
    public String getsCompanyName() {
        return sCompanyName;
    }

    public void setsCompanyName(String sCompanyName) {
        this.sCompanyName = sCompanyName;
    }

    @Basic
    @Column(name = "sRemark")
    public String getsRemark() {
        return sRemark;
    }

    public void setsRemark(String sRemark) {
        this.sRemark = sRemark;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserInfo userinfo = (UserInfo) o;
        return id == userinfo.id &&
                Objects.equals(user, userinfo.user) &&
                Objects.equals(sRealname, userinfo.sRealname) &&
                Objects.equals(sSex, userinfo.sSex) &&
                Objects.equals(sTelephone, userinfo.sTelephone) &&
                Objects.equals(sEmail, userinfo.sEmail) &&
                Objects.equals(sAddress, userinfo.sAddress) &&
                Objects.equals(sCompanyName, userinfo.sCompanyName) &&
                Objects.equals(sRemark, userinfo.sRemark);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, user, sRealname, sSex, sTelephone, sEmail, sAddress, sCompanyName, sRemark);
    }
}
