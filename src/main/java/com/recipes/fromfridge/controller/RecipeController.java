package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.dto.RecipePreviewResponse;
import jakarta.validation.constraints.NotEmpty;
import com.recipes.fromfridge.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/api/v1/from-fridge/recipes")
@Validated
public class RecipeController {
    private final RecipeService recipeService;

    @Autowired
    public RecipeController(RecipeService recipeService) {
        this.recipeService = recipeService;
    }

    @GetMapping("/search")
    public ResponseEntity<List<RecipePreviewResponse>> searchRecipesByIngredientNames(
            @RequestParam @NotEmpty(message = "Please provide at least one ingredient.") List<String> ingredientNames) {
        return new ResponseEntity<>(recipeService.searchRecipesByIngredientNames(ingredientNames), HttpStatus.OK);
    }
}
