class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email, 
    required this.password}){
      if(email.trim().isEmpty || !email.contains("@") || !email.contains(".com")){
        throw Exception('Invalid Email');
      }
      if(password.trim().length < 4){
        throw Exception('Password must be at least 4 characters');
      }
    }
  
}