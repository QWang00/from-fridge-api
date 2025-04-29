package com.recipes.fromfridge.service;

import com.recipes.fromfridge.model.Ingredient;

import java.util.Optional;

public interface IngredientService {

    Ingredient findByNameIgnoreCase(String name);

}
