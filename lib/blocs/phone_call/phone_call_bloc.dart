import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PhoneCallBloc extends Bloc<PhoneCallEvent, PhoneCallState> {
  @override
  PhoneCallState get initialState => InitialPhoneCallState();

  @override
  Stream<PhoneCallState> mapEventToState(
    PhoneCallEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
