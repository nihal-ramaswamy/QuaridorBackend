package com.quaridor.quaridor.repository;

import com.quaridor.quaridor.dto.AccountDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<AccountDto, String> {
    Optional<AccountDto> findAccountDtoByUsername(String username);
}
