import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String firstName; // updated field
  @HiveField(2)
  final String lastName; // updated field
  @HiveField(3)
  final String email; // updated field
  @HiveField(4)
  final String password; // updated field
  @HiveField(5)
  final String confirmPassword; // updated field

  AuthHiveModel({
    String? studentId,
    required this.firstName, // updated field
    required this.lastName, // updated field
    required this.email, // updated field
    required this.password, // updated field
    required this.confirmPassword, // updated field
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        firstName = '', // updated field
        lastName = '', // updated field
        email = '', // updated field
        password = '', // updated field
        confirmPassword = ''; // updated field

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      firstName: entity.firstName, // updated field
      lastName: entity.lastName, // updated field
      email: entity.email, // updated field
      password: entity.password, // updated field
      confirmPassword: entity.confirmPassword, // updated field
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      firstName: firstName, // updated field
      lastName: lastName, // updated field
      email: email, // updated field
      password: password, // updated field
      confirmPassword: confirmPassword, // updated field
    );
  }

  @override
  List<Object?> get props =>
      [studentId, firstName, lastName, email, password, confirmPassword];
}