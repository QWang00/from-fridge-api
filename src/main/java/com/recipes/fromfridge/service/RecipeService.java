package com.recipes.fromfridge.service;

import com.recipes.fromfridge.model.Recipe;
import java.util.List;

public interface RecipeService {

    List<Recipe> searchRecipesByIngredientNames(List<String> ingredientNames);

}
