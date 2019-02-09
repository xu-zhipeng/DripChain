package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "tb_company", schema = "db_dripchain", catalog = "")
public class Company {
    //一对一：
    //一对多：设备Device  排放口Outlet   警报Alarm   警报记录AlarmRecord
    //多对一：
    //多对多：
    private int id;//公司id
    private String sUserRight;//用户权限
    private String sUserName;//用户名
    private String sPassword;//用户密码
    private String sGoc;//政府机构码
    private String sCompanyName;//公司名
    private String sCompanyType;//公司类型
    private String sCompanyAddress;//公司地址
    private String sCompanyTelephone;//公司电话
    private String sEmail;//公司邮箱

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "sUserRight")
    public String getsUserRight() {
        return sUserRight;
    }

    public void setsUserRight(String sUserRight) {
        this.sUserRight = sUserRight;
    }

    @Basic
    @Column(name = "sUserName")
    public String getsUserName() {
        return sUserName;
    }

    public void setsUserName(String sUserName) {
        this.sUserName = sUserName;
    }

    @Basic
    @Column(name = "sPassword")
    public String getsPassword() {
        return sPassword;
    }

    public void setsPassword(String sPassword) {
        this.sPassword = sPassword;
    }

    @Basic
    @Column(name = "sGOC")
    public String getsGoc() {
        return sGoc;
    }

    public void setsGoc(String sGoc) {
        this.sGoc = sGoc;
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
    @Column(name = "sCompanyType")
    public String getsCompanyType() {
        return sCompanyType;
    }

    public void setsCompanyType(String sCompanyType) {
        this.sCompanyType = sCompanyType;
    }

    @Basic
    @Column(name = "sCompanyAddress")
    public String getsCompanyAddress() {
        return sCompanyAddress;
    }

    public void setsCompanyAddress(String sCompanyAddress) {
        this.sCompanyAddress = sCompanyAddress;
    }

    @Basic
    @Column(name = "sCompanyTelephone")
    public String getsCompanyTelephone() {
        return sCompanyTelephone;
    }

    public void setsCompanyTelephone(String sCompanyTelephone) {
        this.sCompanyTelephone = sCompanyTelephone;
    }

    @Basic
    @Column(name = "sEmail")
    public String getsEmail() {
        return sEmail;
    }

    public void setsEmail(String sEmail) {
        this.sEmail = sEmail;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Company company = (Company) o;
        return id == company.id &&
                Objects.equals(sUserRight, company.sUserRight) &&
                Objects.equals(sUserName, company.sUserName) &&
                Objects.equals(sPassword, company.sPassword) &&
                Objects.equals(sGoc, company.sGoc) &&
                Objects.equals(sCompanyName, company.sCompanyName) &&
                Objects.equals(sCompanyType, company.sCompanyType) &&
                Objects.equals(sCompanyAddress, company.sCompanyAddress) &&
                Objects.equals(sCompanyTelephone, company.sCompanyTelephone) &&
                Objects.equals(sEmail, company.sEmail);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sUserRight, sUserName, sPassword, sGoc, sCompanyName, sCompanyType, sCompanyAddress, sCompanyTelephone, sEmail);
    }

    @Override
    public String toString() {
        return "Company{" +
                "id=" + id +
                ", sUserRight='" + sUserRight + '\'' +
                ", sUserName='" + sUserName + '\'' +
                ", sPassword='" + sPassword + '\'' +
                ", sGoc='" + sGoc + '\'' +
                ", sCompanyName='" + sCompanyName + '\'' +
                ", sCompanyType='" + sCompanyType + '\'' +
                ", sCompanyAddress='" + sCompanyAddress + '\'' +
                ", sCompanyTelephone='" + sCompanyTelephone + '\'' +
                ", sEmail='" + sEmail + '\'' +
                '}';
    }
}
