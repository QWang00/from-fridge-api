package com.recipes.fromfridge.repository;

import com.recipes.fromfridge.model.FridgeIngredient;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FridgeIngredientRepository extends JpaRepository<FridgeIngredient, Long> {

    // Check if an ingredient is already in fridge
    boolean existsByIngredientId(Long ingredientId);

    // Find by ingredient ID
    List<FridgeIngredient> findByIngredientId(Long ingredientId);

    // Delete by ingredient ID
    void deleteByIngredientId(Long ingredientId);

}
