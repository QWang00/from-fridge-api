package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.exception.ItemNotFoundException;
import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.service.FridgeIngredientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/v1/fridge")
public class FridgeIngredientController {
    private final FridgeIngredientService fridgeIngredientService;

    @Autowired
    public FridgeIngredientController(FridgeIngredientService fridgeIngredientService) {
        this.fridgeIngredientService = fridgeIngredientService;
    }

    @GetMapping("/ingredients")
    public ResponseEntity<List<FridgeIngredient>> getAllFridgeIngredients() {
        return new ResponseEntity<>(fridgeIngredientService.getAllFridgeIngredients(), HttpStatus.OK);
    }

    @DeleteMapping("/ingredient/{id}")
    public ResponseEntity<String> removeIngredientFromFridge (@PathVariable("id") Integer id){
        try {
            fridgeIngredientService.removeIngredientFromFridge(id);
            return new ResponseEntity<>("Ingredient removed from fridge.", HttpStatus.OK);
        } catch (ItemNotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/ingredients")
    public ResponseEntity<String> clearFridge(){
        try {
            fridgeIngredientService.clearFridge();
            return new ResponseEntity<>("Fridge cleared!", HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>("Error occurred while clearing the fridge", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/ingredient")
    public ResponseEntity<FridgeIngredient> addIngredientToFridge(@RequestParam String ingredient){
        return new ResponseEntity<>(fridgeIngredientService.addIngredientToFridge(ingredient), HttpStatus.OK);
    }


}
