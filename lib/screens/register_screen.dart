import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Usuario'),
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Ha ocurrido un error'));
            } else {
              return Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  const Background(),
                  Column(
                    children: const [
                      Expanded(flex: 3, child: Logo()),
                      Expanded(flex: 3, child: RegisterForm()),
                    ],
                  )
                ],
              );
            }
          }),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Ingrese un correo válido'
                      : null,
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                focusedBorder: styleUnderlineInputBorder,
                enabledBorder: styleUnderlineInputBorder,
                errorStyle: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Mínimo 6 caracteres'
                  : null,
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  focusedBorder: styleUnderlineInputBorder,
                  enabledBorder: styleUnderlineInputBorder,
                  errorStyle: TextStyle(color: Colors.white, fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(
                onPressed: () {
                  signUp();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Text('Registrar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      snackBar(context, 'Usuario registrado');
      Navigator.pushNamed(context, '/login_screen');
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
