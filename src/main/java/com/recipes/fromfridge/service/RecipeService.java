package com.recipes.fromfridge.service;

import com.recipes.fromfridge.dto.RecipePreviewResponse;
import java.util.List;

public interface RecipeService {

    List<RecipePreviewResponse> searchRecipesByIngredientNames(List<String> ingredientNames);

}
