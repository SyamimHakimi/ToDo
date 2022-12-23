import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:to_do/db/database.dart';
import 'package:to_do/function/task_repository.dart';
import 'package:to_do/screen/todo_form_screen.dart';

import '../component/appbar/general_appbar.dart';
import '../component/widget/date_countdown.dart';
import '../utils/app_constant.dart';
import '../utils/app_string.dart';

/// List all To-Do Tasks
class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {

  TaskRepository taskRepository = TaskRepository();

  /// PagingController<index, ReturnObject> for controlling the list
  final PagingController<int, TaskData> _pagingController = PagingController(firstPageKey: 0);

  /// Add listeners on screen creation
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  /// Dispose controllers
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  /// On Quit
  Future<bool> onQuit() async {
    return await showAppDialog(context, quitDialog(context));
  }

  /// Fetch To-Do List
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await taskRepository.getList(context, pageSize, pageKey);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  /// To-Do Task Widget
  Widget infoCard(TaskData item, int index) {
    String dateTimesStartString = item.start_date != null ? dateFormatWord.format(item.start_date!) : "-";
    String dateTimesEndString = item.end_date != null ? dateFormatWord.format(item.end_date!) : "-";

    return Container(
      padding: EdgeInsets.all(padding16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radiusCard)),
        boxShadow: shadowCard
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(item.task_title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height:padding16),
          Row(
            children: [
              _itemTitle(toDoFormStartDate),
              _itemTitle(toDoFormEndDate),
              _itemTitle(toDoFormTimeLeft),
            ],
          ),
          Row(
            children: [
              _itemValue(dateTimesStartString),
              _itemValue(dateTimesEndString),
              Expanded(child: DateCountdown(dateEnd: item.end_date, textStyle: Theme.of(context).textTheme.titleSmall!)),
            ],
          )
        ]
      ),
    );
    // String inspectionDate = "-";
    // if (item.inspectionDate != null) {
    //   inspectionDate = AppConstant.dateFormat.format(item.inspectionDate!);
    // }
    //
    // String inspectionStatus = "-";
    // if (item.inspectionCompliance == complianceGREEN) {
    //   inspectionStatus = statusWordingClosed;
    // } else {
    //   inspectionStatus = statusWordingOpen;
    // }
    //
    // Color color;
    // if (item.validate.validate()) {
    //   color = AppConstant.getColorFromComplianceInspection(item.inspectionCompliance);
    // } else {
    //   color = AppConstant.colorComplianceNA;
    // }
    //
    // return Slidable(
    //
    //   startActionPane: itemSlidableInspection(item.inspectionId),
    //   endActionPane: itemSlidableInspection(item.inspectionId),
    //
    //   child: GestureDetector(
    //     onTap: () {
    //       final GlobalKey<InspectionHomePageState> inspectionHomeGlobalKey = GlobalKey<InspectionHomePageState>();
    //       Navigator.push(context, pageTransitionFadeThrough(InspectionHomePage(key: inspectionHomeGlobalKey,
    //           campaignId: widget.campaignId, inspectionData: item)));
    //     },
    //
    //     child: Container(
    //       margin: const EdgeInsets.symmetric(horizontal: AppConstant.paddingTextDouble),
    //       decoration: BoxDecoration(
    //           color: AppTheme.white,
    //           borderRadius: const BorderRadius.all(Radius.circular(AppConstant.dataCardRadius)),
    //           boxShadow: AppConstant.dataBoxShadow
    //       ),
    //       child: IntrinsicHeight(
    //         child: Row(
    //           children: [
    //             Container(
    //               constraints: const BoxConstraints(minWidth: 50),
    //               width: MediaQuery.of(context).size.width * 0.1,
    //               decoration: BoxDecoration(
    //                   color: color,
    //                   borderRadius: const BorderRadius.all(Radius.circular(AppConstant.dataCardRadius)),
    //                   boxShadow: AppConstant.dataBoxShadow
    //               ),
    //               child: item.validate.validate() ? Center(child: Text(item.findingNo.toString(), style: AppTheme.headlineSecondaryWhite))
    //                   : Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [...errorIcons(item.validate)],
    //               ),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(AppConstant.paddingTextDouble),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.stretch,
    //                   children: <Widget>[
    //                     IntrinsicHeight(
    //                       child: Row(
    //                           children: [
    //                             Flexible(flex: 4, child: infoCardDetail(item.tagNumber ?? "-", iconTag, AppConstant.sizeIconNav, AppTheme.titleSecondary)),
    //                             const SizedBox(width: AppConstant.paddingGridDouble),
    //                             Expanded(child: infoCardIndex(index, noError: item.validate.validate()))
    //                           ]
    //                       ),
    //                     ),
    //                     const SizedBox(height: AppConstant.paddingDouble),
    //                     infoCardDetail(item.equipmentDescription ?? "-", iconEquipment, AppConstant.sizeIconNav, AppTheme.bodyFontMediumSecondary),
    //                     const SizedBox(height: AppConstant.paddingDouble),
    //                     infoCardDetail(item.location ?? "-", iconLocation, AppConstant.sizeIconNav, AppTheme.bodyFontMediumSecondary),
    //                     const SizedBox(height: AppConstant.paddingDouble),
    //                     dividerRounded(),
    //                     const SizedBox(height: AppConstant.paddingDouble),
    //                     Row(
    //                         children: [
    //                           Flexible(child: infoCardDetail(item.inspectionGrade ?? "-", iconGrade, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary)),
    //                           const SizedBox(width: AppConstant.paddingDouble),
    //                           Flexible(
    //                               child: infoCardDetail(inspectionStatus, iconStatus, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary)
    //                           )
    //                         ]
    //                     ),
    //                     const SizedBox(height: AppConstant.paddingDouble),
    //                     Row(
    //                         children: [
    //                           Flexible(child: infoCardDetail(item.personnel ?? "-", iconEngineer, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary)),
    //                           const SizedBox(width: AppConstant.paddingGridDouble),
    //                           Flexible(child: infoCardDetail(inspectionDate, iconCalendar, AppConstant.sizeIconNav, AppTheme.subtitleFontMediumSecondary))
    //                         ]
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  /// Row Child
  Widget _itemTitle(String title) => _itemRow(title, Theme.of(context).textTheme.titleSmall
      ?.copyWith(color: Colors.grey));
  Widget _itemValue(String title) => _itemRow(title, Theme.of(context).textTheme.titleSmall);

  Widget _itemRow(String title, TextStyle? textStyle) {
    return Expanded(child: Text(title, style: textStyle));
  }

  /// To-Do List Widget
  Widget _listView() {
    return PagedListView<int, TaskData>.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<TaskData>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return infoCard(item, index + 1);
        },
      ),
      separatorBuilder: (context, index) => SizedBox(height: padding20),
    );
  }

  /// Build Screen
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onQuit,

      child: Scaffold(
        appBar: appButton(toDoListScreenTitle),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(padding20),
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(() => _pagingController.refresh()), // Refresh method
                  child: _listView()
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ToDoFormScreen())),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // Create Task Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}