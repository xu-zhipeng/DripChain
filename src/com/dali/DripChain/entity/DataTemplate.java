package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "tb_datatemplate", schema = "db_dripchain", catalog = "")
public class DataTemplate {
    private int id;//数据模板id
    private Company company;//公司  （外键关联iComPanyId）
    private String sTemplateName;//模板名称
    private Set<DataPoint> dataPoints;//该模板下的数据点集合

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
    @Column(name = "sTemplateName")
    public String getsTemplateName() {
        return sTemplateName;
    }

    public void setsTemplateName(String sTemplateName) {
        this.sTemplateName = sTemplateName;
    }

    @OneToMany(mappedBy = "dataTemplate",fetch = FetchType.EAGER)
    public Set<DataPoint> getDataPoints() {
        return dataPoints;
    }

    public void setDataPoints(Set<DataPoint> dataPoints) {
        this.dataPoints = dataPoints;
    }

    @Override
    public String toString() {
        return "DataTemplate{" +
                "id=" + id +
                ", company=" + company +
                ", sTemplateName='" + sTemplateName + '\'' +
                '}';
    }
}
