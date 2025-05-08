package com.recipes.fromfridge.repository;

import com.recipes.fromfridge.model.Ingredient;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.junit.jupiter.api.Nested;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@AutoConfigureMockMvc
class IngredientRepositoryTest {
    @Mock
    private IngredientRepository ingredientRepository;

    @Nested
    class FindByNameIgnoreCase {
        @Test
        @DisplayName("Should return the ingredient when searched with all capital letters")
        void ingredientWithAllCapitalLetters() {
            Ingredient ingredient = new Ingredient();
            ingredient.setName("Tomato");

            Mockito.when(ingredientRepository.findByNameIgnoreCase("TOMATO"))
                    .thenReturn(Optional.of(ingredient));

            Optional<Ingredient> result = ingredientRepository.findByNameIgnoreCase("TOMATO");

            assertTrue(result.isPresent());
            assertEquals("Tomato", result.get().getName());
        }

        @Test
        @DisplayName("Should return empty when there is no matching ingredient")
        @Transactional
        void noMatch() {
            assertEquals(0, ingredientRepository.count());

            Optional<Ingredient> result = ingredientRepository.findByNameIgnoreCase("Potato");
            assertFalse(result.isPresent());
        }
    }
}