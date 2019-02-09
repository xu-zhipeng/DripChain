package com.dali.DripChain.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.*;

@Entity
@Table(name = "tb_device", schema = "db_dripchain", catalog = "")
public class Device {
    //一对一：
    //一对多：
    //多对一：企业Company  政府Government   设备分组Devicegroup
    //多对多：设备从机组 DeviceSlave
    private int id;//设备编号 普通设备：最长12位,系统会自动补全至20位。注：有人透传生成的
    private Company company = new Company();//公司（外键关联iCompanyId）
    private String sDeviceName;//设备名称
    private String sDeviceId;//设备编号（有人过来的不做关联）
    private DeviceGroup deviceGroup = new DeviceGroup();//设备分组（外键关联iDeviceGroupId）默认为 1
    private int iDeviceStatus;//设备状态 // 在线状态 0：离线 1：在线
    private String sDevicePass;//通讯密码   必须为 8 位 （不填写默认用账号默认的设备通讯密码）
    private String sHardver;//硬件版本
    private String sSoftver;//软件版本
    private String sImg;//图片地址
    private String sLength;//合包长度
    private String sCustomFields;//自定义地段
    private BigDecimal dDeviceLongitude;//地图位置（经度）
    private BigDecimal dDeviceLatitude;//地图位置（纬度）
    private String sDeviceAddress;//地图位置（详细地址）
    private String sSn;//设备校验码
    private Integer iProtocol;//通讯协议   0:ModbusRTU    1:ModbusTCP   2:TCP透传  3:DL/T645-97    4:DL/T645-07   5:烟感协议
    private Integer iPollingInterval;//采集频率     当设备通讯协议为数据透传时不填写 主动上传为-1
    private int iDeviceType;//设备类型：0：默认设备 1：LoRa集中器 2：CoAP/NB-IoT 3 ：LoRa模块 4：网络io 5：二维码添加 6：LoRaWAN 7.电信 CoAP/NB-IoT 9:PLC云网关
    private Set<DeviceSlave> deviceSlaves = new HashSet<DeviceSlave>();//设备从机集合  当设备类型为 默认设备 / LoRa模块 / CoAP/NB-IoT 且通讯协议为 ModbusRTU/ModbusTCP 时必填 其他情况不需要填写
    private String sQRcode;//二维码
    private Date dCreateTime; //设备创建时间
    private Date dUpdateTime; //设备更新时间

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
    @Column(name = "sDeviceName")
    public String getsDeviceName() {
        return sDeviceName;
    }

    public void setsDeviceName(String sDeviceName) {
        this.sDeviceName = sDeviceName;
    }

    @Basic
    @Column(name = "sDeviceId")
    public String getsDeviceId() {
        return sDeviceId;
    }

    public void setsDeviceId(String sDeviceId) {
        this.sDeviceId = sDeviceId;
    }

    @ManyToOne
    @JoinColumn(name = "iDeviceGroupId")
    public DeviceGroup getDeviceGroup() {
        return deviceGroup;
    }

    public void setDeviceGroup(DeviceGroup deviceGroup) {
        this.deviceGroup = deviceGroup;
    }

    @Basic
    @Column(name = "iDeviceStatus")
    public int getiDeviceStatus() {
        return iDeviceStatus;
    }

    public void setiDeviceStatus(int iDeviceStatus) {
        this.iDeviceStatus = iDeviceStatus;
    }

    @Basic
    @Column(name = "sDevicePass")
    public String getsDevicePass() {
        return sDevicePass;
    }

    public void setsDevicePass(String sDevicePass) {
        this.sDevicePass = sDevicePass;
    }

    @Basic
    @Column(name = "sHardver")
    public String getsHardver() {
        return sHardver;
    }

    public void setsHardver(String sHardver) {
        this.sHardver = sHardver;
    }

    @Basic
    @Column(name = "sSoftver")
    public String getsSoftver() {
        return sSoftver;
    }

    public void setsSoftver(String sSoftver) {
        this.sSoftver = sSoftver;
    }

    @Basic
    @Column(name = "sImg")
    public String getsImg() {
        return sImg;
    }

    public void setsImg(String sImg) {
        this.sImg = sImg;
    }

    @Basic
    @Column(name = "sLength")
    public String getsLength() {
        return sLength;
    }

    public void setsLength(String sLength) {
        this.sLength = sLength;
    }

    @Basic
    @Column(name = "sCustomFields")
    public String getsCustomFields() {
        return sCustomFields;
    }

    public void setsCustomFields(String sCustomFields) {
        this.sCustomFields = sCustomFields;
    }

    @Basic
    @Column(name = "dDeviceLongitude")
    public BigDecimal getdDeviceLongitude() {
        return dDeviceLongitude;
    }

    public void setdDeviceLongitude(BigDecimal dDeviceLongitude) {
        this.dDeviceLongitude = dDeviceLongitude;
    }

    @Basic
    @Column(name = "dDeviceLatitude")
    public BigDecimal getdDeviceLatitude() {
        return dDeviceLatitude;
    }

    public void setdDeviceLatitude(BigDecimal dDeviceLatitude) {
        this.dDeviceLatitude = dDeviceLatitude;
    }

    @Basic
    @Column(name = "sDeviceAddress")
    public String getsDeviceAddress() {
        return sDeviceAddress;
    }

    public void setsDeviceAddress(String sDeviceAddress) {
        this.sDeviceAddress = sDeviceAddress;
    }

    @Basic
    @Column(name = "sSN")
    public String getsSn() {
        return sSn;
    }

    public void setsSn(String sSn) {
        this.sSn = sSn;
    }

    @Basic
    @Column(name = "iProtocol")
    public Integer getiProtocol() {
        return iProtocol;
    }

    public void setiProtocol(Integer iProtocol) {
        this.iProtocol = iProtocol;
    }

    @Basic
    @Column(name = "iPollingInterval")
    public Integer getiPollingInterval() {
        return iPollingInterval;
    }

    public void setiPollingInterval(Integer iPollingInterval) {
        this.iPollingInterval = iPollingInterval;
    }

    @Basic
    @Column(name = "iDeviceType")
    public int getiDeviceType() {
        return iDeviceType;
    }

    public void setiDeviceType(int iDeviceType) {
        this.iDeviceType = iDeviceType;
    }

    /*@ManyToMany(fetch=FetchType.LAZY,cascade = CascadeType.ALL,targetEntity= DeviceSlave.class) //延迟加载//级联删除//目标对象
    *//** 中间表*//*
    @JoinTable(name="Device_DeviceSlave_PK", //指定中间表名称
            joinColumns=@JoinColumn(name="iDeviceId"), //@ManyToMany中没有加mappedby的主键列
            inverseJoinColumns=@JoinColumn(name="iDeviceSlaveId")) //@ManyToMany中加mappedby的主键列*/
    @OneToMany(mappedBy = "device",fetch = FetchType.EAGER)
    public Set<DeviceSlave> getDeviceSlaves() {
        return deviceSlaves;
    }

    public void setDeviceSlaves(Set<DeviceSlave> deviceSlaves) {
        this.deviceSlaves = deviceSlaves;
    }

    @Basic
    @Column(name = "sQRcode")
    public String getsQRcode() {
        return sQRcode;
    }

    public void setsQRcode(String sQRcode) {
        this.sQRcode = sQRcode;
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

    @Override
    public String toString() {
        return "Device{" +
                "id=" + id +
                ", company=" + company +
                ", sDeviceName='" + sDeviceName + '\'' +
                ", sDeviceId='" + sDeviceId + '\'' +
                ", deviceGroup=" + deviceGroup +
                ", iDeviceStatus=" + iDeviceStatus +
                ", sDevicePass='" + sDevicePass + '\'' +
                ", sHardver='" + sHardver + '\'' +
                ", sSoftver='" + sSoftver + '\'' +
                ", sImg='" + sImg + '\'' +
                ", sLength='" + sLength + '\'' +
                ", sCustomFields='" + sCustomFields + '\'' +
                ", dDeviceLongitude=" + dDeviceLongitude +
                ", dDeviceLatitude=" + dDeviceLatitude +
                ", sDeviceAddress='" + sDeviceAddress + '\'' +
                ", sSn='" + sSn + '\'' +
                ", iProtocol=" + iProtocol +
                ", iPollingInterval=" + iPollingInterval +
                ", iDeviceType=" + iDeviceType +
                ", deviceSlaves=" + deviceSlaves +
                ", sQRcode='" + sQRcode + '\'' +
                ", dCreateTime=" + dCreateTime +
                ", dUpdateTime=" + dUpdateTime +
                '}';
    }
}
