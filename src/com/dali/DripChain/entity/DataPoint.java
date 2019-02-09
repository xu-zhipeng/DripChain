package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_datapoint", schema = "db_dripchain", catalog = "")
public class DataPoint {
    private int id;//数据点id
    private String sName;//数据点名称
    private DataTemplate dataTemplate;//数据模板（外键关联iDataTemplateId）
    private Integer iType;//数据类型  0：数值型 1：开关型 3：定位型 4：字符型
    private Integer iWriteRead;//读写    0：只读 1：读写 2：只写
    private Integer iValueKind; /*数值类型：0：两字节无符号整数 1：两字节带符号等数 2：四字节无符号整数（AB CD） 3：四字节带符号整数（AB CD）
    4：四字节浮点型 5：bit  6：四字节无符号整数（CD AB） 8：四字节有符号整数（CD AB）10：四字节浮点型（CD AB）*/
    private Integer iLength;//字节长度
    private String sUnit;//单位 如：us/cm  摄氏度  等单位
    private String sRegister;//	寄存器例如: 寄存器地址为 4 起始地址为 2 此处填写30002  功能码04H，起始地址000AH，则填：30011
    private Integer iDecimalAccuracy;//保留小数点位数
    private String sFormula;//公式
    private Integer iStorage;//是否保存   0 不保存 1 保存
    private String sDescription;//变量描述
    private String sCustomFields;//	自定义字段

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
    @Column(name = "sName")
    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
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
    @Column(name = "iType")
    public Integer getiType() {
        return iType;
    }

    public void setiType(Integer iType) {
        this.iType = iType;
    }

    @Basic
    @Column(name = "iWriteRead")
    public Integer getiWriteRead() {
        return iWriteRead;
    }

    public void setiWriteRead(Integer iWriteRead) {
        this.iWriteRead = iWriteRead;
    }

    @Basic
    @Column(name = "iValueKind")
    public Integer getiValueKind() {
        return iValueKind;
    }

    public void setiValueKind(Integer iValueKind) {
        this.iValueKind = iValueKind;
    }

    @Basic
    @Column(name = "iLength")
    public Integer getiLength() {
        return iLength;
    }

    public void setiLength(Integer iLength) {
        this.iLength = iLength;
    }

    @Basic
    @Column(name = "sUnit")
    public String getsUnit() {
        return sUnit;
    }

    public void setsUnit(String sUnit) {
        this.sUnit = sUnit;
    }

    @Basic
    @Column(name = "sRegister")
    public String getsRegister() {
        return sRegister;
    }

    public void setsRegister(String sRegister) {
        this.sRegister = sRegister;
    }

    @Basic
    @Column(name = "iDecimal_accuracy")
    public Integer getiDecimalAccuracy() {
        return iDecimalAccuracy;
    }

    public void setiDecimalAccuracy(Integer iDecimalAccuracy) {
        this.iDecimalAccuracy = iDecimalAccuracy;
    }

    @Basic
    @Column(name = "sFormula")
    public String getsFormula() {
        return sFormula;
    }

    public void setsFormula(String sFormula) {
        this.sFormula = sFormula;
    }

    @Basic
    @Column(name = "iStorage")
    public Integer getiStorage() {
        return iStorage;
    }

    public void setiStorage(Integer iStorage) {
        this.iStorage = iStorage;
    }

    @Basic
    @Column(name = "sDescription")
    public String getsDescription() {
        return sDescription;
    }

    public void setsDescription(String sDescription) {
        this.sDescription = sDescription;
    }

    @Basic
    @Column(name = "sCustomFields")
    public String getsCustomFields() {
        return sCustomFields;
    }

    public void setsCustomFields(String sCustomFields) {
        this.sCustomFields = sCustomFields;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DataPoint datapoint = (DataPoint) o;
        return id == datapoint.id &&
                Objects.equals(sName, datapoint.sName) &&
                Objects.equals(dataTemplate, datapoint.dataTemplate) &&
                Objects.equals(iType, datapoint.iType) &&
                Objects.equals(iWriteRead, datapoint.iWriteRead) &&
                Objects.equals(iValueKind, datapoint.iValueKind) &&
                Objects.equals(iLength, datapoint.iLength) &&
                Objects.equals(sUnit, datapoint.sUnit) &&
                Objects.equals(sRegister, datapoint.sRegister) &&
                Objects.equals(iDecimalAccuracy, datapoint.iDecimalAccuracy) &&
                Objects.equals(sFormula, datapoint.sFormula) &&
                Objects.equals(iStorage, datapoint.iStorage) &&
                Objects.equals(sDescription, datapoint.sDescription) &&
                Objects.equals(sCustomFields, datapoint.sCustomFields);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sName, dataTemplate, iType, iWriteRead, iValueKind, iLength, sUnit, sRegister, iDecimalAccuracy, sFormula, iStorage, sDescription, sCustomFields);
    }

    @Override
    public String toString() {
        return "DataPoint{" +
                "id=" + id +
                ", sName='" + sName + '\'' +
                ", dataTemplate=" + dataTemplate +
                ", iType=" + iType +
                ", iWriteRead=" + iWriteRead +
                ", iValueKind=" + iValueKind +
                ", iLength=" + iLength +
                ", sUnit='" + sUnit + '\'' +
                ", sRegister='" + sRegister + '\'' +
                ", iDecimalAccuracy=" + iDecimalAccuracy +
                ", sFormula='" + sFormula + '\'' +
                ", iStorage=" + iStorage +
                ", sDescription='" + sDescription + '\'' +
                ", sCustomFields='" + sCustomFields + '\'' +
                '}';
    }
}
