package com.recipes.fromfridge.service;

import com.recipes.fromfridge.model.FridgeIngredient;

import java.util.List;

public interface FridgeIngredientService {

    FridgeIngredient addIngredientToFridge(String ingredientName);

    List<FridgeIngredient> getAllFridgeIngredients();

    void removeIngredientFromFridge(Integer fridgeIngredientId);

    void clearFridge();

}
