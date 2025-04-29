package com.quaridor.quaridor.dto;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import java.sql.Timestamp;

@Document("GameEntryItem")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GameEntryItem {
    @Id
    private String id;

    private String gameId;
    private String playerWhite;
    private String playerBlack;
    private String move;
    private Boolean whiteMoved;
    private Timestamp timestamp;
}
