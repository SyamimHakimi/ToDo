import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../utils/app_constant.dart';
import '../utils/app_string.dart';

/// List all To-Do Tasks
class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {

  /// PagingController<index, ReturnObject> for controlling the list
  final PagingController<int, String> _pagingController = PagingController(firstPageKey: 0);
  /// Default page size for each query
  static const _pageSize = 20;

  /// Add listeners on screen creation
  @override
  void initState() {
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });

    super.initState();
  }

  /// Dispose controllers
  @override
  void dispose() {

    _pagingController.dispose();
    super.dispose();
  }

  /// Fetch To-Do List
  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final newItems = await inspectionRepository.getData(context, _pageSize, pageKey, _listPreferences, widget.campaignId);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  /// To-Do Task Widget
  // Widget infoCard(InspectionList item, int index) {
  //   String inspectionDate = "-";
  //   if (item.inspectionDate != null) {
  //     inspectionDate = AppConstant.dateFormat.format(item.inspectionDate!);
  //   }
  //
  //   String inspectionStatus = "-";
  //   if (item.inspectionCompliance == complianceGREEN) {
  //     inspectionStatus = statusWordingClosed;
  //   } else {
  //     inspectionStatus = statusWordingOpen;
  //   }
  //
  //   Color color;
  //   if (item.validate.validate()) {
  //     color = AppConstant.getColorFromComplianceInspection(item.inspectionCompliance);
  //   } else {
  //     color = AppConstant.colorComplianceNA;
  //   }
  //
  //   return Slidable(
  //
  //     startActionPane: itemSlidableInspection(item.inspectionId),
  //     endActionPane: itemSlidableInspection(item.inspectionId),
  //
  //     child: GestureDetector(
  //       onTap: () {
  //         final GlobalKey<InspectionHomePageState> inspectionHomeGlobalKey = GlobalKey<InspectionHomePageState>();
  //         Navigator.push(context, pageTransitionFadeThrough(InspectionHomePage(key: inspectionHomeGlobalKey,
  //             campaignId: widget.campaignId, inspectionData: item)));
  //       },
  //
  //       child: Container(
  //         margin: const EdgeInsets.symmetric(horizontal: AppConstant.paddingTextDouble),
  //         decoration: BoxDecoration(
  //             color: AppTheme.white,
  //             borderRadius: const BorderRadius.all(Radius.circular(AppConstant.dataCardRadius)),
  //             boxShadow: AppConstant.dataBoxShadow
  //         ),
  //         child: IntrinsicHeight(
  //           child: Row(
  //             children: [
  //               Container(
  //                 constraints: const BoxConstraints(minWidth: 50),
  //                 width: MediaQuery.of(context).size.width * 0.1,
  //                 decoration: BoxDecoration(
  //                     color: color,
  //                     borderRadius: const BorderRadius.all(Radius.circular(AppConstant.dataCardRadius)),
  //                     boxShadow: AppConstant.dataBoxShadow
  //                 ),
  //                 child: item.validate.validate() ? Center(child: Text(item.findingNo.toString(), style: AppTheme.headlineSecondaryWhite))
  //                     : Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [...errorIcons(item.validate)],
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(AppConstant.paddingTextDouble),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     children: <Widget>[
  //                       IntrinsicHeight(
  //                         child: Row(
  //                             children: [
  //                               Flexible(flex: 4, child: infoCardDetail(item.tagNumber ?? "-", iconTag, AppConstant.sizeIconNav, AppTheme.titleSecondary)),
  //                               const SizedBox(width: AppConstant.paddingGridDouble),
  //                               Expanded(child: infoCardIndex(index, noError: item.validate.validate()))
  //                             ]
  //                         ),
  //                       ),
  //                       const SizedBox(height: AppConstant.paddingDouble),
  //                       infoCardDetail(item.equipmentDescription ?? "-", iconEquipment, AppConstant.sizeIconNav, AppTheme.bodyFontMediumSecondary),
  //                       const SizedBox(height: AppConstant.paddingDouble),
  //                       infoCardDetail(item.location ?? "-", iconLocation, AppConstant.sizeIconNav, AppTheme.bodyFontMediumSecondary),
  //                       const SizedBox(height: AppConstant.paddingDouble),
  //                       dividerRounded(),
  //                       const SizedBox(height: AppConstant.paddingDouble),
  //                       Row(
  //                           children: [
  //                             Flexible(child: infoCardDetail(item.inspectionGrade ?? "-", iconGrade, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary)),
  //                             const SizedBox(width: AppConstant.paddingDouble),
  //                             Flexible(
  //                                 child: infoCardDetail(inspectionStatus, iconStatus, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary)
  //                             )
  //                           ]
  //                       ),
  //                       const SizedBox(height: AppConstant.paddingDouble),
  //                       Row(
  //                           children: [
  //                             Flexible(child: infoCardDetail(item.personnel ?? "-", iconEngineer, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary)),
  //                             const SizedBox(width: AppConstant.paddingGridDouble),
  //                             Flexible(child: infoCardDetail(inspectionDate, iconCalendar, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary))
  //                           ]
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// To-Do List Widget
  Widget listView() {
    return PagedListView<int, String>.separated(
      pagingController: _pagingController,
      // padding: EdgeInsets.symmetric(vertical: AppBar().preferredSize.height +
      //     MediaQuery.of(context).padding.top + 24),
      builderDelegate: PagedChildBuilderDelegate<String>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return Text(item);
          // return infoCard(item, index + 1);
        },
        // firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
        //   error: _pagingController.error,
        //   onTryAgain: () => _pagingController.refresh(),
        // ),
        // noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
      ),
      separatorBuilder: (context, index) => SizedBox(height: padding),
    );
  }

  /// Build Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(toDoListScreenTitle),
      ), // Theme AppBar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(() => _pagingController.refresh()), // Refresh method
              child: listView()
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("BRUH"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // Create Task Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}