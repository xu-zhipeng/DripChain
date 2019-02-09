package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_outlet", schema = "db_dripchain", catalog = "")
public class Outlet {
    private int id;//排放口id
    private Company company;//公司（外键关联iCompanyId）
    private PollutionSource pollutionSource;//污染源（外键关联iPollutionSourceId）
    private String sOutletName;//排放口名称
    /*与排放口类有  多对一  关联*/
    //   企业Company  污染源Pollutionsource

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
    @JoinColumn(name = "iPollutionSourceId")
    public PollutionSource getPollutionSource() {
        return pollutionSource;
    }

    public void setPollutionSource(PollutionSource pollutionSource) {
        this.pollutionSource = pollutionSource;
    }

    @Basic
    @Column(name = "sOutletName")
    public String getsOutletName() {
        return sOutletName;
    }

    public void setsOutletName(String sOutletName) {
        this.sOutletName = sOutletName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Outlet outlet = (Outlet) o;
        return id == outlet.id &&
                Objects.equals(company, outlet.company) &&
                Objects.equals(pollutionSource, outlet.pollutionSource) &&
                Objects.equals(sOutletName, outlet.sOutletName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, company, pollutionSource, sOutletName);
    }
}
