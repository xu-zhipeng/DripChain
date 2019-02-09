package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "tb_deviceslave", schema = "db_dripchain", catalog = "")
public class DeviceSlave {
    private int id;//从机id
    private Device device = new Device();
    private Integer iCreator;//创建改从机用户id
    private DataTemplate dataTemplate;//数据模板（外键关联iDataTemplateId）
    private Integer iUid;//用户id
    private Integer iUpdator;//更新改从机用户id
    private String sSlaveAddr;//从机地址
    private String sSlaveIndex;//从机索引
    private String sSlaveName;//从机名称
    private Date dCreateDate;//创建日期
    private Date dUpdateDate;//更细日期

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
    @JoinColumn(name = "iDeviceId")
    public Device getDevice() {
        return device;
    }

    public void setDevice(Device device) {
        this.device = device;
    }

    @Basic
    @Column(name = "iCreator")
    public Integer getiCreator() {
        return iCreator;
    }

    public void setiCreator(Integer iCreator) {
        this.iCreator = iCreator;
    }

    @ManyToOne
    @JoinColumn(name = "iDataTemplateId")
    public DataTemplate getDataTemplate() {
        return dataTemplate;
    }

    public void setDataTemplate(DataTemplate dataTemplate) {
        this.dataTemplate = dataTemplate;
    }

    @Basic
    @Column(name = "iUid")
    public Integer getiUid() {
        return iUid;
    }

    public void setiUid(Integer iUid) {
        this.iUid = iUid;
    }

    @Basic
    @Column(name = "iUpdator")
    public Integer getiUpdator() {
        return iUpdator;
    }

    public void setiUpdator(Integer iUpdator) {
        this.iUpdator = iUpdator;
    }

    @Basic
    @Column(name = "sSlaveAddr")
    public String getsSlaveAddr() {
        return sSlaveAddr;
    }

    public void setsSlaveAddr(String sSlaveAddr) {
        this.sSlaveAddr = sSlaveAddr;
    }

    @Basic
    @Column(name = "sSlaveIndex")
    public String getsSlaveIndex() {
        return sSlaveIndex;
    }

    public void setsSlaveIndex(String sSlaveIndex) {
        this.sSlaveIndex = sSlaveIndex;
    }

    @Basic
    @Column(name = "sSlaveName")
    public String getsSlaveName() {
        return sSlaveName;
    }

    public void setsSlaveName(String sSlaveName) {
        this.sSlaveName = sSlaveName;
    }

    @Basic
    @Column(name = "dCreateDate")
    public Date getdCreateDate() {
        return dCreateDate;
    }

    public void setdCreateDate(Date dCreateDate) {
        this.dCreateDate = dCreateDate;
    }

    @Basic
    @Column(name = "dUpdateDate")
    public Date getdUpdateDate() {
        return dUpdateDate;
    }

    public void setdUpdateDate(Date dUpdateDate) {
        this.dUpdateDate = dUpdateDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DeviceSlave that = (DeviceSlave) o;
        return id == that.id &&
                Objects.equals(device, that.device) &&
                Objects.equals(iCreator, that.iCreator) &&
                Objects.equals(dataTemplate, that.dataTemplate) &&
                Objects.equals(iUid, that.iUid) &&
                Objects.equals(iUpdator, that.iUpdator) &&
                Objects.equals(sSlaveAddr, that.sSlaveAddr) &&
                Objects.equals(sSlaveIndex, that.sSlaveIndex) &&
                Objects.equals(sSlaveName, that.sSlaveName) &&
                Objects.equals(dCreateDate, that.dCreateDate) &&
                Objects.equals(dUpdateDate, that.dUpdateDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, device, iCreator, dataTemplate, iUid, iUpdator, sSlaveAddr, sSlaveIndex, sSlaveName, dCreateDate, dUpdateDate);
    }

    @Override
    public String toString() {
        return "DeviceSlave{" +
                "id=" + id +
                ", device=" + "设备名:"+device.getsDeviceName() +
                ", iCreator=" + iCreator +
                ", dataTemplate=" + dataTemplate +
                ", iUid=" + iUid +
                ", iUpdator=" + iUpdator +
                ", sSlaveAddr='" + sSlaveAddr + '\'' +
                ", sSlaveIndex='" + sSlaveIndex + '\'' +
                ", sSlaveName='" + sSlaveName + '\'' +
                ", dCreateDate=" + dCreateDate +
                ", dUpdateDate=" + dUpdateDate +
                '}';
    }
}
