package com.snykdemo.football;

import java.util.List;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.util.HtmlUtils;
import jakarta.validation.Valid;

@RequestMapping("/players")
@RestController
public class PlayerController {
    @GetMapping
    public List<String> listPlayers() { return List.of("Ivana ANDRES", "Alexia PUTELLAS"); }

    @PostMapping
    public ResponseEntity<PlayerDto> createPlayer(@Valid @RequestBody PlayerDto input) {
        // simple escape to avoid reflected XSS in this example
        String safe = HtmlUtils.htmlEscape(input.getName());
        PlayerDto created = new PlayerDto(safe);
        return ResponseEntity.status(201).body(created);
    }

    @GetMapping("/{name}")
    public ResponseEntity<PlayerDto> readPlayer(@PathVariable String name) {
        String safe = HtmlUtils.htmlEscape(name);
        return ResponseEntity.ok(new PlayerDto(safe));
    }

    @DeleteMapping("/{name}")
    public ResponseEntity<PlayerDto> deletePlayer(@PathVariable String name) {
        String safe = HtmlUtils.htmlEscape(name);
        return ResponseEntity.ok(new PlayerDto("deleted: " + safe));
    }

    @PutMapping("/{name}")
    public ResponseEntity<PlayerDto> updatePlayer(@PathVariable String name, @Valid @RequestBody PlayerDto newName) {
        String safeName = HtmlUtils.htmlEscape(name);
        String safeNew = HtmlUtils.htmlEscape(newName.getName());
        return ResponseEntity.ok(new PlayerDto(safeName + " -> " + safeNew));
    }
}
