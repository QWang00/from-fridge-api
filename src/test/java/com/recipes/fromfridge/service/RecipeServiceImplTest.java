package com.recipes.fromfridge.service;

import com.recipes.fromfridge.dto.RecipeDetailDto;
import com.recipes.fromfridge.dto.RecipePreviewResponse;
import com.recipes.fromfridge.exception.DuplicateItemException;
import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.Ingredient;
import com.recipes.fromfridge.model.Recipe;
import com.recipes.fromfridge.model.RecipeIngredient;
import com.recipes.fromfridge.repository.RecipeRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.junit.jupiter.api.Nested;
import com.recipes.fromfridge.dto.IngredientDetailDto;
import java.util.*;
import java.util.stream.Collectors;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyList;
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

        @Test
        @DisplayName("Should throw DuplicateItemException when duplicate ingredients contain spaces")
        void duplicateIngredientsWithSpaces() {
            List<String> ingredients = List.of("egg ", " egg");

            when(ingredientService.getIngredientByNameIgnoreCase(anyString()))
                    .thenReturn(new Ingredient(1, "egg"));

            DuplicateItemException exception = assertThrows(DuplicateItemException.class, () -> {
                recipeService.searchRecipesByIngredientNames(ingredients);
            });

            assertEquals("Ingredient [ egg] already exists, please try again.", exception.getMessage());
        }

        @Test
        @DisplayName("Should throw ItemNotFoundException when ingredient list is empty")
        void emptyIngredientList() {
            List<String> ingredients = List.of();

            ItemNotFoundException exception = assertThrows(ItemNotFoundException.class, () -> {
                recipeService.searchRecipesByIngredientNames(ingredients);
            });

            assertEquals("No recipe found matching the given ingredients.", exception.getMessage());
        }

        @Test
        @DisplayName("Should throw ItemNotFoundException when no recipes match the given ingredients")
        void noMatchingRecipesFound() {
            List<String> ingredients = List.of("egg", "milk");

            when(ingredientService.getIngredientByNameIgnoreCase("egg")).thenReturn(new Ingredient(1, "egg"));
            when(ingredientService.getIngredientByNameIgnoreCase("milk")).thenReturn(new Ingredient(2, "milk"));

            when(recipeRepository.findRecipesByIngredientIds(anyList())).thenReturn(Collections.emptyList());

            ItemNotFoundException exception = assertThrows(ItemNotFoundException.class, () -> {
                recipeService.searchRecipesByIngredientNames(ingredients);
            });

            assertEquals("No recipe found matching the given ingredients.", exception.getMessage());
        }

        @Test
        @DisplayName("Should return recipes sorted by matched ingredient count")
        void partiallyMatchedIngredients() {
            Ingredient egg = new Ingredient(1, "egg");
            Ingredient milk = new Ingredient(2, "milk");

            Recipe recipe1 = Recipe.builder()
                    .id(1)
                    .title("Omelette")
                    .imageUrl("img.jpg")
                    .ingredients(List.of(
                            RecipeIngredient.builder().ingredient(egg).build(),
                            RecipeIngredient.builder().ingredient(milk).build()
                    ))
                    .build();

            Recipe recipe2 = Recipe.builder()
                    .id(1)
                    .title("Boiled Egg")
                    .imageUrl("img2")
                    .ingredients(List.of(
                            RecipeIngredient.builder().ingredient(egg).build()
                    ))
                    .build();

            when(ingredientService.getIngredientByNameIgnoreCase("egg")).thenReturn(egg);
            when(ingredientService.getIngredientByNameIgnoreCase("milk")).thenReturn(milk);
            when(recipeRepository.findRecipesByIngredientIds(anyList()))
                    .thenReturn(List.of(recipe1, recipe2));

            List<RecipePreviewResponse> results = recipeService.searchRecipesByIngredientNames(List.of("egg", "milk"));

            assertEquals(2, results.size());
            assertEquals("Omelette", results.get(0).title());
            assertEquals("Boiled Egg", results.get(1).title());
            assertEquals(2, results.get(0).matchedCount());
            assertEquals(1, results.get(1).matchedCount());
        }

        @Test
        @DisplayName("Should return recipe with full ingredient match")
        void fullyMatchedIngredients() {
            Ingredient flour = new Ingredient(1, "flour");
            Ingredient egg = new Ingredient(2, "egg");

            Recipe pancake = Recipe.builder()
                    .id(1)
                    .title("Pancake")
                    .imageUrl("img")
                    .ingredients(List.of(
                            RecipeIngredient.builder().ingredient(flour).build(),
                            RecipeIngredient.builder().ingredient(egg).build()
                    ))
                    .build();

            when(ingredientService.getIngredientByNameIgnoreCase("flour")).thenReturn(flour);
            when(ingredientService.getIngredientByNameIgnoreCase("egg")).thenReturn(egg);
            when(recipeRepository.findRecipesByIngredientIds(anyList()))
                    .thenReturn(List.of(pancake));

            List<RecipePreviewResponse> results = recipeService.searchRecipesByIngredientNames(List.of("flour", "egg"));

            assertEquals(1, results.size());
            assertEquals("Pancake", results.get(0).title());
            assertEquals(2, results.get(0).matchedCount());
        }

        @Test
        @DisplayName("Should not include recipes with 0 matched ingredients")
        void unmatchedIngredients() {
            Ingredient egg = new Ingredient(1, "egg");
            Ingredient anchovy = new Ingredient(99, "anchovy");

            Recipe unrelatedRecipe = Recipe.builder()
                    .id(1)
                    .title("Anchovy Salad")
                    .imageUrl("url")
                    .ingredients(List.of(
                            RecipeIngredient.builder().ingredient(anchovy).build()
                    ))
                    .build();

            when(ingredientService.getIngredientByNameIgnoreCase("egg")).thenReturn(egg);
            when(recipeRepository.findRecipesByIngredientIds(anyList()))
                    .thenReturn(List.of(unrelatedRecipe));

            List<RecipePreviewResponse> result = recipeService.searchRecipesByIngredientNames(List.of("egg"));

            assertEquals(0, result.size());
        }

        @Test
        @DisplayName("Should return recipes with equal matched counts in consistent order")
        void equalMatchedCountRecipes() {
            Ingredient egg = new Ingredient(1, "egg");

            Recipe r1 = Recipe.builder()
                    .id(1)
                    .title("Dish A")
                    .imageUrl("imgA")
                    .ingredients(List.of(
                            RecipeIngredient.builder().ingredient(egg).build()
                    ))
                    .build();

            Recipe r2 = Recipe.builder()
                    .id(2)
                    .title("Dish B")
                    .imageUrl("imgB")
                    .ingredients(List.of(
                            RecipeIngredient.builder().ingredient(egg).build()
                    ))
                    .build();

            when(ingredientService.getIngredientByNameIgnoreCase("egg")).thenReturn(egg);
            when(recipeRepository.findRecipesByIngredientIds(anyList()))
                    .thenReturn(List.of(r1, r2));

            List<RecipePreviewResponse> result = recipeService.searchRecipesByIngredientNames(List.of("egg"));

            assertEquals(2, result.size());
            assertEquals(1, result.get(0).matchedCount());
            assertEquals(1, result.get(1).matchedCount());
            assertTrue(Set.of("Dish A", "Dish B").contains(result.get(0).title()));
        }

    }

    @Nested
    class GetRecipeDetailById {

        private Recipe buildRecipeWithIngredients(String... names) {
            List<RecipeIngredient> ingredients =
                    List.of(names).stream()
                            .map(name -> RecipeIngredient.builder()
                                    .ingredient(new Ingredient(null, name))
                                    .quantity("1 cup")
                                    .preparation("chopped")
                                    .build())
                            .collect(Collectors.toList());

            return Recipe.builder()
                    .id(1)
                    .title("Sample Recipe")
                    .imageUrl("sample.jpg")
                    .servings(2)
                    .difficulty("Easy")
                    .cookTime(30)
                    .description("Sample description")
                    .method(List.of("Step 1", "Step 2"))
                    .ingredients(ingredients)
                    .build();
        }

        @Test
        @DisplayName("Should return recipe with 2 matched ingredients correctly marked")
        void matchedIngredientsProperlyMarked() {
            Recipe recipe = buildRecipeWithIngredients("Egg", "Milk", "Sugar");

            when(recipeRepository.findById(1)).thenReturn(Optional.of(recipe));

            List<String> matched = List.of("egg", "milk");

            RecipeDetailDto result = recipeService.getRecipeDetailById(1, matched);

            assertEquals(2, result.matchedCount());
            assertTrue(result.ingredients().stream()
                    .filter(i -> i.name().equalsIgnoreCase("Egg") || i.name().equalsIgnoreCase("Milk"))
                    .allMatch(IngredientDetailDto::owned));
            assertTrue(result.ingredients().stream()
                    .filter(i -> i.name().equalsIgnoreCase("Sugar"))
                    .allMatch(i -> !i.owned()));
        }

        @Test
        @DisplayName("Should return recipe with all ingredients matched")
        void allIngredientsMatched() {
            Recipe recipe = buildRecipeWithIngredients("Egg", "Milk");

            when(recipeRepository.findById(1)).thenReturn(Optional.of(recipe));

            List<String> matched = List.of("egg", "milk");

            RecipeDetailDto result = recipeService.getRecipeDetailById(1, matched);

            assertEquals(2, result.matchedCount());
            assertTrue(result.ingredients().stream().allMatch(IngredientDetailDto::owned));
        }


        @Test
        @DisplayName("Should match ingredients case-insensitively")
        void caseInsensitiveMatching() {
            Recipe recipe = buildRecipeWithIngredients("Egg");

            when(recipeRepository.findById(1)).thenReturn(Optional.of(recipe));

            List<String> matched = List.of("egg");

            RecipeDetailDto result = recipeService.getRecipeDetailById(1, matched);

            assertEquals(1, result.matchedCount());
            assertTrue(result.ingredients().get(0).owned());
        }


        @Test
        @DisplayName("Should throw ItemNotFoundException if recipe not found")
        void recipeNotFound() {
            when(recipeRepository.findById(999)).thenReturn(Optional.empty());

            assertThrows(ItemNotFoundException.class, () -> recipeService.getRecipeDetailById(999, List.of("egg")));
        }

    }
}