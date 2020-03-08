import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:contactbloc/models/res.dart';
import './bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => InitialContactState();


  @override
  void onError(Object error, StackTrace stacktrace) {
    print('$error, $stacktrace');
  }

  @override
  void onTransition(Transition<ContactEvent, ContactState> transition) {
    print(transition);
  }

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is AddContact) {
      yield AddContactState(event.name, event.phone);
    } else if (event is UpdateContact) {
      yield UpdateContactState(event.name, event.phone);
    } else if (event is RemoveContact) {
      yield RemoveContactState(event.phone);
    }
  }
}
