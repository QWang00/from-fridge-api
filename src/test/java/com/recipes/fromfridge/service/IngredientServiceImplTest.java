package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.repository.IngredientRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;
import java.util.Optional;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Nested;

@SpringBootTest
class IngredientServiceImplTest {

    @Mock
    private IngredientRepository ingredientRepository;

    @InjectMocks
    private IngredientServiceImpl ingredientService;

    @Nested
    class GetIngredientByNameIgnoreCase {

        @Test
        @DisplayName("Should return ingredient when found by name ignoring case")
        void shouldReturnIngredientWhenFound() {
            String ingredientName = "Tomato";
            Ingredient ingredient = new Ingredient();
            ingredient.setName(ingredientName);

            Mockito.when(ingredientRepository.findByNameIgnoreCase(ingredientName))
                    .thenReturn(Optional.of(ingredient));

            Ingredient result = ingredientService.getIngredientByNameIgnoreCase(ingredientName);

            assertNotNull(result);
            assertEquals(ingredientName, result.getName());
        }

        @Test
        @DisplayName("Should throw ItemNotFoundException when ingredient not found")
        void shouldThrowExceptionWhenNotFound() {
            String ingredientName = "Potato";

            Mockito.when(ingredientRepository.findByNameIgnoreCase(ingredientName))
                    .thenReturn(Optional.empty());

            ItemNotFoundException exception = assertThrows(ItemNotFoundException.class, () ->
                    ingredientService.getIngredientByNameIgnoreCase(ingredientName)
            );

            assertEquals(String.format("Ingredient [%s] not recognized, please try again", ingredientName),
                    exception.getMessage());
        }

        @Test
        @DisplayName("Should trim the ingredient name before searching")
        void shouldTrimNameBeforeSearching() {
            String ingredientNameWithSpaces = "  Tomato  ";
            Ingredient ingredient = new Ingredient();
            ingredient.setName("Tomato");

            Mockito.when(ingredientRepository.findByNameIgnoreCase("Tomato"))
                    .thenReturn(Optional.of(ingredient));

            Ingredient result = ingredientService.getIngredientByNameIgnoreCase(ingredientNameWithSpaces);

            assertNotNull(result);
            assertEquals("Tomato", result.getName());
        }

        @Test
        @DisplayName("Should return ingredient regardless of input case")
        void shouldReturnIngredientRegardlessOfCase() {
            String ingredientNameLower = "tomato";
            String ingredientNameUpper = "TOMATO";
            String ingredientNameMixed = "ToMaTo";
            Ingredient ingredient = new Ingredient();
            ingredient.setName("Tomato");

            Mockito.when(ingredientRepository.findByNameIgnoreCase(Mockito.anyString()))
                    .thenReturn(Optional.of(ingredient));

            Ingredient resultLower = ingredientService.getIngredientByNameIgnoreCase(ingredientNameLower);
            Ingredient resultUpper = ingredientService.getIngredientByNameIgnoreCase(ingredientNameUpper);
            Ingredient resultMixed = ingredientService.getIngredientByNameIgnoreCase(ingredientNameMixed);

            assertNotNull(resultLower);
            assertEquals("Tomato", resultLower.getName());

            assertNotNull(resultUpper);
            assertEquals("Tomato", resultUpper.getName());

            assertNotNull(resultMixed);
            assertEquals("Tomato", resultMixed.getName());
        }
    }
}
