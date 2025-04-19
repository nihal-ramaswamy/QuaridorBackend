package com.quaridor.quaridor.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessagePayload {
    private MessageType type;
    private String content;
    private String sender;
}
