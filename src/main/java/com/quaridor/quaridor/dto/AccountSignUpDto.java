package com.quaridor.quaridor.dto;

public record AccountSignUpDto(
        String email,
        String username,
        String password,
        String ingGameName) {
}
