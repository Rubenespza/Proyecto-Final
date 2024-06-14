package com.example.appkotlin.controlador

import com.example.appkotlin.model.Comida
import com.example.appkotlin.model.RegistroDataGeneral
import com.example.appkotlin.model.RegistroRequest
import com.example.appkotlin.model.RegistroRequestComida
import okhttp3.RequestBody
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.Callback
import retrofit2.http.Body
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST

interface ApiService {
    @FormUrlEncoded
    @POST("action_loguin_usuario.php")
    fun login(
        @Field("usuario") usuario: String,
        @Field("password") password: String
    ): Call<ResponseBody>

    @POST("action_completar_perfil.php")
    fun registrar(@Body registroRequest: RegistroRequest): Call<ResponseBody>

    @GET("action_bienvenida.php")
    fun obtenerMenus(): Call<ResponseBody>

    @FormUrlEncoded
    @POST("action_muestrario.php")
    fun obtenerMuestrario(
        @Field("id_menu") id_menu: Int,
        @Field("id_restaurante") id_restaurante: Int
    ): Call<ResponseBody>

    @POST("action_insertar_comida.php")
    fun insertar(@Body registro: RegistroRequestComida): Call<ResponseBody>

    @FormUrlEncoded
    @POST("action_info_restaurante.php")
    fun obtenerDatosRestaurante(
        @Field("usuario") usuario: String,
        @Field("password") password: String,
        @Field("idRestaurante") idRestaurante: Int
    ): Call<ResponseBody>

    @FormUrlEncoded
    @POST("action_verificar_usuario.php")
    fun verificarUsuarioExistencia(@Field("usuario") usuario: String): Call<ResponseBody>

    @FormUrlEncoded
    @POST("action_eliminar_usuario.php")
    fun eliminar(
        @Field("usuario") usuario: String,
        @Field("password") password: String
    ): Call<ResponseBody>

    @POST("action_actualizar_general.php")
    fun actualizarTablas(@Body registro: RegistroDataGeneral): Call<ResponseBody>

    @FormUrlEncoded
    @POST("action_obtener_datos_generales.php")
    fun obtenerDatosGeneral(
        @Field("usuario") usuario: String,
        @Field("password") password: String
    ): Call<ResponseBody>

    @FormUrlEncoded
    @POST("action_eliminar_comida.php")
    fun eliminarComida(
        @Field("id_comida") id_comida: Int
    ): Call<ResponseBody>
}