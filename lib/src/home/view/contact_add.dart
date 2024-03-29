//

import 'package:contacts_demo/src/view.dart';

import 'package:contacts_demo/src/model.dart';

///
class AddContact extends StatefulWidget {
  ///
  const AddContact({this.contact, this.title, Key? key}) : super(key: key);

  ///
  final Contact? contact;

  ///
  final String? title;
  @override
  State createState() => _AddContactState();
}

/// Should always keep your State class 'hidden' with the leading underscore
class _AddContactState extends StateX<AddContact> {
  @override
  void initState() {
    super.initState();
    contact = widget.contact ?? Contact();
    //Link to this State object
    contact.pushState(this);
  }

  // Either an 'empty' contact or a contact passed to class, AddContact
  late Contact contact;

  @override
  void dispose() {
    // Detach from the State object.
    contact.popState();
    super.dispose();
  }

  /// Android interface
  @override
  Widget buildAndroid(BuildContext context) => _BuildAndroid(state: this);

  /// iOS interface
  @override
  Widget buildiOS(BuildContext context) => _BuildiOS(state: this);

  @override
  void onError(details) {
    if (kDebugMode) {
      print("Handle error in this 'Contacts List' State object!");
    }
  }
}

/// The Android interface.
class _BuildAndroid extends StatelessWidget {
  const _BuildAndroid({Key? key, required this.state}) : super(key: key);
  final _AddContactState state;

  @override
  Widget build(BuildContext context) {
//    throw 'Error in the build() function and see what happens!';
    final widget = state.widget;
    final contact = state.contact;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Add a contact'.tr),
        actions: [
          TextButton(
            onPressed: () async {
              final pop = await contact.onPressed();
              if (pop) {
                await contact.model.getContacts();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
            },
            child: const Icon(Icons.save, color: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: contact.formKey,
          child: ListView(
            children: [
              contact.givenName.textFormField,
              contact.middleName.textFormField,
              contact.familyName.textFormField,
              contact.phone.onListItems(),
              contact.email.onListItems(),
              contact.company.textFormField,
              contact.jobTitle.textFormField,
            ],
          ),
        ),
      ),
    );
  }
}

/// The iOS interface
class _BuildiOS extends StatelessWidget {
  const _BuildiOS({Key? key, required this.state}) : super(key: key);
  final _AddContactState state;

  @override
  Widget build(BuildContext context) {
    final widget = state.widget;
    final contact = state.contact;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Home',
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        middle: Text(widget.title ?? 'Add a contact'.tr),
        trailing: Material(
          child: TextButton(
            onPressed: () async {
              final pop = await contact.onPressed();
              if (pop) {
                await contact.model.getContacts();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
            },
            child: const Icon(Icons.save),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: contact.formKey,
          child: ListView(
            children: [
              contact.givenName.textFormField,
              contact.middleName.textFormField,
              contact.familyName.textFormField,
              contact.phone.onListItems(),
              contact.email.onListItems(),
              contact.company.textFormField,
              contact.jobTitle.textFormField,
            ],
          ),
        ),
      ),
    );
  }
}
