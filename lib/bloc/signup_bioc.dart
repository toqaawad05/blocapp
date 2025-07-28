import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmittedEvent>(_onSignUpSubmitted);
    //
    on<SignUpReset>(_onSignUpReset);
    //
    on<InitiSingUpScreenEvent>(_onSignUpIniti);
  }

  // SignUpValidator signUpValidator;
  Future<void> _onSignUpSubmitted(
    SignUpSubmittedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    // Form validation
    if (event.email.isEmpty ||
        event.password.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(SignUpFailure('All fields are required'));
      return;
    }
    if (!event.email.contains('@')) {
      emit(SignUpFailure('Please enter a valid email'));
      return;
    }
    if (event.password.length < 6) {
      emit(SignUpFailure('Password must be at least 6 characters'));
      return;
    }
    if (event.password != event.confirmPassword) {
      emit(SignUpFailure('Passwords do not match'));
      return;
    }
    emit(SignUpLoading());
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    // Simulate success/failure
    if (event.email == 'exists@example.com') {
      emit(SignUpFailure('Email already in use'));
    } else {
      emit(SignUpSuccess(event.email));
    }
  }

  void _onSignUpReset(SignUpReset event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }

  void _onSignUpIniti(InitiSingUpScreenEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }
}
