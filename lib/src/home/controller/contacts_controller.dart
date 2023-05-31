//
import 'package:contacts_demo/src/view.dart';

import 'package:contacts_demo/src/controller.dart';

import 'package:contacts_demo/src/home/model/contact.dart';

import 'package:contacts_demo/src/home/model/contacts_db.dart';

import 'font_size.dart' as f;

import 'sort_items.dart' as s;

/// Controller for the home screen app
class ContactsController extends StateXController {
  ///
  factory ContactsController([StateX? state]) =>
      _this ??= ContactsController._(state);

  ContactsController._([StateX? state])
      : model = ContactsDB(),
        super(state);

  ///
  final ContactsDB model;
  static ContactsController? _this;

  @override
  Future<bool> initAsync() async {
    //
    final init = await model.initState();
    if (init) {
      await getContacts();
    }
    return init;
  }

  @override
  bool onAsyncError(FlutterErrorDetails details) {
    /// Supply an 'error handler' routine if something goes wrong
    /// in the corresponding initAsync() routine.
    /// Returns true to continue despite the error.
    if (kDebugMode) {
      print("Handle an asynchronous error in 'ContactsController.' A State object controller!");
    }
    return false;
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  /// The assign font size.
  double? get fontSize => f.fontSize;

  /// Increase the font size.
  void addFontSize() {
    f.addFontSize();
    getContacts().then((value) => super.setState(() {}));
  }

  /// Decrease the font size.
  void subFontSize() {
    f.subFontSize();
    getContacts().then((value) => super.setState(() {}));
  }

  /// Indicate if the records are sorted
  bool get sortedAlpha => s.sortedAlpha;

  ///
  Future<List<Contact>> getContacts() async {
    _contacts = await model.getContacts();
    if (sortedAlpha) {
      _contacts!.sort();
    }
    return _contacts!;
  }

  /// Called by menu option
  Future<List<Contact>> sort() async {
    s.sortedAlpha = !s.sortedAlpha;
    await getContacts();
    super.setState(() {});
    return _contacts!;
  }

  ///
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///
  List<Contact>? get items => _contacts;
  List<Contact>? _contacts;

  ///
  Contact? itemAt(int index) => items?.elementAt(index);

  ///
  Future<bool> deleteItem(int index) async {
    final Contact? contact = items?.elementAt(index);
    var delete = contact != null;
    if (delete) {
      delete = await contact.delete();
    }
    await getContacts().then((value) => super.setState(() {}));
    return delete;
  }
}
