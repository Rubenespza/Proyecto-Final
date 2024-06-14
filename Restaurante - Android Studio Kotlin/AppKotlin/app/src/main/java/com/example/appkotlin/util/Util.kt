package com.example.appkotlin.util

import android.content.Context
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.graphics.drawable.VectorDrawable
import android.util.Base64
import android.widget.ImageView
import androidx.core.content.ContextCompat
import java.io.ByteArrayOutputStream

object Util {
    private const val PREFS_NAME = "MyAppPrefs"
    private const val KEY_JSON = "json"

    fun drawableToBlob(context: Context, drawableResId: Int): String {
        val drawable = ContextCompat.getDrawable(context, drawableResId)
        val bitmap: Bitmap

        if (drawable is BitmapDrawable) {
            bitmap = drawable.bitmap
        } else if (drawable is VectorDrawable) {
            bitmap = getBitmapFromVectorDrawable(drawable)
        } else {
            throw IllegalArgumentException("Unsupported drawable type")
        }

        val byteArrayOutputStream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
        val byteArray = byteArrayOutputStream.toByteArray()
        return Base64.encodeToString(byteArray, Base64.DEFAULT)
    }

    // Helper function to convert VectorDrawable to Bitmap
    private fun getBitmapFromVectorDrawable(vectorDrawable: VectorDrawable): Bitmap {
        val bitmap = Bitmap.createBitmap(
            vectorDrawable.intrinsicWidth,
            vectorDrawable.intrinsicHeight,
            Bitmap.Config.ARGB_8888
        )
        val canvas = Canvas(bitmap)
        vectorDrawable.setBounds(0, 0, canvas.width, canvas.height)
        vectorDrawable.draw(canvas)
        return bitmap
    }


    fun imageViewToBlob(context: Context, imageView: ImageView): String {
        val drawable = imageView.drawable
        val bitmap: Bitmap

        if (drawable is BitmapDrawable) {
            bitmap = drawable.bitmap
        } else if (drawable is VectorDrawable) {
            bitmap = getBitmapFromVectorDrawable(drawable)
        } else {
            throw IllegalArgumentException("Unsupported drawable type")
        }

        val byteArrayOutputStream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
        val byteArray = byteArrayOutputStream.toByteArray()
        return Base64.encodeToString(byteArray, Base64.DEFAULT)
    }

    private fun getBitmapFromVectorDrawable(vectorDrawable: Drawable): Bitmap {
        val bitmap = Bitmap.createBitmap(
            vectorDrawable.intrinsicWidth,
            vectorDrawable.intrinsicHeight,
            Bitmap.Config.ARGB_8888
        )
        val canvas = Canvas(bitmap)
        vectorDrawable.setBounds(0, 0, canvas.width, canvas.height)
        vectorDrawable.draw(canvas)
        return bitmap
    }

    fun setImageFromBase64(imageView: ImageView, base64String: String?) {
        try {
            if (base64String != null) {
                val decodedString: ByteArray = Base64.decode(base64String, Base64.DEFAULT)
                val decodedByte: Bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size)
                val drawable = BitmapDrawable(imageView.resources, decodedByte)
                imageView.background = drawable
            } else {
                imageView.setBackgroundResource(0) // Remueve el fondo si base64String es null
            }
        } catch (e: IllegalArgumentException) {
            e.printStackTrace()
        }
    }

    fun decodeBase64FromImageView(imageView: ImageView): String? {
        return try {

            val backgroundDrawable = imageView.background as? BitmapDrawable
            backgroundDrawable?.let {
                val bitmap = it.bitmap
                val baos = ByteArrayOutputStream()
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, baos)
                val byteArray = baos.toByteArray()
                Base64.encodeToString(byteArray, Base64.DEFAULT)
            }
        } catch (e: Exception) {
            e.printStackTrace()
            null // Devuelve null en caso de error
        }
    }

    fun decodeBase64FromImageView(context: Context, id: Int): String? {
        return try {
            // Decodificar el recurso drawable en un objeto Bitmap
            val bitmap = BitmapFactory.decodeResource(context.resources, id)

            // Codificar el objeto Bitmap en una cadena Base64
            val byteArrayOutputStream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
            val byteArray = byteArrayOutputStream.toByteArray()
            Base64.encodeToString(byteArray, Base64.DEFAULT)
        } catch (e: Exception) {
            e.printStackTrace()
            null // Devuelve null en caso de error
        }
    }

    fun bitmapToBase64(bitmap: Bitmap): String? {
        return try {
            val baos = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, baos)
            val byteArray = baos.toByteArray()
            Base64.encodeToString(byteArray, Base64.DEFAULT)
        } catch (e: Exception) {
            e.printStackTrace()
            null // Devuelve null en caso de error
        }
    }

    fun saveData(context: Context, msg: String) {
        val sharedPreferences: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val editor = sharedPreferences.edit()

        editor.putString(KEY_JSON, msg)

        editor.apply()  // Use apply() for asynchronous saving
    }

    fun getData(context: Context?): String?{
        val sharedPreferences: SharedPreferences? = context?.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val msg = sharedPreferences?.getString(KEY_JSON, null)

        return msg
    }
}