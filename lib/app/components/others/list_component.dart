// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hr_portal/app/mahas/components/mahas_themes.dart';
// import 'package:hr_portal/app/mahas/mahas_service.dart';
// import '../../mahas_config.dart';
// import '../../models/api_list_resut_model.dart';
// import '../../services/helper.dart';
// import '../../services/http_api.dart';
// import '../inputs/input_text_component.dart';
// import 'empty_component.dart';
// import 'shimmer_component.dart';

// class ListComponentController<T> {
//   Function(int index, String filter) urlApi;
//   final T Function(dynamic e) fromDynamic;
//   final bool allowSearch;
//   final bool autoRefresh;
//   final BaseUrlType baseUrlType;
//   final bool withPageIndex;
//   Future<void> Function()? customPullRequest;
//   Function()? additionalRefresh;
//   final Function(int totalCount)? onSuccessRetrieveData;
//   late Function(VoidCallback fn) setState;

//   final _listViewController = ScrollController();
//   final _filterController = InputTextController();
//   final List<T> items = [];

//   ListComponentController({
//     required this.urlApi,
//     required this.fromDynamic,
//     this.allowSearch = true,
//     this.autoRefresh = true,
//     this.baseUrlType = BaseUrlType.apiHrportal,
//     this.withPageIndex = true,
//     this.customPullRequest,
//     this.onSuccessRetrieveData,
//     this.additionalRefresh,
//   });

//   bool _loadingBottom = false;
//   bool _isItemRefresh = true;
//   int _pageIndex = 0;
//   int _maxPage = 0;

//   void clear() {
//     items.clear();
//     _pageIndex = 0;
//     _maxPage = 0;
//   }

//   Future refresh() async {
//     clear();
//     await _refreshBottom();
//     Get.focusScope?.unfocus();
//     setState(() {});
//   }

//   Future _refreshBottom({nextPage = false}) async {
//     final itemsX = await _getItems(nextPage: nextPage);
//     if (itemsX != null) {
//       items.addAll(itemsX);
//     }
//     if (additionalRefresh != null) {
//       additionalRefresh!();
//     }
//   }

//   Future<List<T>?> _getItems({nextPage = false}) async {
//     if (!nextPage) {
//       setState(() {
//         _isItemRefresh = true;
//       });
//     }
//     try {
//       final pageIndexX = nextPage ? _pageIndex + 1 : _pageIndex;
//       final filterX = _filterController.value;
//       final query =
//           urlApi(pageIndexX + (MahasConfig.isLaravelBackend ? 1 : 0), filterX);
//       final apiModel = await HttpApi.get(query, baseUrlType: baseUrlType);
//       final List<T> result = [];
//       setState(() {
//         _isItemRefresh = false;
//       });
//       if (apiModel.success) {
//         if (withPageIndex) {
//           ApiResultListModel listModel =
//               ApiResultListModel.fromJson(apiModel.body);
//           if (onSuccessRetrieveData != null) {
//             setState(
//                 () => onSuccessRetrieveData!(listModel.totalRowCount ?? 0));
//           }
//           _maxPage = listModel.maxPage!;
//           _pageIndex = pageIndexX;
//           for (var obj in (listModel.datas ?? [])) {
//             result.add(fromDynamic(obj));
//           }
//         } else {
//           List datas = jsonDecode(apiModel.body);
//           for (var obj in datas) {
//             result.add(fromDynamic(obj));
//           }
//         }
//       } else {
//         setState(() => onSuccessRetrieveData!(0));
//         bool internetError =
//             MahasService.isInternetCausedError(apiModel.message.toString());
//         if (internetError) {
//           Helper.errorToast();
//         } else {
//           if (!apiModel.message.toString().contains(RegExp(
//               "Item that you try to find can not be found",
//               caseSensitive: false))) {
//             Helper.errorToast(message: apiModel.message.toString());
//           }
//         }
//       }
//       return result;
//     } catch (ex) {
//       bool internetError = MahasService.isInternetCausedError(ex.toString());
//       if (internetError) {
//         Helper.errorToast(
//           message: "Gagal memuat data, silahkan cek koneksi internet",
//         );
//       } else {
//         if (ex.toString().contains(RegExp(
//             "Item that you try to find can not be found",
//             caseSensitive: false))) {
//           Helper.errorToast(message: "Data tidak ditemukan");
//         } else {
//           Helper.errorToast(message: ex.toString());
//         }
//       }
//       setState(() {
//         _isItemRefresh = false;
//       });
//       return null;
//     }
//   }

//   void init(Function(VoidCallback fn) setStateX) {
//     setState = setStateX;
//     _filterController.onEditingComplete = () => refresh();
//     _filterController.onChanged = (value) => refresh();
//     _listViewController.addListener(() async {
//       if (_loadingBottom) return;
//       final maxScroll = _listViewController.position.maxScrollExtent;
//       final currentScroll = _listViewController.position.pixels;
//       const delta = 0.0;
//       if (maxScroll - currentScroll <= delta && _pageIndex != _maxPage) {
//         _loadingBottom = true;
//         await _refreshBottom(nextPage: true);
//         _loadingBottom = false;
//       }
//     });
//     if (autoRefresh) {
//       refresh();
//     }
//   }
// }

// class ListComponent<T> extends StatefulWidget {
//   final ListComponentController<T> controller;
//   final Widget Function(T e) itemBuilder;
//   final bool allowMenuAction;
//   final Widget? customWidgetFilter;
//   final Widget Function(BuildContext context, int index, int length)?
//       separatorBuilder;
//   final bool emptyIsCard;
//   final bool emptyCardWithMargin;
//   final bool isReverse;
//   final String searchPlaceholder;
//   final Widget? searchIcon;
//   final double? searchHorizontalMargin;

//   const ListComponent({
//     Key? key,
//     required this.controller,
//     required this.itemBuilder,
//     this.allowMenuAction = false,
//     this.customWidgetFilter,
//     this.separatorBuilder,
//     this.emptyIsCard = false,
//     this.isReverse = false,
//     this.searchPlaceholder = "Search",
//     this.searchIcon,
//     this.searchHorizontalMargin,
//     this.emptyCardWithMargin = true,
//   }) : super(key: key);

//   @override
//   State<ListComponent<T>> createState() => _ListComponentState<T>();
// }

// class _ListComponentState<T> extends State<ListComponent<T>> {
//   @override
//   void initState() {
//     widget.controller.init((fn) {
//       if (mounted) {
//         setState(fn);
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Visibility(
//           visible: widget.controller.allowSearch,
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: widget.searchHorizontalMargin ?? 10),
//             child: InputTextComponent(
//               borderRadius: Radius.circular(MahasThemes.borderRadius),
//               placeHolder: widget.searchPlaceholder,
//               marginBottom: widget.customWidgetFilter == null ? 10 : 0,
//               controller: widget.controller._filterController,
//               prefixIcon: widget.searchIcon,
//             ),
//           ),
//         ),
//         if (widget.customWidgetFilter != null) ...[widget.customWidgetFilter!],
//         Expanded(
//           child: RefreshIndicator(
//             onRefresh: widget.controller.customPullRequest ??
//                 widget.controller.refresh,
//             child: widget.controller._isItemRefresh
//                 ? const ShimmerComponent()
//                 : widget.controller.items.isEmpty &&
//                         !widget.controller._isItemRefresh
//                     ? EmptyComponent(
//                         onPressed: widget.controller.customPullRequest ??
//                             widget.controller.refresh,
//                         isCard: widget.emptyIsCard,
//                         padding: widget.emptyCardWithMargin ? 15 : 0,
//                       )
//                     : ListView.separated(
//                         padding: EdgeInsets.zero,
//                         reverse: widget.isReverse,
//                         shrinkWrap: true,
//                         separatorBuilder: widget.separatorBuilder != null
//                             ? (context, index) => widget.separatorBuilder!(
//                                 context, index, widget.controller.items.length)
//                             : (context, index) => const Divider(height: 0),
//                         controller: widget.controller._listViewController,
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         itemCount: widget.controller.items.length +
//                             (MahasConfig.isLaravelBackend ? 1 : 0),
//                         itemBuilder: (context, index) {
//                           if (index == widget.controller.items.length) {
//                             return Visibility(
//                               visible: widget.controller._pageIndex !=
//                                       widget.controller._maxPage &&
//                                   widget.controller.items.isNotEmpty,
//                               child: Container(
//                                 margin: const EdgeInsets.all(10),
//                                 child: const Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return widget
//                                 .itemBuilder(widget.controller.items[index]);
//                           }
//                         },
//                       ),
//           ),
//         )
//       ],
//     );
//   }
// }
