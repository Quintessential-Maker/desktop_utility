import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewPage extends StatelessWidget {
  final HomeViewController controller = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double screenWidth = MediaQuery.of(context).size.width;
    bool showBoth = screenWidth > 1000;  // condition for full screen

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            /// Left part (55% if full, 100% if small)
            /*Expanded(
              flex: showBoth  ? 55 : 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Row 1: Controls
                          Wrap(
                            spacing: 30,
                            runSpacing: 20,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: controller.startSocket,
                                icon: Icon(Icons.play_arrow),
                                label: Text('start'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: controller.stopSocket,
                                icon: Icon(Icons.stop),
                                label: Text('stop'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.error,
                                  foregroundColor: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${'port'.tr}:', style: theme.textTheme.titleMedium),
                                  SizedBox(width: 8),
                                  SizedBox(
                                      width: 100,
                                      child: Obx(() => TextFormField(
                                        controller: controller.portController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        ),
                                        enabled: controller.isRunning.value,
                                        style: theme.textTheme.titleMedium,
                                      ),)
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                // onPressed: controller.isRunning.value
                                //     ? () => controller.testSocket(context)
                                //     : null,
                                onPressed: () => controller.testSocket(context),
                                icon: Icon(Icons.bolt),
                                label: Text('test'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          /// Row 2: Status
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.network_check, size: 20, color: getStatusColor(controller.statusController.status.value),),
                                SizedBox(width: 6),
                                Obx(() => StatusChip(label: controller.statusController.status.value),),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  /// 📊 History Table
                  Text('requestHistory'.tr, style: theme.textTheme.headlineSmall),
                  SizedBox(height: 12),
                  Obx(() {
                    if (controller.historyList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'noRequestSentYet'.tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }

                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                                (states) => theme.colorScheme.primary.withOpacity(0.1),
                          ),
                          columnSpacing: 20,
                          columns: [
                            DataColumn(label: Text('reqTS'.tr)),
                            DataColumn(label: Text('url'.tr)),
                            DataColumn(label: Text('authToken'.tr)),
                            DataColumn(label: Text('repliedTS'.tr)),
                            DataColumn(label: Text('statusCode'.tr)),
                          ],
                          rows: controller.historyList.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(buildCell(item['reqTS'], maxWidth: 150)),
                                DataCell(buildCell(item['url'], maxWidth: 200)),
                                DataCell(buildCell(item['authToken'], maxWidth: 200)),
                                DataCell(buildCell(item['repliedTS'], maxWidth: 150)),
                                DataCell(buildCell(item['statusCode'], maxWidth: 100)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),*/
        Expanded(
        flex: showBoth ? 55 : 100,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Yeh actual width hai left section ka
              final leftSectionWidth = constraints.maxWidth;

              // Har column ke liye dynamic width
              double colWidth(int flex) => leftSectionWidth * (flex / 100);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Row 1: Controls
                          Wrap(
                            spacing: 30,
                            runSpacing: 20,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: controller.startSocket,
                                icon: Icon(Icons.play_arrow),
                                label: Text('start'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: controller.stopSocket,
                                icon: Icon(Icons.stop),
                                label: Text('stop'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.error,
                                  foregroundColor: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${'port'.tr}:', style: theme.textTheme.titleMedium),
                                  SizedBox(width: 8),
                                  SizedBox(
                                      width: 100,
                                      child: Obx(() => TextFormField(
                                        controller: controller.portController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        ),
                                        enabled: controller.isRunning.value,
                                        style: theme.textTheme.titleMedium,
                                      ),)
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                // onPressed: controller.isRunning.value
                                //     ? () => controller.testSocket(context)
                                //     : null,
                                onPressed: () => controller.testSocket(context),
                                icon: Icon(Icons.bolt),
                                label: Text('test'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          /// Row 2: Status
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.network_check, size: 20, color: getStatusColor(controller.statusController.status.value),),
                                SizedBox(width: 6),
                                Obx(() => StatusChip(label: controller.statusController.status.value),),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  /// 📊 History Table
                  Text('requestHistory'.tr, style: theme.textTheme.headlineSmall),
                  SizedBox(height: 12),
                  Obx(() {
                    if (controller.historyList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'noRequestSentYet'.tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }

                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                                (states) => theme.colorScheme.primary.withOpacity(0.1),
                          ),
                          columnSpacing: showBoth ? 35 : 10,
                          columns: [
                            DataColumn(label: Text('reqTS'.tr)),
                            DataColumn(label: Text('url'.tr)),
                            DataColumn(label: Text('authToken'.tr)),
                            DataColumn(label: Text('repliedTS'.tr)),
                            DataColumn(label: Text('statusCode'.tr)),
                          ],
                          rows: controller.historyList.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(buildCell(item['reqTS'], maxWidth: colWidth(15))),
                                DataCell(buildCell(item['url'], maxWidth: colWidth(30))),
                                DataCell(buildCell(item['authToken'], maxWidth: colWidth(20))),
                                DataCell(buildCell(item['repliedTS'], maxWidth: colWidth(20))),
                                DataCell(buildCell(item['statusCode'], maxWidth: colWidth(45))),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ),

        VerticalDivider(
              color: Colors.black,
              thickness: 10,
            ),

            /// Right part (only show if full screen)
            if (showBoth)
              Expanded(
                flex: 45,
                child: Obx(() => Container(
                  // width: constraints.maxWidth * 0.8,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: controller.isTestButtonClicked.value
                      ?
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('testXml'.tr,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall),
                      SizedBox(height: 16),
                      TextFormField(
                        maxLines: 5,
                        // onChanged: (val) => xmlInputController.text = val,
                        controller: controller.xmlInputController,
                        decoration: InputDecoration(
                          labelText: 'enterXml'.tr,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await controller.signXml(context);
                          },
                          icon: Icon(Icons.send),
                          label: Text('send'.tr),
                        ),
                      ),
                    ],
                  )
                      : null,
                ),)
              ),
          ],
        ),
      ),
    );
  }

  /// Helper function to build each cell
  Widget buildCell(String? value, {double maxWidth = 150}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(
        value ?? '',
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 3,
      ),
    );
  }

  Widget StatusChip({required String label}) {
    return Chip(
      label: Text(label, style: TextStyle(color: hexToColor(CustomColors.whiteColor))),
      backgroundColor: getStatusColor(label),
    );
  }

}
