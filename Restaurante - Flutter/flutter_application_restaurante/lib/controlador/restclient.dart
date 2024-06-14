import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/registroDataGeneral.dart';
import '../model/registroRequest.dart';
import '../model/registroRequestComida.dart';

part 'restclient.g.dart';

@RestApi(baseUrl: 'http://192.168.1.8/ApiRest/php/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @FormUrlEncoded()
  @POST("action_loguin_usuario.php")
  Future<HttpResponse> login(
    @Field("usuario") String usuario,
    @Field("password") String password,
  );

  @POST("action_completar_perfil.php")
  Future<HttpResponse> registrar(@Body() RegistroRequest registroRequest);

  @GET("action_bienvenida.php")
  Future<HttpResponse> obtenerMenus();

  @FormUrlEncoded()
  @POST("action_muestrario.php")
  Future<HttpResponse> obtenerMuestrario(
    @Field("id_menu") int idMenu,
    @Field("id_restaurante") int idRestaurante,
  );

  @FormUrlEncoded()
  @POST("action_info_restaurante.php")
  Future<HttpResponse> obtenerDatosRestaurante(
    @Field("usuario") String usuario,
    @Field("password") String password,
    @Field("idRestaurante") int idRestaurante,
  );

  @FormUrlEncoded()
  @POST("action_verificar_usuario.php")
  Future<HttpResponse> verificarUsuarioExistencia(
      @Field("usuario") String usuario);

  @FormUrlEncoded()
  @POST("action_eliminar_usuario.php")
  Future<HttpResponse> eliminar(
    @Field("usuario") String usuario,
    @Field("password") String password,
  );

  @POST("action_actualizar_general.php")
  Future<HttpResponse> actualizarTablas(@Body() RegistroDataGeneral registro);

  @POST("action_insertar_comida.php")
  Future<HttpResponse> insertar(@Body() RegistroRequestComida registro);

  @FormUrlEncoded()
  @POST("action_obtener_datos_generales.php")
  Future<HttpResponse> obtenerDatosGeneral(
    @Field("usuario") String usuario,
    @Field("password") String password,
  );

  @FormUrlEncoded()
  @POST("action_eliminar_comida.php")
  Future<HttpResponse> eliminarComida(@Field("id_comida") int idComida);
}
