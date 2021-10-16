import 'package:get/get.dart';
import 'package:news360/src/logic/global/variables.dart';

import 'auth_configuration.dart';
import 'authentication_state.dart';
import 'error_tracker.dart';

class AuthenticationController extends GetxController with ErrorTracker {
  late final AuthConfiguration _authenticationServices;

  final _authenticationState = const AuthenticationState().obs;

  AuthenticationState get state => _authenticationState.value;

  AuthenticationController(this._authenticationServices);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<void> signIn({required String email, required String password}) async {
    final user = await _authenticationServices.loginUser(
      email: email,
      password: password,
    );

    if (user == null) {
      _authenticationState.value = AuthenticatedFailure(message: error.value);
      return;
    }
    _authenticationState.value = Authenticated(user: user);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final user = await _authenticationServices.createUser(
      email: email,
      password: password,
      username: username,
    );
    if (user == null) {
      _authenticationState.value = AuthenticatedFailure(message: error.value);
      return;
    }
    _authenticationState.value = Authenticated(user: user);
  }

  Future<void> signOut() async {
    await _authenticationServices.logOut();
  }

  void _getAuthenticatedUser() {
    _authenticationState.value = AuthenticationLoading();

    final user = _authenticationServices.currentUser();

    if (user.email == null) {
      _authenticationState.value = UnAuthenticated();
    } else {
      _authenticationState.value = Authenticated(user: user);
    }
  }
}
