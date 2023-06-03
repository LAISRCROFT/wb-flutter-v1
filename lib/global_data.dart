class GlobalData {
  static int user_id = 0;
  static String name = "";
  static String apelido = "";
  static bool usar_apelido = false;
  static String foto_perfil = "";
  static String email = "";
  static String api_token = "";
  static String xsrfToken = "";

  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  static void setUserId(int id) {
    user_id = id;
  }

  static void setName(String n) {
    name = n;
  }

  static void setApelido(String a) {
    apelido = a;
  }

  static void setUsarApelido(bool u) {
    usar_apelido = u;
  }

  static void setFotoPerfil(String f) {
    foto_perfil = f;
  }

  static void setEmail(String e) {
    email = e;
  }

  static void setApiToken(String a) {
    api_token = a;
  }

  static void setXsrfToken(String xsrfTokenParams) {
    xsrfToken = xsrfTokenParams;
  }

  static int getUserId() {
    return user_id;
  }

  static String getName() {
    return name;
  }

  static String getApelido() {
    return apelido;
  }

  static bool getUsarApelido() {
    return usar_apelido;
  }

  static String getFotoPerfil() {
    return foto_perfil;
  }

  static String getEmail() {
    return email;
  }

  static String getApiToken() {
    return api_token;
  }

  static String getXsrfToken() {
    return xsrfToken;
  }

  static void clear() {
    user_id = 0;
    name = "";
    apelido = "";
    usar_apelido = false;
    foto_perfil = "";
    email = "";
    api_token = "";
  }



  


}
