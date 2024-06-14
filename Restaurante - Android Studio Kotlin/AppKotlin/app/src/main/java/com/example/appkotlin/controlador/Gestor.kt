package com.example.appkotlin.controlador

import com.example.appkotlin.model.Comida
import com.example.appkotlin.model.Prestador
import com.example.appkotlin.model.RegistroDataGeneral
import com.example.appkotlin.model.RegistroRequest
import com.example.appkotlin.model.RegistroRequestComida
import com.example.appkotlin.model.Restaurante
import com.example.appkotlin.model.Usuario
import com.google.gson.Gson
import okhttp3.MediaType
import okhttp3.RequestBody
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.Callback

class Gestor {
    private val apiService = RetrofitCliente.instance.create(ApiService::class.java)

    fun loguin(usuario: String, password: String): Call<ResponseBody> {
        return apiService.login(usuario, password)
    }

    // Esta función utiliza la función registrar del ApiService para enviar los datos al servidor
    fun registrar(us: Usuario, prestador: Prestador, rest: Restaurante): Call<ResponseBody> {

        val registroRequest = RegistroRequest(us, prestador, rest)
        return apiService.registrar(registroRequest)
    }

    fun obtenerMenus(): Call<ResponseBody> {
        return apiService.obtenerMenus()
    }

    fun obtenerMuestrario(id_menu: Int, id_restaurante: Int): Call<ResponseBody> {
        return apiService.obtenerMuestrario(id_menu, id_restaurante)
    }

    fun insertar(
        comida: Comida,
        id_restaurante: Int,
        menu: String,
        usuario: String,
        password: String
    ): Call<ResponseBody> {
        return apiService.insertar(
            RegistroRequestComida(
                comida,
                id_restaurante,
                menu,
                usuario,
                password
            )
        )
    }

    fun obtenerDatosRestaurante(
        usuario: String,
        password: String,
        id_restaurante: Int
    ): Call<ResponseBody> {
        return apiService.obtenerDatosRestaurante(
            usuario,
            password,
            id_restaurante
        )
    }

    fun verificarUsuarioExistencia(usuario: String): Call<ResponseBody> {
        return apiService.verificarUsuarioExistencia(usuario)
    }

    fun eliminarCuenta(usuario: String, password: String): Call<ResponseBody> {
        return apiService.eliminar(usuario, password)
    }

    fun actualizarTablas(registro: RegistroDataGeneral): Call<ResponseBody> {
        return apiService.actualizarTablas(registro)
    }

    fun obtenerDatosGeneral(usuario: String, password: String): Call<ResponseBody> {
        return apiService.obtenerDatosGeneral(usuario, password)
    }

    fun eliminarComida(id: Int) : Call<ResponseBody>{
return apiService.eliminarComida(id)
    }
}



