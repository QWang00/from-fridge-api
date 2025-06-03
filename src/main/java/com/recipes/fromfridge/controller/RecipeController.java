package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.dto.RecipeDetailDto;
import com.recipes.fromfridge.dto.RecipePreviewResponse;
import com.recipes.fromfridge.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
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
            @RequestParam(required = false) List<String> ingredientNames) {
        if (ingredientNames == null || ingredientNames.isEmpty()) {
            throw new IllegalArgumentException("Please provide at least one ingredient.");
        }
        return ResponseEntity.ok(recipeService.searchRecipesByIngredientNames(ingredientNames));
    }


    @GetMapping("/{id}/detail")
    public ResponseEntity<RecipeDetailDto> getRecipeDetail(
            @PathVariable Integer id,
            @RequestParam List<String> ownedIngredients) {
        return ResponseEntity.ok(recipeService.getRecipeDetailById(id, ownedIngredients));
    }
}
