import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/data/repositories/employee_repository.dart';
import 'package:hive/hive.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  static final EmployeeRepositoryImpl _instance = EmployeeRepositoryImpl._internal();

  static const String _boxName = "employeeBox";

  // Private constructor
  EmployeeRepositoryImpl._internal();

  factory EmployeeRepositoryImpl() => _instance;

  Future<void> init() async {
    Hive.registerAdapter(EmployeeModelAdapter());
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<EmployeeModel>(_boxName);
    }
  }

  @override
  List<EmployeeModel> getAllEmployees() {
    final box = Hive.box<EmployeeModel>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> addEmployee(EmployeeModel employee) async {
    final box = Hive.box<EmployeeModel>(_boxName);
    await box.put(employee.id, employee);
  }

  @override
  Future<void> updateEmployee(EmployeeModel employee) async {
    final box = Hive.box<EmployeeModel>(_boxName);
    await box.put(employee.id, employee);
  }

  @override
  Future<void> deleteEmployee(String id) async {
    final box = Hive.box<EmployeeModel>(_boxName);
    await box.delete(id);
  }
}
