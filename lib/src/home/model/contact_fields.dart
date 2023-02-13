//
import 'package:contacts_demo/src/view.dart';

import 'contact.dart' show Contact;

///
class Id extends ContactsField {
  ///
  Id(dynamic value) : super(label: 'Identifier'.tr, value: value);
}

///
class DisplayName extends ContactsField {
  ///
  DisplayName(String value, Widget child, TextStyle style)
      : super(
          label: 'Display Name'.tr,
          value: value,
          style: style,
          child: child,
        );
}

///
class GivenName extends ContactsField {
  ///
  GivenName([dynamic value])
      : super(
          label: 'First Name'.tr,
          textCapitalization: TextCapitalization.sentences,
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        );
}

///
class MiddleName extends ContactsField {
  ///
  MiddleName([dynamic value])
      : super(
          label: 'Middle Name'.tr,
          textCapitalization: TextCapitalization.sentences,
          value: value,
          keyboardType: TextInputType.name,
        );
}

///
class FamilyName extends ContactsField {
  ///
  FamilyName([dynamic value])
      : super(
          label: 'Last Name'.tr,
          textCapitalization: TextCapitalization.sentences,
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        );
}

///
class Company extends ContactsField {
  ///
  Company([dynamic value])
      : super(
          label: 'Company'.tr,
          textCapitalization: TextCapitalization.sentences,
          value: value,
          keyboardType: TextInputType.name,
        );
}

///
class JobTitle extends ContactsField {
  ///
  JobTitle([dynamic value])
      : super(
          label: 'Job'.tr,
          textCapitalization: TextCapitalization.sentences,
          value: value,
          keyboardType: TextInputType.name,
        );
}

///
class Phone extends ContactsField {
  ///
  Phone([dynamic value])
      : super(
          label: 'Phone'.tr,
          value: value,
          inputDecoration: InputDecoration(
            labelText: 'Phone'.tr,
          ),
          keyboardType: TextInputType.phone,
        ) {
    // Change the name of the map's key fields.
    keys(value: 'phone');
    // There may be more than one phone number
    one2Many<Phone>(Phone.new);
  }

  ///
  Phone.init(DataFieldItem dataItem)
      : super(
          label: dataItem.label,
          value: dataItem.value,
          type: dataItem.type,
        );

  @override
  ListItems<Contact> onListItems({
    String? title,
    List<FieldWidgets<Contact>>? items,
    MapItemFunction? mapItem,
    GestureTapCallback? onTap,
    ValueChanged<String?>? onChanged,
    List<String>? dropItems,
  }) =>
      super.onListItems(
        title: title,
        items: items,
        mapItem: mapItem,
        onTap: onTap,
        onChanged: onChanged ?? (String? value) => state!.setState(() {}),
        dropItems: dropItems ??
            ['home'.tr, 'work'.tr, 'landline'.tr, 'mobile'.tr, 'other'.tr],
      );

  @override
  List<Map<String, dynamic>> mapItems<U extends FieldWidgets<Contact>>(
      String key,
      List<DataFieldItem>? items,
      U Function(DataFieldItem dataItem) create,
      [U? itemsObj]) {
    //
    final list = super.mapItems<U>(key, items, create, itemsObj);

    //ignore: unnecessary_cast
    for (int cnt = 0; cnt <= this.items!.length - 1; cnt++) {
      //
      final phone = this.items!.elementAt(cnt) as Phone;

      list[cnt]['initValue'] = phone.initialValue;
    }
    return list;
  }
}

///
class Email extends ContactsField {
  ///
  Email([dynamic value])
      : super(
          label: 'Email'.tr,
          value: value,
          inputDecoration: InputDecoration(
            labelText: 'Email'.tr,
          ),
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
        ) {
    // There may be more than one email address.
    one2Many<Email>(Email.new);
  }

  ///
  Email.init(DataFieldItem dataItem)
      : super(
          label: dataItem.label,
          value: dataItem.value,
          type: dataItem.type,
        );

  @override
  ListItems<Contact> onListItems({
    String? title,
    List<FieldWidgets<Contact>>? items,
    MapItemFunction? mapItem,
    GestureTapCallback? onTap,
    ValueChanged<String?>? onChanged,
    List<String>? dropItems,
  }) =>
      super.onListItems(
        title: title,
        items: items,
        mapItem: mapItem,
        onTap: onTap,
        dropItems: dropItems ?? ['home'.tr, 'work'.tr, 'other'.tr],
        onChanged: onChanged ??
            (String? value) {
              state!.setState(() {});
            },
      );
}

/// Base class for all the fields
class ContactsField extends FieldWidgets<Contact> with FormFields {
  ///
  ContactsField({
    super.key,
    super.object,
    super.label,
    super.value,
    super.type,
// TextFormField
    super.controller,
    super.initialValue,
    super.focusNode,
    super.inputDecoration,
    super.keyboardType,
    super.textCapitalization,
    super.textInputAction,
    super.textSpan,
    super.style,
    super.textAlign,
    super.autofocus,
    super.obscureText,
    super.autocorrect,
//    super.autovalidate,
//    super.maxLengthEnforced,
    super.maxLengthEnforcement,
    super.maxLines,
    super.maxLength,
    super.changed,
    super.editingComplete,
    super.fieldSubmitted,
    super.saved,
    super.validator,
    super.inputFormatters,
    super.enabled,
    super.keyboardAppearance,
    super.scrollPadding,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
// Text
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
// ListTile
    super.leading,
    super.title,
    super.subtitle,
    super.trailing,
    super.isThreeLine,
    super.dense,
    super.visualDensity,
    super.shape,
    super.selectedColor,
    super.iconColor,
    super.textColor,
    super.contentPadding,
    super.tap,
    super.longPress,
    super.mouseCursor,
    super.selected,
    super.focusColor,
    super.hoverColor,
    super.tileColor,
    super.selectedTileColor,
// CheckboxListTile
    super.secondary,
    super.controlAffinity,
// CircleAvatar
    super.backgroundColor,
    super.backgroundImage,
    super.foregroundImage,
    super.onBackgroundImageError,
    super.onForegroundImageError,
    super.foregroundColor,
    super.radius,
    super.minRadius,
    super.maxRadius,
// Dismissible
    super.child,
    super.background,
    super.secondaryBackground,
    super.resize,
    super.dismissed,
    super.direction,
    super.resizeDuration,
    super.dismissThresholds,
    super.movementDuration,
    super.crossAxisEndOffset,
// CheckBox
    super.toggle,
    super.activeColor,
    super.tristate,
    super.materialTapTargetSize,
  });
}

/// Add to the class this:
/// `extends FieldWidgets<T> with FieldChange`
mixin FormFields on FieldWidgets<Contact> {
  ///
  Set<FieldWidgets<Contact>> get changedFields => _changedFields;
  static final Set<FieldWidgets<Contact>> _changedFields = {};

  /// If the field's value changed, that field is added to a Set.
  @override
  void onSaved(dynamic v) {
    super.onSaved(v);
    if (isChanged()) {
      _changedFields.add(this);
    }
  }

  ///
  bool changeIn<T>() => changedFields.whereType<T>().isNotEmpty;
}

///
String? notEmpty(String? v) =>
    v != null && v.isEmpty ? 'Cannot be empty'.tr : null;

///
FormFields displayName(Contact contact) {
  String? display;

  if (contact.givenName.value != null) {
    display = contact.givenName.value ?? '';
    display = '$display ${contact.familyName.value}';
  }
  display ??= '';
  return DisplayName(display, Text(display), contact.textStyle);
}
