import 'package:flutter/material.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';

class InputCheckboxController {
  bool _checked = false;
  late Function(VoidCallback fn) setState;
  Function(bool checked)? onChanged;
  bool _isInit = false;

  void onTab(bool editable) {
    if (!editable) return;
    setState(() {
      _checked = !_checked;
      if (onChanged != null) {
        onChanged!(_checked);
      }
    });
  }

  bool get checked {
    return _checked;
  }

  set checked(bool val) {
    _checked = val;
    if (_isInit) {
      setState(() {});
    }
  }

  void _onChanged(bool? v, bool editable) {
    if (!editable) return;
    setState(() {
      _checked = v ?? false;
      if (onChanged != null) {
        onChanged!(_checked);
      }
    });
  }

  void _init(Function(VoidCallback fn) setStateX) {
    setState = setStateX;
    _isInit = true;
  }
}

class InputCheckboxComponent extends StatefulWidget {
  final InputCheckboxController controller;
  final bool editable;
  final String? label;
  final bool isSwitch;
  final EdgeInsetsGeometry margin;

  const InputCheckboxComponent({
    super.key,
    required this.controller,
    this.editable = true,
    this.label,
    this.isSwitch = false,
    this.margin = const EdgeInsets.only(bottom: 20),
  });

  @override
  State<InputCheckboxComponent> createState() => _InputCheckboxComponentState();
}

class _InputCheckboxComponentState extends State<InputCheckboxComponent> {
  @override
  void initState() {
    widget.controller._init((fn) {
      if (mounted) {
        setState(fn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.isSwitch
              ? Switch(
                  activeColor: MahasColors.primary,
                  value: widget.controller._checked,
                  onChanged: (v) =>
                      widget.controller._onChanged(v, widget.editable),
                )
              : Checkbox(
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  activeColor: MahasColors.primary,
                  value: widget.controller._checked,
                  onChanged: (v) =>
                      widget.controller._onChanged(v, widget.editable),
                )),
          const Padding(padding: EdgeInsets.only(left: 5)),
          Expanded(
            child: InkWell(
              child: Text(
                widget.label ?? "",
              ),
              onTap: () => widget.controller.onTab(widget.editable),
            ),
          ),
        ],
      ),
    );
  }
}
