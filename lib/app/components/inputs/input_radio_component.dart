import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_format.dart';
import 'package:project_tes2/app/components/mahas_themes.dart';
import 'package:project_tes2/app/components/texts/text_component.dart';
import 'input_box_component.dart';

enum InputRadioType { row, column, customRow }

class RadioButtonItem {
  dynamic id;
  String text;
  dynamic value;
  String? svgUrl;

  RadioButtonItem({
    this.id,
    required this.text,
    this.value,
    this.svgUrl,
  });

  RadioButtonItem.autoId(String text, dynamic value)
      : this(
          id: MahasFormat.idGenerator,
          text: text,
          value: value,
        );

  RadioButtonItem.simple(String value) : this.autoId(value, value);
}

class InputRadioController {
  late Function(VoidCallback fn) setState;

  List<RadioButtonItem> items;
  RadioButtonItem? _value;
  Function(RadioButtonItem item)? onChanged;
  bool required = false;
  String? _errorMessage;
  bool _isInit = false;

  InputRadioController({
    this.items = const [],
    this.onChanged,
  });

  void _onChanged(RadioButtonItem v, bool editable) {
    if (!editable) return;
    setState(() {
      _value = v;
      if (onChanged != null) {
        onChanged!(v);
      }
    });
  }

  set setItems(List<RadioButtonItem> val) {
    if (val.where((e) => e.value == _value?.value).isEmpty) {
      _value = null;
    }
    items = val;
  }

  dynamic get value {
    return _value?.value;
  }

  set value(dynamic val) {
    if (items.where((e) => e.value == val).isEmpty) {
      _value = null;
    } else {
      _value = items.firstWhere((e) => e.value == val);
    }
    if (_isInit) {
      setState(() {});
    }
  }

  void _init(Function(VoidCallback fn) setStateX) {
    setState = setStateX;
    _isInit = true;
  }

  bool get isValid {
    setState(() {
      _errorMessage = null;
    });
    if (required && _value == null) {
      setState(() {
        _errorMessage = 'The field is required';
      });
      return false;
    }
    return true;
  }
}

class InputRadioComponent extends StatefulWidget {
  final InputRadioController controller;
  final bool editable;
  final bool required;
  final String? label;
  final InputRadioType? type;

  const InputRadioComponent({
    super.key,
    required this.controller,
    this.editable = true,
    this.label,
    this.required = false,
    this.type = InputRadioType.column,
  });

  @override
  State<InputRadioComponent> createState() => _InputRadioComponentState();
}

class _InputRadioComponentState extends State<InputRadioComponent> {
  @override
  void initState() {
    widget.controller._init((fn) {
      if (mounted) {
        setState(fn);
      }
    });
    widget.controller.required = widget.required;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => InputBoxComponent(
        label: widget.label,
        errorMessage: widget.controller._errorMessage,
        children: widget.type == InputRadioType.column
            ? column()
            : widget.type == InputRadioType.row
                ? row()
                : customRow(),
      );

  Row row() {
    return Row(
      children: widget.controller.items
          .map((e) => InkWell(
                onTap: () => widget.controller._onChanged(e, widget.editable),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio<RadioButtonItem>(
                      activeColor: MahasColors.primary,
                      value: e,
                      groupValue: widget.controller._value,
                      onChanged: (value) =>
                          widget.controller._onChanged(value!, widget.editable),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    Expanded(
                      child: Text(
                        e.text,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Column column() {
    return Column(
      children: widget.controller.items
          .map((e) => InkWell(
                onTap: () => widget.controller._onChanged(e, widget.editable),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio<RadioButtonItem>(
                      activeColor: MahasColors.primary,
                      value: e,
                      groupValue: widget.controller._value,
                      onChanged: (value) =>
                          widget.controller._onChanged(value!, widget.editable),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    Expanded(
                      child: Text(
                        e.text,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget customRow() {
    return Row(
      children: widget.controller.items
          .map(
            (e) => Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => widget.controller._onChanged(e, widget.editable),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.controller._value == e
                          ? MahasColors.primary
                          : MahasColors.muted,
                    ),
                    borderRadius:
                        BorderRadius.circular(MahasThemes.borderRadius),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/${e.svgUrl}.svg",
                        width: MediaQuery.of(context).size.width * 0.1,
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(
                          widget.controller._value == e
                              ? MahasColors.primary
                              : MahasColors.muted,
                          BlendMode.srcIn,
                        ),
                      ),
                      TextComponent(
                        margin: const EdgeInsets.only(top: 5),
                        value: e.text,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
