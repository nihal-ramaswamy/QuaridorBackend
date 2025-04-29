package com.quaridor.quaridor.repository;

import com.quaridor.quaridor.dto.GameEntryItem;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GameItemEntryRepository extends MongoRepository<GameEntryItem, String> {
}
