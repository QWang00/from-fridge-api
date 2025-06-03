package com.recipes.fromfridge.service;

import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.exception.ItemNotFoundException;
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
import java.util.Arrays;
import java.util.List;

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

    @Nested
    class GetAllFridgeIngredients {
        @Test
        @DisplayName("Should return an empty list when fridge is empty")
        void emptyFridge() {
            Mockito.when(fridgeIngredientRepository.findAll()).thenReturn(Arrays.asList());

            List<FridgeIngredient> result = fridgeIngredientService.getAllFridgeIngredients();

            assertNotNull(result);
            assertTrue(result.isEmpty());
            Mockito.verify(fridgeIngredientRepository).findAll();
        }

        @Test
        @DisplayName("Should return a list with one ingredient when there is one ingredient in the fridge")
        void singleIngredientInFridge() {
            FridgeIngredient fridgeIngredient = new FridgeIngredient();
            Mockito.when(fridgeIngredientRepository.findAll()).thenReturn(Arrays.asList(fridgeIngredient));

            List<FridgeIngredient> result = fridgeIngredientService.getAllFridgeIngredients();

            assertNotNull(result);
            assertEquals(1, result.size());
            assertSame(fridgeIngredient, result.get(0));
            Mockito.verify(fridgeIngredientRepository).findAll();
        }

        @Test
        @DisplayName("Should return a list with multiple ingredients when there are multiple ingredients in the fridge")
        void multiIngredientInFridge() {

            FridgeIngredient fridgeIngredient1 = new FridgeIngredient();
            FridgeIngredient fridgeIngredient2 = new FridgeIngredient();
            Mockito.when(fridgeIngredientRepository.findAll()).thenReturn(Arrays.asList(fridgeIngredient1, fridgeIngredient2));

            List<FridgeIngredient> result = fridgeIngredientService.getAllFridgeIngredients();

            assertNotNull(result);
            assertEquals(2, result.size());
            assertSame(fridgeIngredient1, result.get(0));
            assertSame(fridgeIngredient2, result.get(1));
            Mockito.verify(fridgeIngredientRepository).findAll();
        }
    }

    @Nested
    class RemoveIngredientFromFridge {
        @Test
        @DisplayName("Should remove ingredient from fridge successfully")
        void shouldRemoveIngredientFromFridge() {

            Integer fridgeIngredientId = 1;
            Mockito.when(fridgeIngredientRepository.existsByIngredientId(fridgeIngredientId)).thenReturn(true);

            fridgeIngredientService.removeIngredientFromFridge(fridgeIngredientId);

            Mockito.verify(fridgeIngredientRepository).deleteById(fridgeIngredientId);
        }

        @Test
        @DisplayName("Should do nothing if ingredient is not in the fridge")
        void IngredientNotInFridge() {
            Integer fridgeIngredientId = 1;
            Mockito.when(fridgeIngredientRepository.existsByIngredientId(fridgeIngredientId)).thenReturn(false);

            ItemNotFoundException thrown = assertThrows(
                    ItemNotFoundException.class,
                    () -> fridgeIngredientService.removeIngredientFromFridge(fridgeIngredientId)
            );

            assertEquals("Ingredient not found in the fridge.", thrown.getMessage());
        }
    }

    @Nested
    class ClearFridge {
        @Test
        @DisplayName("Should do nothing if fridge is empty")
        void emptyFridge() {
            Mockito.when(fridgeIngredientRepository.findAll()).thenReturn(Arrays.asList());

            fridgeIngredientService.clearFridge();

            Mockito.verify(fridgeIngredientRepository).deleteAll();
        }

        @Test
        @DisplayName("Should remove the only ingredient in the fridge")
        void fridgeHasOneIngredient() {
            FridgeIngredient fridgeIngredient = new FridgeIngredient();
            Mockito.when(fridgeIngredientRepository.findAll()).thenReturn(Arrays.asList(fridgeIngredient));

            fridgeIngredientService.clearFridge();

            Mockito.verify(fridgeIngredientRepository).deleteAll();
        }

        @Test
        @DisplayName("Should remove all ingredients when there are multiple")
        void fridgeHasMultiIngredient() {
            FridgeIngredient fridgeIngredient1 = new FridgeIngredient();
            FridgeIngredient fridgeIngredient2 = new FridgeIngredient();
            Mockito.when(fridgeIngredientRepository.findAll()).thenReturn(Arrays.asList(fridgeIngredient1, fridgeIngredient2));

            fridgeIngredientService.clearFridge();

            Mockito.verify(fridgeIngredientRepository).deleteAll();
        }
    }
}


