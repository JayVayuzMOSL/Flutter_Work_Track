import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

extension CubitExtension<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) {
      emit(state);
    }
  }
}

extension DateParsing on String {
  DateTime toDate() {
    return DateFormat("d MMM yyyy").parse(this);
  }
}

extension StringParsing on DateTime {
  String toDateString() {
    return DateFormat("d MMM yyyy").format(this);
  }
}