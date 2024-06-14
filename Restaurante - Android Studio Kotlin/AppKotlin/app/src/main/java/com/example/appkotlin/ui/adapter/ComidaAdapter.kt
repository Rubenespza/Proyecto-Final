package com.example.appkotlin.ui.adapter

import android.app.ProgressDialog
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView
import com.example.appkotlin.R
import com.example.appkotlin.controlador.Gestor
import com.example.appkotlin.model.Comida
import com.example.appkotlin.ui.home.HomeFragment
import com.example.appkotlin.util.Util
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.stream.Collectors

class ComidaAdapter(
    private val context: Context?,
    private val list: MutableList<Comida>,
private val fragment : HomeFragment) :
    RecyclerView.Adapter<ComidaAdapter.ComidaViewHolder>() {
    private var progressDialog: ProgressDialog? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ComidaViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.item_muestrario, parent, false)
        return ComidaViewHolder(view)
    }

    override fun onBindViewHolder(holder: ComidaViewHolder, position: Int) {
        val comida = list[position]
        holder.tvNombre.text = comida.nombre
        holder.tvPrecio.text = comida.precio.toString()
        Util.setImageFromBase64(holder.imgIconComida, comida.foto)
        holder.btnEliminar.setOnClickListener {
            val gestor = Gestor()

            showProgressDialog("Procesando..")
            gestor.eliminarComida(comida.id).enqueue(object : Callback<ResponseBody> {
                override fun onResponse(
                    call: Call<ResponseBody>,
                    response: Response<ResponseBody>
                ) {
                    dismissProgressDialog()
                   fragment.cargarInformacion()

                }

                override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                    dismissProgressDialog()

                    val msg = "Error: onFailure!"
                    Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
                    t.printStackTrace()
                    dismissProgressDialog()
                }

            })
        }
    }

    override fun getItemCount(): Int {
        return list.size
    }

    fun getLista(): List<Comida> {
        return list
    }

    fun limpiar() {
        list.clear()
    }

    private fun showProgressDialog(msg : String) {
        progressDialog = ProgressDialog(context)
        progressDialog?.setMessage(msg) // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }


    inner class ComidaViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val imgIconComida: ImageView = itemView.findViewById(R.id.imgComida)
        val tvNombre: TextView = itemView.findViewById(R.id.tvNombreMuestrario)
        val tvPrecio: TextView = itemView.findViewById(R.id.tvPrecio)
        val btnEliminar: ImageView = itemView.findViewById(R.id.btnEliminarComida)

    }
}