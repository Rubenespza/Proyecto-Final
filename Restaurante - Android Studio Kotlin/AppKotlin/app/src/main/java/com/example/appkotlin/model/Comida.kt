package com.example.appkotlin.model

data class Comida(
    val id: Int = -1,
    val nombre: String = "sin nombre",
    val idMenu: Int = -1,
    val precio: Double = 0.0,
    val foto: String? = "",
    val descripcion: String = "sin descripcion"
)
