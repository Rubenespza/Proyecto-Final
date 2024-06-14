package com.example.appkotlin.ui.home

import android.app.ProgressDialog
import android.graphics.Bitmap
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.RecyclerView
import com.example.appkotlin.controlador.Gestor
import com.example.appkotlin.databinding.FragmentHomeBinding
import com.example.appkotlin.model.Comida
import com.example.appkotlin.model.Menu
import com.example.appkotlin.ui.adapter.ComidaAdapter
import com.example.appkotlin.ui.adapter.MenuAdapter
import com.example.appkotlin.ui.dialog.DialogComida
import com.example.appkotlin.util.Comunicacion
import com.example.appkotlin.util.Util
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class HomeFragment : Fragment() {

    private var _binding: FragmentHomeBinding? = null
    private val binding get() = _binding!!
    private var progressDialog: ProgressDialog? = null
    private lateinit var menuAdapter: MenuAdapter
    private lateinit var comidaAdapter: ComidaAdapter

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {

        _binding = FragmentHomeBinding.inflate(inflater, container, false)
        val root: View = binding.root

        configurar()
        cargarInformacion()
        return root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun configurar() {
        val recyclerView: RecyclerView = binding.rvMuestrario
        comidaAdapter = ComidaAdapter(context, mutableListOf(), this@HomeFragment)
        recyclerView.adapter = comidaAdapter

        binding.btnNuevoComida.setOnClickListener {
            val titulo = binding.tvMuestrarioTitulo.text.toString()
            val menu: Menu? = menuAdapter.getLista().firstOrNull { it.nombre == titulo }
            val JSON = Util.getData(context)
            val jsonObject = JSONObject(JSON)
            val id_restaurante: Int = jsonObject.getInt("id_restaurante")

            if (activity != null) {
                val dialog = DialogComida(
                    requireContext(),
                    activity,
                    menu,
                    id_restaurante,
                    this@HomeFragment)
                dialog.show()
            }
        }
    }

    public fun cargarInformacion() {
        showProgressDialog()
        val gestor = Gestor()

        val JSON = Util.getData(context)
        val jsonObject = JSONObject(JSON)
        val id_restaurante: Int = jsonObject.getInt("id_restaurante")

        mostrarViewVacio()
        gestor.obtenerMenus().enqueue(object : Callback<ResponseBody> {
            override fun onResponse(call: Call<ResponseBody>, response: Response<ResponseBody>) {
                dismissProgressDialog()

                if (response.isSuccessful) {
                    val responseBody = response.body()?.string()
                    responseBody?.let {
                        val listType = object : TypeToken<List<Menu>>() {}.type
                        val menuList: List<Menu> = Gson().fromJson(it, listType)

                        if (menuList.isNotEmpty()) {
                            val id_menu = menuList.get(0).id
                            val nombre_menu = menuList.get(0).nombre

                            proc_1(id_menu, id_restaurante, nombre_menu)
                        }

                        cargarMenus(menuList)
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

    fun proc_1(id_menu: Int, id_restaurante: Int, nombre: String) {
        val gestor = Gestor()

        binding.tvMuestrarioTitulo.setText(nombre)
        gestor.obtenerMuestrario(id_menu, id_restaurante).enqueue(object : Callback<ResponseBody> {
            override fun onResponse(call: Call<ResponseBody>, response: Response<ResponseBody>) {
                dismissProgressDialog()
                if (response.isSuccessful) {
                    val responseBody = response.body()?.string()
                    responseBody?.let {
                        val listType = object : TypeToken<List<Comida>>() {}.type
                        val comidaList: MutableList<Comida> = Gson().fromJson(it, listType)

                        if (!comidaList.isEmpty()) {
                            cargarMuestrario(comidaList)
                            ocultarViewVacio()
                        }
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

    private fun mostrarViewVacio() {
        binding.imgVacio.visibility = View.VISIBLE
        binding.rvMuestrario.visibility = View.GONE
        binding.tvRes.visibility = View.VISIBLE

    }

    private fun ocultarViewVacio() {
        binding.imgVacio.visibility = View.GONE
        binding.tvRes.visibility = View.GONE
        binding.rvMuestrario.visibility = View.VISIBLE

    }


    private fun cargarMenus(menuList: List<Menu>) {
        val recyclerView: RecyclerView = binding.rvMenus
        menuAdapter = MenuAdapter(context, menuList, object : Comunicacion {
            override fun onClick(menu: Menu) {
                mostrarViewVacio()
                showProgressDialog()
                comidaAdapter.limpiar()

                val JSON = Util.getData(context)
                val jsonObject = JSONObject(JSON)
                val id_restaurante: Int = jsonObject.getInt("id_restaurante")
                proc_1(
                    menu.id,
                    id_restaurante,
                    menu.nombre
                )
            }

            override fun onBitmap(bitmap: Bitmap) {
                TODO("Not yet implemented")
            }

        })
        recyclerView.adapter = menuAdapter
    }

    private fun cargarMuestrario(list: MutableList<Comida>) {
        // Asegúrate de que el RecyclerView y el Adapter estén inicializados
        val recyclerView: RecyclerView = binding.rvMuestrario
        comidaAdapter = ComidaAdapter(context, list, this@HomeFragment)
        recyclerView.adapter = comidaAdapter
    }

    private fun showProgressDialog() {
        progressDialog = ProgressDialog(context)
        progressDialog?.setMessage("Cargando...") // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }

}