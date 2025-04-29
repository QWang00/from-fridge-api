package com.recipes.fromfridge.service;

import com.recipes.fromfridge.model.Ingredient;

public interface IngredientService {

    Ingredient getIngredientByNameIgnoreCase(String name);

}
