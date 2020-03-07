class Contact {
  String name;
  String phone;

  Contact(this.name, this.phone);

  @override
  String toString() {
    return "name: $name, phone: $phone";
  }
}

class Respo {
  List<Contact> lsContact = <Contact>[];

  List<Contact> getAll() {
    return lsContact;
  }

  void add(Contact c) {
    lsContact.insert(0, c);
  }

  void remove(String phone) {
    lsContact.removeWhere((c) => c.phone == phone);
  }

  void update(String phone, String name) {
    lsContact.firstWhere((c) => c.phone == phone).name = name;
  }
}
