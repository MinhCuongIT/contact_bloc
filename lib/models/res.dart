import 'package:shared_preferences/shared_preferences.dart';

import 'contacts.dart';

class Respo {
  Contacts contacts = Contacts();

  List<Contact> getAll() {
    return contacts.contact;
  }

  void add(Contact c) {
    contacts.contact.insert(0, c);
  }

  void remove(String phone) {
    contacts.contact.removeWhere((c) => c.phone == phone);
  }

  void update(String phone, String name) {
    contacts.contact.firstWhere((c) => c.phone == phone).name = name;
  }

  Future<bool> saveToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("contacts", contacts.toRawJson());
  }

  Future<bool> loadFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String rawJson = prefs.getString("contacts");
      if (rawJson!= null) {
        contacts = Contacts.fromRawJson(rawJson);
      }else{
        contacts.contact = <Contact>[];
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
