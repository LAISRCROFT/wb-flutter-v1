// import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'categorias.dart';
import 'global_data.dart';

import 'models/Categorias.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    // Manter o App em apenas uma orientação
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/categorias': (context) => const CategoriasList(),
      },
      // home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.black,
        fontFamily: 'Ubuntu',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        //Exemplo de estilo aplicado themeData para appBars
        appBarTheme: const AppBarTheme(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final List<Categoria> _categorias = [];

  final double _padding_form = 20;
  
  String _xsrfToken = '';

  final dio = Dio();
  final cookieJar = CookieJar();

  Future<void> _fetchXsrfToken() async {

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final jar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage("$appDocPath/.cookies/"),
    );
    dio.interceptors.add(CookieManager(jar));

    var response = await dio.get(
      'https://worldbooks.serratedevs.com.br/wbcore/public/sanctum',
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      final headers = response.headers;

      setState(() {
        final headerResponse = headers['set-cookie'] ?? '';

        _xsrfToken = headerResponse.toString();
        _xsrfToken = _xsrfToken.split(';')[0];
        _xsrfToken = _xsrfToken.split('=')[1];

        _xsrfToken = _xsrfToken.replaceAll('"', '');
        _xsrfToken = _xsrfToken.replaceAll("%3D", '');

        GlobalData.setXsrfToken(_xsrfToken);
      });
    } else {
      throw Exception('Failed to fetch XSRF Token');
    }
  }

  Future<void> _login() async {
    final emailFinal = email.text;
    final passwordFinal = password.text;

    await _fetchXsrfToken();

    final response = await dio.post(
      'https://worldbooks.serratedevs.com.br/wbcore/public/login',
      options: Options(
        headers: {
          'X-XSRF-TOKEN': GlobalData.getXsrfToken(),
        },
      ),
      data: {
        'email': emailFinal,
        'password': passwordFinal,
      },
    );

    if (response.statusCode == 200) {
      // Lógica para processar a resposta do login

      final data = response.data;
        // Fluttertoast.showToast(
        //   msg: 'API request successful!',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.green,
        //   textColor: Colors.white,
        // );

      // print(data);

      GlobalData.setUserId(data['data']['user_id']);
      GlobalData.setName(data['data']['name']);
      GlobalData.setApelido(data['data']['apelido']);
      GlobalData.setUsarApelido(data['data']['usar_apelido']);
      GlobalData.setFotoPerfil(data['data']['foto_perfil']);
      GlobalData.setEmail(data['data']['email']);
      GlobalData.setApiToken(data['data']['api_token']);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CategoriasList(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "API request failed! ${response.statusCode} ${response.statusMessage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      throw Exception('Failed to login');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchXsrfToken();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyPage = Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/layered-waves-haikei-3.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/wb_logo.png',
                  height: 100,
                  width: 100,
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'Bem-vindo ao ',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 24,
                      color: Palette.WBColor.shade400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'World Books!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Ubuntu',
                          // fontSize: 30,
                          color: Palette.WBColor.shade50,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                          filled: true,
                          fillColor: Color(0xffffffff),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          filled: true,
                          fillColor: Color(0xffffffff),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _login();
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              maximumSize:  MaterialStateProperty.all(const Size(100, 45)),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                              backgroundColor: MaterialStateProperty.all(Palette.WBColor.shade50),
                              textStyle: MaterialStateProperty.all(const TextStyle(fontFamily: 'Ubuntu'),
                              ),
                            ),
                            child: const Text("Entrar"),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              elevation: 0,
                              minimumSize: const Size(88, 36),
                              padding: EdgeInsets.symmetric(horizontal: _padding_form),
                              textStyle: const TextStyle(
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            child: const Text("Esqueci  a senha"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'Não possui uma conta? ',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          color: Palette.WBColor.shade400,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Cadastre-se!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Ubuntu',
                              // fontSize: 30,
                              color: Palette.WBColor.shade50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Palette.WBColor.shade400,
      body: bodyPage,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
