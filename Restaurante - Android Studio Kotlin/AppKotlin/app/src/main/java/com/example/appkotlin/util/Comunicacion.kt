package com.example.appkotlin.util

import android.graphics.Bitmap
import com.example.appkotlin.model.Menu


interface Comunicacion {
    fun onClick(menu : Menu)

    fun onBitmap(bitmap : Bitmap)
}