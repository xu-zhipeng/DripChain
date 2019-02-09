package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "tb_alarmrecord", schema = "db_dripchain", catalog = "")
public class AlarmRecord {
    //一对一：
    //一对多：
    //多对一：公司Company 设备Device 数据点Datapoint
    //多对多：
    private int id;//报警记录id
    private Company company;//公司（外键关联iCompanyId）
    private Device device;//设备（外键关联iDeviceId）
    private DataPoint dataPoint;//数据点（外键关联iDataPointId）
    private String sAlarmedValue;//警报值
    private String sAlarmContent;//警报内容
    private Date dAlarmTime;//警报触发时的时间
    private String sHandlingStatus;//处理状态  未处理  已处理 误报
    private String sType;// 是异常警报还是恢复警报  异常警报 恢复警报

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

    @ManyToOne
    @JoinColumn(name = "iDeviceId")
    public Device getDevice() {
        return device;
    }

    public void setDevice(Device device) {
        this.device = device;
    }

    @ManyToOne
    @JoinColumn(name = "iDataPointId")
    public DataPoint getDataPoint() {
        return dataPoint;
    }

    public void setDataPoint(DataPoint dataPoint) {
        this.dataPoint = dataPoint;
    }

    @Basic
    @Column(name = "sAlarmedValue")
    public String getsAlarmedValue() {
        return sAlarmedValue;
    }

    public void setsAlarmedValue(String sAlarmedValue) {
        this.sAlarmedValue = sAlarmedValue;
    }

    @Basic
    @Column(name = "sAlarmContent")
    public String getsAlarmContent() {
        return sAlarmContent;
    }

    public void setsAlarmContent(String sAlarmContent) {
        this.sAlarmContent = sAlarmContent;
    }

    @Basic
    @Column(name = "dAlarmTime")
    public Date getdAlarmTime() {
        return dAlarmTime;
    }

    public void setdAlarmTime(Date dAlarmTime) {
        this.dAlarmTime = dAlarmTime;
    }

    @Basic
    @Column(name = "sHandlingStatus")
    public String getsHandlingStatus() {
        return sHandlingStatus;
    }

    public void setsHandlingStatus(String sHandlingStatus) {
        this.sHandlingStatus = sHandlingStatus;
    }

    public String getsType() {
        return sType;
    }

    public void setsType(String sType) {
        this.sType = sType;
    }
}
