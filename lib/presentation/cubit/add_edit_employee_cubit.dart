import 'package:bloc/bloc.dart';
import 'package:flutter_work_track/data/models/employee_model.dart';

import 'add_edit_employee_state.dart';

class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
  AddEditEmployeeCubit(EmployeeModel? employee)
      : super(AddEditEmployeeState(
          name: employee?.name ?? '',
          position: employee?.position,
          startDate: employee?.dateOfJoining,
          endDate: employee?.dateOfLeaveCompany,
        ));

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updatePosition(String position) {
    emit(state.copyWith(position: position));
  }

  void updateStartDate(String startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void updateEndDate(String endDate) {
    emit(state.copyWith(endDate: endDate));
  }
}
