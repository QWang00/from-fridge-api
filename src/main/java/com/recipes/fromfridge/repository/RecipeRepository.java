package com.recipes.fromfridge.repository;

import com.recipes.fromfridge.model.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RecipeRepository extends JpaRepository<Recipe, Integer> {
    @Query("SELECT DISTINCT r FROM Recipe r JOIN r.ingredients ri WHERE ri.ingredient.id IN :ingredientIds")
    List<Recipe> findRecipesByIngredientIds(@Param("ingredientIds") List<Integer> ingredientIds);
}
