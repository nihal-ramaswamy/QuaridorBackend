package com.quaridor.quaridor.filter;

import com.quaridor.quaridor.dto.AccountDto;
import com.quaridor.quaridor.dto.Roles;
import com.quaridor.quaridor.repository.AccountRepository;
import com.quaridor.quaridor.service.TokenProviderService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Component
public class SecurityFilter extends OncePerRequestFilter {
    private final TokenProviderService tokenProviderService;
    private final AccountRepository accountRepository;

    @Autowired
    public SecurityFilter(TokenProviderService tokenProviderService, AccountRepository accountRepository) {
        this.tokenProviderService = tokenProviderService;
        this.accountRepository = accountRepository;
    }

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull FilterChain filterChain)
            throws ServletException, IOException {
        var token = this.recoverToken(request);
        if (token != null) {
            var login = tokenProviderService.validateToken(token);
            Optional<AccountDto> accountDto = accountRepository.findById(login);
            var authentication = new UsernamePasswordAuthenticationToken(accountDto.orElse(null), null, accountDto.map(AccountDto::getAuthorities).orElse(null));
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        filterChain.doFilter(request, response);
    }

    private String recoverToken(HttpServletRequest request) {
        var authHeader = request.getHeader("Authorization");
        if (authHeader == null)
            return null;
        return authHeader.replace("Bearer ", "");
    }
}
