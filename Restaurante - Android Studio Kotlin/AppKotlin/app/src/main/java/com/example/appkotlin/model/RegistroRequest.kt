package com.example.appkotlin.model

data class RegistroRequest(
    val usuario: Usuario,
    val prestador: Prestador,
    val restaurante: Restaurante
)
