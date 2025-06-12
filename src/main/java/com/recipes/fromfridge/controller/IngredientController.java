package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.service.IngredientService;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/api/v1/from-fridge/ingredients")
@Validated
public class IngredientController {
    private final IngredientService ingredientService;

    public IngredientController(IngredientService ingredientService) {
        this.ingredientService = ingredientService;
    }

    @GetMapping("/search")
    public ResponseEntity<List<Ingredient>> searchIngredients(@RequestParam String query) {
        return ResponseEntity.ok(ingredientService.searchIngredients(query));
    }
}
