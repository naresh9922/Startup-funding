part of 'registration_bloc_bloc.dart';

@immutable
final class RegistrationState {}

final class RegistrationInitialState extends RegistrationState {}

final class StudentRegistrationFormState extends RegistrationState {}

final class InvestorRegistrationFormState extends RegistrationState {}

final class MentorRegistrationFormState extends RegistrationState {}

final class RegistrationFailedState extends RegistrationState {}

final class RegistrationInProgressState extends RegistrationState {}

final class RegistrationSuccessState extends RegistrationState {}
