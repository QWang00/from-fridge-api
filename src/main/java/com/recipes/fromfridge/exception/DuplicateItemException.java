package com.recipes.fromfridge.exception;

public class DuplicateItemException extends RuntimeException{
    public DuplicateItemException(String message){
        super(message);
    }
}
