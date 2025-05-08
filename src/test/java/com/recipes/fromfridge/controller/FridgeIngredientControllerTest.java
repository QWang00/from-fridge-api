package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.service.FridgeIngredientService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import java.util.Collections;
import java.util.List;
import static org.hamcrest.Matchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(FridgeIngredientController.class)
public class FridgeIngredientControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private FridgeIngredientService fridgeIngredientService;

    @Nested
    class GetAllFridgeIngredients {
        @Test
        @DisplayName("Should return empty list and 200 status when fridge is empty")
        void emptyFridge() throws Exception {
            when(fridgeIngredientService.getAllFridgeIngredients())
                    .thenReturn(Collections.emptyList());

            mockMvc.perform(get("/api/v1/fridge/ingredients")
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(0)))
                    .andExpect(jsonPath("$").isArray());
        }

        @Test
        @DisplayName("Should return ingredient list and 200 status when fridge has contents")
        void contentInFridge() throws Exception {
            Ingredient ingredient = new Ingredient(1, "Tomato");
            FridgeIngredient fridgeIngredient = new FridgeIngredient();
            fridgeIngredient.setIngredient(ingredient);

            when(fridgeIngredientService.getAllFridgeIngredients())
                    .thenReturn(List.of(fridgeIngredient));

            mockMvc.perform(get("/api/v1/fridge/ingredients")
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(1)))
                    .andExpect(jsonPath("$[0].ingredient.id").value(1))
                    .andExpect(jsonPath("$[0].ingredient.name").value("Tomato"));
        }
    }

    @Nested
    class RemoveIngredientFromFridge {

        @Test
        @DisplayName("Should remove ingredient successfully when it exists in the fridge")
        void removeIngredientSuccessfully() throws Exception {
            Integer ingredientId = 1;

            doNothing().when(fridgeIngredientService).removeIngredientFromFridge(ingredientId);

            mockMvc.perform(delete("/api/v1/fridge/ingredient/{id}", ingredientId))
                    .andExpect(status().isOk())
                    .andExpect(content().string("Ingredient removed from fridge."));

            verify(fridgeIngredientService, times(1)).removeIngredientFromFridge(ingredientId);
        }

        @Test
        @DisplayName("Should return 404 if ingredient is not found in the fridge")
        void ingredientNotFound() throws Exception {
            Integer ingredientId = 1;

            doThrow(new ItemNotFoundException("Ingredient not found in the fridge.")).when(fridgeIngredientService).removeIngredientFromFridge(ingredientId);

            mockMvc.perform(delete("/api/v1/fridge/ingredient/{id}", ingredientId))
                    .andExpect(status().isNotFound())
                    .andExpect(content().string("Ingredient not found in the fridge."));

            verify(fridgeIngredientService, times(1)).removeIngredientFromFridge(ingredientId);
        }

        @Test
        @DisplayName("Should return 400 for invalid ingredient ID")
        void ingredientWithInvalidId() throws Exception {
            Integer invalidIngredientId = -1;

            doThrow(new IllegalArgumentException("Invalid ingredient ID")).when(fridgeIngredientService).removeIngredientFromFridge(invalidIngredientId);

            mockMvc.perform(delete("/api/v1/fridge/ingredient/{id}", invalidIngredientId))
                    .andExpect(status().isBadRequest())
                    .andExpect(content().string("Invalid ingredient ID"));

            verify(fridgeIngredientService, times(1)).removeIngredientFromFridge(invalidIngredientId);
        }
    }

    @Nested
    class ClearFridge {

        @Test
        @DisplayName("Should return success and 200 status when fridge is cleared successfully")
        void clearFridgeSuccessfully() throws Exception {
            doNothing().when(fridgeIngredientService).clearFridge();

            mockMvc.perform(delete("/api/v1/fridge/ingredients")
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isOk())
                    .andExpect(content().string("Fridge cleared!"));

            verify(fridgeIngredientService, times(1)).clearFridge();
        }

        @Test
        @DisplayName("Should return success and 200 status when fridge is already empty")
        void clearEmptyFridge() throws Exception {
            doNothing().when(fridgeIngredientService).clearFridge();

            mockMvc.perform(delete("/api/v1/fridge/ingredients")
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isOk())
                    .andExpect(content().string("Fridge cleared!"));

            verify(fridgeIngredientService, times(1)).clearFridge();
        }

        @Test
        @DisplayName("Should return 404 if there is an issue clearing the fridge")
        void clearFridgeFailure() throws Exception {

            doThrow(new RuntimeException("Error occurred while clearing the fridge")).when(fridgeIngredientService).clearFridge();

            mockMvc.perform(delete("/api/v1/fridge/ingredients")
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isInternalServerError())
                    .andExpect(content().string("Error occurred while clearing the fridge"));


            verify(fridgeIngredientService, times(1)).clearFridge();
        }
    }

    @Nested
    class AddIngredientToFridge {

        @Test
        @DisplayName("Should successfully add ingredient to fridge")
        void addIngredientSuccessfully() throws Exception {
            String ingredientName = "Tomato";
            Ingredient ingredient = new Ingredient(1, "Tomato");
            FridgeIngredient fridgeIngredient = new FridgeIngredient();
            fridgeIngredient.setIngredient(ingredient);

            when(fridgeIngredientService.addIngredientToFridge(ingredientName)).thenReturn(fridgeIngredient);

            mockMvc.perform(post("/api/v1/fridge/ingredient")
                            .param("ingredient", ingredientName)
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.ingredient.id").value(1))
                    .andExpect(jsonPath("$.ingredient.name").value("Tomato"));

            verify(fridgeIngredientService, times(1)).addIngredientToFridge(ingredientName);
        }

        @Test
        @DisplayName("Should return 409 if ingredient already exists in the fridge")
        void ingredientAlreadyExists() throws Exception {
            String ingredientName = "Tomato";

            doThrow(new DuplicateItemException("Ingredient [Tomato] already exists in the fridge."))
                    .when(fridgeIngredientService).addIngredientToFridge(ingredientName);

            mockMvc.perform(post("/api/v1/fridge/ingredient")
                            .param("ingredient", ingredientName)
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isConflict())
                    .andExpect(content().string("Ingredient [Tomato] already exists in the fridge."));

            verify(fridgeIngredientService, times(1)).addIngredientToFridge(ingredientName);
        }

        @Test
        @DisplayName("Should return 404 if ingredient is not found in the database")
        void ingredientNotFound() throws Exception {
            String ingredientName = "Tomato";

            doThrow(new ItemNotFoundException("Ingredient not found in the database."))
                    .when(fridgeIngredientService).addIngredientToFridge(ingredientName);

            mockMvc.perform(post("/api/v1/fridge/ingredient")
                            .param("ingredient", ingredientName)
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isNotFound())
                    .andExpect(content().string("Ingredient not found in the database."));

            verify(fridgeIngredientService, times(1)).addIngredientToFridge(ingredientName);
        }

        @Test
        @DisplayName("Should return 400 for invalid ingredient name")
        void invalidIngredientName() throws Exception {
            String invalidIngredientName = "";

            doThrow(new IllegalArgumentException("Invalid ingredient name"))
                    .when(fridgeIngredientService).addIngredientToFridge(invalidIngredientName);

            mockMvc.perform(post("/api/v1/fridge/ingredient")
                            .param("ingredient", invalidIngredientName)
                            .contentType(MediaType.APPLICATION_JSON))
                    .andExpect(status().isBadRequest())
                    .andExpect(content().string("Invalid ingredient name"));

            verify(fridgeIngredientService, times(1)).addIngredientToFridge(invalidIngredientName);
        }
    }
}
