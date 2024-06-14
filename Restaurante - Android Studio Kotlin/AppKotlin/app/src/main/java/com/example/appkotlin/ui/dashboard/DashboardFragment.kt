package com.example.appkotlin.ui.dashboard

import android.app.ProgressDialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.appkotlin.controlador.Gestor
import com.example.appkotlin.databinding.FragmentDashboardBinding
import com.example.appkotlin.model.Menu
import com.example.appkotlin.model.RegistroDataGeneral
import com.example.appkotlin.model.Restaurante
import com.example.appkotlin.ui.dialog.DialogEdicion
import com.example.appkotlin.util.Util
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class DashboardFragment : Fragment() {

    private var _binding: FragmentDashboardBinding? = null
    private val binding get() = _binding!!
    private var progressDialog: ProgressDialog? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentDashboardBinding.inflate(inflater, container, false)
        val root: View = binding.root

        configurar()
        cargarInformacion()
        return root
    }

    fun configurar() {
        binding.btnEditar.setOnClickListener {
            val gestor = Gestor()
            val JSON = Util.getData(context)
            val jsonObject = JSONObject(JSON)
            val usuario: String = jsonObject.getString("usuario")
            val password: String = jsonObject.getString("password")

            showProgressDialog("Procesando...")
            gestor.obtenerDatosGeneral(usuario, password).enqueue(object : Callback<ResponseBody> {
                override fun onResponse(
                    call: Call<ResponseBody>,
                    response: Response<ResponseBody>
                ) {
                    dismissProgressDialog()

                    if (response.isSuccessful) {
                        val responseBody = response.body()?.string()
                        responseBody?.let {
                            var jsonObject = JSONObject(responseBody)
                            val json = jsonObject.getString("obj")

                            val objType = object : TypeToken<RegistroDataGeneral>() {}.type
                            val objRegistro: RegistroDataGeneral = Gson().fromJson(json, objType)

                            val dialog = DialogEdicion(context!!, activity, objRegistro)
                            dialog.show()
                        }

                    } else {
                        val msg = "Error: la informacion no ha sido obtenida!"
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

    fun cargarInformacion() {
        showProgressDialog()
        val gestor = Gestor()
        val JSON = Util.getData(context)
        val jsonObject = JSONObject(JSON)
        val id_restaurante: Int = jsonObject.getInt("id_restaurante")
        val usuario: String = jsonObject.getString("usuario")
        val password: String = jsonObject.getString("password")

        gestor.obtenerDatosRestaurante(usuario, password, id_restaurante)
            .enqueue(object : Callback<ResponseBody> {
                override fun onResponse(
                    call: Call<ResponseBody>,
                    response: Response<ResponseBody>
                ) {
                    dismissProgressDialog()

                    if (response.isSuccessful) {
                        val responseBody = response.body()?.string()
                        responseBody?.let {
                            var jsonObject = JSONObject(responseBody)
                            val msg = jsonObject.getString("msg")

                            val listType = object : TypeToken<Restaurante>() {}.type
                            val objRestaurante: Restaurante = Gson().fromJson(msg, listType)

                            cargarPanel(objRestaurante)

                        }

                    } else {
                        val msg = "Error: la informacion no ha sido obtenida!"
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

    private fun cargarPanel(objRestaurante: Restaurante) {
        binding.tvNombreLocal.text = objRestaurante.nombre
        binding.tvDireccion.text = objRestaurante.direccion
        binding.tvTlefono.text = objRestaurante.telefono
        binding.tvFacebook.text = objRestaurante.facebook
        binding.tvDescripcion.text = objRestaurante.descripcion
        Util.setImageFromBase64(binding.imgRest, objRestaurante.foto)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun showProgressDialog() {
        progressDialog = ProgressDialog(context)
        progressDialog?.setMessage("Cargando...") // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun showProgressDialog(msg: String) {
        progressDialog = ProgressDialog(context)
        progressDialog?.setMessage(msg) // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }
}