package com.quaridor.quaridor.service;

import com.quaridor.quaridor.dto.AccountDto;
import com.quaridor.quaridor.dto.AccountSignUpDto;
import com.quaridor.quaridor.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountService {
    private final AccountRepository accountRepository;

    @Autowired
    public AccountService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    public void signUpHandler(final AccountSignUpDto accountSignUpDto) {
        this.accountRepository.save(AccountDto.fromAccountSignUpDto(accountSignUpDto));
    }
}
