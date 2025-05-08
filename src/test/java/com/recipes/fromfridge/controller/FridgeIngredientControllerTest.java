package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.service.FridgeIngredientService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import java.util.Collections;
import java.util.List;
import static org.hamcrest.Matchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
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
        @DisplayName("Should return empty list if fridge is empty")
        void emptyFridge() throws Exception {
            when(fridgeIngredientService.getAllFridgeIngredients())
                    .thenReturn(Collections.emptyList());

            mockMvc.perform(get("/api/v1/fridge/ingredients"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(0)));
        }

        @Test
        @DisplayName("Should return one ingredient when there are ingredients in the fridge")
        void contentInFridge() throws Exception {
            FridgeIngredient fridgeIngredient = new FridgeIngredient();
            Ingredient ingredient = new Ingredient();
            ingredient.setId(1);
            ingredient.setName("Tomato");
            fridgeIngredient.setIngredient(ingredient);

            when(fridgeIngredientService.getAllFridgeIngredients())
                    .thenReturn(List.of(fridgeIngredient));

            mockMvc.perform(get("/api/v1/fridge/ingredients"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(1)))
                    .andExpect(jsonPath("$[0].ingredient.id").value(1))
                    .andExpect(jsonPath("$[0].ingredient.name").value("Tomato"));
        }
    }
}