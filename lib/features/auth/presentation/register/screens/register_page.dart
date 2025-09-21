import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:twitter/features/feed/presentation/widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onRegisterPressed(){
    context.read<RegisterBloc>().add(
      RegisterSubmitted(
        email: _emailController.text.trim(), 
        username: _usernameController.text.trim(), 
        password: _passwordController.text.trim(), 
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if(state is RegisterSuccess){
              Navigator.pushReplacementNamed(context, '/home');
            }
            if(state is RegisterFailure){
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
          child: BlocBuilder<RegisterBloc, RegisterState>(
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
                        controller: _usernameController,
                        label:'Username',
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
                      onPressed: state is RegisterLoading ? null : _onRegisterPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: state is RegisterLoading 
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                    ),
                  ),
          
          
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Already have an account? Login here",
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