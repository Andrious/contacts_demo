//
import 'dart:core';

import 'package:dbutils/sqlite_db.dart' show Database, SQLiteDB, Transaction;

import 'package:contacts_demo/src/view.dart' show DataFieldItem, showBox;

import 'contact.dart' show Contact;

///
class ContactsDB extends SQLiteDB {
  ///
  factory ContactsDB() => _this ??= ContactsDB._();
  ContactsDB._() : super();

  /// Make only one instance of this class.
  static ContactsDB? _this;

  @override
  String get name => 'Contacts';

  @override
  int get version => 1;

  /// An Asynchronous operation is involved when initializing this class.
  Future<bool> initState() => init(); //throw 'Error in iniState()'; // init();

  /// Just to show you there's a dispose function called in the parent class.
  void dispose() => disposed();

  @override
  Future<void> onConfigure(Database db) {
    return db.execute('PRAGMA foreign_keys=ON;');
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.transaction((Transaction txn) async {
      await txn.execute('''
     CREATE TABLE Contacts(
              id INTEGER PRIMARY KEY
              ,givenName TEXT
              ,middleName TEXT
              ,familyName TEXT
              ,company TEXT
              ,jobTitle TEXT
              ,deleted INTEGER DEFAULT 0
              )
     ''');

      await txn.execute('''
     CREATE TABLE Emails(
              id INTEGER PRIMARY KEY
              ,userid INTEGER
              ,type TEXT
              ,email TEXT
              ,deleted INTEGER DEFAULT 0
              ,FOREIGN KEY (userid) REFERENCES Contacts (id)
              )
     ''');

      await txn.execute('''
     CREATE TABLE Phones(
              id INTEGER PRIMARY KEY
              ,userid INTEGER
              ,type TEXT
              ,phone TEXT
              ,deleted INTEGER DEFAULT 0
              )
     ''');
    }, exclusive: true);
  }

  ///
  Future<List<Contact>> getContacts() async {
    return listContacts(
        await _this!.rawQuery('SELECT * FROM Contacts WHERE deleted = 0'));
  }

  ///
  Future<List<Contact>> listContacts(List<Map<String, dynamic>> query) async {
    //
    final contactList = <Contact>[];

    for (final contact in query) {
      //
      final map = contact.map((key, value) {
        return MapEntry(key, value is int ? value.toString() : value);
      });

      final phones = await _this!.rawQuery(
          'SELECT * FROM Phones WHERE userid = ${contact['id']} AND deleted = 0');

      map['phones'] =
          phones.map((m) => DataFieldItem.fromMap(m, value: 'phone')).toList();

      final emails = await _this!.rawQuery(
          'SELECT * FROM Emails WHERE userid = ${contact['id']} AND deleted = 0');

      map['emails'] =
          emails.map((m) => DataFieldItem.fromMap(m, value: 'email')).toList();

      contactList.add(Contact.fromMap(map));
    }

    return contactList;
  }

  ///
  Future<bool> addContact(Contact contact) async {
    //
    var add = true;

    final map = contact.toMap;

    // The Contact's unique id
    dynamic id = map['id'];

    if (contact.isChanged()) {
      //
      final newContact = await _this!.saveMap('Contacts', map);

      id ??= newContact['id'];

      add = newContact.isNotEmpty;
    }

    // Save Phone Numbers
    if (add && contact.phoneChange()) {
      //
      for (final Map<String, dynamic> phone in map['phones']) {
        //
        if (phone.isEmpty) {
          continue;
        }

        phone.addAll({'userid': id});

        final phoneNumber = phone['phone'] as String;

        if (phoneNumber.isEmpty) {
          //
          phone['phone'] = phone['initValue'];

          final delete = await showBox(
              text: 'Deleting this Phone number?',
              context: contact.state!.context);

          if (delete) {
            phone.addAll({'deleted': 1});
          }
        }

        await _this!.saveMap('Phones', phone);
      }
    }

    if (add && contact.emailChange()) {
      // Save Emails.
      for (final Map<String, dynamic> email in map['emails']) {
        //
        if (email.isEmpty) {
          continue;
        }

        email.addAll({'userid': id});

        final emailAddress = email['email'] as String;

        if (emailAddress.isEmpty) {
          //
          email['phone'] = email['initValue'];

          final delete = await showBox(
              text: 'Deleting this email?', context: contact.state!.context);

          if (delete) {
            email.addAll({'deleted': 1});
          }
        }

        await _this!.saveMap('Emails', email);
      }
    }
    return add;
  }

  ///
  void func(key, value) {}

  ///
  Future<bool> deleteContact(Contact contact) async {
    //
    final id = contact.id.value;

    final count = await _this!
        .rawUpdate('UPDATE Contacts SET deleted = 1 WHERE id = ?', [id]);

    final deleted = count > 0;

    if (deleted) {
      //
      var recs = await _this!
          .rawUpdate('UPDATE Phones SET deleted = 1 WHERE userid = ?', [id]);

      recs = await _this!
          .rawUpdate('UPDATE Emails SET deleted = 1 WHERE userid = ?', [id]);
    }
    return deleted;
  }

  ///
  Future<int> undeleteContact(Contact contact) async {
    //
    final map = contact.toMap;

    var id = map['id'];

    if (id == null) {
      return Future.value(0);
    }

    if (id is String) {
      id = int.parse(id);
    }

    final recs = await _this!
        .rawUpdate('UPDATE Contacts SET deleted = 0 WHERE id = ?', [id]);

    if (recs > 0) {
      //
      var count = await _this!
          .rawUpdate('UPDATE Phones SET deleted = 0 WHERE userid = ?', [id]);

      count = await _this!
          .rawUpdate('UPDATE Emails SET deleted = 0 WHERE userid = ?', [id]);
    }
    return recs;
  }
}
