
import 'dart:convert';

class Contacts {
  List<Contact> contact;

  Contacts({
    this.contact,
  });

  factory Contacts.fromRawJson(String str) => Contacts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
    contact: json["contact"] == null ? null : List<Contact>.from(json["contact"].map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contact": contact == null ? null : List<dynamic>.from(contact.map((x) => x.toJson())),
  };
}

class Contact {
  String name;
  String phone;

  Contact({
    this.name,
    this.phone,
  });

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json["name"] == null ? null : json["name"],
    phone: json["Phone"] == null ? null : json["Phone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "Phone": phone == null ? null : phone,
  };
}
