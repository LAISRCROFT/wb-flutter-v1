import 'package:flutter/material.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'categorias.dart';
import 'models/Categorias.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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
        '/': (context) => MyHomePage(),
        '/categorias': (context) => CategoriasList(),
      },
      // home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.black,
        fontFamily: 'Ubuntu',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        //Exemplo de estilo aplicado themeData para appBars
        appBarTheme: AppBarTheme(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final List<Categoria> _categorias = [];

  final double _padding_form = 20;

  Future<void> realizarLogin(String email, String password) async {
    print("Email: ${email}. Senha: ${password}");
    String url = 'https://worldbooks.serratedevs.com.br/wbcore/public/sanctum';
    String getUrl = 'https://worldbooks.serratedevs.com.br/wbcore/public/api/historia/1';
    
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          'X-XSRF-TOKEN': 'eyJpdiI6IjNldzYxYnJ6cUdOVzRvQzl0SUNmZXc9PSIsInZhbHVlIjoiODdBRk1WZVhnbFFiWThGZnBnVVhEZHJ1ZUlWT0l1SGR6bFNVK3Z0MzVDZS9qcXNaTEhzVFdiQmJkR25WbjFVZ1R5WStQcnZXV2tmTkFQQm16RVNsQVhnYkpVTWFiZm5BMnpwZDhGVTVlcEdXRWsxUlVoQ01sN3IzODh5VVh3b0MiLCJtYWMiOiI4OWJjMGI3ZGUxMzM0YmM5YjNlOGZiMWNjMGIzOGZlNTRlMTRjZGYwNWM3MTc2ZTc0YzYxMDExMjU3ZDRkNjY3IiwidGFnIjoiIn0%3D; world_books_session=eyJpdiI6ImlSQ3hlZlRDUTlqdzR6SnFmaGNRTEE9PSIsInZhbHVlIjoiaGl3aEg3ZHZZSzR6ZFAvY20yMk40L05kRFNvdnJzcjNsNVoybDV5NmhFenYrK2JvWlJVTGNOR1VJWXNaLzhoQmRwSWhGSUZJclgreXkzMVU3YWlJZmtYUWQwVjRiSzlSR04wdzdBdk5obFRpSHI2QWxiWHlrSytvYVJZUHRkbXIiLCJtYWMiOiJhM2RjNmU1ZTU1NDVjMWM3YzQ2ODEwYWI2MjhkMzQ4MTQ4ZDkxMGQ3NzBlYzBmMWZlNDI4YmRmMzc4MDUxZDQ1IiwidGFnIjoiIn0%3D',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Accept': '*/*'       
        }
      );
      // Verifique o código de status da resposta
      if (response.statusCode == 200) {
        // A requisição foi bem-sucedida, você pode manipular a resposta aqui
        print(response.body);
      } else {
        // A requisição falhou
        print('Falha na requisição: ${response.statusCode}');
      }
    } catch (error) {
      // Trate qualquer erro que ocorrer durante a requisição
      print('Erro na requisição: $error');
    }
  }

  Future<void> getCookie() async {
    String url = 'https://worldbooks.serratedevs.com.br/wbcore/public/sanctum';
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-XSRF-TOKEN': 'eyJpdiI6IjNldzYxYnJ6cUdOVzRvQzl0SUNmZXc9PSIsInZhbHVlIjoiODdBRk1WZVhnbFFiWThGZnBnVVhEZHJ1ZUlWT0l1SGR6bFNVK3Z0MzVDZS9qcXNaTEhzVFdiQmJkR25WbjFVZ1R5WStQcnZXV2tmTkFQQm16RVNsQVhnYkpVTWFiZm5BMnpwZDhGVTVlcEdXRWsxUlVoQ01sN3IzODh5VVh3b0MiLCJtYWMiOiI4OWJjMGI3ZGUxMzM0YmM5YjNlOGZiMWNjMGIzOGZlNTRlMTRjZGYwNWM3MTc2ZTc0YzYxMDExMjU3ZDRkNjY3IiwidGFnIjoiIn0%3D; world_books_session=eyJpdiI6ImlSQ3hlZlRDUTlqdzR6SnFmaGNRTEE9PSIsInZhbHVlIjoiaGl3aEg3ZHZZSzR6ZFAvY20yMk40L05kRFNvdnJzcjNsNVoybDV5NmhFenYrK2JvWlJVTGNOR1VJWXNaLzhoQmRwSWhGSUZJclgreXkzMVU3YWlJZmtYUWQwVjRiSzlSR04wdzdBdk5obFRpSHI2QWxiWHlrSytvYVJZUHRkbXIiLCJtYWMiOiJhM2RjNmU1ZTU1NDVjMWM3YzQ2ODEwYWI2MjhkMzQ4MTQ4ZDkxMGQ3NzBlYzBmMWZlNDI4YmRmMzc4MDUxZDQ1IiwidGFnIjoiIn0%3D',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Accept': '*/*'       
        }
      );
      // Verifique o código de status da resposta
      if (response.statusCode == 200) {
        // A requisição foi bem-sucedida, você pode manipular a resposta aqui
        print(response.body);
      } else {
        // A requisição falhou
        print('Falha na requisição: ${response.statusCode}');
      }
    } catch (error) {
      // Trate qualquer erro que ocorrer durante a requisição
      print('Erro na requisição: $error');
    }
  }

  Future<void> getCookie2() async {
    String url = 'https://worldbooks.serratedevs.com.br/wbcore/public/sanctum';

    try {
      Dio dio = Dio();
      
      Map<String, String> headers = {
        'Cookie': 'XSRF-TOKEN=eyJpdiI6IjNldzYxYnJ6cUdOVzRvQzl0SUNmZXc9PSIsInZhbHVlIjoiODdBRk1WZVhnbFFiWThGZnBnVVhEZHJ1ZUlWT0l1SGR6bFNVK3Z0MzVDZS9qcXNaTEhzVFdiQmJkR25WbjFVZ1R5WStQcnZXV2tmTkFQQm16RVNsQVhnYkpVTWFiZm5BMnpwZDhGVTVlcEdXRWsxUlVoQ01sN3IzODh5VVh3b0MiLCJtYWMiOiI4OWJjMGI3ZGUxMzM0YmM5YjNlOGZiMWNjMGIzOGZlNTRlMTRjZGYwNWM3MTc2ZTc0YzYxMDExMjU3ZDRkNjY3IiwidGFnIjoiIn0%3D; world_books_session=eyJpdiI6ImlSQ3hlZlRDUTlqdzR6SnFmaGNRTEE9PSIsInZhbHVlIjoiaGl3aEg3ZHZZSzR6ZFAvY20yMk40L05kRFNvdnJzcjNsNVoybDV5NmhFenYrK2JvWlJVTGNOR1VJWXNaLzhoQmRwSWhGSUZJclgreXkzMVU3YWlJZmtYUWQwVjRiSzlSR04wdzdBdk5obFRpSHI2QWxiWHlrSytvYVJZUHRkbXIiLCJtYWMiOiJhM2RjNmU1ZTU1NDVjMWM3YzQ2ODEwYWI2MjhkMzQ4MTQ4ZDkxMGQ3NzBlYzBmMWZlNDI4YmRmMzc4MDUxZDQ1IiwidGFnIjoiIn0%3D',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Accept': '*/*'
      };

      Response response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Falha na requisição: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro na requisição: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getCookie();
    
  }
  @override
  Widget build(BuildContext context) {
    final bodyPage = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/layered-waves-haikei-3.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 15 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Image.asset(
                'assets/images/wb_logo.png',
                height: 100,
                width: 100,
              ),
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
              padding: EdgeInsets.only(
                top: 3,
                right: _padding_form,
                left: _padding_form,
                bottom: 3 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: 10,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                    filled: true,
                    fillColor: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                top: 3,
                right: _padding_form,
                left: _padding_form,
                bottom: 3 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: 50,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    filled: true,
                    fillColor: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String emailValue = email.text;
                    String passwordValue = password.text;
                    realizarLogin(emailValue, passwordValue);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriasList(),
                      ),
                    );
                  },
                  child: Text("Entrar"),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    maximumSize: MaterialStateProperty.all(const Size(100, 45)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                    backgroundColor:MaterialStateProperty.all(Palette.WBColor.shade50),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Esqueci  a senha"),
                  style: TextButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: _padding_form),
                    textStyle: const TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
    );
    return Scaffold(
      backgroundColor: Palette.WBColor.shade400,
      body: bodyPage,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
