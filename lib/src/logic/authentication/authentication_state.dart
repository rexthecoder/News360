import 'package:equatable/equatable.dart';
import '../model/user_models/user_data_model.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthenticationState {
  final UserResponseModel user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthenticationLoading extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class AuthenticatedFailure extends AuthenticationState {
  final String message;

  const AuthenticatedFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
