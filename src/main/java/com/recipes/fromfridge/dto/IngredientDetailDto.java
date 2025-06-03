package com.recipes.fromfridge.dto;

public record IngredientDetailDto(
    String name,
    String quantity,
    String preparation,
    boolean owned
) {}

