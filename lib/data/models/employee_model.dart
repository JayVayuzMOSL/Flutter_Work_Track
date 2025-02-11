import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String position;

  @HiveField(3)
  final String dateOfJoining;

  @HiveField(4)
  final String dateOfLeaveCompany;

  EmployeeModel(
      {required this.id,
      required this.name,
      required this.position,
      required this.dateOfJoining,
      required this.dateOfLeaveCompany});

  @override
  List<Object?> get props => [id, name, position, dateOfJoining, dateOfLeaveCompany];

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? position,
    String? dateOfJoining,
    String? dateOfLeaveCompany,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      dateOfLeaveCompany: dateOfLeaveCompany ?? this.dateOfLeaveCompany,
    );
  }
}
