class UserEntity {
  final String email;
  final String username;
  final String password;

  UserEntity({
    required this.email, 
    required this.username, 
    required this.password}){
      if(email.trim().isEmpty || !email.contains("@")){
        throw Exception('Invalid Email');
      }
      if(username.trim().isEmpty){
        throw Exception('Username cannot be empty');
      }
      if(password.trim().length < 4){
        throw Exception('Password must be at least 4 characters');
      }
    }
  
}