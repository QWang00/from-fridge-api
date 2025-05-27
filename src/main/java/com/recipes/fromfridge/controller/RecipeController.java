package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.dto.RecipePreviewResponse;
import com.recipes.fromfridge.model.Recipe;
import com.recipes.fromfridge.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/api/v1/from-fridge/recipes")
public class RecipeController {
    private final RecipeService recipeService;

    @Autowired
    public RecipeController(RecipeService recipeService) {
        this.recipeService = recipeService;
    }

    @GetMapping("/search")
    public ResponseEntity<List<RecipePreviewResponse>> searchRecipesByIngredientNames(@RequestParam List<String> ingredientNames){
        if (ingredientNames == null || ingredientNames.isEmpty()) {
            throw new IllegalArgumentException("Please provide at least one ingredient.");
        }
        return new ResponseEntity<>(recipeService.searchRecipesByIngredientNames(ingredientNames), HttpStatus.OK);
    }
}
