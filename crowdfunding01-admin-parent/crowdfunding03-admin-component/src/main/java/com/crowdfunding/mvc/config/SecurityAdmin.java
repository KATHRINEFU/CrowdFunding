package com.crowdfunding.mvc.config;

import com.crowdfunding.entity.Admin;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.List;

/**
 * @ClassName SecurityAdmin
 * @Description get original Admin object
 * 考虑到user对象中仅包含帐号密码，为了获取到原始admin对象，专门创建这个类，对User类拓展
 * @Author katefu
 * @Date 6/13/22 12:07 AM
 * @Version 1.0
 **/
public class SecurityAdmin extends User {
    private static final long serialVersionUID = 1L;
    //原始的Admin对象
    private Admin originalAdmin;

    public SecurityAdmin(Admin originalAdmin, List<GrantedAuthority> authorities) {
        super(originalAdmin.getLogin(), originalAdmin.getUserPswd(), authorities);
        this.originalAdmin = originalAdmin;
    }

    public Admin getOriginalAdmin() {
        return originalAdmin;
    }
}
