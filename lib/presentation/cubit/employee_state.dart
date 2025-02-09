import 'package:equatable/equatable.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';

abstract class EmployeeState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<EmployeeModel> employees;

  EmployeeLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}
