
import 'package:neomorphic_chat_flutter/Auth/auth_provider.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_event.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/exception.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final bool isInitialized;

  AuthBloc(AuthProvider provider, {this.isInitialized = false})
      : super(const AuthStateUninitialized(isLoading: true)) {
  // Initialize event
    on<AuthEventInitialise>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      
      if (user == null) {
        emit(const AuthStateLoggedOut(
          isLoading: false,
        ));
      } else {
        emit(AuthStateLoggedIn(
          isLoading: false,
          user: user,
        ));
      }
    });
    
    // Login event
    on<AuthEventSignIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
        isLoading: true,
      ));
      
      try {
        final user = await provider.login(
          event.email,
          event.password,
        );
        print(user.toString());
        if (user == null) {
          emit(AuthStateLoggedOut(
            isLoading: false,
            exception: UserNotFoundException()
          ));
        } else {
          emit(AuthStateLoggedIn(
            isLoading: false,
            user: user,
          ));
        }
      } catch (e) {
        emit(AuthStateLoggedOut(
          isLoading: false,
          exception: e as Exception,
        ));
      }
    });
    
    // Register event
    on<AuthEventRegister>((event, emit) async {
      emit(const AuthStateRegistering(
        isLoading: true,
        loadingText: 'Creating account...',
      ));
      
      try {
        final user = await provider.register(
          event.name,
          event.email,
          event.password,
        );
        print(user);
        if (user == null) {
          emit(AuthStateRegistering(
            isLoading: false,
            loadingText: null,
            exception: UserAlreadyExistsException(),
          ));
        } else {
          emit(AuthStateLoggedIn(
            isLoading: false,
            user: user,
          ));
        }
      } catch (e) {
        emit(AuthStateRegistering(
          isLoading: false,
          loadingText: null,
          exception: e as Exception,
        ));
      }
    });
    
    // Logout event
    on<AuthEventSignOut>((event, emit) async {
      emit(const AuthStateLoggedOut(
        isLoading: true,
      ));
      
      await provider.logout();
      
      emit(const AuthStateLoggedOut(
        isLoading: false,
      ));
    });
  }
}