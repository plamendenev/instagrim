/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Set;
import java.util.UUID;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;

/**
 *
 * @author Administrator
 */
public class User {

    Cluster cluster;
    private String username, name, surname;
    private Set<String> email;
    //private Pic profilePic;
    private UUID profilePic;
    private User user;

    public User() {
        name = null;
        surname = null;
        username = null;
        email = null;
        profilePic = null;
    }

    public UUID getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(UUID profilePic) {
        this.profilePic = profilePic;
    }

    public Set<String> getEmail() {
        return email;
    }

    public void setEmail(Set<String> email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public void setUsername(String name) {
        this.username = name;
    }

    public String getUsername() {
        return username;
    }

    public boolean RegisterUser(String name, String surname, String username, String Password) {
        AeSimpleSHA1 sha1handler = new AeSimpleSHA1();
        String EncodedPassword = null;
        try {
            EncodedPassword = sha1handler.SHA1(Password);
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException et) {
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (login, password, first_name, last_name) Values(?,?,?,?)");

        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute(boundStatement.bind(username, EncodedPassword, name, surname));
        //We are assuming this always works.  Also a transaction would be good here !        
        return true;
    }

    public LoggedIn IsValidUser(String username, String Password) {
        AeSimpleSHA1 sha1handler = new AeSimpleSHA1();
        String EncodedPassword = null;
        try {
            EncodedPassword = sha1handler.SHA1(Password);
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException et) {
            System.out.println("Can't check your password");
            return null;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        boundStatement.bind(username);

        rs = session.execute(boundStatement);
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0) {
                    LoggedIn lg = new LoggedIn();
                    lg.setLogedin();
                    user = getUserDb(username);
                    lg.setUser(user);

                    return lg;
                }
            }
        }

        return null;
    }

    public User getUserDb(String username) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select first_name, last_name, login from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        boundStatement.bind(username);
        rs = session.execute(boundStatement);
        Row aRow = rs.one();
        user = new User();
        user.setUsername(aRow.getString("login"));
        user.setName(aRow.getString("first_name"));
        user.setSurname(aRow.getString("last_name"));

        return user;
    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

}
