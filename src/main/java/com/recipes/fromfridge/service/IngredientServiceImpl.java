package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.repository.IngredientRepository;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class IngredientServiceImpl implements IngredientService {
    private final IngredientRepository ingredientRepository;

    public IngredientServiceImpl(IngredientRepository ingredientRepository) {
        this.ingredientRepository = ingredientRepository;
    }


    @Override
    public Ingredient getIngredientByNameIgnoreCase(String name) {
         return ingredientRepository.findByNameIgnoreCase(name.trim())
                 .orElseThrow(()-> new ItemNotFoundException(
                         String.format("Ingredient [%s] not recognized, please try again", name)));
    }


}
