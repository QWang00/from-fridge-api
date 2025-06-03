package com.recipes.fromfridge.service;

import com.recipes.fromfridge.dto.IngredientDetailDto;
import com.recipes.fromfridge.dto.RecipeDetailDto;
import com.recipes.fromfridge.dto.RecipePreviewResponse;
import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.model.Recipe;
import com.recipes.fromfridge.model.RecipeIngredient;
import com.recipes.fromfridge.repository.RecipeRepository;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RecipeServiceImpl implements RecipeService{

    private final RecipeRepository recipeRepository;
    private final IngredientService ingredientService;

    public RecipeServiceImpl(RecipeRepository recipeRepository, IngredientService ingredientService) {
        this.recipeRepository = recipeRepository;
        this.ingredientService = ingredientService;
    }

    @Override
    public List<RecipePreviewResponse> searchRecipesByIngredientNames(List<String> ingredientNames) {
        if(ingredientNames.size() > 5) throw new IllegalArgumentException("You can enter up to 5 ingredients.");
        List<Integer> ingredientIds = validateAndGetIngredientIds(ingredientNames);

        List<Recipe> recipesByIngredientIds = recipeRepository.findRecipesByIngredientIds(ingredientIds);
        if (recipesByIngredientIds.isEmpty()) {
            throw new ItemNotFoundException("No recipe found matching the given ingredients.");
        }

        List<RecipeMatchInfo> recipeMatchInfos = new ArrayList<>();

        for(Recipe recipe : recipesByIngredientIds){
            RecipeMatchInfo recipeMatchInfo = getRecipeMatchInfo(recipe, ingredientIds);
            recipeMatchInfos.add(recipeMatchInfo);
        }

        return sortByMatchCount(recipeMatchInfos).stream()
                .map(info -> new RecipePreviewResponse(
                        info.recipe().getTitle(),
                        info.recipe().getImageUrl(),
                        info.matchedCount(),
                        info.matchedIngredient()
                ))
                .toList();
    }

    @Override
    public RecipeDetailDto getRecipeDetailById(Integer recipeId, List<String> ownedIngredients) {
        Recipe recipe = recipeRepository.findById(recipeId)
                .orElseThrow(() -> new ItemNotFoundException("Recipe not found"));

        Set<String> ownedSet = ownedIngredients.stream()
                .map(String::toLowerCase)
                .collect(Collectors.toSet());

        List<IngredientDetailDto> ingredientDetails = recipe.getIngredients().stream()
                .map(ri -> new IngredientDetailDto(
                        ri.getIngredient().getName(),
                        ri.getQuantity(),
                        ri.getPreparation(),
                        ownedSet.contains(ri.getIngredient().getName().toLowerCase())
                ))
                .toList();

        return new RecipeDetailDto(
                recipe.getTitle(),
                recipe.getImageUrl(),
                recipe.getServings(),
                recipe.getDifficulty(),
                recipe.getCookTime(),
                recipe.getMethod(),
                recipe.getDescription(),
                ingredientDetails,
                ownedSet.size()
        );
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
            if(ingredientIds.contains(ri.getIngredient().getId())) {
                matchedCount++;
                matchedIngredient.add(ri.getIngredient().getName());
            }
        }
        return new RecipeMatchInfo(recipe, matchedCount, matchedIngredient);
    }

    private List<RecipeMatchInfo> sortByMatchCount(List<RecipeMatchInfo> matchInfoList) {
        matchInfoList.sort(Comparator.comparing(RecipeMatchInfo::matchedCount).reversed());
        return matchInfoList;
    }
}
