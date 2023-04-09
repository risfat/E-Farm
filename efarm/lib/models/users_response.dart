
import 'user_model.dart';

class UsersResponse {
  final List<UserModel> users;
  final int currentPage;
  final int lastPage;
  final bool hasError;
  final String error;

  UsersResponse(this.users, this.currentPage, this.lastPage, this.hasError, this.error);

  UsersResponse.fromJson(Map<String, dynamic> json)
      : users = (json["users"] as List)
            .map((i) => UserModel.fromJson(i))
            .toList(),
        currentPage = json["current_page"] ?? 0,
        lastPage = json["last_page"] ?? 0,
        hasError = false,
        error = "";

  UsersResponse.withError(String errorValue)
      : users = [],
        currentPage = 0,
        lastPage = 0,
        hasError = true,
        error = errorValue;
}
