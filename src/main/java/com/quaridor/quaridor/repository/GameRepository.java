package com.quaridor.quaridor.repository;

import com.quaridor.quaridor.dto.GameDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GameRepository extends JpaRepository<GameDto, String> {
}
