package com.quaridor.quaridor.dto;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Table(name = "game")
@Entity
@Data
@EqualsAndHashCode(of = "id")
public class GameDto {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "ID", unique = true, nullable = false)
    private String id;

    @Column(name = "PLAYER_WHITE", nullable = false)
    private String playerWhite;

    @Column(name = "PLAYER_BLACK", nullable = false)
    private String playerBlack;

    @Column(name = "GAME_STATUS", nullable = false)
    private GameStatus gameStatus;
}
