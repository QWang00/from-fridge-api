package com.recipes.fromfridge.repository;

import com.recipes.fromfridge.model.Ingredient;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface IngredientRepository extends CrudRepository<Ingredient, Integer> {
    Optional<Ingredient> findByNameIgnoreCase(String name);

}
