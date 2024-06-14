package com.example.appkotlin.model

data class RegistroRequestComida (
    val comida: Comida,
    val id_restaurante: Int,
    val menu : String,
    val usuario : String,
    val password : String
)