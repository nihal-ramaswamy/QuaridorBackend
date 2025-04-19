package com.quaridor.quaridor.controller;

import com.quaridor.quaridor.dto.AccountDto;
import com.quaridor.quaridor.dto.AccountSignInDto;
import com.quaridor.quaridor.dto.AccountSignUpDto;
import com.quaridor.quaridor.dto.JwtDto;
import com.quaridor.quaridor.service.AccountService;
import com.quaridor.quaridor.service.TokenProviderService;
import com.quaridor.quaridor.utils.AuthManager;
import org.antlr.v4.runtime.Token;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/account")
public class AccountController {
    private final AccountService accountService;
    private final AuthManager authenticationManager;
    private final TokenProviderService tokenProviderService;

    @Autowired
    public AccountController(AccountService accountService, AuthManager authenticationManager, TokenProviderService tokenProviderService) {
        this.accountService = accountService;
        this.authenticationManager = authenticationManager;
        this.tokenProviderService = tokenProviderService;
    }

    @PostMapping("/sign-up")
    public ResponseEntity<?> signUpHandler(@RequestBody AccountSignUpDto accountSignUpDto) {
        this.accountService.signUpHandler(accountSignUpDto);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/sign-in")
    public ResponseEntity<JwtDto> signInHandler(@RequestBody AccountSignInDto accountSignInDto) {
        var usernamePassword = new UsernamePasswordAuthenticationToken(accountSignInDto.username(), accountSignInDto.password());
        var authUser = this.authenticationManager.authenticate(usernamePassword);
        var accessToken = this.tokenProviderService.generateAccessToken((AccountDto) authUser.getPrincipal());
        return ResponseEntity.ok(new JwtDto(accessToken));
    }
}
