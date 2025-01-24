import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_tes2/app/components/images/image_component.dart';
import 'package:project_tes2/app/components/inputs/input_box_component.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_font_size.dart';
import 'package:project_tes2/app/components/mahas_themes.dart';
import 'package:project_tes2/app/components/mahas_widget.dart';
import 'package:project_tes2/app/components/others/button_component.dart';
import 'package:project_tes2/app/components/texts/text_component.dart';
import 'package:image/image.dart' as img;

enum InputFileType { image, pdf, camera }

class InputFileController {
  final List<PlatformFile> _files = [];
  FilePickerResult? result;
  bool mutipleFile = false;
  int? maxImageLength;
  FileType type;
  String? _errorMessage;
  late bool _required;
  bool _isInit = false;
  String? strBase64;
  List<String> extension = [];
  final dynamic tipe;
  bool urlImage = false;
  bool isGetPath;
  String? urlApiOnTap;

  InputFileController({
    this.type = FileType.image,
    this.mutipleFile = false,
    this.maxImageLength,
    this.extension = const ['jpg', 'png'],
    this.tipe = InputFileType.image,
    this.urlImage = false,
    this.isGetPath = false,
    this.urlApiOnTap,
  });

  List<PlatformFile> get values {
    return _files;
  }

  dynamic get value {
    if (_files.isEmpty) {
      strBase64 = null;
      return null;
    } else if (isGetPath) {
      PlatformFile platformFile = _files.first;
      return platformFile;
    } else {
      PlatformFile file = _files.first;
      Uint8List fileBytes = file.bytes!;
      String base64String = base64Encode(fileBytes);
      return base64String;
    }
  }

  // dynamic get valueMultipart {
  //   if (_files.isEmpty) {
  //     strBase64 = null;
  //     return null;
  //   }
  //   if (mutipleFile) {
  //     List<dio.MultipartFile> files = [];
  //     for (var e in _files) {
  //       Uint8List fileBytes = compressImage(e.bytes!, 50);
  //       var finalfile = dio.MultipartFile.fromBytes(
  //         fileBytes,
  //         filename: e.name,
  //       );
  //       files.add(finalfile);
  //     }
  //     return files;
  //   } else {
  //     PlatformFile file = _files.first;
  //     Uint8List fileBytes = compressImage(file.bytes!, 50);
  //     var finalfile = dio.MultipartFile.fromBytes(
  //       fileBytes,
  //       filename: file.name,
  //     );
  //     return finalfile;
  //   }
  // }

  dynamic get valueMultiple {
    if (_files.isEmpty) {
      strBase64 = null;
      return null;
    } else if (isGetPath) {
      List<PlatformFile> platformFile = [];
      for (var e in _files) {
        platformFile.add(e);
      }
      return platformFile;
    } else {
      List<String> files = [];
      for (var e in _files) {
        Uint8List fileBytes = compressImage(e.bytes!, 50);
        String base64String = base64Encode(fileBytes);
        files.add(base64String);
      }
      return files;
    }
  }

  // dynamic get valueMultipleArray {
  //   if (_files.isEmpty) {
  //     strBase64 = null;
  //     return null;
  //   }
  //   if (mutipleFile) {
  //     List<Uint8List> files = [];
  //     for (var e in _files) {
  //       Uint8List fileBytes = compressImage(e.bytes!, 50);
  //       files.add(fileBytes);
  //       return files;
  //     }
  //   } else {
  //     Uint8List fileBytes = compressImage(_files.first.bytes!, 50);
  //     return fileBytes;
  //   }
  // }

  Uint8List compressImage(Uint8List imageBytes, int quality) {
    img.Image image = img.decodeImage(imageBytes)!;
    return Uint8List.fromList(img.encodeJpg(image, quality: quality));
  }

  dynamic get name {
    if (_files.isEmpty) {
      strBase64 = null;
      return null;
    }
    String fileName = _files.first.name;
    return fileName;
  }

  set value(dynamic val) {
    if (val is String) {
      if (urlImage == false) {
        strBase64 = val;
        Uint8List bytes = base64Decode(strBase64!);
        PlatformFile platformFile = PlatformFile(
          name: "file",
          size: bytes.length,
          bytes: bytes,
        );
        _files.add(platformFile);
      } else {
        strBase64 = val;
      }
    }
  }

  void removeLocalData() {
    if (_files.isNotEmpty && _files.length > 1) {
      for (var e in _files) {
        if (e.path != null) {
          _files.remove(e);
        }
      }
    }
  }

  void addValue(PlatformFile file) {
    _files.add(file);
    if (_isInit) {
      setState(() {});
    }
    if (onChanged != null) {
      onChanged!();
    }
  }

  late Function(VoidCallback fn) setState;
  BuildContext? context;
  Function()? onChanged;

  bool get isValid {
    setState(() {
      _errorMessage = null;
    });
    if (_required && _files.isEmpty) {
      setState(() {
        _errorMessage = 'The field is required';
      });
      return false;
    }
    return true;
  }

  // Future<void> getImageFiles() async {
  //   if (strBase64 != null && strBase64!.isNotEmpty) {
  //     await EasyLoading.show();
  //     String imageData;
  //     var r = await HttpApi.get(
  //       urlApiOnTap!,
  //       baseUrlType: BaseUrlType.apiDinkes,
  //     );
  //     if (r.success) {
  //       imageData = base64Encode(r.bodyBytes);
  //       MahasWidget.dialogCustomWidget(
  //         [
  //           ConstrainedBox(
  //             constraints: const BoxConstraints(maxHeight: 500),
  //             child: Image.memory(
  //               base64Decode(imageData),
  //               errorBuilder: (context, error, stackTrace) {
  //                 return const Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 50),
  //                   child: Column(
  //                     children: [
  //                       Icon(
  //                         FontAwesomeIcons.triangleExclamation,
  //                         color: MahasColors.warning,
  //                         size: 50,
  //                       ),
  //                       TextComponent(
  //                         textAlign: TextAlign.center,
  //                         value: "Terjadi Kesalahan",
  //                         fontSize: MahasFontSize.h6,
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //         actions: [
  //           Row(
  //             children: [
  //               Expanded(
  //                 flex: 1,
  //                 child: ButtonComponent(
  //                   onTap: Get.back,
  //                   text: "Tutup",
  //                   btnColor: MahasColors.light,
  //                   borderColor: MahasColors.dark,
  //                   textColor: MahasColors.dark,
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       );
  //     }
  //     EasyLoading.dismiss();
  //   }
  // }

  Future<void> _viewFileOnPressed(String data, {bool editable = true}) async {
    String tipeData;
    if (File(data).existsSync()) {
      tipeData = 'file';
    } else {
      tipeData = 'another';
    }
    MahasWidget.dialogCustomWidget(
      [
        if (tipeData == 'file') ...[
          Image.file(File(data)),
        ] else ...[
          Container(
            child: (tipe == InputFileType.image)
                ? Image.memory(base64Decode(data))
                : (tipe == InputFileType.pdf)
                    ? SizedBox(
                        width: 300,
                        height: 400,
                        child: PDFView(
                          pdfData: Uint8List.fromList(
                            base64Decode(data),
                          ),
                        ),
                      )
                    : (tipe == InputFileType.camera && urlImage == true)
                        ? isGetPath && editable
                            ? Image.memory(base64Decode(data))
                            : Image.network(data)
                        : !editable
                            ? Image.network(data)
                            : Image.memory(base64Decode(data)),
          ),
        ]
      ],
      actions: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ButtonComponent(
                onTap: Get.back,
                text: "Tutup",
                btnColor: MahasColors.light,
                borderColor: MahasColors.dark,
                textColor: MahasColors.dark,
              ),
            ),
            if (editable == true) ...[
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ButtonComponent(
                  onTap: () {
                    setState(() => _files.clear());
                    Get.back();
                  },
                  text: "Hapus",
                  btnColor: MahasColors.light,
                  borderColor: MahasColors.danger,
                  textColor: MahasColors.danger,
                ),
              ),
            ],
          ],
        )
      ],
    );
  }

  void _onTab(bool editable) async {
    if (!editable) return;
    if (mutipleFile == false) _files.clear();
    result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: mutipleFile,
      allowedExtensions: extension,
      withData: true,
    );
    if (result!.files.isEmpty) return;
    setState(() {
      _files.addAll(result!.files);
      isValid;
    });
  }

  void _onCameraTab(bool editable) async {
    if (!editable) return;
    if (mutipleFile == false) _files.clear();
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    if (pickedFile == null) return;
    PlatformFile platformFile = PlatformFile(
      path: pickedFile.path,
      name: pickedFile.name,
      size: await pickedFile.length(),
      bytes: await pickedFile.readAsBytes(),
    );
    setState(() {
      _files.add(platformFile);
      isValid;
    });
  }

  void _init(Function(VoidCallback fn) setStateX, BuildContext contextX) {
    setState = setStateX;
    context = contextX;
    _isInit = true;
  }

  void _clearOnTab() {
    _files.clear();
    if (_isInit) {
      setState(() {});
    }
    if (onChanged != null) {
      onChanged!();
    }
  }

  void _clearIndexOnTab(int index) {
    _files.remove(_files[index]);
    if (_isInit) {
      setState(() {});
    }
    if (onChanged != null) {
      onChanged!();
    }
  }
}

class InputFileComponent extends StatefulWidget {
  final InputFileController controller;
  final bool editable;
  final String? label;
  final bool required;
  final bool withIcon;
  final String? placeHolder;
  final bool isConventionalWidget;
  final bool nonConventionalWithLabel;

  const InputFileComponent({
    super.key,
    required this.controller,
    this.editable = true,
    this.label,
    this.required = false,
    this.withIcon = false,
    this.placeHolder = "Upload Lampiran (Max 2MB) *",
    this.isConventionalWidget = true,
    this.nonConventionalWithLabel = false,
  });

  @override
  InputFileComponentState createState() => InputFileComponentState();
}

class InputFileComponentState extends State<InputFileComponent> {
  @override
  void initState() {
    widget.controller._required = widget.required;
    widget.controller._init(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isConventionalWidget
        ? Column(
            children: [
              InputBoxComponent(
                errorMessage: widget.controller._errorMessage,
                label: widget.label,
                children: !widget.editable
                    ? widget.label == null
                        ? const TextComponent(
                            value: "Lampiran",
                            isMuted: true,
                            textAlign: TextAlign.start,
                            fontSize: MahasFontSize.h6,
                          )
                        : const SizedBox()
                    : Column(
                        children: [
                          InkWell(
                            onTap: !widget.editable
                                ? null
                                : () {
                                    if (widget.controller.maxImageLength !=
                                            null &&
                                        widget.controller._files.length <
                                            widget.controller.maxImageLength!) {
                                      if (widget.controller.tipe ==
                                          InputFileType.camera) {
                                        widget.controller._onCameraTab(true);
                                      } else {
                                        widget.controller._onTab(true);
                                      }
                                      setState(() {
                                        _viewImage();
                                      });
                                    } else {
                                      if (widget.controller.tipe ==
                                          InputFileType.camera) {
                                        widget.controller._onCameraTab(true);
                                      } else {
                                        widget.controller._onTab(true);
                                      }
                                      setState(() {
                                        _viewImage();
                                      });
                                    }
                                  },
                            child: DottedBorder(
                              borderPadding: const EdgeInsets.all(2),
                              radius: Radius.circular(MahasThemes.borderRadius),
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              color: widget.controller._errorMessage == null
                                  ? MahasColors.dark
                                  : MahasColors.danger,
                              dashPattern: const [5, 3],
                              child: Container(
                                height: 45,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MahasThemes.borderRadius),
                                  color: MahasColors.dark.withValues(
                                      alpha: widget.editable ? .01 : .05),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible:
                                          widget.withIcon && widget.editable,
                                      child: SizedBox(
                                        width: 35,
                                        height: 40,
                                        child: InkWell(
                                          onTap: widget.controller._clearOnTab,
                                          child: Icon(
                                            widget.controller.type ==
                                                    FileType.image
                                                ? (widget.controller.mutipleFile
                                                    ? FontAwesomeIcons.images
                                                    : Icons.image)
                                                : (widget.controller.mutipleFile
                                                    ? Icons.file_copy
                                                    : FontAwesomeIcons.file),
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextComponent(
                                        value: widget.controller
                                                        .maxImageLength !=
                                                    null &&
                                                widget.controller._files
                                                        .length ==
                                                    widget.controller
                                                        .maxImageLength!
                                            ? "Lampiran sudah mencapai batas maksimum (${widget.controller.maxImageLength} lampiran)"
                                            : widget.placeHolder,
                                        isMuted: true,
                                        textAlign: TextAlign.center,
                                        fontSize: MahasFontSize.h6,
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.controller._files
                                                  .isNotEmpty &&
                                              widget.controller._files.length ==
                                                  1
                                          ? true
                                          : false,
                                      child: SizedBox(
                                        width: 35,
                                        height: 40,
                                        child: InkWell(
                                          onTap: widget.controller._clearOnTab,
                                          child: const Icon(
                                            FontAwesomeIcons.xmark,
                                            color: MahasColors.danger,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              _viewImage(),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        : InkWell(
            onTap: !widget.editable && widget.isConventionalWidget
                ? () => widget.controller._viewFileOnPressed(
                      widget.controller.strBase64 ?? "",
                      editable: false,
                    )
                : !widget.editable && !widget.isConventionalWidget
                    ? () {}
                    : widget.controller._files.isEmpty
                        ? () {
                            if (widget.controller.tipe ==
                                InputFileType.camera) {
                              widget.controller._onCameraTab(true);
                            } else {
                              widget.controller._onTab(true);
                            }
                            setState(() {
                              _viewImage();
                            });
                          }
                        : () => widget.controller._viewFileOnPressed(
                              widget.controller.tipe == InputFileType.camera &&
                                      widget.controller.urlImage == true &&
                                      !widget.controller.isGetPath
                                  ? widget.controller._files[0].path!
                                  : base64Encode(
                                      widget.controller._files[0].bytes!),
                            ),
            child: widget.nonConventionalWithLabel
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(MahasThemes.borderRadius),
                      border: Border.all(color: MahasColors.grey),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.editable &&
                                      (widget.controller._files.isEmpty ||
                                          widget.controller.value == null)
                                  ? MahasColors.primary
                                  : !widget.editable &&
                                          widget.controller.strBase64
                                              .toString()
                                              .isEmpty
                                      ? MahasColors.primary
                                      : MahasColors.green),
                          child: ImageComponent(
                            svgUrl: widget.editable &&
                                    (widget.controller._files.isEmpty ||
                                        widget.controller.value == null)
                                ? "assets/svg/camera_add.svg"
                                : !widget.editable &&
                                        widget.controller.strBase64
                                            .toString()
                                            .isEmpty
                                    ? "assets/svg/camera_add.svg"
                                    : "assets/svg/image_view.svg",
                            boxFit: BoxFit.fitWidth,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextComponent(
                                value: widget.label ?? "",
                                fontWeight: FontWeight.w600,
                                fontSize: MahasFontSize.h6,
                              ),
                              TextComponent(
                                value: widget.editable
                                    ? "Klik icon Gambar untuk menambahkan gambar"
                                    : "Klik icon Gambar untuk menampilkan gambar",
                                fontColor: MahasColors.muted,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.editable &&
                                (widget.controller._files.isEmpty ||
                                    widget.controller.value == null)
                            ? MahasColors.primary
                            : !widget.editable &&
                                    widget.controller.strBase64
                                        .toString()
                                        .isEmpty
                                ? MahasColors.primary
                                : MahasColors.green),
                    child: ImageComponent(
                      svgUrl: widget.editable &&
                              (widget.controller._files.isEmpty ||
                                  widget.controller.value == null)
                          ? "assets/svg/camera_add.svg"
                          : !widget.editable &&
                                  widget.controller.strBase64.toString().isEmpty
                              ? "assets/svg/camera_add.svg"
                              : "assets/svg/image_view.svg",
                      boxFit: BoxFit.fitWidth,
                    ),
                  ),
          );
  }

  Widget _viewImage() {
    return widget.controller._files.isEmpty && !widget.editable
        ? const Text(
            "No File Included",
            style: TextStyle(color: MahasColors.grey),
          )
        : widget.controller._files.length == 1
            ? InkWell(
                onTap: () => widget.controller._viewFileOnPressed(
                  widget.controller.tipe == InputFileType.camera &&
                          widget.controller.urlImage == true
                      ? widget.controller._files[0].path!
                      : base64Encode(widget.controller._files[0].bytes!),
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MahasColors.dark),
                    ),
                    padding: const EdgeInsets.all(5),
                    width: 150,
                    height: 200,
                    child: (widget.controller.tipe == InputFileType.image ||
                            widget.controller.tipe == InputFileType.camera)
                        ? Image.memory(widget.controller._files[0].bytes!)
                        : (widget.controller.tipe == InputFileType.pdf)
                            ? Stack(
                                children: [
                                  PDFView(
                                    enableSwipe: false,
                                    pdfData: Uint8List.fromList(
                                      widget.controller._files[0].bytes!,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        widget.controller._viewFileOnPressed(
                                      widget.controller.tipe ==
                                                  InputFileType.camera &&
                                              widget.controller.urlImage == true
                                          ? widget.controller._files[0].path!
                                          : base64Encode(widget
                                              .controller._files[0].bytes!),
                                    ),
                                    child: const SizedBox(
                                      width: 150,
                                      height: 200,
                                    ),
                                  ),
                                ],
                              )
                            : (widget.controller.tipe == InputFileType.camera &&
                                    widget.controller.urlImage == true)
                                ? Image.network(
                                    widget.controller._files[0].path!)
                                : Image.memory(
                                    widget.controller._files[0].bytes!),
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: widget.controller._files.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 200,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MahasColors.dark),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () => widget.controller._viewFileOnPressed(
                            widget.controller.tipe == InputFileType.camera &&
                                    widget.controller.urlImage == true
                                ? widget.controller._files[index].path!
                                : base64Encode(
                                    widget.controller._files[index].bytes!),
                          ),
                          child: (widget.controller.tipe == InputFileType.pdf)
                              ? Stack(
                                  children: [
                                    PDFView(
                                      enableSwipe: false,
                                      pdfData: Uint8List.fromList(
                                        widget.controller._files[index].bytes!,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          widget.controller._viewFileOnPressed(
                                        widget.controller.tipe ==
                                                    InputFileType.camera &&
                                                widget.controller.urlImage ==
                                                    true
                                            ? widget
                                                .controller._files[index].path!
                                            : base64Encode(widget.controller
                                                ._files[index].bytes!),
                                      ),
                                      child: const SizedBox(
                                        width: 150,
                                        height: 200,
                                      ),
                                    ),
                                  ],
                                )
                              : (widget.controller.tipe ==
                                          InputFileType.camera &&
                                      widget.controller.urlImage == true)
                                  ? Image.network(
                                      widget.controller._files[index].path!)
                                  : Image.memory(
                                      widget.controller._files[index].bytes!),
                        ),
                      ),
                      Visibility(
                        visible: widget.controller._files.length > 1 &&
                                widget.editable
                            ? true
                            : false,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () =>
                                widget.controller._clearIndexOnTab(index),
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                FontAwesomeIcons.xmark,
                                color: MahasColors.danger,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
  }
}
