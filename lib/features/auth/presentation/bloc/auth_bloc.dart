import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoodie/features/auth/domain/usecases/google_sign_in_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser? loginUser;
  final RegisterUser? registerUser;
  final GoogleSignInUseCase? googleSignInUseCase; // 👈 new field

  AuthBloc({
    this.loginUser,
    this.registerUser,
    this.googleSignInUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested); // 👈 new event handler
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      print('Attempting login with: ${event.email}');
      final user = await loginUser!(event.email, event.password);
      emit(AuthSuccess(user: user));
      print('Login successful: ${user?.email}');
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await registerUser!(event.email, event.password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await googleSignInUseCase!.call();
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(error: "Google Sign-In cancelled"));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
