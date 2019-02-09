package com.dali.DripChain.entity;

import javax.persistence.*;

@Entity
@Table(name = "tb_data", schema = "db_dripchain", catalog = "")
public class Data {
    /*"alarm":0,//是否报警 0 未报警 1 报警
    "createTime":1514277990,// 创建时间
    "dataid":3112,// 数据点id
    "slaveIndex":1,// 从机地址
    "did":"00004299000000000001",// 设备id
    "id":30031448,
    "value":436 // 数值*/
    private  int id;
    private int iCompanyId;
    private  String deviceId; // 设备id
    private String deviceName; //设备名
    private int dataPointId; // 数据点id
    private String dataPointName; //数据点名
    private String createTime; // 创建时间
    private int slaveIndex; // 从机名称
    private String slaveName; //数据点名
    private int alarm; //是否报警 0 未报警 1 报警
    private String value; // 数值

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "iCompanyId")
    public int getiCompanyId() {
        return iCompanyId;
    }

    public void setiCompanyId(int iCompanyId) {
        this.iCompanyId = iCompanyId;
    }

    @Basic
    @Column(name = "deviceId")
    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    @Basic
    @Column(name = "deviceName")
    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    @Basic
    @Column(name = "dataPointId")
    public int getDataPointId() {
        return dataPointId;
    }

    public void setDataPointId(int dataPointId) {
        this.dataPointId = dataPointId;
    }

    @Basic
    @Column(name = "dataPointName")
    public String getDataPointName() {
        return dataPointName;
    }

    public void setDataPointName(String dataPointName) {
        this.dataPointName = dataPointName;
    }

    @Basic
    @Column(name = "createTime")
    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "slaveIndex")
    public int getSlaveIndex() {
        return slaveIndex;
    }

    public void setSlaveIndex(int slaveIndex) {
        this.slaveIndex = slaveIndex;
    }

    @Basic
    @Column(name = "slaveName")
    public String getSlaveName() {
        return slaveName;
    }

    public void setSlaveName(String slaveName) {
        this.slaveName = slaveName;
    }

    @Basic
    @Column(name = "alarm")
    public int getAlarm() {
        return alarm;
    }

    public void setAlarm(int alarm) {
        this.alarm = alarm;
    }

    @Basic
    @Column(name = "value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Data{" +
                "id=" + id +
                ", iCompanyId=" + iCompanyId +
                ", deviceId='" + deviceId + '\'' +
                ", deviceName='" + deviceName + '\'' +
                ", dataPointId=" + dataPointId +
                ", dataPointName='" + dataPointName + '\'' +
                ", createTime='" + createTime + '\'' +
                ", slaveIndex=" + slaveIndex +
                ", slaveName='" + slaveName + '\'' +
                ", alarm=" + alarm +
                ", value='" + value + '\'' +
                '}';
    }
}
