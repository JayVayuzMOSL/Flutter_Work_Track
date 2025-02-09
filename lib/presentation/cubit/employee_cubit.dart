import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_track/core/constants/extensions.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/data/repositories/employee_repository.dart';
import 'package:flutter_work_track/presentation/cubit/employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _employeeRepository;

  EmployeeCubit({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(EmployeeInitial());

  /// Load all employees from the database
  Future<void> loadEmployees() async {
    safeEmit(EmployeeLoading());
    try {
      final employees = _employeeRepository.getAllEmployees();
      if(employees.isEmpty){
        safeEmit(EmployeeError('No Employees Found'));
      }
      else {
        safeEmit(EmployeeLoaded(employees));
      }
    } catch (e) {
      safeEmit(EmployeeError('No Employees Found'));
    }
  }

  /// Add a new employee
  Future<void> addEmployee(EmployeeModel employee,{bool undoItem=false}) async {
    await _employeeRepository.addEmployee(employee);
    await loadEmployees();
  }

  /// Update existing employee data
  Future<void> updateEmployee(EmployeeModel employee) async {
    await _employeeRepository.updateEmployee(employee);
    await loadEmployees(); // Ensure UI refresh
  }

  /// Delete an employee
  Future<void> deleteEmployee(String id) async {
    await _employeeRepository.deleteEmployee(id);
    await loadEmployees();
  }
}
