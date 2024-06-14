package com.example.appkotlin

import android.Manifest
import android.app.Activity
import android.app.ProgressDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.view.View
import android.widget.EditText
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import com.example.appkotlin.controlador.ApiService
import com.example.appkotlin.controlador.RetrofitCliente
import com.example.appkotlin.util.Util
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import java.io.File

class LoginActivity : AppCompatActivity() {

    private val apiService = RetrofitCliente.instance.create(ApiService::class.java)
    private var progressDialog: ProgressDialog? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


    }


    fun iniciarrSesion(view: View) {

        // Muestra el diálogo de progreso
        showProgressDialog()

        val correo = findViewById<EditText>(R.id.edtCorreo).text.trim().toString()
        val password = findViewById<EditText>(R.id.edtPassword).text.trim().toString()

        apiService.login(correo, password).enqueue(object : Callback<ResponseBody> {
            override fun onResponse(
                call: Call<ResponseBody>,
                response: retrofit2.Response<ResponseBody>
            ) {
                dismissProgressDialog()
                if (response.isSuccessful) {
                    val responseBody = response.body()?.string()
                    responseBody?.let {
                        Util.saveData(applicationContext, responseBody)

                        val jsonObject = JSONObject(responseBody)
                        val acceso = jsonObject.getString("acceso").toBoolean()
                        val msg = jsonObject.getString("msg")


                        if (acceso) {
                            val intent =
                                Intent(applicationContext, MainRestauranteActivity::class.java)
                            startActivity(intent)
                        } else {
                            Toast.makeText(applicationContext, msg, Toast.LENGTH_LONG).show()
                        }
                    }

                } else {
                    val msg = "Error: consulta sin exito!"
                    Toast.makeText(applicationContext, msg, Toast.LENGTH_LONG).show()
                }
            }

            override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                val msg = "Error: onFailure!"
                Toast.makeText(applicationContext, msg, Toast.LENGTH_LONG).show()
                t.printStackTrace()
                dismissProgressDialog()
            }
        })
    }

    fun registrar(view: View) {
        val intent = Intent(applicationContext, RegistrarActivity::class.java)
        startActivity(intent)
    }

    private fun showProgressDialog() {
        progressDialog = ProgressDialog(this)
        progressDialog?.setMessage("Verificando...") // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }



}
