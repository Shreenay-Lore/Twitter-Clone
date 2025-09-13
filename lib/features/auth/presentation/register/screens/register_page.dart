import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/features/auth/presentation/register/bloc/register_bloc.dart';

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
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if(state is RegisterLoading){
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),

                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    label: Text('Username'),
                  ),
                ),

                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _onRegisterPressed, 
                  child: const Text('Register'),
                ),

                const SizedBox(height: 20),

                if(state is RegisterFailure)
                Text(state.message,),

                if(state is RegisterSuccess)
                const Text('Register Success'),

              ],
            );
          },
        ),
      ),
    );
  
  }
}