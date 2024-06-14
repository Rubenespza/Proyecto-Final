package com.example.appkotlin

import android.Manifest
import android.app.Activity
import android.app.ProgressDialog
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.MediaStore
import android.text.Html
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.viewpager.widget.ViewPager
import androidx.viewpager.widget.ViewPager.OnPageChangeListener
import com.example.appkotlin.controlador.Gestor
import com.example.appkotlin.model.Prestador
import com.example.appkotlin.model.Restaurante
import com.example.appkotlin.model.Usuario
import com.example.appkotlin.util.MyViewPagerAdapter
import com.example.appkotlin.util.Util
import com.google.android.material.textfield.TextInputEditText
import okhttp3.ResponseBody
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class RegistrarActivity : AppCompatActivity() {
    private lateinit var viewPager: ViewPager
    private lateinit var myViewPagerAdapter: MyViewPagerAdapter
    private lateinit var dotsLayout: LinearLayout
    private lateinit var dots: Array<TextView?>
    private lateinit var layouts: IntArray
    private lateinit var btnNext: Button

    private var usuario: Usuario = Usuario()
    private var prestador: Prestador = Prestador()
    private var restaurante: Restaurante = Restaurante()
    private var progressDialog: ProgressDialog? = null

    private lateinit var imageView: ImageView
    private val REQUEST_CAMERA_PERMISSION = 2
    private val REQUEST_IMAGE_PICK = 1


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registrar)

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

        configurar()
    }

    fun configurar() {

        viewPager = findViewById<View>(R.id.view_pager) as ViewPager
        dotsLayout = findViewById<View>(R.id.layoutDots) as LinearLayout
        btnNext = findViewById<View>(R.id.btn_next) as Button

        layouts = intArrayOf(
            R.layout.welcome_slide0,
            R.layout.welcome_slide1,
            R.layout.welcome_slide2,
            R.layout.welcome_slide3,
            R.layout.welcome_slide4
        )

        //  viewpager change listener
        val viewPagerPageChangeListener: OnPageChangeListener = object : OnPageChangeListener {
            override fun onPageSelected(position: Int) {
                addBottomDots(position)
                if (position == layouts.size - 1) {
                    btnNext.text = getString(R.string.start)
                } else {
                    // still pages are left
                    btnNext.text = getString(R.string.next)
                }
            }

            override fun onPageScrolled(arg0: Int, arg1: Float, arg2: Int) {}
            override fun onPageScrollStateChanged(arg0: Int) {}
        }

        addBottomDots(0)
        myViewPagerAdapter = MyViewPagerAdapter(applicationContext, layouts)
        viewPager.setAdapter(myViewPagerAdapter)
        viewPager.addOnPageChangeListener(viewPagerPageChangeListener)

        btnNext.setOnClickListener {
            val current: Int = viewPager.currentItem

            if (current < (layouts.size - 1)) {
                validarYSeguir(current);
            } else {
                guardarInformacionYSeguir()
            }
        }
    }

    private fun addBottomDots(currentPage: Int) {
        dots = arrayOfNulls(layouts.size)
        val colorsActive = getResources().getIntArray(R.array.array_dot_active)
        val colorsInactive = getResources().getIntArray(R.array.array_dot_inactive)
        dotsLayout.removeAllViews()

        for (i in dots.indices) {
            dots[i] = TextView(this)
            dots[i]?.text = Html.fromHtml("•")
            dots[i]?.setTextSize(35f)
            dots[i]?.setTextColor(colorsInactive[currentPage])
            dotsLayout.addView(dots[i])
        }

        if (dots.size > 0) dots[currentPage]?.setTextColor(colorsActive[currentPage])
    }

    private fun getItem(i: Int): Int {
        return viewPager.currentItem + i
    }

    private fun guardarInformacionYSeguir() {
        if (validarDatosLocalComercial2()) {
            cargarDatosObjRestaurante2()

            showProgressDialog()
            val gestor = Gestor()

            gestor.registrar(usuario, prestador, restaurante).enqueue(object :
                Callback<ResponseBody> {
                override fun onResponse(
                    call: Call<ResponseBody>,
                    response: Response<ResponseBody>
                ) {
                    dismissProgressDialog()
                    if (response.isSuccessful) {
                        val responseBody = response.body()?.string()
                        println("huh : " + responseBody)
                        responseBody?.let {
                            val jsonObject = JSONObject(responseBody)
                            val acceso = jsonObject.getString("acceso").toBoolean()
                            val msg = jsonObject.getString("msg")


                            if (acceso) {
                                Util.saveData(applicationContext, responseBody)


                                val intent =
                                    Intent(applicationContext, MainRestauranteActivity::class.java)
                                startActivity(intent)
                                finish()

                            } else {
                                Toast.makeText(applicationContext, msg, Toast.LENGTH_LONG).show()
                            }
                        }
                    } else {
                        val msg = "Error: la informacion no ha sido guardada!"
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
        } else {
            Toast.makeText(
                applicationContext,
                "Complete los campos correctamente!",
                Toast.LENGTH_LONG
            ).show()
        }
    }

    private fun validarYSeguir(current: Int) {
        when (current) {
            0 -> {
                viewPager.setCurrentItem(getItem(+1))
            }

            1 -> if (validarDatosUsuario()) {

                verificarUsuarioUnicoYSeguir()

            } else {
                Toast.makeText(
                    applicationContext,
                    "Complete los campos correctamente!",
                    Toast.LENGTH_LONG
                ).show()
            }

            2 -> if (validarDatosPersonales()) {
                cargarDatosObjPrestador()
                viewPager.setCurrentItem(getItem(+1))
            } else {
                Toast.makeText(
                    applicationContext,
                    "Complete los campos correctamente!",
                    Toast.LENGTH_LONG
                ).show()
            }

            3 -> if (validarDatosLocalComercial()) {
                cargarDatosObjRestaurante1()
                viewPager.setCurrentItem(getItem(+1))

                val thread = Thread {
                    var btn: Button? = viewPager.findViewById(R.id.btnCargarFoto)

                    while (btn == null) {

                        btn = viewPager.findViewById(R.id.btnTomarFoto)

                        try {
                            Thread.sleep(100)
                        } catch (e: Exception) {

                        }
                    }

                    btn.setOnClickListener {
                        imageView = viewPager.findViewById<ImageView>(R.id.imgFoto)
                        dispatchPickImageIntent(imageView)
                    }
                }
                thread.start()


            } else {
                Toast.makeText(
                    applicationContext,
                    "Complete los campos correctamente!",
                    Toast.LENGTH_LONG
                ).show()
            }

        }
    }

    private fun validarDatosUsuario(): Boolean {
        val us = viewPager.findViewById<TextInputEditText>(R.id.edtUsuario).text.toString().trim()
        val pass =
            viewPager.findViewById<TextInputEditText>(R.id.edtPassword).text.toString().trim()
        val repass =
            viewPager.findViewById<TextInputEditText>(R.id.edtRePassword).text.toString().trim()

        if (!pass.equals(repass)) {
            return false
        }

        if (us.isBlank() || pass.isBlank() || repass.isBlank()) {
            return false
        }

        return true
    }


    private fun validarDatosPersonales(): Boolean {
        val nom = viewPager.findViewById<TextInputEditText>(R.id.edtNombre).text.toString().trim()
        val ape = viewPager.findViewById<TextInputEditText>(R.id.edtApellido).text.toString().trim()
        val dom =
            viewPager.findViewById<TextInputEditText>(R.id.edtDomicilio).text.toString().trim()

        if (nom.isBlank() || ape.isBlank() || dom.isBlank()) {
            return false
        }

        return true
    }

    private fun validarDatosLocalComercial(): Boolean {
        val nomLocal =
            viewPager.findViewById<TextInputEditText>(R.id.edtNombreLocal).text.toString().trim()
        val dirLocal =
            viewPager.findViewById<TextInputEditText>(R.id.edtDireccionLocal).text.toString().trim()
        val wat = viewPager.findViewById<TextInputEditText>(R.id.edtWhatsapp).text.toString().trim()
        val face =
            viewPager.findViewById<TextInputEditText>(R.id.edtFacebook).text.toString().trim()

        if (nomLocal.isBlank()
            || dirLocal.isBlank()
            || wat.isBlank()
            || face.isBlank()
        ) {
            return false
        }

        return true
    }

    private fun validarDatosLocalComercial2(): Boolean {
        val desc =
            viewPager.findViewById<TextInputEditText>(R.id.edtDesc).text.toString().trim()


        if (desc.isBlank()) {
            return false
        }

        return true
    }

    private fun cargarDatosObjUsuario() {
        val us = viewPager.findViewById<TextInputEditText>(R.id.edtUsuario).text.toString().trim()
        val pass =
            viewPager.findViewById<TextInputEditText>(R.id.edtPassword).text.toString().trim()

        usuario.usuario = us
        usuario.password = pass
    }

    private fun cargarDatosObjPrestador() {
        val nom = viewPager.findViewById<TextInputEditText>(R.id.edtNombre).text.toString().trim()
        val ape = viewPager.findViewById<TextInputEditText>(R.id.edtApellido).text.toString().trim()
        val dom =
            viewPager.findViewById<TextInputEditText>(R.id.edtDomicilio).text.toString().trim()

        prestador.nombre = nom
        prestador.apellido = ape
        prestador.direccion = dom
    }

    private fun cargarDatosObjRestaurante1() {
        val nomLocal =
            viewPager.findViewById<TextInputEditText>(R.id.edtNombreLocal).text.toString().trim()
        val dirLocal =
            viewPager.findViewById<TextInputEditText>(R.id.edtDireccionLocal).text.toString().trim()
        val wat = viewPager.findViewById<TextInputEditText>(R.id.edtWhatsapp).text.toString().trim()
        val face =
            viewPager.findViewById<TextInputEditText>(R.id.edtFacebook).text.toString().trim()

        restaurante.nombre = nomLocal
        restaurante.direccion = dirLocal
        restaurante.telefono = wat
        restaurante.facebook = face

    }

    private fun cargarDatosObjRestaurante2() {
        val desc =
            viewPager.findViewById<TextInputEditText>(R.id.edtDesc).text.toString().trim()
        restaurante.descripcion = desc


        val imageView = findViewById<ImageView>(R.id.imgFoto)

        val base64Image = try {
            Util.imageViewToBlob(this, imageView)
        }catch (e : Exception){
            Util.drawableToBlob(this, R.drawable.logo)
        }

        restaurante.foto = base64Image

    }

    private fun showProgressDialog() {
        progressDialog = ProgressDialog(this)
        progressDialog?.setMessage("Registrando...") // Mensaje que se muestra en el diálogo
        progressDialog?.setCancelable(false) // Para evitar que se cierre al tocar fuera del diálogo
        progressDialog?.show()
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

    fun dispatchPickImageIntent(img: ImageView) {
        imageView = img
        Intent(
            Intent.ACTION_PICK,
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        ).also { pickImageIntent ->
            startActivityForResult(pickImageIntent, REQUEST_IMAGE_PICK)
        }
    }

    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?, context: Context) {
        if (requestCode == REQUEST_IMAGE_PICK && resultCode == Activity.RESULT_OK) {
            data?.data?.let { uri ->
                imageView.setImageURI(uri)
            }
        }
    }

    fun verificarUsuarioUnicoYSeguir() {

        showProgressDialog("Verificando usuario...")
        val gestor = Gestor()

        val usuario = viewPager.findViewById<TextInputEditText>(R.id.edtUsuario).text.toString().trim()

        gestor.verificarUsuarioExistencia(usuario).enqueue(object : Callback<ResponseBody>{
            override fun onResponse(call: Call<ResponseBody>, response: Response<ResponseBody>) {
                dismissProgressDialog()
                if (response.isSuccessful) {
                    val responseBody = response.body()?.string()
                    responseBody?.let {
                        val jsonObject = JSONObject(responseBody)
                        val acceso = jsonObject.getString("acceso").toBoolean()

                        if (acceso) {
                            cargarDatosObjUsuario()
                            viewPager.setCurrentItem(getItem(+1))

                        } else {
                            Toast.makeText(applicationContext, "El usuario ya existe, intente otro...", Toast.LENGTH_LONG).show()
                        }
                    }
                } else {
                    val msg = "Error: la informacion no ha sido guardada!"
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

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        handleActivityResult(requestCode, resultCode, data, this)
    }

}