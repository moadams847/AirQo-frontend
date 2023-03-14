part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class FetchAccountInfo extends AccountEvent {
  const FetchAccountInfo();
  @override
  List<Object?> get props => [];
}

class LoadAccountInfo extends AccountEvent {
  const LoadAccountInfo();
  @override
  List<Object?> get props => [];
}

class RefreshProfile extends AccountEvent {
  const RefreshProfile();
  @override
  List<Object?> get props => [];
}

class LogOutAccount extends AccountEvent {
  const LogOutAccount({
    required this.context,
  });
  final BuildContext context;
  @override
  List<Object?> get props => [];
}

class DeleteAccount extends AccountEvent {
  const DeleteAccount({
    required this.context,
  });
  final BuildContext context;

  @override
  List<Object?> get props => [];
}

class AccountDeletionCheck extends AccountEvent {
  const AccountDeletionCheck({
    this.error,
    required this.passed,
  });

  final bool passed;
  final AuthenticationError? error;
  @override
  List<Object?> get props => [
        passed,
        error,
      ];
}

class EditProfile extends AccountEvent {
  const EditProfile({
    this.firstName,
    this.lastName,
    this.photoUrl,
  });

  final String? firstName;
  final String? lastName;
  final String? photoUrl;

  @override
  List<Object?> get props => [firstName, lastName, photoUrl];
}

class UpdateProfile extends AccountEvent {
  const UpdateProfile();

  @override
  List<Object?> get props => [];
}

class UpdateProfilePreferences extends AccountEvent {
  const UpdateProfilePreferences({
    this.notifications,
    this.location,
  });
  final bool? notifications;
  final bool? location;

  @override
  List<Object?> get props => [location, notifications];
}
