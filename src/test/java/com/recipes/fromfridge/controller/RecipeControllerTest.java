package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.dto.RecipePreviewResponse;
import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.service.RecipeService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Nested;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(RecipeController.class)
class RecipeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private RecipeService recipeService;

    @Nested
    class SearchRecipesByIngredientNames {

        @Test
        @DisplayName("Should return 400 Bad Request when no ingredients are provided")
        void noIngredientsProvided() throws Exception {
            mockMvc.perform(get("/api/v1/from-fridge/recipes/search"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("Should return 200 and recipe preview list when ingredients are valid")
        void ingredientsAreValid() throws Exception {
            List<RecipePreviewResponse> mockResponse = List.of(
                    new RecipePreviewResponse("Omelette", "img.jpg", 2),
                    new RecipePreviewResponse("Boiled Egg", "img2.jpg", 1)
            );

            when(recipeService.searchRecipesByIngredientNames(List.of("egg", "milk")))
                    .thenReturn(mockResponse);

            mockMvc.perform(get("/api/v1/from-fridge/recipes/search")
                            .param("ingredientNames", "egg", "milk"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(2))
                    .andExpect(jsonPath("$[0].title").value("Omelette"))
                    .andExpect(jsonPath("$[0].imageUrl").value("img.jpg"))
                    .andExpect(jsonPath("$[0].matchedCount").value(2));
        }

        @Test
        @DisplayName("Should return 404 when no matching recipes found")
        void noMatchingRecipesFound() throws Exception {
            when(recipeService.searchRecipesByIngredientNames(List.of("egg", "milk")))
                    .thenThrow(new ItemNotFoundException("No recipe found matching the given ingredients."));

            mockMvc.perform(get("/api/v1/from-fridge/recipes/search")
                            .param("ingredientNames", "egg", "milk"))
                    .andExpect(status().isNotFound());
        }




    }

}