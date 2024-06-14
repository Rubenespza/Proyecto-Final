package com.example.appkotlin.ui.dialog

import android.Manifest
import android.app.Activity
import android.app.Dialog
import android.app.ProgressDialog
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.widget.AppCompatButton
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.fragment.app.FragmentActivity
import com.example.appkotlin.LoginActivity
import com.example.appkotlin.MainRestauranteActivity
import com.example.appkotlin.R
import com.example.appkotlin.controlador.Gestor
import com.example.appkotlin.model.Comida
import com.example.appkotlin.model.Menu
import com.example.appkotlin.model.RegistroDataGeneral
import com.example.appkotlin.util.Comunicacion
import com.example.appkotlin.util.Util
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import java.io.File
import retrofit2.Callback
import retrofit2.Response

class DialogEdicion(
    context: Context,
    private val activity: Activity?,
    private val registro: RegistroDataGeneral
) : Dialog(context) {

    lateinit var imageView: ImageView
    lateinit var edtNombreComercio: EditText
    lateinit var edtDescripcion: EditText
    lateinit var edtPassword: EditText
    lateinit var edtNombreProp: EditText
    lateinit var edtApellidoProp: EditText
    lateinit var btnGuardar: AppCompatButton
    lateinit var btnCancelar: AppCompatButton
    lateinit var tvTitulo: TextView

    private var progressDialog: ProgressDialog? = null
    private var fotoDefault : String = Util.drawableToBlob(context, R.drawable.logo)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.dialog_editar_restaurante)

        // Configura el ancho del diálogo para que ocupe todo el ancho de la pantalla
        window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        window?.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)

        imageView = findViewById(R.id.imgFotoRestaurante)
        edtNombreComercio = findViewById(R.id.edtNombreComercio)
        edtDescripcion = findViewById(R.id.edtDescripcion)
        edtPassword = findViewById(R.id.edtPassword)
        edtNombreProp = findViewById(R.id.edtNombreProp)
        edtApellidoProp = findViewById(R.id.edtApellidoProp)
        btnGuardar = findViewById(R.id.btnGuardar)
        btnCancelar = findViewById(R.id.btnCancelar)
        tvTitulo = findViewById(R.id.tvTitulo)

        cargarInformacion()

        btnCancelar.setOnClickListener {
            dismiss()
        }

        btnGuardar.setOnClickListener {
            actualizarDatos()
        }
    }

    private fun cargarInformacion() {
        Util.setImageFromBase64(imageView, registro.restaurante.foto)

        fotoDefault = registro.restaurante.foto!!

        edtNombreComercio.setText(registro.restaurante.nombre)
        edtDescripcion.setText(registro.restaurante.descripcion)
        edtPassword.setText(registro.usuario.password)
        edtNombreProp.setText(registro.prestador.nombre)
        edtApellidoProp.setText(registro.prestador.apellido)
    }


    private fun actualizarDatos() {
        val nombreComercio = edtNombreComercio.text.toString().trim()
        val descripcion = edtDescripcion.text.toString().trim()
        val password = edtPassword.text.toString().trim()
        val nombreProp = edtNombreProp.text.toString().trim()
        val apellidoProp = edtApellidoProp.text.toString().trim()

        registro.restaurante.nombre = nombreComercio
        registro.restaurante.descripcion = descripcion

        registro.usuario.password = password
        registro.prestador.nombre = nombreProp
        registro.prestador.apellido = apellidoProp

        showProgressDialog("Procesando...")

        val gestor = Gestor()
        gestor.actualizarTablas(registro)
            .enqueue(object : Callback<ResponseBody> {
                override fun onResponse(
                    call: Call<ResponseBody>,
                    response: Response<ResponseBody>
                ) {
                    dismissProgressDialog()
                    if (response.isSuccessful) {
                        val responseBody = response.body()?.string()

                        println("response : " + responseBody)

                        responseBody?.let {
                            val jsonObject = JSONObject(responseBody)
                            val acceso = jsonObject.getString("acceso").toBoolean()
                            val msg = jsonObject.getString("msg")

                            if (acceso) {
                                dismiss()
                                Toast.makeText(context, "Actualizado!", Toast.LENGTH_LONG).show()
                            } else {
                                Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
                            }
                        }
                    } else {
                        dismissProgressDialog()
                        val msg = "Error: operacion sin éxito!"
                        Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
                    }
                }

                override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                    dismissProgressDialog()
                    Toast.makeText(context, "Error: ${t.message}", Toast.LENGTH_LONG).show()
                }
            })
    }

    private fun showProgressDialog(msg: String) {
        progressDialog = ProgressDialog(context)
        progressDialog?.setMessage(msg)
        progressDialog?.setCancelable(false)
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }

}
