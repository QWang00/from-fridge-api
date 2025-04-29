package com.recipes.fromfridge.repository;

import com.recipes.fromfridge.model.FridgeIngredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FridgeIngredientRepository extends JpaRepository<FridgeIngredient, Integer> {

    // Check if an ingredient is already in fridge
    boolean existsByIngredientId(Integer ingredientId);


}
