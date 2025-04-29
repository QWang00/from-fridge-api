package com.recipes.fromfridge.controller;

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
        fridgeIngredientService.removeIngredientFromFridge(id);
        return new ResponseEntity<>("Ingredient removed from fridge.", HttpStatus.OK);
    }

    @DeleteMapping("/ingredients")
    public ResponseEntity<String> clearFridge(){
        fridgeIngredientService.clearFridge();
        return new ResponseEntity<>("Fridge cleared!", HttpStatus.OK);
    }

    @PostMapping("/ingredient")
    public ResponseEntity<FridgeIngredient> addIngredientToFridge(@RequestParam String ingredient){
        return new ResponseEntity<>(fridgeIngredientService.addIngredientToFridge(ingredient), HttpStatus.OK);
    }


}
