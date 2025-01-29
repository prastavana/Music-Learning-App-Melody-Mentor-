import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String firstName;
  final String lastName;
  final String? image;
  final String email;
  final String? password;
  final String confirmPassword;

  const AuthApiModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password ?? '',
      confirmPassword: confirmPassword,
    );
  }

  //from Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      image: entity.image,
      email: entity.email,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
