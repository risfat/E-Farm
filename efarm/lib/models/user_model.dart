import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String type;
  final String email;
  final String emailVerifiedAt;
  final String twoFactorConfirmedAt;
  final int currentTeamId;
  final String createdAt;
  final String updatedAt;
  final String profilePhotoUrl;
  final String supplyDemand;
  final String status;
  final String address;

  const UserModel(this.id, this.name, this.phone, this.type, this.email, this.emailVerifiedAt,
      this.twoFactorConfirmedAt, this.currentTeamId, this.createdAt, this.updatedAt, this.profilePhotoUrl, this.supplyDemand, this.status, this.address );

  UserModel.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        name = json['name'],
        phone = json['phone'],
        type = json['type'],
        address = json['address'],
        email = json['email'],
        emailVerifiedAt = json['email_verified_at'].toString(),
        twoFactorConfirmedAt = json['two_factor_confirmed_at'].toString(),
        currentTeamId = json['current_team_id'] ?? 0,
        createdAt = json['created_at'].toString(),
        updatedAt = json['updated_at'].toString(),
        profilePhotoUrl = json['profile_photo_url'] ?? "",
        supplyDemand = json['bio'] ?? "",
        status = json['status'] ?? "";

  @override
  List<Object> get props => [id, name, phone, email, emailVerifiedAt, twoFactorConfirmedAt, currentTeamId,
    createdAt, updatedAt, profilePhotoUrl, supplyDemand, status];


  static const empty = UserModel(0, "", "", "", "", "", "", 0, "", "", "", "", "", "");
}