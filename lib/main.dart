import 'package:flutter/material.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'categorias.dart';
import 'models/Categorias.dart';

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
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: _padding_form)),
                    backgroundColor:
                        MaterialStateProperty.all(Palette.WBColor.shade50),
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
      body: bodyPage,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
