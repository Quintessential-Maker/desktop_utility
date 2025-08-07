import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewPage extends StatelessWidget {
  final HomeViewController controller = Get.put(HomeViewController());

  Color _getStatusColor(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'busy':
        return Theme.of(context).colorScheme.secondary;
      case 'oops':
        return Theme.of(context).colorScheme.error;
      case 'idle':
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(title: Text('Socket XML Tool')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔘 Top Control Section
            /// 🔘 Top Control Section (Better Grouping + Status Label)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Row 1: Controls
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: controller.startSocket,
                          icon: Icon(Icons.play_arrow),
                          label: Text('Start'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: controller.stopSocket,
                          icon: Icon(Icons.stop),
                          label: Text('Stop'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Port:", style: theme.textTheme.titleMedium),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: controller.portController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () => controller.testSocket(context),
                          icon: Icon(Icons.bolt),
                          label: Text('Test'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    /// Row 2: Status
                    Obx(() {
                      final statusText = controller.status.value;
                      final statusColor = _getStatusColor(statusText, context);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.network_check, size: 20, color: statusColor),
                          SizedBox(width: 6),
                          Text(
                            'Status: ',
                            style: theme.textTheme.titleMedium,
                          ),
                          Obx(() => StatusChip(label: controller.status.value),),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),

            /*/// 📝 XML Input Box
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 5,
                      onChanged: (val) => controller.xmlInput.value = val,
                      decoration: InputDecoration(
                        labelText: 'Paste XML Input',
                        border: OutlineInputBorder(),
                        hintText: '<xml>...</xml>',
                      ),
                    ),
                    SizedBox(height: 12),
                    Obx(() => AnimatedOpacity(
                      opacity: controller.xmlInput.value.trim().isEmpty ? 0.5 : 1,
                      duration: Duration(milliseconds: 300),
                      child: ElevatedButton.icon(
                        onPressed: () {

                          controller.xmlInput.value.trim().isEmpty
                              ? null
                              : controller.signXml(context);

                        },
                        icon: Icon(Icons.send),
                        label: Text('Send'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),*/

            // SizedBox(height: 10),

            /// 📊 History Table
            Text('Request History', style: theme.textTheme.headlineSmall),
            SizedBox(height: 12),
            Obx(() {
              if (controller.historyList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No requests sent yet.',
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }

              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 48,
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                            (states) => theme.colorScheme.primary.withOpacity(0.1),
                      ),
                      columnSpacing: 10,
                      columns: [
                        DataColumn(
                          label: Center(child: Text('Request TS', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('URL', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('AuthToken', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Replied TS', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Status Code', textAlign: TextAlign.center)),
                        ),
                      ],
                      rows: controller.historyList.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(ConstrainedBox(constraints: BoxConstraints(maxWidth: 150),child: Text(item['RequestTS'] ?? '',softWrap: true,overflow: TextOverflow.visible,maxLines: null,textAlign: TextAlign.left,),),),
                            DataCell(ConstrainedBox(constraints: BoxConstraints(maxWidth: 150),child: Text(item['URL'] ?? '',softWrap: true,overflow: TextOverflow.visible,maxLines: null,textAlign: TextAlign.left,),),),
                            DataCell(ConstrainedBox(constraints: BoxConstraints(maxWidth: 150),child: Text(item['AuthToken'] ?? '',softWrap: true,overflow: TextOverflow.visible,maxLines: null,textAlign: TextAlign.left,),),),
                            DataCell(ConstrainedBox(constraints: BoxConstraints(maxWidth: 150),child: Text(item['RepliedTS'] ?? '',softWrap: true,overflow: TextOverflow.visible,maxLines: null,textAlign: TextAlign.left,),),),
                            DataCell(ConstrainedBox(constraints: BoxConstraints(maxWidth: 150),child: Text(item['StatusCode'] ?? '',softWrap: true,overflow: TextOverflow.visible,maxLines: null,textAlign: TextAlign.left,),),),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget StatusChip({required String label}) {
    final color = label == 'Busy'
        ? hexToColor(CustomColors.warningColorBg)
        : label == 'Oops'
        ? hexToColor(CustomColors.dangerColorBg)
        : hexToColor(CustomColors.successColorBg);

    return Chip(
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }

}
