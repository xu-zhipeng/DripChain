package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "tb_devicegroup", schema = "db_dripchain", catalog = "")
public class DeviceGroup {
    private int id; //分组id
    private Company company;//公司  （外键关联iComPanyId）
    private String sGroupName;//设备分组名称
    private Date dCreateTime; //分组创建时间
    private Date dUpdateTime; //分组更新时间

    private Set<Device> devices;//该设备组下的设备集合

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
    @Column(name = "sGroupName")
    public String getsGroupName() {
        return sGroupName;
    }

    public void setsGroupName(String sGroupName) {
        this.sGroupName = sGroupName;
    }

    @Basic
    @Column(name = "dCreateTime")
    public Date getdCreateTime() {
        return dCreateTime;
    }

    public void setdCreateTime(Date dCreateTime) {
        this.dCreateTime = dCreateTime;
    }

    @Basic
    @Column(name = "dUpdateTime")
    public Date getdUpdateTime() {
        return dUpdateTime;
    }

    public void setdUpdateTime(Date dUpdateTime) {
        this.dUpdateTime = dUpdateTime;
    }

    @OneToMany(mappedBy = "deviceGroup",fetch = FetchType.EAGER)
    public Set<Device> getDevices() {
        return devices;
    }

    public void setDevices(Set<Device> devices) {
        this.devices = devices;
    }

    @Override
    public String toString() {
        return "DeviceGroup{" +
                "id=" + id +
                ", company=" + company +
                ", sGroupName='" + sGroupName + '\'' +
                ", dCreateTime=" + dCreateTime +
                ", dUpdateTime=" + dUpdateTime +
                '}';
    }
}
