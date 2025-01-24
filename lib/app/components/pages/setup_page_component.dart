// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:hr_portal/app/mahas/mahas_service.dart';
// import '../../mahas_colors.dart';
// import '../../mahas_config.dart';
// import '../../mahas_font_size.dart';
// import '../../mahas_widget.dart';
// import '../../models/api_result_model.dart';
// import '../../services/helper.dart';
// import '../../services/http_api.dart';
// import '../images/image_component.dart';
// import '../mahas_themes.dart';
// import '../others/shimmer_component.dart';
// import '../texts/text_component.dart';

// enum SetupPageState {
//   create,
//   update,
//   detail,
// }

// class SetupPageController<T> extends ChangeNotifier {
//   final String Function(dynamic id)? urlApiGet;
//   final String Function()? urlApiPost;
//   final String Function(dynamic id)? urlApiPut;
//   final String Function(dynamic id)? urlApiPatch;
//   final String Function(dynamic id)? urlApiDelete;
//   final dynamic Function(dynamic e) itemKey;
//   final dynamic Function(dynamic e) itemIdAfterSubmit;
//   late Function(VoidCallback fn) setState;

//   final bool withQuestionBack;
//   bool allowDelete;
//   bool allowEdit;
//   bool allowHistory;
//   bool autoBack;
//   bool showSubmitButton;
//   bool returnMessageWhenGetIsEmpty;
//   final bool isFormData;
//   final dynamic pageBackParametes;
//   bool editable = false;
//   String deleteCaption;
//   String deleteDescription;
//   BaseUrlType baseUrlType;

//   Function()? initState;
//   Function()? onSubmit;
//   Function()? onInit;
//   Function(ApiResultModel)? onSuccessSubmit;
//   Function()? onHistory;
//   Function(ApiResultModel)? onRefreshWhenSubmit;
//   Function(dynamic id)? deleteOnTap;
//   Future<bool> Function()? backAction;

//   dynamic _id;
//   bool _backRefresh = false;

//   dynamic model;
//   bool Function()? onBeforeSubmit;
//   Function(dynamic id)? bodyApi;
//   Function(dynamic json)? apiToView;
//   BuildContext? context;

//   bool _isLoading = true;

//   SetupPageController({
//     this.urlApiGet,
//     this.urlApiPost,
//     this.urlApiPut,
//     this.urlApiPatch,
//     this.urlApiDelete,
//     required this.itemKey,
//     this.allowDelete = true,
//     this.allowEdit = true,
//     this.autoBack = false,
//     this.withQuestionBack = true,
//     this.allowHistory = false,
//     this.pageBackParametes,
//     required this.itemIdAfterSubmit,
//     this.onBeforeSubmit,
//     this.onSuccessSubmit,
//     this.baseUrlType = BaseUrlType.apiHrportal,
//     this.bodyApi,
//     this.isFormData = false,
//     this.apiToView,
//     this.onInit,
//     this.onHistory,
//     this.deleteOnTap,
//     this.deleteCaption = "Delete",
//     this.deleteDescription = "Yakin akan menghapus data ini?",
//     this.backAction,
//     this.onRefreshWhenSubmit,
//     this.onSubmit,
//     this.returnMessageWhenGetIsEmpty = true,
//     this.showSubmitButton = true,
//   });

//   void _init({
//     Function(VoidCallback fn)? setStateX,
//     BuildContext? contextX,
//   }) async {
//     if (setStateX != null) {
//       setState = setStateX;
//     }
//     if (contextX != null) {
//       context = contextX;
//     }
//     setState(() {
//       _isLoading = true;
//     });
//     if (initState != null) {
//       await initState!();
//     }
//     dynamic idX = itemKey(Get.parameters);
//     if (onInit != null) {
//       await onInit!();
//     }
//     if (idX != null) {
//       await _getModelFromApi(idX);
//     } else {
//       if (showSubmitButton) {
//         editable = true;
//       } else {
//         editable = false;
//       }
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future _getModelFromApi(dynamic idX) async {
//     if (urlApiGet != null) {
//       final r = await HttpApi.get(urlApiGet!(idX), baseUrlType: baseUrlType);
//       if (r.success) {
//         _id = idX;
//         setState(() {
//           apiToView!(r.body);
//         });
//       } else {
//         bool internetError =
//             MahasService.isInternetCausedError(r.message.toString());
//         if (internetError) {
//           Helper.errorToast(
//             message: "Gagal memuat data, silahkan cek koneksi internet",
//           );
//         } else {
//           if (r.message.toString().contains(RegExp(
//               "Item that you try to find can not be found",
//               caseSensitive: false))) {
//             if (returnMessageWhenGetIsEmpty) {
//               Helper.errorToast(message: "Data tidak ditemukan");
//             }
//             editable = true;
//           } else {
//             Helper.errorToast(message: r.message.toString());
//           }
//         }
//       }
//     } else {
//       setState(() {
//         apiToView!(idX);
//       });
//     }
//   }

//   void _back() {
//     Helper.backOnPress(
//       result: _backRefresh,
//       editable: editable,
//       questionBack: withQuestionBack,
//       parametes: pageBackParametes,
//     );
//   }

//   Future<bool> _onWillPop() async {
//     _back();
//     return false;
//   }

//   void _popupMenuButtonOnSelected(String v) async {
//     if (v == 'Edit') {
//       editable = true;
//       setState(() {});
//     } else if (v == 'Cancel') {
//       _init();
//       editable = false;
//       setState(() {});
//     } else if (v == deleteCaption) {
//       final r = await Helper.dialogQuestion(
//         message: deleteDescription,
//         icon: FontAwesomeIcons.trash,
//         textConfirm: deleteCaption,
//       );
//       if (r == true) {
//         if (EasyLoading.isShow) return;
//         await EasyLoading.show();
//         final model = bodyApi != null ? bodyApi!(_id) : null;
//         final r = await HttpApi.delete(urlApiDelete!(_id),
//             body: model, baseUrlType: baseUrlType);
//         await EasyLoading.dismiss();
//         if (r.success) {
//           if (deleteOnTap != null) {
//             _id = itemIdAfterSubmit(r.body) ?? _id;
//             deleteOnTap!(_id);
//           } else {
//             _backRefresh = true;
//             _back();
//           }
//         } else {
//           bool internetError =
//               MahasService.isInternetCausedError(r.message.toString());
//           if (internetError) {
//             Helper.errorToast(
//               message: "Gagal menghapus data, silahkan cek koneksi internet",
//             );
//           } else {
//             Helper.errorToast(message: r.message.toString());
//           }
//         }
//       }
//     } else if (v == 'History') {
//       onHistory!();
//     }
//   }

//   void submitOnPressed() async {
//     if (onSubmit != null) {
//       onSubmit!();
//     } else {
//       if (EasyLoading.isShow) return;
//       if (onBeforeSubmit != null) {
//         if (!onBeforeSubmit!()) return;
//       }
//       final model = bodyApi != null ? bodyApi!(_id) : null;

//       if (urlApiPost != null || urlApiPut != null || urlApiPatch != null) {
//         await EasyLoading.show();
//         setState(() {
//           editable = false;
//         });
//         ApiResultModel? r;
//         if (allowHistory == true) {
//           r = await HttpApi.post(
//             urlApiPut!(_id),
//             body: model,
//             baseUrlType: baseUrlType,
//             contentType:
//                 isFormData ? HTTPContentType.formData : HTTPContentType.json,
//           );
//         } else {
//           r = _id == null
//               ? await HttpApi.post(
//                   urlApiPost!(),
//                   body: model,
//                   baseUrlType: baseUrlType,
//                   contentType: isFormData
//                       ? HTTPContentType.formData
//                       : HTTPContentType.json,
//                 )
//               : urlApiPatch == null
//                   ? await HttpApi.put(
//                       urlApiPut!(_id),
//                       body: model,
//                       baseUrlType: baseUrlType,
//                       contentType: isFormData
//                           ? HTTPContentType.formData
//                           : HTTPContentType.json,
//                     )
//                   : await HttpApi.patchDio(
//                       urlApiPatch!(_id),
//                       body: model,
//                       baseUrlType: baseUrlType,
//                       isFormData: isFormData,
//                     );
//         }
//         if (r.success) {
//           if (autoBack == true && _id == null) {
//             Get.back();
//           }
//           if (onRefreshWhenSubmit != null) {
//             onRefreshWhenSubmit!(r);
//           }
//           if (onSuccessSubmit != null) {
//             onSuccessSubmit!(r);
//           } else {
//             _backRefresh = true;
//             _id ??= itemIdAfterSubmit(r.body);
//             await _getModelFromApi(_id);
//             editable = false;
//           }
//         } else {
//           bool internetError =
//               MahasService.isInternetCausedError(r.message.toString());
//           if (internetError) {
//             Helper.errorToast(
//               message: "Gagal menyimpan data, silahkan cek koneksi internet",
//             );
//           } else {
//             Helper.errorToast(message: r.message.toString());
//           }
//           setState(() {
//             editable = true;
//           });
//         }
//         await EasyLoading.dismiss();
//       }
//     }
//   }

//   set id(dynamic id) {
//     _id = id;
//   }

//   SetupPageState get isState {
//     if (editable) {
//       if (_id == null) {
//         return SetupPageState.create;
//       } else {
//         return SetupPageState.update;
//       }
//     } else {
//       return SetupPageState.detail;
//     }
//   }
// }

// class SetupPageComponent extends StatefulWidget {
//   final SetupPageController controller;
//   final bool childrenPadding;
//   final String title;
//   final Function children;
//   final bool showAppBar;
//   final dynamic crossAxisAlignmentChildren;
//   final Function? titleFunction;
//   final List<Widget>? childrenAfterButton;
//   final String? customBackground;
//   final bool useCardInside;
//   final String btnSubmitText;
//   final String? headerLogo;
//   final String? headerText;
//   final String buttonText;
//   final double buttonRadius;
//   final Color appBarBackgroudColor;
//   final EdgeInsets cardPadding;

//   const SetupPageComponent({
//     Key? key,
//     required this.title,
//     required this.controller,
//     this.childrenPadding = true,
//     this.useCardInside = true,
//     this.customBackground = "assets/svg/background_001.svg",
//     required this.children,
//     this.childrenAfterButton,
//     this.crossAxisAlignmentChildren = CrossAxisAlignment.center,
//     this.titleFunction,
//     this.btnSubmitText = "Simpan",
//     this.headerLogo,
//     this.headerText,
//     this.showAppBar = true,
//     this.buttonText = "Simpan",
//     this.buttonRadius = 10,
//     this.appBarBackgroudColor = Colors.transparent,
//     this.cardPadding = const EdgeInsets.all(15),
//   }) : super(key: key);

//   @override
//   State<SetupPageComponent> createState() => _SetupPageComponentState();
// }

// class _SetupPageComponentState extends State<SetupPageComponent> {
//   @override
//   void initState() {
//     widget.controller._init(
//         setStateX: (fn) {
//           if (mounted) {
//             setState(fn);
//           }
//         },
//         contextX: context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: widget.controller.backAction ?? widget.controller._onWillPop,
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: Colors.transparent,
//         appBar: !widget.showAppBar
//             ? null
//             : MahasWidget().mahasAppBar(
//                 onBackTap: () async {
//                   if (widget.controller.backAction != null) {
//                     var r = await widget.controller.backAction!();
//                     if (r) {
//                       Get.back();
//                     }
//                   } else if (widget.controller.withQuestionBack == true) {
//                     var r = await widget.controller._onWillPop();
//                     if (r) {
//                       Get.back();
//                     }
//                   } else {
//                     Get.back(result: true);
//                   }
//                 },
//                 title: widget.title,
//                 elevation: 0,
//                 background: widget.appBarBackgroudColor,
//                 actionBtn: widget.controller._id == null ||
//                         (!widget.controller.allowEdit &&
//                             !widget.controller.allowDelete)
//                     ? []
//                     : [
//                         PopupMenuButton(
//                           onSelected:
//                               widget.controller._popupMenuButtonOnSelected,
//                           itemBuilder: (BuildContext context) {
//                             List<PopupMenuItem<String>> r = [];
//                             if (widget.controller.editable) {
//                               r.add(const PopupMenuItem(
//                                 value: 'Cancel',
//                                 child: Text('Batal'),
//                               ));
//                             } else {
//                               if (widget.controller.allowEdit) {
//                                 r.add(const PopupMenuItem(
//                                   value: 'Edit',
//                                   child: Text('Edit'),
//                                 ));
//                               }
//                               if (widget.controller.allowDelete) {
//                                 r.add(const PopupMenuItem(
//                                   value: 'Delete',
//                                   child: Text('Delete'),
//                                 ));
//                               }
//                             }
//                             return r;
//                           },
//                         ),
//                       ],
//               ),
//         body: Stack(
//           children: [
//             widget.customBackground == null
//                 ? MahasWidget().hideWidget()
//                 : ImageComponent(
//                     width: MahasConfig().fullWidthSize,
//                     svgUrl: widget.customBackground,
//                     boxFit: BoxFit.fitWidth,
//                   ),
//             SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     widget.headerLogo != null
//                         ? ImageComponent(
//                             margin: const EdgeInsets.only(top: 20),
//                             localUrl: widget.headerLogo,
//                             width: 100,
//                             height: 100,
//                           )
//                         : MahasWidget().hideWidget(),
//                     widget.headerText != null
//                         ? TextComponent(
//                             margin: const EdgeInsets.only(top: 10),
//                             value: widget.headerText,
//                             fontSize: MahasFontSize.h3,
//                             fontWeight: FontWeight.bold,
//                             fontColor: MahasColors.light,
//                           )
//                         : MahasWidget().hideWidget(),
//                     Container(
//                       padding: widget.useCardInside ? widget.cardPadding : null,
//                       margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: widget.childrenPadding ? 10 : 0),
//                       decoration: widget.useCardInside
//                           ? BoxDecoration(
//                               color: MahasColors.light,
//                               borderRadius: BorderRadius.circular(
//                                   MahasThemes.borderRadius),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                       MahasColors.dark.withValues(alpha: 0.3),
//                                   spreadRadius: 1,
//                                   blurRadius: 3,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             )
//                           : null,
//                       child: widget.controller._isLoading
//                           ? const ShimmerComponent()
//                           : SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         widget.crossAxisAlignmentChildren,
//                                     children: widget.children(),
//                                   ),
//                                   Visibility(
//                                     visible: widget.controller.editable,
//                                     child: Container(
//                                       margin: EdgeInsets.symmetric(
//                                           vertical: 0,
//                                           horizontal:
//                                               !widget.childrenPadding ? 10 : 0),
//                                       child: ElevatedButton(
//                                         onPressed:
//                                             widget.controller.submitOnPressed,
//                                         child: TextComponent(
//                                           value: widget.btnSubmitText,
//                                           fontWeight: FontWeight.w500,
//                                           fontColor: MahasColors.light,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: widget.childrenAfterButton != null,
//                                     child: Column(
//                                       children:
//                                           widget.childrenAfterButton ?? [],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
