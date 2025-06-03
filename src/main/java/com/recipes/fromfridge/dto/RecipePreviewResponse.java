package com.recipes.fromfridge.dto;

import java.util.List;

public record RecipePreviewResponse(String title,
                                    String imageUrl,
                                    int matchedCount,
                                    List<String> matchedIngredients
                                    )  {}
