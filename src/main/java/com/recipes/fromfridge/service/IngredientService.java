package com.recipes.fromfridge.service;

import com.recipes.fromfridge.model.Ingredient;

import java.util.List;

public interface IngredientService {

    Ingredient getIngredientByNameIgnoreCase(String name);

    List<Ingredient> searchIngredients(String query);


}
