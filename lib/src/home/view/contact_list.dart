//
import 'package:contacts_demo/src/controller.dart';

import 'package:contacts_demo/src/model.dart';

import 'package:contacts_demo/src/view.dart';

import 'contact_add.dart' show AddContact;

import 'contact_details.dart' show ContactDetails;

import 'util/draggable_fab.dart';

import 'util/offset_fab.dart';

/// Lists all the contacts
class ContactsList extends StatefulWidget {
  ///
  const ContactsList({super.key});

  ///
  @override
  State createState() => _ContactListState();
}

class _ContactListState extends StateX<ContactsList> {
  _ContactListState() : super(ContactsController()) {
    con = controller as ContactsController;
  }
  late ContactsController con;
  @override
  void initState() {
    super.initState();
    appCon = DemoController();
  }

  late DemoController appCon;

  @override
  Widget buildAndroid(BuildContext context) => _forAndroid(this);

  @override
  Widget buildiOS(BuildContext context) => _foriOS(this);

  @override // _ContactListState StateX
  void onError(details) {
    if (kDebugMode) {
      print("Handle error in this 'Contacts List' State object!");
    }
  }
}

Widget _forAndroid(_ContactListState state) {
  //
  final con = state.con;
  final appMenu = AppMenu();
  final offset = OffsetPrefs('AddOffset');
  final onLeftSide = Settings.onLeftSide;

  // The sort button
  Widget _sort() => TextButton(
        onPressed: con.sort,
        child: Icon(con.sortedAlpha ? Icons.sort : Icons.sort_by_alpha,
            color: Colors.white),
      );

  // Supply the appropriate title
  Widget _title() {
    Widget title = L10n.t(App.title!);
    if (onLeftSide) {
      title = Row(children: [
        _sort(),
        const SizedBox(width: 20),
        Flexible(child: title),
      ]);
    }
    return title;
  }

  return Scaffold(
    appBar: AppBar(
      leading: onLeftSide ? appMenu.popupMenuButton : null,
      automaticallyImplyLeading: onLeftSide,
      title: _title(),
      actions: onLeftSide ? null : [_sort(), appMenu.popupMenuButton],
      bottom: appMenu.tabBar,
    ),
    floatingActionButton: DraggableFab(
      onDragEnd: offset.set,
      initPosition: offset.get(),
      button: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(state.context).push(MaterialPageRoute<void>(
            builder: (_) => const AddContact(),
          ));
          await con.getContacts();
          state.setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    ),
    body: SafeArea(
      child: con.items == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: con.items?.length ?? 0,
              itemBuilder: (_, int index) {
                final contact = con.itemAt(index);
                return contact!.displayName.onDismissible(
                  background: Container(
                    color: Colors.red,
                    child: const ListTile(
                      leading:
                          Icon(Icons.delete, color: Colors.white, size: 36),
                      trailing:
                          Icon(Icons.delete, color: Colors.white, size: 36),
                    ),
                  ),
                  dismissed: (DismissDirection direction) {
                    con.deleteItem(index);
                    final action = (direction == DismissDirection.endToStart)
                        ? 'deleted'
                        : 'archived';
                    App.snackBar(
                      duration: const Duration(milliseconds: 8000),
                      content: Text('You $action an item.'.tr),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () async {
                            await contact.undelete();
                            await con.getContacts();
                            state.setState(() {});
                          }),
                    );
                  },
                  child: ListTile(
                    onTap: () async {
                      await Navigator.of(state.context)
                          .push(MaterialPageRoute<void>(
                        builder: (_) => ContactDetails(contact: contact),
                      ));
                      await con.getContacts();
                      state.setState(() {});
                    },
                    leading: contact.displayName.circleAvatar,
                    title: contact.displayName.text,
                  ),
                );
              },
            ),
    ),
  );
}

Widget _foriOS(_ContactListState state) {
  //
  final con = state.con;
  final theme = App.themeData;
  final onLeftSide = Settings.onLeftSide;

  // Sort items button
  Widget _sort() => Material(
        child: IconButton(
          icon: Icon(con.sortedAlpha ? Icons.sort : Icons.sort_by_alpha),
          onPressed: con.sort,
        ),
      );

  return CupertinoPageScaffold(
    child: CustomScrollView(
      semanticChildCount: 5,
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: L10n.t(App.title!),
          leading: onLeftSide ? AppMenu().popupMenuButton : _sort(),
          middle: Material(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(con.state!.context)
                    .push(CupertinoPageRoute<void>(
                  builder: (_) => const AddContact(),
                ));
                await con.getContacts();
                state.setState(() {});
              },
            ),
          ),
          trailing: onLeftSide ? _sort() : AppMenu().popupMenuButton,
        ),
        if (con.items == null)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                final contact = con.itemAt(index);
                return contact?.displayName.onDismissible(
                  background: Material(
                    child: Container(
                      color: Colors.red,
                      child: const ListTile(
                        leading:
                            Icon(Icons.delete, color: Colors.white, size: 40),
                        trailing:
                            Icon(Icons.delete, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                  dismissed: (DismissDirection direction) {
                    con.deleteItem(index);
                    final action = (direction == DismissDirection.endToStart)
                        ? 'deleted'
                        : 'archived';
                    App.snackBar(
                      duration: const Duration(milliseconds: 8000),
                      content: Text('You $action an item.'),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () async {
                            await contact.undelete();
                            state.setState(() {});
                          }),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme?.canvasColor,
                      border: Border(
                        bottom: BorderSide(color: theme!.dividerColor),
                      ),
                    ),
                    child: CupertinoListTile(
                      leading: contact.displayName.circleAvatar,
                      title: contact.displayName.text,
                      onTap: () async {
                        await Navigator.of(state.context)
                            .push(MaterialPageRoute<void>(
                          builder: (_) => ContactDetails(contact: contact),
                        ));
                        await con.getContacts();
                        state.setState(() {});
                      },
                    ),
                  ),
                );
              },
              childCount: con.items?.length,
              semanticIndexCallback: (Widget widget, int localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                return null;
              },
            ),
          ),
      ],
    ),
  );
}
