import 'package:equatable/equatable.dart';

class AuthErrorModel extends Equatable{
  final String message;
  final Map<String, List<String>> errors;

  const AuthErrorModel({
    required this.message,
    required this.errors,
  });

  factory AuthErrorModel.fromJson(Map<String, dynamic> json) {
    return AuthErrorModel(
      message: json['message'],
      errors: json['errors'] != null
          ? (json['errors'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, List<String>.from(value)))
          : {},
    );
  }

  @override
  List<Object> get props => [message, errors];
}
