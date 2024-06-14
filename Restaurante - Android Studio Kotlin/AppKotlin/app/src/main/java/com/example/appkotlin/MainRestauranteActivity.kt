package com.example.appkotlin

import android.Manifest
import android.app.Activity
import android.app.ProgressDialog
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.view.Menu
import android.view.MenuItem
import android.widget.ImageView
import android.widget.Toast
import com.google.android.material.bottomnavigation.BottomNavigationView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.example.appkotlin.controlador.Gestor
import com.example.appkotlin.databinding.ActivityMainRestauranteBinding
import com.example.appkotlin.model.Comida
import com.example.appkotlin.util.Comunicacion
import com.example.appkotlin.util.Util
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MainRestauranteActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainRestauranteBinding
    private lateinit var imageView: ImageView
    private lateinit var com : Comunicacion
    private val REQUEST_CAMERA_PERMISSION = 2
    private val REQUEST_IMAGE_PICK = 1
    private var progressDialog: ProgressDialog? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainRestauranteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val navView: BottomNavigationView = binding.navView

        val navController = findNavController(R.id.nav_host_fragment_activity_main_restaurante)

        navView.setupWithNavController(navController)

        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.CAMERA
            ) != PackageManager.PERMISSION_GRANTED ||
            ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE),
                REQUEST_CAMERA_PERMISSION
            )
        }

        supportActionBar?.apply {
            title = "" // Establecer texto vacío
            setBackgroundDrawable(ContextCompat.getDrawable(this@MainRestauranteActivity, android.R.color.transparent)) // Fondo transparente
        }
    }

    fun dispatchPickImageIntent(img: ImageView, comuni: Comunicacion) {
        imageView = img
        com = comuni
        Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI).also { pickImageIntent ->
            startActivityForResult(pickImageIntent, REQUEST_IMAGE_PICK)
        }
    }

    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?, context: Context) {
        if (requestCode == REQUEST_IMAGE_PICK && resultCode == Activity.RESULT_OK) {
            data?.data?.let { uri ->
                imageView.setImageURI(uri)
                // Opcional: si necesitas obtener la imagen como Bitmap o realizar alguna otra operación
                val bitmap = MediaStore.Images.Media.getBitmap(context.contentResolver, uri)
                com.onBitmap(bitmap)
            }
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        handleActivityResult(requestCode, resultCode, data, this)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_eliminar_cuenta -> {
                eliminarCuenta()
                true
            }
            R.id.action_salir -> {
                finish()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    private fun eliminarCuenta(){

        val JSON = Util.getData(this)
        val jsonObject = JSONObject(JSON)
        val usuario: String = jsonObject.getString("usuario")
        val password: String = jsonObject.getString("password")

        val gestor = Gestor()

        showProgressDialog("Procesando...")
        gestor.eliminarCuenta(usuario , password).enqueue(object : Callback<ResponseBody>{
            override fun onResponse(call: Call<ResponseBody>, response: Response<ResponseBody>) {
                dismissProgressDialog()
                if (response.isSuccessful) {
                    val responseBody = response.body()?.string()
                    println("info: " + responseBody)

                    responseBody?.let {
                        val jsonObject = JSONObject(responseBody)
                        val acceso = jsonObject.getString("acceso").toBoolean()
                        val msg = jsonObject.getString("msg")

                        if (acceso) {
                           this@MainRestauranteActivity.finish()
                            Toast.makeText(applicationContext, msg, Toast.LENGTH_LONG).show()
                        } else {
                            Toast.makeText(applicationContext, msg, Toast.LENGTH_LONG).show()
                        }
                    }

                } else {
                    val msg = "Error: el proceso de eliminacion ha fallado!"
                    Toast.makeText(this@MainRestauranteActivity, msg, Toast.LENGTH_LONG).show()
                }
            }

            override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                val msg = "Error: onFailure!"
                Toast.makeText(this@MainRestauranteActivity, msg, Toast.LENGTH_LONG).show()
                t.printStackTrace()
                dismissProgressDialog()
            }

        })
    }

    private fun showProgressDialog(msg : String) {
        progressDialog = ProgressDialog(this)
        progressDialog?.setMessage(msg) // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }
}