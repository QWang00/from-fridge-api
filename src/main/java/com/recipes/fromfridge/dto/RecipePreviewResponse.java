package com.recipes.fromfridge.dto;

public record RecipePreviewResponse(String title,
                                    String imageUrl,
                                    int matchedCount
)  {}
