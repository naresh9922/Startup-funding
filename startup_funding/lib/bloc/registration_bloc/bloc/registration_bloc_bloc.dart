import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'registration_bloc_event.dart';
part 'registration_bloc_state.dart';

class RegistrationBloc extends Bloc<RegistrationBlocEvent, RegistrationState> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  RegistrationBloc() : super(RegistrationInitialState()) {
    on<RegistrationInitialEvent>(registrationInitialEvent);
    on<StudentRoleSelectedEvent>(studentRoleSelectedEvent);
    on<InvestorRoleSelectedEvent>(investorRoleSelectedEvent);
    on<MentorRoleSelectedEvent>(mentorRoleSelectedEvent);
    on<RegisterButtonClickedEventEvent>(registerButtonClickedEventEvent);
  }

  FutureOr<void> studentRoleSelectedEvent(
      StudentRoleSelectedEvent event, Emitter<RegistrationState> emit) {
    debugPrint("StudentRegistrationFormState");
    emit(StudentRegistrationFormState());
  }

  FutureOr<void> investorRoleSelectedEvent(
      InvestorRoleSelectedEvent event, Emitter<RegistrationState> emit) {
    debugPrint("InvestorRegistrationFormState");
    emit(InvestorRegistrationFormState());
  }

  FutureOr<void> mentorRoleSelectedEvent(
      MentorRoleSelectedEvent event, Emitter<RegistrationState> emit) {
    debugPrint("MentorRegistrationFormState");
    emit(MentorRegistrationFormState());
  }

  FutureOr<void> registerButtonClickedEventEvent(
      RegisterButtonClickedEventEvent event,
      Emitter<RegistrationState> emit) async {
    emit(RegistrationInProgressState());
    debugPrint("RegistrationInProgressState ${event.role}");

    if (event.role == "Mentor") {
      await users.add({
        'role': event.data['role'],
        'name': event.data['name'],
        'phone': event.data['phone'],
        'email': event.data['email'],
        'address': event.data['address'],
        'passwprd': event.data['password']
      }).then((value) {
        debugPrint(" ${event.role} Added ");
        emit(RegistrationSuccessState());
      }).catchError((error) {
        debugPrint("Failed to add ${event.role} : $error");
        emit(RegistrationFailedState());
      });
    }

    if (event.role == "Investor") {
      await users.add({
        'role': event.data['role'],
        'name': event.data['name'],
        'phone': event.data['phone'],
        'email': event.data['email'],
        'address': event.data['address'],
        'occupation': event.data['occupation'],
        'experience': event.data['experience'],
        'passwprd': event.data['password']
      }).then((value) {
        debugPrint(" ${event.role} Added ");
        emit(RegistrationSuccessState());
      }).catchError((error) {
        debugPrint("Failed to add ${event.role} : $error");
        emit(RegistrationFailedState());
      });
    }

    if (event.role == "Student") {
      await users.add({
        'role': event.data['role'],
        'name': event.data['name'],
        'phone': event.data['phone'],
        'email': event.data['email'],
        'address': event.data['address'],
        'class': event.data['class'],
        'password': event.data['password']
      }).then((value) {
        debugPrint(" ${event.role} Added ");
        emit(RegistrationSuccessState());
      }).catchError((error) {
        debugPrint("Failed to add ${event.role} : $error");
        emit(RegistrationFailedState());
      });
    }
    emit(RegistrationSuccessState());
  }

  FutureOr<void> registrationInitialEvent(
      RegistrationInitialEvent event, Emitter<RegistrationState> emit) {
    debugPrint("RegistrationInitialState");
    emit(RegistrationInitialState());
  }
}
