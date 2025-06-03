package com.recipes.fromfridge.dto;

import java.util.List;

public record RecipeDetailDto(
        String title,
        String imageUrl,
        Integer servings,
        String difficulty,
        Integer cookTime,
        List<String> method,
        String description,
        List<IngredientDetailDto> ingredients
) {}
