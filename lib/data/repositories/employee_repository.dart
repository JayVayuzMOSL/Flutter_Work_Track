import 'package:flutter_work_track/data/models/employee_model.dart';

abstract class EmployeeRepository {
  /// Get all employees from the repository
  List<EmployeeModel> getAllEmployees();

  /// Add a new employee to the repository
  Future<void> addEmployee(EmployeeModel employee);

  /// Update an existing employee in the repository
  Future<void> updateEmployee(EmployeeModel employee);

  /// Delete an employee by ID
  Future<void> deleteEmployee(String id);
}
