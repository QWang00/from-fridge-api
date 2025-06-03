package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.repository.RecipeRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.junit.jupiter.api.Nested;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@SpringBootTest
class RecipeServiceImplTest {

    @Mock
    private RecipeRepository recipeRepository;

    @Mock
    private IngredientServiceImpl ingredientService;

    @InjectMocks
    private RecipeServiceImpl recipeService;

    @Nested
    class SearchRecipesByIngredientNames  {

        @Test
        @DisplayName("Should throw IllegalArgumentException when more than 5 ingredients are entered")
        void moreThanFiveIngredientsProvided() {
            List<String> ingredients = List.of("egg", "milk", "flour", "sugar", "butter", "salt");

            IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
                recipeService.searchRecipesByIngredientNames(ingredients);
            });

            assertEquals("You can enter up to 5 ingredients.", exception.getMessage());
        }

        @Test
        @DisplayName("Should throw DuplicateItemException when duplicate ingredients are entered")
        void duplicateIngredientsProvided() {
            List<String> ingredients = List.of("egg", "egg");

            when(ingredientService.getIngredientByNameIgnoreCase(anyString()))
                    .thenReturn(new Ingredient(1, "egg"));

            DuplicateItemException exception = assertThrows(DuplicateItemException.class, () -> {
                recipeService.searchRecipesByIngredientNames(ingredients);
            });

            assertEquals("Ingredient [egg] already exists, please try again.", exception.getMessage());
        }

        @Test
        @DisplayName("Should throw DuplicateItemException when duplicate ingredients differ only in case")
        void duplicateIngredientsWithDifferentCase() {
            List<String> ingredients = List.of("Egg", "egg");

            when(ingredientService.getIngredientByNameIgnoreCase(anyString()))
                    .thenReturn(new Ingredient(1, "egg"));

            DuplicateItemException exception = assertThrows(DuplicateItemException.class, () -> {
                recipeService.searchRecipesByIngredientNames(ingredients);
            });

            assertEquals("Ingredient [egg] already exists, please try again.", exception.getMessage());
        }





    }

}