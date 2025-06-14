package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.repository.FridgeIngredientRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FridgeIngredientServiceImpl implements FridgeIngredientService{

    private final FridgeIngredientRepository fridgeIngredientRepository;
    private final IngredientService ingredientService;

    public FridgeIngredientServiceImpl(FridgeIngredientRepository fridgeIngredientRepository, IngredientService ingredientService) {
        this.fridgeIngredientRepository = fridgeIngredientRepository;
        this.ingredientService = ingredientService;
    }

    @Override
    public FridgeIngredient addIngredientToFridge(String ingredientName) {
        Ingredient ingredient = ingredientService.getIngredientByNameIgnoreCase(ingredientName);
        boolean ingredientInFridge = fridgeIngredientRepository.existsByIngredientId(ingredient.getId());
        if(ingredientInFridge){
            throw new DuplicateItemException(
                    String.format("Ingredient [%s] already exists in the fridge.", ingredientName)
            );
        }
        FridgeIngredient fridgeIngredient = new FridgeIngredient();
        fridgeIngredient.setIngredient(ingredient);
        return fridgeIngredientRepository.save(fridgeIngredient);
    }

    @Override
    public List<FridgeIngredient> getAllFridgeIngredients() {
        return fridgeIngredientRepository.findAll();
    }

    @Override
    public void removeIngredientFromFridge(Integer fridgeIngredientId) {
        boolean exists = fridgeIngredientRepository.existsById(fridgeIngredientId);
        if(!exists) throw new ItemNotFoundException("Ingredient not found in the fridge.");

        fridgeIngredientRepository.deleteById(fridgeIngredientId);
    }

    @Override
    public void clearFridge() {
        fridgeIngredientRepository.deleteAll();
    }
}
