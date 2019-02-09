package com.dali.DripChain.entity;

import javax.persistence.*;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "tb_pollutionsource", schema = "db_dripchain", catalog = "")
public class PollutionSource {
    private int id;//污染源id
    private String sName;//污染源名称
    private Set<Outlet> outlets;//该污染源下的排放口集合

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

    @OneToMany(mappedBy = "pollutionSource",fetch = FetchType.EAGER)
    public Set<Outlet> getOutlets() {
        return outlets;
    }

    public void setOutlets(Set<Outlet> outlets) {
        this.outlets = outlets;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PollutionSource that = (PollutionSource) o;
        return id == that.id &&
                Objects.equals(sName, that.sName) &&
                Objects.equals(outlets, that.outlets);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sName, outlets);
    }
}
