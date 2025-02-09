import 'package:equatable/equatable.dart';

class AddEditEmployeeState extends Equatable {
  final String name;
  final String? position;
  final String? startDate;
  final String? endDate;

  const AddEditEmployeeState({
    this.name = '',
    this.position,
    this.startDate,
    this.endDate,
  });

  AddEditEmployeeState copyWith({
    String? name,
    String? position,
    String? startDate,
    String? endDate,
  }) {
    return AddEditEmployeeState(
      name: name ?? this.name,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [name, position, startDate, endDate];
}
