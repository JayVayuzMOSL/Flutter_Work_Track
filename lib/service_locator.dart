import 'package:flutter_work_track/data/models/employee_model.dart';
import 'package:flutter_work_track/data/repositories/employee_repository.dart';
import 'package:flutter_work_track/data/repositories/employee_repository_impl.dart';
import 'package:flutter_work_track/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:flutter_work_track/presentation/cubit/employee_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final employeeRepo = EmployeeRepositoryImpl();
  await employeeRepo.init(); // ✅ Ensure Hive box is opened

  getIt.registerLazySingleton<EmployeeRepository>(() => employeeRepo);

  // ✅ Register EmployeeCubit AFTER EmployeeRepository is available
  getIt.registerFactory<EmployeeCubit>(
      () => EmployeeCubit(employeeRepository: getIt<EmployeeRepository>()));
  getIt.registerFactoryParam<AddEditEmployeeCubit, EmployeeModel?, void>(
    (employee, _) => AddEditEmployeeCubit(employee),
  );
  print("🔹 Registered types in GetIt:");
  getIt.allReady().then((_) {
    print(getIt.allowReassignment);
  });
}
