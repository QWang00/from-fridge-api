package com.recipes.fromfridge.repository;


import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.model.Ingredient;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Nested;

@SpringBootTest
@AutoConfigureMockMvc
class FridgeIngredientRepositoryTest {

    @Mock
    private FridgeIngredientRepository fridgeIngredientRepository;

    @Nested
    class ExistsByIngredientId {

        @Test
        @DisplayName("Should return true when ingredient exists in the fridge")
        void ingredientExists() {

            Integer ingredientId = 1;
            Ingredient ingredient = new Ingredient();
            ingredient.setId(ingredientId);

            FridgeIngredient fridgeIngredient = new FridgeIngredient();
            fridgeIngredient.setIngredient(ingredient);

            Mockito.when(fridgeIngredientRepository.existsByIngredientId(ingredientId))
                    .thenReturn(true);

            boolean result = fridgeIngredientRepository.existsByIngredientId(ingredientId);
            assertTrue(result);
        }

        @Test
        @DisplayName("Should return false when ingredient does not exist in the fridge")
        @Transactional
        void ingredientDoesNotExist() {
            Integer ingredientId = 2;

            Mockito.when(fridgeIngredientRepository.existsByIngredientId(ingredientId))
                    .thenReturn(false);

            boolean result = fridgeIngredientRepository.existsByIngredientId(ingredientId);

            assertFalse(result);
        }
    }
}
