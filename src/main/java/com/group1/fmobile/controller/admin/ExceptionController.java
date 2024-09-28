package com.group1.fmobile.controller.admin;

import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.io.FileNotFoundException;

@ControllerAdvice
public class ExceptionController {
    @ExceptionHandler(NullPointerException.class)
    public String nullPointer(Exception e){
        e.printStackTrace();
        return "admin/error";
    }
    @ExceptionHandler(IllegalArgumentException.class)
    public String IllegalArgument(Exception e){
        e.printStackTrace();
        return "admin/error";
    }
    @ExceptionHandler(FileNotFoundException.class)
    public String FileNotFound(Exception e){
        e.printStackTrace();
        return "admin/error";
    }
    @ExceptionHandler(InvalidDataAccessApiUsageException.class)
    public String InvalidDataAccessApiUsageException(Exception e){
        e.printStackTrace();
        return "admin/error";
    }
    @ExceptionHandler(Exception.class)
    public String Exception(Exception e){
        e.printStackTrace();
        return "admin/error";
    }

}
