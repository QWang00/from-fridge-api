package com.recipes.fromfridge.service;

import com.recipes.fromfridge.model.Recipe;
import java.util.List;

public record RecipeMatchInfo(Recipe recipe, int matchedCount, List<String> matchedIngredient) {}
