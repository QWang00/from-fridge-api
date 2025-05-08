package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.DuplicateItemException;
import org.junit.jupiter.api.Nested;
import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.repository.FridgeIngredientRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class FridgeIngredientServiceImplTest {

    @Mock
    private FridgeIngredientRepository fridgeIngredientRepository;

    @Mock
    private IngredientService ingredientService;

    @InjectMocks
    private FridgeIngredientServiceImpl fridgeIngredientService;

    @Nested
    class AddIngredientToFridge {
        @Test
        @DisplayName("Should add ingredient to fridge if not already present")
        void IngredientNotInFridge() {

            String ingredientName = "Tomato";
            Ingredient ingredient = new Ingredient();
            ingredient.setId(1);
            ingredient.setName("Tomato");

            Mockito.when(ingredientService.getIngredientByNameIgnoreCase(ingredientName))
                    .thenReturn(ingredient);
            Mockito.when(fridgeIngredientRepository.existsByIngredientId(ingredient.getId()))
                    .thenReturn(false);

            Mockito.when(fridgeIngredientRepository.save(Mockito.any(FridgeIngredient.class)))
                    .thenReturn(new FridgeIngredient(ingredient.getId(), ingredient));

            FridgeIngredient result = fridgeIngredientService.addIngredientToFridge(ingredientName);

            assertNotNull(result);
            assertEquals(ingredient.getName(), result.getIngredient().getName());
            Mockito.verify(fridgeIngredientRepository).save(Mockito.any(FridgeIngredient.class));
            Mockito.verify(ingredientService).getIngredientByNameIgnoreCase(ingredientName);
        }

        @Test
        @DisplayName("Should throw DuplicateItemException if ingredient is already in the fridge")
        void IngredientAlreadyInFridge() {

            String ingredientName = "Tomato";
            Ingredient ingredient = new Ingredient();
            ingredient.setId(1);
            ingredient.setName("Tomato");

            Mockito.when(ingredientService.getIngredientByNameIgnoreCase(ingredientName))
                    .thenReturn(ingredient);
            Mockito.when(fridgeIngredientRepository.existsByIngredientId(ingredient.getId()))
                    .thenReturn(true);

            DuplicateItemException exception = assertThrows(DuplicateItemException.class, () ->
                    fridgeIngredientService.addIngredientToFridge(ingredientName)
            );

            assertEquals(String.format("Ingredient [%s] already exists in the fridge.", ingredientName), exception.getMessage());
            Mockito.verify(fridgeIngredientRepository, Mockito.never()).save(Mockito.any());
            Mockito.verify(ingredientService).getIngredientByNameIgnoreCase(ingredientName);
        }
    }


}
