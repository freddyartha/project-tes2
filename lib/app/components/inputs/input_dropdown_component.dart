// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hr_portal/app/mahas/components/inputs/input_text_component.dart';
// import 'package:hr_portal/app/mahas/components/others/list_component.dart';
// import 'package:hr_portal/app/mahas/components/texts/text_component.dart';
// import 'package:hr_portal/app/mahas/mahas_config.dart';
// import 'package:hr_portal/app/mahas/mahas_font_size.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import '../../mahas_colors.dart';
// import '../mahas_themes.dart';
// import 'input_box_component.dart';

// class DropdownItem {
//   String text;
//   dynamic value;
//   String? label;
//   dynamic additionalValue;
//   dynamic additionalValue1;
//   dynamic additionalValue2;
//   dynamic additionalValue3;
//   dynamic additionalValue4;

//   DropdownItem({
//     required this.text,
//     this.value,
//     this.label,
//     this.additionalValue,
//     this.additionalValue1,
//     this.additionalValue2,
//     this.additionalValue3,
//     this.additionalValue4,
//   });

//   DropdownItem.init(String? text, dynamic value, {String? label})
//       : this(
//           text: text ?? "",
//           value: value,
//           label: label,
//         );

//   DropdownItem.simple(String? value) : this.init(value, value);
// }

// enum InputDropDownType { standard, withSearch }

// class InputDropdownController {
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   late Function(VoidCallback fn) setState;
//   final InputDropDownType dropDownType;
//   DropdownItem? jsonDropdownItemName;
//   String? urlApi;
//   BaseUrlType? baseUrlType;

//   DropdownItem? _value;
//   List<DropdownItem> items;
//   Function(DropdownItem? value)? onChanged;
//   Function()? onChangedVoid;
//   bool _isInit = false;
//   ListComponentController? _listCon;
//   InputTextController? _dropDownWithSearchCon;
//   BuildContext? controllerContext;

//   late bool _required = false;

//   dynamic get value {
//     return _value?.value;
//   }

//   String? get text {
//     return _value?.text;
//   }

//   String? get label {
//     return _value?.label;
//   }

//   dynamic get additionalValue {
//     return _value?.additionalValue;
//   }

//   dynamic get additionalValue1 {
//     return _value?.additionalValue1;
//   }

//   dynamic get additionalValue2 {
//     return _value?.additionalValue2;
//   }

//   dynamic get additionalValue3 {
//     return _value?.additionalValue3;
//   }

//   dynamic get additionalValue4 {
//     return _value?.additionalValue4;
//   }

//   set value(dynamic val) {
//     if (dropDownType == InputDropDownType.standard &&
//         items.where((e) => e.value == val).isEmpty) {
//       _value = null;
//     } else if (dropDownType == InputDropDownType.withSearch) {
//       _value = val;
//     } else {
//       _value = items.firstWhere((e) => e.value == val);
//     }
//     if (_isInit) {
//       setState(() {});
//     }
//   }

//   set setItems(List<DropdownItem> val) {
//     if (val.where((e) => e.value == _value?.value).isEmpty) {
//       _value = null;
//     }
//     items = val;
//   }

//   InputDropdownController({
//     this.items = const [],
//     this.onChanged,
//     this.dropDownType = InputDropDownType.standard,
//     this.jsonDropdownItemName,
//     this.urlApi,
//     this.baseUrlType,
//   });

//   void _rootOnChanged(e) {
//     isValid;
//     _value = e;
//     if (onChanged != null) {
//       onChanged!(e);
//     }
//     if (_isInit) {
//       setState(() {});
//     }
//     if (onChangedVoid != null) {
//       onChangedVoid!();
//     }
//   }

//   String? _validator(v) {
//     if (_required && v == null) {
//       return 'The field is required';
//     }
//     return null;
//   }

//   bool get isValid {
//     bool? valid = _key.currentState?.validate();
//     if (_dropDownWithSearchCon != null && _dropDownWithSearchCon!.isValid) {
//       return true;
//     } else if (_dropDownWithSearchCon != null &&
//         !_dropDownWithSearchCon!.isValid) {
//       return false;
//     } else if (valid == null) {
//       return true;
//     } else {
//       return valid;
//     }
//   }

//   Future<void> _getListItem(String? label) async {
//     _listCon = ListComponentController<DropdownItem>(
//       urlApi: (index, filter) => '$urlApi?pageIndex=$index&keyword=$filter',
//       fromDynamic: _fromDynamic,
//       allowSearch: true,
//       baseUrlType: baseUrlType ?? BaseUrlType.apiHrportal,
//     );
//     await showMaterialModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: controllerContext!,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.7,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//         ),
//         padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 5,
//                   width: 100,
//                   decoration: const BoxDecoration(
//                     color: MahasColors.grey,
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                   ),
//                 ),
//               ),
//             ),
//             TextComponent(
//               value: label ?? "",
//               fontWeight: FontWeight.w600,
//               fontSize: MahasFontSize.h5,
//               margin: const EdgeInsets.symmetric(vertical: 10),
//             ),
//             const SizedBox(height: 12),
//             Expanded(
//               child: ListComponent(
//                 searchHorizontalMargin: 0,
//                 controller: _listCon!,
//                 itemBuilder: (item) => TextComponent(
//                   onTap: () => _itemWithSearchOnTap(item),
//                   value: item.text,
//                   fontSize: MahasFontSize.h6,
//                   margin: const EdgeInsets.symmetric(vertical: 20),
//                 ),
//                 searchIcon: Icon(
//                   FontAwesomeIcons.magnifyingGlass,
//                   size: 14,
//                   color: MahasColors.muted,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _itemWithSearchOnTap(DropdownItem item) {
//     _value = item;
//     _dropDownWithSearchCon!.value = item.text;
//     isValid;
//     if (onChanged != null) onChanged!(item);
//     Navigator.pop(controllerContext!);
//   }

//   DropdownItem _fromDynamic(dynamic dynamicData) {
//     return DropdownItem(
//       text: dynamicData[jsonDropdownItemName?.text],
//       value: dynamicData[jsonDropdownItemName?.value],
//       label: dynamicData[jsonDropdownItemName?.label],
//       additionalValue: dynamicData[jsonDropdownItemName?.additionalValue],
//       additionalValue1: dynamicData[jsonDropdownItemName?.additionalValue1],
//       additionalValue2: dynamicData[jsonDropdownItemName?.additionalValue2],
//       additionalValue3: dynamicData[jsonDropdownItemName?.additionalValue3],
//       additionalValue4: dynamicData[jsonDropdownItemName?.additionalValue4],
//     );
//   }

//   void _init(Function(VoidCallback fn) setStateX, bool requiredX) {
//     setState = setStateX;
//     _required = requiredX;
//     _isInit = true;
//   }
// }

// class InputDropdownComponent extends StatefulWidget {
//   final String? label;
//   final double? marginBottom;
//   final bool required;
//   final bool editable;
//   final InputDropdownController controller;
//   final Radius? borderRadius;
//   final String? hint;
//   final Color? labelColor;

//   const InputDropdownComponent({
//     Key? key,
//     this.label,
//     this.marginBottom,
//     this.editable = true,
//     required this.controller,
//     this.required = false,
//     this.borderRadius,
//     this.hint,
//     this.labelColor,
//   }) : super(key: key);

//   @override
//   State<InputDropdownComponent> createState() => _InputDropdownComponentState();
// }

// class _InputDropdownComponentState extends State<InputDropdownComponent> {
//   @override
//   void initState() {
//     widget.controller._init(
//       (fn) {
//         if (mounted) {
//           setState(fn);
//         }
//       },
//       widget.required,
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final decoration = InputDecoration(
//       filled: true,
//       contentPadding: const EdgeInsets.all(9.25),
//       fillColor: widget.editable ? MahasColors.light : Colors.grey[50],
//       isDense: true,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.all(
//             widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(
//             widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
//         borderSide: const BorderSide(color: MahasColors.dark, width: .1),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(
//             widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
//         borderSide: const BorderSide(color: MahasColors.dark, width: .1),
//       ),
//       prefixStyle: TextStyle(
//         color: MahasColors.light.withValues(alpha: 0.6),
//       ),
//       suffixIconConstraints: const BoxConstraints(
//         minHeight: 30,
//         minWidth: 30,
//       ),
//     );
//     widget.controller.controllerContext = context;

//     if (widget.controller.dropDownType == InputDropDownType.withSearch) {
//       widget.controller._dropDownWithSearchCon =
//           InputTextController(onTap: () async {
//         if (widget.editable) {
//           await widget.controller._getListItem(widget.label);
//         }
//       })
//             ..value = widget.controller._value?.text;
//     }

//     return widget.controller.dropDownType == InputDropDownType.withSearch
//         ? Form(
//             child: InputTextComponent(
//               label: widget.label,
//               editable: widget.editable,
//               controller: widget.controller._dropDownWithSearchCon!,
//               placeHolder: "Pilih ${widget.label}",
//               suffixIcon: Icon(
//                 Icons.keyboard_arrow_down,
//                 color: MahasColors.dark.withValues(alpha: 0.6),
//               ),
//               disableInputKeyboard: true,
//               required: widget.required,
//             ),
//           )
//         : InputBoxComponent(
//             label: widget.label,
//             isRequired: widget.required,
//             labelColor: widget.labelColor,
//             marginBottom: widget.marginBottom,
//             childText: widget.controller._value == null
//                 ? ""
//                 : widget.controller._value?.text ?? "",
//             children: widget.editable
//                 ? Form(
//                     key: widget.controller._key,
//                     child: DropdownButtonFormField(
//                       hint: Text(widget.hint ?? ""),
//                       elevation: 0,
//                       decoration: decoration,
//                       isExpanded: true,
//                       focusColor: Colors.transparent,
//                       validator: widget.controller._validator,
//                       value: widget.controller._value,
//                       onChanged: widget.controller._rootOnChanged,
//                       items: widget.controller.items
//                           .map(
//                             (e) => DropdownMenuItem(
//                               value: e,
//                               child: TextComponent(
//                                 value: e.text,
//                                 maxLines: 1,
//                               ),
//                             ),
//                           )
//                           .toList(),
//                       style: TextStyle(
//                         color: MahasColors.dark.withValues(alpha: .7),
//                       ),
//                       dropdownColor: MahasColors.light,
//                     ),
//                   )
//                 : null,
//           );
//   }
// }
