package com.quaridor.quaridor.controller;

import com.quaridor.quaridor.dto.MessagePayload;
import com.quaridor.quaridor.dto.MessageType;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class MessagePayloadController {
    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public MessagePayload handleMessagePayload(MessagePayload messagePayload) {
        return new MessagePayload(MessageType.CHAT, "response from server: " + messagePayload.getContent(), "server");
    }
}
