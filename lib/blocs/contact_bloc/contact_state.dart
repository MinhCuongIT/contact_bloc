import 'package:contactbloc/models/res.dart';
import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  ContactState();
}

class InitialContactState extends ContactState {
  @override
  List<Object> get props => [];
}

class AddContactState extends ContactState {
  String name;
  String phone;

  AddContactState(this.name, this.phone);
  @override
  List<Object> get props => [name, phone];
}

class RemoveContactState extends ContactState {
  String phone;

  RemoveContactState(this.phone);

  @override
  List<Object> get props => [phone];
}

class UpdateContactState extends ContactState {
  String name;
  String phone;

  UpdateContactState(this.name, this.phone);

  @override
  List<Object> get props => [name, phone];
}
