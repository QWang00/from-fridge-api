package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.model.Recipe;
import com.recipes.fromfridge.model.RecipeIngredient;
import com.recipes.fromfridge.repository.IngredientRepository;
import com.recipes.fromfridge.repository.RecipeRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RecipeServiceImpl implements RecipeService{

    private final RecipeRepository recipeRepository;
    private final IngredientService ingredientService;

    public RecipeServiceImpl(RecipeRepository recipeRepository, IngredientService ingredientService) {
        this.recipeRepository = recipeRepository;
        this.ingredientService = ingredientService;
    }

    @Override
    public List<Recipe> searchRecipesByIngredientNames(List<String> ingredientNames) {
        return List.of();
    }

    private List<Integer> validateAndGetIngredientIds(List<String> ingredientNames) {
        Set<String> seen = new HashSet<>();
        List<Integer> ingredientIds = new ArrayList<>();

        for (String name : ingredientNames) {
            String lowerCase = name.trim().toLowerCase();
            if(!seen.add(lowerCase)) {
                throw new DuplicateItemException(
                        String.format("Ingredient [%s] already exists, please try again.", name));
            }
            Ingredient ingredient = ingredientService.getIngredientByNameIgnoreCase(name);
            ingredientIds.add(ingredient.getId());
        }

        return ingredientIds;
    }

    private RecipeMatchInfo getRecipeMatchInfo(Recipe recipe, List<Integer> ingredientIds) {
        int matchedCount = 0;
        List<String> matchedIngredient = new ArrayList<>();

        for(RecipeIngredient ri : recipe.getIngredients()){
            if(ingredientIds.contains(ri.getId())) {
                matchedCount++;
                matchedIngredient.add(ri.getIngredient().getName());
            }
        }
        return new RecipeMatchInfo(recipe, matchedCount, matchedIngredient);
    }

    private List<RecipeMatchInfo> sortByMatchCount(List<RecipeMatchInfo> RecipesMatchInfo) {
        return null;
    }
}
