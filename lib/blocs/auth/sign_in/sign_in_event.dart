abstract class SignInEvent {}

class EmailChanged extends SignInEvent {
  final String email;

  EmailChanged({required this.email});
}
