part of 'registration_bloc_bloc.dart';

@immutable
sealed class RegistrationBlocEvent {}

final class RegistrationInitialEvent extends RegistrationBlocEvent {}

final class MentorRoleSelectedEvent extends RegistrationBlocEvent {}

final class InvestorRoleSelectedEvent extends RegistrationBlocEvent {}

final class StudentRoleSelectedEvent extends RegistrationBlocEvent {}

final class RegisterButtonClickedEventEvent extends RegistrationBlocEvent {
  final String role;
  final Map<String, dynamic> data;
  RegisterButtonClickedEventEvent(this.role, this.data);
}
