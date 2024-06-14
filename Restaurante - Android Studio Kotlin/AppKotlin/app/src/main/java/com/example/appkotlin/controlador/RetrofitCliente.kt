package com.example.appkotlin.controlador

// RetrofitClient.kt
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object RetrofitCliente {
    private const val BASE_URL = "http://192.168.1.8/ApiRest/php/"
    const val connectionTimeoutInSecconds = 60
    const val readTimeoutInSecconds = 45
    const val writeTimeoutInSecconds = 45


    //HttpLoggingInterceptor Logs
    val client = OkHttpClient.Builder()
        .connectTimeout(
            connectionTimeoutInSecconds.toLong(),
            TimeUnit.SECONDS
        )
        .readTimeout(
            readTimeoutInSecconds.toLong(),
            TimeUnit.SECONDS
        )
        .writeTimeout(
            writeTimeoutInSecconds.toLong(),
            TimeUnit.SECONDS
        )
        .build()


    val instance = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .client(client)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

}
