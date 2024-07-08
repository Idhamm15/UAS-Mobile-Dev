import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/bloc/login/bloc/login_bloc.dart';
import 'package:fe/bloc/login/bloc/login_event.dart';
import 'package:fe/bloc/login/bloc/login_state.dart';
import 'package:fe/data/model/users_model.dart';
import 'package:fe/presentation/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: 'owner@go.id');
  final passwordController = TextEditingController(text: '123456');
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Email Screen"),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedState) {
            UserModel usuario = state.user;
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginErrorState) {
            setState(() {
              errorMessage = state.error;
            });
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial || state is LoginErrorState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                    const SizedBox(height: 30.0),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Masukan Email',
                          labelText: 'Email *',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          hintText: 'Masukan Password',
                          labelText: 'Password *',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        minimumSize: const Size(200, 15),
                      ),
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoadLoginEvent(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      child: const Text("Login"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?"),
                        TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()), // Ganti SignUpScreen() dengan halaman pendaftaran yang sesuai
                      );
                    },
                    child: const Text("Buat akun"),
                    ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is LoginLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
