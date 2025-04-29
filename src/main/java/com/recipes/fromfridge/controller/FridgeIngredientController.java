package com.recipes.fromfridge.controller;

import com.recipes.fromfridge.model.FridgeIngredient;
import com.recipes.fromfridge.service.FridgeIngredientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("api/v1/fridge")
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

}
