import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ContactEvent extends Equatable {
  ContactEvent();
}

class AddContact extends ContactEvent {
  String name;
  String phone;

  AddContact(this.name, this.phone);

  @override
  List<Object> get props => [name, phone];
}

class UpdateContact extends ContactEvent {
  String name;
  String phone;

  UpdateContact(this.name, this.phone);

  @override
  List<Object> get props => [name, phone];
}

class RemoveContact extends ContactEvent {
  final String phone;

  RemoveContact(@required this.phone);
  @override
  List<Object> get props => [phone];
}
