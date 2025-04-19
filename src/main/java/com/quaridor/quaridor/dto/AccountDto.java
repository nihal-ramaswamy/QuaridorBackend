package com.quaridor.quaridor.dto;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "account")
@Data
@EqualsAndHashCode(of = "id")
public class AccountDto {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "ID", unique = true, nullable = false)
    private String id;

    @Column(name = "EMAIL", unique = true, nullable = false)
    private String email;

    @Column(name = "USERNAME", nullable = false)
    private String username;

    @Column(name = "PASSWORD", nullable = false)
    private String password;

    @Column(name = "IN_GAME_NAME", unique = true, nullable = false)
    private String ingGameName;

    @Column(name = "IS_VERIFIED")
    private Boolean isVerified = false;

    @Column(name = "ROLES")
    @Enumerated(EnumType.STRING)
    private Roles roles;

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return switch (this.getRoles()) {
            case Roles.ADMIN -> List.of(new SimpleGrantedAuthority(Roles.ADMIN.name()), new SimpleGrantedAuthority(Roles.USER.name()));
            case Roles.USER -> List.of(new SimpleGrantedAuthority(Roles.USER.name()));
        };
    }

    public static AccountDto fromAccountSignUpDto(final AccountSignUpDto accountSignUpDto) {
        AccountDto accountDto = new AccountDto();
        accountDto.setEmail(accountSignUpDto.email());
        accountDto.setUsername(accountSignUpDto.username());
        accountDto.setPassword(new BCryptPasswordEncoder().encode(accountSignUpDto.password()));
        accountDto.setIsVerified(false);
        accountDto.setRoles(Roles.USER);
        accountDto.setIngGameName(accountSignUpDto.ingGameName());

        return accountDto;
    }
}
