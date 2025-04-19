package com.quaridor.quaridor.utils;

import com.quaridor.quaridor.dto.AccountDto;
import com.quaridor.quaridor.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
public class AuthManager implements AuthenticationManager {
    private final AccountRepository accountRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AuthManager(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }


    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        Optional<AccountDto> accountDtoOptional = this.accountRepository.findAccountDtoByUsername(authentication.getName());
        if (accountDtoOptional.isEmpty()) {
            throw new BadCredentialsException("invalid credentials");
        }
        AccountDto accountDto = accountDtoOptional.get();
        if (!passwordEncoder.matches(authentication.getCredentials().toString(), accountDto.getPassword())) {
            throw new BadCredentialsException("invalid credentials");
        }
        List<GrantedAuthority> grantedAuthorityList = new ArrayList<>(accountDto.getAuthorities());
        return new UsernamePasswordAuthenticationToken(accountDto, authentication.getCredentials(), grantedAuthorityList);
    }
}
