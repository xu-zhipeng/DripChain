package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_contact", schema = "db_dripchain", catalog = "")
public class Contact {
    private int id;//联系人id
    private Company company;//公司（外键关联iCompanyId）
    private String sEmail;//邮箱
    private String sName;//联系人姓名
    private String sNote;//备注
    private String sPhone;//电话
    private String sWeChat;//微信

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @ManyToOne
    @JoinColumn(name = "iCompanyId")
    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
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
    @Column(name = "sName")
    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    @Basic
    @Column(name = "sNote")
    public String getsNote() {
        return sNote;
    }

    public void setsNote(String sNote) {
        this.sNote = sNote;
    }

    @Basic
    @Column(name = "sPhone")
    public String getsPhone() {
        return sPhone;
    }

    public void setsPhone(String sPhone) {
        this.sPhone = sPhone;
    }

    @Basic
    @Column(name = "sWeChat")
    public String getsWeChat() {
        return sWeChat;
    }

    public void setsWeChat(String sWeChat) {
        this.sWeChat = sWeChat;
    }

}
