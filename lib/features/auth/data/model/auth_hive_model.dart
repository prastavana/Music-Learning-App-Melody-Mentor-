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
  final String name; // updated field
  @HiveField(2)
  final String email; // updated field
  @HiveField(3)
  final String password; // updated field

  AuthHiveModel({
    String? studentId,
    required this.name, // updated field
    required this.email, // updated field
    required this.password, // updated field
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        name = '', // updated field
        email = '', // updated field
        password = ''; // updated field

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      name: entity.name, // updated field
      email: entity.email, // updated field
      password: entity.password, // updated field
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      name: name, // updated field
      email: email, // updated field
      password: password, // updated field
    );
  }

  @override
  List<Object?> get props => [studentId, name, email, password];
}
