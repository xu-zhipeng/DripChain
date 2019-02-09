package com.dali.DripChain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class tbUser {
    private String id;
    private String username;
    private String password;

    public tbUser() {
    }

    public tbUser(String password) {
        this.password = password;
    }

    public tbUser(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public tbUser(String id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    @Id
    @Column(name = "ID")
    @GenericGenerator(name = "generator",strategy = "uuid.hex")
    @GeneratedValue(generator = "generator")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "USERNAME")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Basic
    @Column(name = "PASSWORD")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        tbUser tbUser = (tbUser) o;
        return Objects.equals(id, tbUser.id) &&
                Objects.equals(username, tbUser.username) &&
                Objects.equals(password, tbUser.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username, password);
    }

    @Override
    public String toString() {
        return "tbUser{" +
                "id='" + id + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
