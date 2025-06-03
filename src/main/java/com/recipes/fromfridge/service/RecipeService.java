package com.recipes.fromfridge.service;

import com.recipes.fromfridge.dto.RecipeDetailDto;
import com.recipes.fromfridge.dto.RecipePreviewResponse;
import java.util.List;

public interface RecipeService {

    List<RecipePreviewResponse> searchRecipesByIngredientNames(List<String> ingredientNames);

    RecipeDetailDto getRecipeDetailById(Integer recipeId, List<String> ownedIngredients);

}
