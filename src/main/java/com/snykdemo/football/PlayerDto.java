package com.snykdemo.football;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class PlayerDto {

    @NotBlank
    @Size(max = 100)
    private String name;

    public PlayerDto() {}

    public PlayerDto(String name) { this.name = name; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}
