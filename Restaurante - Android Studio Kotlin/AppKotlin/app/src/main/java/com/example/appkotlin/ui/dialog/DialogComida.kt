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
import com.example.appkotlin.ui.home.HomeFragment
import com.example.appkotlin.util.Comunicacion
import com.example.appkotlin.util.Util
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import java.io.File
import retrofit2.Callback
import retrofit2.Response

class DialogComida(
    context: Context,
    private val activity: Activity?,
    private val menu: Menu?,
    private val id_restaurante: Int,
    private val fragment: HomeFragment
) : Dialog(context) {

    lateinit var imageView: ImageView
    lateinit var btnTomarFoto: Button
    lateinit var edtNombre: EditText
    lateinit var edtPrecio: EditText
    lateinit var edtDescripcion: EditText
    lateinit var btnGuardar: AppCompatButton
    lateinit var btnCancelar: AppCompatButton
    lateinit var tvTItulo: TextView

    private var progressDialog: ProgressDialog? = null
    private var foto: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.dialog_alta_comida)

        // Configura el ancho del diálogo para que ocupe todo el ancho de la pantalla
        window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        window?.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)

        imageView = findViewById(R.id.imageView2)
        btnTomarFoto = findViewById(R.id.btnTomarFoto)
        edtNombre = findViewById(R.id.edtNombre)
        edtPrecio = findViewById(R.id.edtPrecio)
        edtDescripcion = findViewById(R.id.edtDescripcion)
        btnGuardar = findViewById(R.id.btnGuardar)
        btnCancelar = findViewById(R.id.btnCancelar)
        tvTItulo = findViewById(R.id.tvTitulo)
        foto = Util.decodeBase64FromImageView(context, R.drawable.plato)

        println("valor: " + foto)
        tvTItulo.setText("Nuevo " + menu?.nombre)
        btnTomarFoto.setOnClickListener {
            val com = object : Comunicacion {
                override fun onClick(menu: Menu) {
                    TODO("Not yet implemented")
                }

                override fun onBitmap(bitmap: Bitmap) {
                    foto = Util.bitmapToBase64(bitmap)!!
                }

            }

            (activity as MainRestauranteActivity).dispatchPickImageIntent(imageView, com)
        }

        btnCancelar.setOnClickListener {
            dismiss()
        }

        btnGuardar.setOnClickListener {
            val idMenu = menu?.id ?: 0
            val idRestaurante = id_restaurante
            val nombre = edtNombre.text.toString().trim()
            val descripcion = edtDescripcion.text.toString().trim()
            val precio = edtPrecio.text.toString().toDouble()
            val comida = Comida(-1, nombre, idMenu, precio, foto, descripcion)
            val nombre_menu = menu?.nombre ?: "ninguno"
            val gestor = Gestor()

            val JSON = Util.getData(context)
            val jsonObject = JSONObject(JSON)
            val usuario: String = jsonObject.getString("usuario")
            val password: String = jsonObject.getString("password")

            showProgressDialog()
            gestor.insertar(comida, idRestaurante, nombre_menu, usuario, password)
                .enqueue(object : Callback<ResponseBody> {
                    override fun onResponse(
                        call: Call<ResponseBody>,
                        response: Response<ResponseBody>
                    ) {
                        dismissProgressDialog()
                        if (response.isSuccessful) {
                            val responseBody = response.body()?.string()

                            println(responseBody)

                            responseBody?.let {
                                val jsonObject = JSONObject(responseBody)
                                val acceso = jsonObject.getString("acceso").toBoolean()
                                val msg = jsonObject.getString("msg")

                                if (acceso) {
                                    dismiss()
                                    Toast.makeText(context, "Guardado!", Toast.LENGTH_LONG).show()
                                    fragment.cargarInformacion()
                                } else {
                                    Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
                                }
                            }

                        } else {
                            dismissProgressDialog()
                            val msg = "Error: consulta sin exito!"
                            Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
                        }
                    }

                    override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                        val msg = "Error: onFailure!"
                        Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
                        t.printStackTrace()
                        dismissProgressDialog()
                    }

                })
        }
    }

    private fun showProgressDialog() {
        progressDialog = ProgressDialog(context)
        progressDialog?.setMessage("Guardando...") // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }
}
