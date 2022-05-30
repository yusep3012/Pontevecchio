import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:pontevecchio/screens/screens.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Ha ocurrido un error'));
            } else if (snapshot.hasData) {
              return const TablesScreen();
            } else {
              return Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  const Background(),
                  Column(
                    children: const [
                      Expanded(flex: 3, child: Logo()),
                      Expanded(flex: 3, child: LoginForm()),
                    ],
                  )
                ],
              );
            }
          }),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const styleUnderlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputEmail(
                emailController: _emailController,
                styleUnderlineInputBorder: styleUnderlineInputBorder),
            const SizedBox(height: 15),
            InputPassword(
                passwordController: _passwordController,
                styleUnderlineInputBorder: styleUnderlineInputBorder),
            const Register(),
            buttonSignIn(),
          ],
        ),
      ),
    );
  }

  Widget buttonSignIn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ElevatedButton(
        onPressed: () {
          signIn();
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.indigo[800],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Text('Ingresar', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  void signIn() async {
    _formKey.currentState!.validate();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      snackBar(context, 'Bienvenido(a)');
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      if (e.code == 'unknown') {
        snackBar(context, 'Por favor rellenar el formulario');
      }

      if (e.code == 'wrong-password') {
        snackBar(context, 'Contraseña errónea');
      }

      if (e.code == 'user-not-found') {
        snackBar(context, 'Cuenta no existente');
      }

      if (e.code == 'invalid-email') {
        snackBar(context, 'Correo electrónico no válido');
      }
    }
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required TextEditingController passwordController,
    required this.styleUnderlineInputBorder,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;
  final UnderlineInputBorder styleUnderlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          value != null && value.length < 6 ? 'Mínimo 6 caracteres' : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: 'Contraseña',
          labelStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.white,
          focusedBorder: styleUnderlineInputBorder,
          enabledBorder: styleUnderlineInputBorder,
          errorStyle: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key? key,
    required TextEditingController emailController,
    required this.styleUnderlineInputBorder,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;
  final UnderlineInputBorder styleUnderlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Ingrese un correo válido'
          : null,
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: 'Correo electrónico',
          labelStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.white,
          focusedBorder: styleUnderlineInputBorder,
          enabledBorder: styleUnderlineInputBorder,
          errorStyle: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}

class Register extends StatelessWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorText = Colors.white;
    const double fontSize = 16;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('¿No estás registrado?',
              style: TextStyle(color: colorText, fontSize: fontSize)),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_screen');
              },
              child:
                  const Text('Registrar', style: TextStyle(fontSize: fontSize)))
        ],
      ),
    );
  }
}
