import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/sources/supabase_auth_sources.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, MyAuthState> {
  final SupabaseAuthSource authSource;

  AuthBloc(this.authSource) : super(AuthInitialState()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<MyAuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final email = await authSource.signIn(event.email, event.password);
      emit(AuthSuccessState(email: email));
    } catch (e) {
      final errorMessage = _getCustomErrorMessage(e.toString());
      emit(AuthFailureState(message: errorMessage));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<MyAuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final email = await authSource.signUp(event.email, event.password);
      emit(AuthSuccessState(email: email));
    } catch (e) {
      final errorMessage = _getCustomErrorMessage(e.toString());
      emit(AuthFailureState(message: errorMessage));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<MyAuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await authSource.signOut();
      emit(AuthInitialState());
    } catch (e) {
      final errorMessage = _getCustomErrorMessage(e.toString());
      emit(AuthFailureState(message: errorMessage));
    }
  }

  String _getCustomErrorMessage(String error) {
    if (error.contains('email')) {
      return 'Invalid email address. Please check and try again.';
    } else if (error.contains('password')) {
      return 'Incorrect password. Please try again.';
    } else if (error.contains('network')) {
      return 'Network issue. Please check your internet connection.';
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}
