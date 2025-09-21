import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:twitter/features/feed/presentation/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    context.read<LoginBloc>().add(LoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess){
              Navigator.pushReplacementNamed(context, '/home');
            }
            if(state is LoginFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  )
                )
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  Center(
                    child: Image.asset('assets/images/icon.jpg', 
                      height: 48, 
                      width: 48,
                    )
                  ),

                  const SizedBox(height: 40),

                  Column(
                    children: [
                      customTextFormField(
                        controller: _emailController,
                        label:'Email',
                        keyboardType: TextInputType.emailAddress
                      ),

                      const SizedBox(height: 20),

                      customTextFormField(
                        controller: _passwordController,
                        label:'Password',
                        obscureText: true,
                      ),

                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is LoginLoading ? null : _onLoginPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: state is LoginLoading 
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                    ),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text(
                      "Don't have an account? Register here",
                      style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline)
                    ),
                  ),
                
                ],
              );
            },
          ),
        ),
      ),
    );
  }


}
