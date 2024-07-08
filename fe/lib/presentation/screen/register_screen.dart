// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fe/bloc/register/bloc/register_bloc.dart';
// import 'package:fe/bloc/register/bloc/register_event.dart';
// import 'package:fe/bloc/register/bloc/register_state.dart';
// import 'package:fe/presentation/screen/login_screen.dart';

// class RegisterScreen extends StatelessWidget {
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocListener<RegisterBloc, RegisterState>(
//         listener: (context, state) {
//           if (state is RegisterSuccessState) {
//             Navigator.pushReplacementNamed(context, '/login');
//           } else if (state is RegisterErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('Registration failed: ${state.error}'),
//               duration: Duration(seconds: 2),
//             ));
//           }
//         },
//         child: BlocBuilder<RegisterBloc, RegisterState>(
//           builder: (context, state) {
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     controller: fullNameController,
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.person),
//                       hintText: 'Fullname',
//                       labelText: 'Fullname *',
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   TextFormField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.email),
//                       hintText: 'Email',
//                       labelText: 'Email *',
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   TextFormField(
//                     controller: passwordController,
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.lock),
//                       hintText: 'Password',
//                       labelText: 'Password *',
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 16.0),
//                   TextFormField(
//                     controller: confirmPasswordController,
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.lock),
//                       hintText: 'Confirm Password',
//                       labelText: 'Confirm Password *',
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       final fullName = fullNameController.text;
//                       final email = emailController.text;
//                       final password = passwordController.text;
//                       final confirmPassword = confirmPasswordController.text;
//                       if (password == confirmPassword) {
//                         BlocProvider.of<RegisterBloc>(context).add(
//                         RegisterButtonPressed(
//                           fullName: fullName,
//                           email: email,
//                           password: password,
//                         ),
//                       );

//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text('Password and Confirm Password do not match'),
//                           duration: Duration(seconds: 2),
//                         ));
//                       }
//                     },
//                     child: const Text('Register'),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account?"),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(context, '/login');
//                         },
//                         child: const Text("Login"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/bloc/login/bloc/login_bloc.dart';
import 'package:fe/bloc/login/bloc/login_event.dart';
import 'package:fe/bloc/login/bloc/login_state.dart';
import 'package:fe/data/model/users_model.dart';
import 'package:fe/presentation/screen/login_screen.dart';
import 'package:fe/presentation/screen/register_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<RegisterScreen> {
  final fullnameController = TextEditingController(text: 'Fullname');
  final emailController = TextEditingController(text: 'heyy@gmail.com');
  final passwordController = TextEditingController(text: 'testing123');
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
                      radius: 100.0,
                      child: Image.asset('assets/images/icon.png'),
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
                        controller: fullnameController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Fullname',
                          labelText: 'Fullname *',
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
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          hintText: 'Konfirmasi Password',
                          labelText: 'Konfirmasi Password *',
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
                      child: const Text("Register"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sudah punya akun?"),
                        TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()), // Ganti SignUpScreen() dengan halaman pendaftaran yang sesuai
                      );
                    },
                    child: const Text("Login"),
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
